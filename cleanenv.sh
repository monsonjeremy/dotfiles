#!/usr/bin/env zsh

pushd $DOTFILES
for i in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
    echo "FOLDER $folder"
    stow -D $folder
done
popd
