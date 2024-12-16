# dotfiles

Example dotfiles that are managed by [dotdrop](https://github.com/deadc0de6/dotdrop).

## Prerequisite
  * dotdrop
  * wget
  * curl
  * bash
  * getopt
  * unzip

## Usage
* clone this repository to `${HOME}/.dotfiles`
```
git clone git@github.com:lpaulic/dotfiles.git ${HOME}/.dotfiles
```
* bootstarp
```
sudo <path-to-this-repo>/setup/setup.sh [--rust] [--nvm]
```
* every day use
```
# edit files in this repository
git pull
git add -A
git commit
git push
dotdrop install
# or use the alias defined in config/zsh/aliases
dotsync
```

## Profile names
The proces of creating and using the dotdrop profile names are 
related to host name as follows:
- The host name follows the format: `<profile-name>-<machine-sn-last-4-characters>`
    - `<profile-name>` - stirng of user chosing, usually follows 
    a [naming scheme](https://namingschemes.com/Main_Page). Personally
    using tree names.
    - `<machine-sn-last-4-characters>` - last 4 characters, uppercase, of the 
    host machine, usually located on the back side of the machine

The `<profile-name>` serves as a code name for 
the machine configuraiton: OS distribution, desktop environment, etc.
For every different machine configuration a different profile with 
different `<profile-name>` should exists. If the same machine 
configuration exists on a different machine that the host name 
will have the same `<profile-name>` but different `<machine-sn-last-4-characters>`

For the setup script from this repository to work the host name must 
follow the above mentioned rule. The `<profile-name>` is used 
to find the appropriate predefined package list.

If you want to use the script and use your custom `<profile-name>`
that is not mentioned in the `dotfiles/setup/configurations/` 
directory, do the following:
1. Create a scrpit named `<custom-profile-name>.sh`
2. Create a variable named `<system-pacakage-manager>_package_list`
and populate it with aplications that you want or copy from 
a existing configuration script
3. Add the profile with and the desired configurations in the 
`dotfiles/config/dotdrop/config.yaml`
4. Modify the `DOTDROP_PROFILE` variable in `dotfiles/config/zsh/environment.zsh`
to hold the `<custom-profile-name>` 
5. Run the `./dotfiles/setup/setup.sh` as sudo

## Inspiration

Inspiration was found [here](https://dotfiles.github.io/).
