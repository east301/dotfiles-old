#!/bin/sh

which rpath.py >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "[ERROR] rpath.py is not found." 1>&2
    exit 1
fi

if [ $# -ne 1 ]; then
    echo "Usage:" 1>&2
    echo "    $0 [profile]" 1>&2
    exit 1
fi


DF_DIR=$(rpath.py -n -d 2 $0)
VCS_DIR=$DF_DIR/vcs

python $DF_DIR/dependencies/vcs-profile-manager/manager.py\
    --profile-directory $VCS_DIR --profile-prefix "git-"\
    change git $VCS_DIR/git-template.ini "$1" ~/.gitconfig
