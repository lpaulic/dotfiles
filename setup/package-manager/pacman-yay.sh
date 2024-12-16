package_manager_install_packages() {
    local -n pacman_packages="${1}"

    echo "INF: updating package repositories ..."
    pacman -Sy &> /dev/null  || { echo "ERR: Failed to update package repositories" ; return 1; }
    for package in "${pacman_packages[@]}"; do
        echo "INF: Installing ${package} ..."
        if pacman -S --noconfirm "${package}" &> /dev/null; then
            echo "INF: Successfully installed ${package}"
        else
            echo "WARN: Failed to install ${package}. Please install manually." 
        fi
    done

    return 0
}

secondary_package_manager_install_packages() {
    local -n yay_packages="${1}"
    local no_sudo="sudo -u ${SUDO_USER}"

    if ! which yay &>/dev/null; then
    	echo "ERR: Yay is not installed please install."
	    return 1
    fi

    echo "INF: updating secondary package repositories ..."
    ${no_sud} yay -Sy &> /dev/null  || { echo "ERR: Failed to update package repositories" ; return 1; }
    for package in "${yay_packages[@]}"; do
        echo "INF: Installing ${package} ..."
        if ${no_sudo} yay -S --answerclean None --answerdiff None --noconfirm "${package}" &>/dev/null; then
            echo "INF: Successfully installed ${package}"
        else
            echo "WARN: Failed to install ${package}. Please install manually." 
        fi
    done

    return 0
}
