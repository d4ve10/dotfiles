#!/bin/bash
DOTFILES="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

command_exists() {
    type "$1" > /dev/null 2>&1
}

check_command() {
    if ! command_exists "$1"; then
        echo -e "\033[31merror:\033[0m $1 is not installed"
        exit 1
    fi
}

git_clone() {
    git clone --progress ${@:3} "$1" "$2" 2>&1 | grep -v "already exists" || ( cd "$2" && git pull )
}

check_command stow
check_command git
check_command zsh

echo "
--------------------------------------------------------------------
                         Installing dotfiles
--------------------------------------------------------------------
"

for file in $(ls "$DOTFILES/files/"); do
    echo "Installing $file"
    if [ -d "$DOTFILES/files/$file" ]; then
        (cd "$DOTFILES/files/$file" && find ./ -mindepth 1 -type d -exec mkdir -p "$HOME/{}" \;) &>/dev/null
    fi
    stow --target="$HOME" --dir="$DOTFILES/files/" "$file"
done

chmod 700 "$HOME/.gnupg"

zsh_path="$(command -v zsh)"

if [[ "$SHELL" != "$zsh_path" ]]; then
    echo
    echo "--------------------------------------------------------------------"
    echo "                  Configuring zsh as default shell                  "
    echo "--------------------------------------------------------------------"
    echo
    sudo chsh -s "$zsh_path" $(whoami) &>/dev/null
    if [ $? -eq 0 ]; then
        echo "Default shell changed to $zsh_path"
    else
        echo "Failed to configure zsh as default shell"
    fi
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
