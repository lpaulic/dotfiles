#!/bin/bash

### Metadata
# Description: Script for setting up dotfiles.
# The script utilizes the HOSTNAME and extracts 
# the profile and matches it with the proflie 
# in dotdrop configuration. The script figures
# out the package manager on the system. Not 
# all package mangers are supported.

### Error settings
set -eo pipefail
## Debugging purposes
# set -x

### Trap Signals
# shellcheck disable=SC2317
interrupt_trap() {
    echo "INF: not cleaning successfull installs"
    return 0
}

trap interrupt_trap SIGINT

### Functions
usage() {
    echo "Usage: $0 [options]"
    echo
    echo "Flags:"
    echo "  options             Optional flags. Must be one of:"
    echo "                      -h|--help"
}

# param[in] 1: host name retreived from HOSTNAME environemnt variable
validate_host_name() {
    local host_name="${1}"

    # host_name must follow the template <string>-<last-4-digits-of-SN>
    if [[ "${host_name}" =~ ^[^-]+-([A-Z0-9]{4}|vm)$ ]]; then
        return 0
    else
        return 1
    fi
}

# param[in] 1:  json array containing objects in form 
#               '{ 
#                   "name": string, 
#                   "version": string, 
#                   "uri": string, 
#                   "proto": string, 
#                   "cmd": string
#               }'
#               all objec keys are mandatory
install_from_source() {
    local src_name=""
    local src_ver=""
    local src_uri=""
    local src_proto=""
    local src_cmd=""

    echo "${1}" | jq -c '.[]' | while IFS= read -r SRC; do
        src_name="$(echo "$SRC" | jq -r '.name')"
        src_ver="$(echo "$SRC" | jq -r '.version')"
        src_uri="$(echo "$SRC" | jq -r '.uri')"
        src_proto="$(echo "$SRC" | jq -r '.proto')"
        src_cmd="$(echo "$SRC" | jq -r '.cmd')"
  
        echo "INF: Installing '$src_name' from source ..."
        if [ "${src_proto^^}" != "GIT" ]; then
            echo "WARN: Unsupported protocol: '${src_proto}', skipping ..."
            continue
        fi

        if [ ! -d "/usr/local/src/$src_name" ]; then
            echo "INF: Downloading '$src_name' ..."
            ${NO_SUDO} git clone --depth 1 --branch "$src_ver" "$src_uri" "/tmp/$src_name" || { echo "WARN: Failed to download '$src_name', continuing ..."; continue; }
            mv "/tmp/$src_name" /usr/local/src/ || { echo "WARN: Failed to move '$src_name' to '/usr/local/src/', continuing ..."; continue; }
        fi
    
        cd "/usr/local/src/$src_name" || true

        echo "Running '$src_cmd' for '$src_name' ..."
        bash -c "${src_cmd}" || { echo "WARN: Failed to run '$src_cmd', continuing ..."; }
        cd - || true
    done
}

install_dotfiles() {
    local profile="${1}"
    local dotfiles_dir_path="${SCRIPT_DIR_PATH}/.."
    
    if dotdrop -b -c "${dotfiles_dir_path}/config/dotdrop/config-user.yaml" profiles | grep "${profile}"; then
        ${NO_SUDO} dotdrop -b -f -p "${profile}" -c "${dotfiles_dir_path}/config/dotdrop/config-user.yaml" install &>/dev/null || { return 1; } 
    else
        echo "WARN: no files for profile '${profile}' for user configuratoin."
    fi

    if dotdrop -b -c "${dotfiles_dir_path}/config/dotdrop/config-system.yaml" profiles | grep "${profile}"; then
        dotdrop -b -f -p "${profile}" -c "${dotfiles_dir_path}/config/dotdrop/config-system.yaml" install &>/dev/null || { return 1; } 
    else
        echo "WARN: no files for profile '${profile}' for system configuration."
    fi

    return 0
}

install_rust() { 
    ${NO_SUDO} bash -c "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh" || { echo "ERR: Failed to install rust" ; return 1; }

    return 0
}

post_install() {
    if which grub-mkconfig &>/dev/null; then
        grub-mkconfig -o /boot/grub/grub.cfg &>/dev/null || echo "WRN: grub-mkconfig failed. Take a look."
    fi

    ldconfig || { echo "WARN: Failed to update libraries. Take a look."; }
    usermod -aG libvirt,kvm,docker "$SUDO_USER" || { echo "WARN: Failed to add '$SUDO_USER' to docker, kvm and libvirt. Take a look."; }
    echo "vhost_net" | tee -a /etc/modules || { echo "WARN: Failed to enable KVM network kernel module loading. Take a look."; }
    virsh net-start default || { echo "Failed to start default virtual network. Take a look."; }
    virsh net-autostart default || { echo "Failed to set auto-start for default virtual network. Take a look."; }

    return 0
}

### Script Sourcing

### Variables
SCRIPT_DIR_PATH="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
DEFAULT_HOST=${HOSTNAME:-""}
SHORT_OPTS="h"
NO_SUDO="sudo -u ${SUDO_USER}"
PROFILE=""
JSON_CONFIG_FILE_PATH=""

### Command Line Flags Parsing ###

while getopts "$SHORT_OPTS" OPT; do
    case "$OPT" in
        h)
            usage
            exit 0
            ;;
        \?)
            echo "ERR: Invalid option: -$OPTARG" >&2
            usage
            exit 1
            ;;
    esac
done

shift $((OPTIND - 1))

### Main Logic
if [ "$(id -u)" != 0 ]; then
   echo "ERR: The script must be run as root."
   exit 1
fi

if [ -z "$DEFAULT_HOST" ]; then
    echo "ERR: The HOST environemnt variable must be set"
    exit 1
fi

if ! validate_host_name "$DEFAULT_HOST"; then
    echo "ERR: The HOST doesn't follow the required template"
    exit 2
fi

PROFILE="${DEFAULT_HOST%-*}"
if ! find "${SCRIPT_DIR_PATH}/configurations" -name "${PROFILE}.json"; then
    echo "ERR: No configuration for profile '$PROFILE'"
    exit 3
fi

JSON_CONFIG_FILE_PATH="${SCRIPT_DIR_PATH}/configurations/${PROFILE}.json"

# System packages
if which apt-get &>/dev/null; then
    source "${SCRIPT_DIR_PATH}/package-manager/apt.sh"
else
    echo "ERR: No supported package manager"
    exit 1
fi

echo "INF: Installing system packages ..."
package_manager_install_packages "$(jq '.packages' "$JSON_CONFIG_FILE_PATH")" || { echo "ERR: failed to install packages" ; exit 1; }
echo "INF: System packages installed"

# From source
echo "INF: Installing packages from source ..."
install_from_source "$(jq '.from_sources' "$JSON_CONFIG_FILE_PATH")" || { echo "ERR: Failed to install packages from source" ; exit 1; }
echo "INF: Installed packages from source"

# Rust
echo "INF: Installing Rust ..."
install_rust || { echo "ERR: failed to install rust" ; exit 1; }
echo "INF: Rust installed"

# Dotfiles
echo "INF: Installing dotdrop configurations ..."
install_dotfiles "${PROFILE}" || { echo "ERR: faild to install dotconf files" ; exit 1; }
echo "INF: Dotdrop configurations installed"

# Post-install runs
echo "INF: Running post install commands ..."
post_install || { echo "ERR: failed to run post install commands"; exit 1; }
echo "INF: Post install commands ran"

exit 0
