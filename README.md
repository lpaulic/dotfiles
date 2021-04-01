# dotfiles

Example dotfiles that are managed by [dotdrop](https://github.com/deadc0de6/dotdrop).

## Prerequisite
  * dotdrop

## Usage
* bootstarp
  ```
  dotdrop -b --cfg=<path-to-this-repo>/config/dotdrop/config.yaml install
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
## Inspiration

Inspiration was found [here](https://dotfiles.github.io/).