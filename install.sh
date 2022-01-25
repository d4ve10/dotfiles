#!/usr/bin/env bash
DOTFILES="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

command_exists() {
    type "$1" > /dev/null 2>&1
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

echo -ne "
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

echo -ne "
--------------------------------------------------------------------
                        Installing oh-my-zsh
--------------------------------------------------------------------
"

git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.config/oh-my-zsh"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.config/oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.config/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.config/oh-my-zsh/custom}/themes/powerlevel10k

echo -ne "
--------------------------------------------------------------------
                                Done
                        Reload your terminal
--------------------------------------------------------------------
"