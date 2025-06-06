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

### Trap Signals
interrupt_trap() {
    echo "INF: not cleaning successfull installs"
    return 0
}

trap interrupt_trap SIGINT

### Functions
usage() {
    echo "Usage: $0 [options] <argument>"
    echo
    echo "Flags:"
    echo "  options             Optional flags. Must be one of:"
    echo "                      -h|--help"
    echo "			-r|--rust: install rust packages"
}

validate_host_name() {
    local host_name="${1}"

    # host_name must follow the template <string>-<last-4-digits-of-SN>
    if [[ "${host_name}" =~ ^[^\s\\]+-[A-Z0-9]{4}$ ]]; then
        return 0
    else
        return 1
    fi
}

install_dotfiles() {
    local profile="${1}"
    local dotfiles_dir_path="${script_dir_path}/.."
 
    ${no_sudo} dotdrop -b -f -p "${profile}" -c "${dotfiles_dir_path}/config/dotdrop/config-user.yaml" install &>/dev/null || { return 1; } 
    dotdrop -b -f -p "${profile}" -c "${dotfiles_dir_path}/config/dotdrop/config-system.yaml" install &>/dev/null || { return 1; } 

    return 0
}

install_rust() { 
	echo "INF: Installing Rust ..."
    ${no_sudo} bash -c "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh" || { echo "ERR: Failed to install rust" ; return 1; }
	echo "INF: Installed Rust"

    return 0
}

post_install() {
    if which grub-mkconfig &>/dev/null; then
        grub-mkconfig -o /boot/grub/grub.cfg &>/dev/null || echo "WRN: grub-mkconfig failed. Take a look."
    fi

    return 0
}

### Script Sourcing

### Variables
default_host=${HOSTNAME:-""}

short_opts="hrn"
long_opts="help,rust"
script_dir_path="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
no_sudo="sudo -u ${SUDO_USER}"
install_rust=false
profile=""
package_list=()

### Command Line Flags Parsing ###
if ! TEMP=$(getopt -o "${short_opts}" -l "${long_opts}" -n "$0" -- "$@"); then
    echo "ERR: Failed to parse arguments."
    usage
    exit 1
fi

eval set -- "$TEMP"
while true; do
    case "$1" in
        -h|--help)
            usage
            exit 0
            ;;
        -r|--rust)
            install_rust=true
            shift 1
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "ERR: Unexpected option $1"
            usage
            exit 1
            ;;
    esac
done


### Main Logic
if [ "$(id -u)" != 0 ]; then
   echo "ERR: The script must be run as root."
   exit 1
fi

if [ -z ${default_host} ]; then
    echo "ERR: The HOST environemnt variable must be set"
    exit 1
fi

if ! validate_host_name ${default_host}; then
    echo "ERR: The HOST doesn't follow the required template"
    exit 2
fi

profile="${default_host%-*}"
if ! ls -1 ${script_dir_path}/configurations | grep -q "${profile}".sh ; then
    echo "ERR: No configuration for profile '${profile}'"
    exit 3
fi

# imports <package-manager>_package_list variable
source ${script_dir_path}/configurations/${profile}.sh 

# System packages
if which apt-get &>/dev/null; then
    source ${script_dir_path}/package-manager/apt.sh
    package_list=("${apt_package_list[@]}")
elif which pacman &>/dev/null; then
    source ${script_dir_path}/package-manager/pacman-yay.sh
    package_list=("${pacman_package_list[@]}")
    secondary_package_list=("${yay_package_list[@]}")
else
    echo "ERR: No supported package manager"
    exit 1
fi

echo "INF: Installing system packages ..."
# passing array by name
package_manager_install_packages package_list || { echo "ERR: failed to install packages" ; exit 1; }
echo "INF: System packages installed"

if declare -F "secondary_package_manager_install_packages" &>/dev/null; then 
    echo "INF: Installing secundary packages ..."
    # passing array by name
    secondary_package_manager_install_packages secondary_package_list || { echo "ERR: failed to install secondary packages" ; exit 1; }
    echo "INF: Secondary packages installed."
fi

# Dotfiles
echo "INF: Installing dotdrop configurations ..."
install_dotfiles "${profile}" || { echo "ERR: faild to install dotconf files" ; exit 1; }
echo "INF: Dotdrop configurations installed"

# Rust
if ${install_rust}; then
    echo "INF: Installing Rust ..."
    install_rust_packages || { echo "ERR: failed to install rust" ; exit 1; }
    echo "INF: Rust installed"
fi

# Post-install runs
echo "INF: Running post install commands ..."
post_install || { echo "ERR: failed to run post install commands"; exit 1; }
echo "INF: Post install commands ran"

exit 0
