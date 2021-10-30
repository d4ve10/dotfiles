#!/usr/bin/env bash

defaultName=$( git config --global user.name )
defaultEmail=$( git config --global user.email )
defaultGithub=$( git config --global github.user )

if [[ "$defaultGithub" != "" ]]; then
	return
fi

echo "--------------------------------------"
echo "            Setting up Git            "
echo "--------------------------------------"
echo -e "\n"

read -rp "Github username [$defaultGithub] " github
read -rp "Name [$defaultName] " name
read -rp "Email [$defaultEmail] " email

git config --global github.user "${github:-$defaultGithub}"
git config --global user.name "${name:-$defaultName}"
git config --global user.email "${email:-$defaultEmail}"

ssh-keygen -t ed25519 -C "${email:-$defaultEmail}" -f "$HOME/.ssh/id_ed25519_github"
echo "Added ssh key, now you can add it to your GitHub account"