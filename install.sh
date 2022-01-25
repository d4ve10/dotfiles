#!/bin/bash
DOTFILES="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

command_exists() {
    type "$1" > /dev/null 2>&1
}

git_clone() {
    git clone --progress ${@:3} "$1" "$2" 2>&1 | grep -v "already exists" || ( cd "$2" && git pull )
}

if ! command_exists stow; then
    echo "stow not found. Please install and then re-run installation script"
    exit 1
fi
if ! command_exists git; then
    echo "git not found. Please install and then re-run installation script"
    exit 1
fi
if ! command_exists zsh; then
    echo "zsh not found. Please install and then re-run installation script"
    exit 1
fi

echo "
--------------------------------------------------------------------
                         Installing dotfiles
--------------------------------------------------------------------
"
for file in $(ls "$DOTFILES/files/"); do
    echo "Installing $file"
    stow --target="$HOME" --dir="$DOTFILES/files/" "$file"
done

zsh_path="$(command -v zsh)"

if [[ "$SHELL" != "$zsh_path" ]]; then
    echo "Configuring zsh as default shell"
    sudo chsh -s "$zsh_path" $(whoami)
    echo "Default shell changed to $zsh_path"
fi

if [ "$1" = "all" ]; then
    source "$DOTFILES/functions/git.sh"
fi

echo "
--------------------------------------------------------------------
                        Installing oh-my-zsh
--------------------------------------------------------------------
"
ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.config/oh-my-zsh/custom}"
git_clone https://github.com/ohmyzsh/ohmyzsh.git ~/.config/oh-my-zsh
git_clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions
git_clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting
git_clone https://github.com/romkatv/powerlevel10k $ZSH_CUSTOM_DIR/themes/powerlevel10k --depth=1

echo -n "
--------------------------------------------------------------------
                                Done
                        Reload your terminal
--------------------------------------------------------------------
"