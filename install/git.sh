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

ssh-keygen -t ed25519 -C "${email:-$defaultEmail}"
echo "Added ssh key, now you can add it to your GitHub account"

gpg --full-generate-key
gpg --list-secret-keys --keyid-format LONG
git config --global commit.gpgsign true
echo "With the command 'git config --global user.signingkey ID', you can tell git your GPG key ID"
echo "With the command 'gpg --armor --export ID', you can see your GPG key and add it to GitHub"
