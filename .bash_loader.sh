#!/usr/bin/env bash

### ENV ###
PROJECT_ROOT="$PWD"
# BIN_PATH="$PROJECT_ROOT/bin/"

### Load global alias and function files ###
source $PROJECT_ROOT/aliases.sh
source $PROJECT_ROOT/functions.sh

### Load each plugin ###
for PLUGIN_ROOT_FOLDER in `find plugins/* -maxdepth 0 -type d`
do
	PROJECT_PATH="$PROJECT_ROOT/$PLUGIN_ROOT_FOLDER"

	# If index file exists, include it
	cd $PROJECT_PATH && if test -f index.sh
	then
	       	source index.sh
	else
		echo "[!] Found invalid plugin - $PLUGIN_ROOT_FOLDER"	
	fi

	# If there are executables, soft link them
	if test -d bin
	then
		for BIN_FILE in `find bin/* -type f`
		do
			echo "Found file $BIN_FILE"
			ln -s -f "../$PLUGIN_ROOT_FOLDER/$BIN_FILE" "$PROJECT_ROOT/$BIN_FILE"
		done
	fi
	cd $PROJECT_ROOT
done
