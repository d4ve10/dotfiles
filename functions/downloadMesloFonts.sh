#!/bin/bash
if wget -q --spider https://raw.githubusercontent.com; then
  mkdir $HOME/.fonts &>/dev/null
  wget -c -q -O "$HOME/.fonts/MesloLGS_NF_Regular.ttf" https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Regular.ttf
  wget -c -q -O "$HOME/.fonts/MesloLGS_NF_Bold_Italic.ttf" https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Bold%20Italic.ttf
  wget -c -q -O "$HOME/.fonts/MesloLGS_NF_Bold.ttf" https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Bold.ttf
  wget -c -q -O "$HOME/.fonts/MesloLGS_NF_Italic.ttf" https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Italic.ttf
  fc-cache -f -v &>/dev/null
fi