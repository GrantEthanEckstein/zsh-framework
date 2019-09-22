#!/usr/bin/env zsh

CURRENT_DIRECTORY="$PWD"

### ENV ###
PROJECT_ROOT="$HOME/.zsh_framework"

### Load each plugin ###
for PLUGIN_ROOT_FOLDER in `find $PROJECT_ROOT/plugins/* -maxdepth 0 -type d`
do
	PROJECT_PATH="$PLUGIN_ROOT_FOLDER"

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
			ln -s -f "../$PLUGIN_ROOT_FOLDER/$BIN_FILE" "$PROJECT_ROOT/$BIN_FILE"
		done
	fi
	cd $PROJECT_ROOT
done

cd "$CURRENT_DIRECTORY"
