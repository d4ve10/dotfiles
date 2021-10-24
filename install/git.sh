#!/usr/bin/env bash

defaultName=$( git config --global user.name )
defaultEmail=$( git config --global user.email )
defaultGithub=$( git config --global github.user )

if [[ "$defaultGithub" != "" ]]; then
	return
fi

printf "Setting up Git...\\n\\n"

read -rp "Name [$defaultName] " name
read -rp "Email [$defaultEmail] " email
read -rp "Github username [$defaultGithub] " github

git config --global user.name "${name:-$defaultName}"
git config --global user.email "${email:-$defaultEmail}"
git config --global github.user "${github:-$defaultGithub}"

read -rn 1 -p "Save user and password to an unencrypted file to avoid writing? [y/N] " save
echo
if [[ $save =~ ^([Yy])$ ]]; then
    git config --global credential.helper "store"
else
    git config --global credential.helper "cache --timeout 3600"
fi

ssh-keygen -t ed25519 -C "${email:-$defaultEmail}" -f "$HOME/.ssh/id_ed25519_github"
echo "Added ssh key, now you can add it to your GitHub account"