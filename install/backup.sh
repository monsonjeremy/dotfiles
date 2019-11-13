#!/usr/bin/env bash
INSTALLDIR=$PWD

echo "---------------------------------------------------------"
echo "$(tput setaf 2)JARVIS: Backup up current files.$(tput sgr 0)"
echo "---------------------------------------------------------"

# Backup files that are provided by the Jarvis into a ~/$INSTALLDIR-backup directory
BACKUP_DIR=$INSTALLDIR/backup

set -e # Exit immediately if a command exits with a non-zero status.

echo "---------------------------------------------------------"
echo "$(tput setaf 2)JARVIS: Creating backup directory at $BACKUP_DIR.$(tput sgr 0)"
echo "---------------------------------------------------------"
mkdir -p $BACKUP_DIR

NVIM_CONFIG="$HOME/.config/nvim"
if [ ! -L $NVIM_CONFIG ]; then
    echo "---------------------------------------------------------"
    echo "$(tput setaf 2)JARVIS: Backing up $NVIM_CONFIG.$(tput sgr 0)"
    echo "---------------------------------------------------------"
    mv $NVIM_CONFIG $BACKUP_DIR 2>/dev/null
else
    echo "---------------------------------------------------------"
    echo -e "$(tput setaf 3)JARVIS: $NVIM_CONFIG does not exist at this location or is a symlink.$(tput sgr 0)"
    echo "---------------------------------------------------------"
fi

linkables=$(find -H "$INSTALLDIR" -maxdepth 3 -name '*.symlink')
for file in $linkables; do
    target="$HOME/.$(basename $file '.symlink')"
    if [ ! -L $target ]; then
        echo "---------------------------------------------------------"
        echo "$(tput setaf 2)JARVIS: Backing up $target.$(tput sgr 0)"
        echo "---------------------------------------------------------"
        mv $target $BACKUP_DIR 2>/dev/null
    else
        echo "---------------------------------------------------------"
        echo -e "$(tput setaf 3)JARVIS: $target does not exist at this location or is a symlink.$(tput sgr 0)"
        echo "---------------------------------------------------------"
    fi
done

echo "---------------------------------------------------------"
echo "$(tput setaf 2)JARVIS: Backup completed.$(tput sgr 0)"
echo "---------------------------------------------------------"
