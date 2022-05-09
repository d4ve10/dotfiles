#!/usr/bin/env bash

defaultName=$( git config --global user.name )
defaultEmail=$( git config --global user.email )
defaultGithub=$( git config --global github.user )

if [[ "$defaultGithub" != "" ]]; then
	return
fi

echo "
--------------------------------------------------------------------
                           Setting up Git
--------------------------------------------------------------------
"

read -rp "Github username [$defaultGithub] " github
read -rp "Email [$defaultEmail] " email

git config --global github.user "${github:-$defaultGithub}"
git config --global user.name "${github:-$defaultName}"
git config --global user.email "${email:-$defaultEmail}"

echo "
--------------------------------------------------------------------
                          Creating SSH Key
--------------------------------------------------------------------
"

ssh-keygen -t ed25519 -C "${email:-$defaultEmail}" -f "$HOME/.ssh/id_ed25519_github"
echo -n "
--------------------------------------------------------------------
                            Added SSH Key
                You can add it to your GitHub account
--------------------------------------------------------------------
"
cat "$HOME/.ssh/id_ed25519_github.pub"
