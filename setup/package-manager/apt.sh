# param[in] 1:  json list containing objects 
#               '{
#                   "name": string, 
#                   "version": string
#               }'
#               where the "version" key is optional
package_manager_install_packages() {
    local pkg_name=""

    echo "INF: updating package repositories ..."
    apt-get -y update &> /dev/null || { echo "ERR: Failed to update package repositories" ; return 1; }
    
    echo "${1}" | jq -c '.[]' | while IFS= read -r PACKAGE; do
        pkg_name="$(echo "$PACKAGE" | jq -r ".name")"

        echo "INF: Installing '$pkg_name' ..."
        if apt-get -y install "$pkg_name" &> /dev/null; then
            echo "INF: Successfully installed $pkg_name"
        else
            echo "WARN: Failed to install $pkg_name. Please install manually." 
        fi
    done

    return 0
}
