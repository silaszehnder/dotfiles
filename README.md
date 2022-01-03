# Dotfiles

Personal dotfiles of various configs.

## Usage

Use `setup.sh` to automatically symlink some of the more common configs that will
be used across distros/desktop environments. It will create a backup of pre-existing
dotfiles that it attempts to symlink.

More specific configs for things like `i3` and `compton` won't be automatically
linked unless the list of files in `setup.sh` is modified to include these files.
