package_manager_install_packages() {
    local -n apt_packages="${1}"
    local apt_experimental_file="/etc/apt/sources.list.d/experimental.list"
    local apt_opts=""

    touch "${apt_experimental_file}" || true
    if ! grep -q 'experimental' "${apt_experimental_file}"; then 
        echo 'deb https://deb.debian.org/debian experimental main' > "${apt_experimental_file}"
    fi

    echo "INF: updating package repositories ..."
    apt-get -y update &> /dev/null || { echo "ERR: Failed to update package repositories" ; return 1; }
    apt-get -y install aptitude &> /dev/null || return 1; 
    for package in "${apt_packages[@]}"; do
        echo "INF: Installing ${package} ..."
        if aptitude -y install "${package}" &> /dev/null; then
            echo "INF: Successfully installed ${package}"
        else
            echo "WARN: Failed to install ${package}. Please install manually." 
        fi
    done

    return 0
}
