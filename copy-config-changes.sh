#!/bin/bash

usage() {
	MYNAME=$(basename ${0})
	echo "Usage: $MYNAME [Options]"
	echo "Copies the configuration files which have changed from the original package version to a folder"
	echo
	echo "Copies are organized in subfolders corresponding to the location in the file hierarchy where they"
	echo "originally appeared. The subfolder where they are saved is always named \"<hostname>-config-changes\"."
	echo
	echo "Options:"
	echo "    -h    Show this help and exit"
	echo
	exit 1
}


if [ "$1" == "-h" ] ; then usage ; fi
CURRENT_DIR=$(realpath .)
if [ "$(basename $CURRENT_DIR)" == "$(hostname)-config-changes" ]
then
	REPO="$CURRENT_DIR"
	echo "Using current directory as repo"
else
	REPO="$CURRENT_DIR/$(hostname)-config-changes"
	if [ ! -d "$REPO" ]
	then
		read -s -n1 -p "Create directory to store changes at $REPO? [y/N] " INKEY
		echo
		if [ "$INKEY" != "y" ] ; then exit ; fi
		mkdir $REPO
	fi
fi

for FILE in $(sudo debsums -ca)
do
	TGT_DIR="$REPO$(dirname $FILE)"
	mkdir -p "$TGT_DIR"
	TGT="$TGT_DIR/$(basename $FILE)"
	echo $FILE
	cp "$FILE" "$TGT"
done

