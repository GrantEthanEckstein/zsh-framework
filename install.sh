#!/usr/bin/env zsh
set -e -o pipefail

### This script will run the initial installation, including a base plugin ###

PROJECT_ROOT="$HOME/.zsh_framework"

# Move executable, set permissions
mkdir ~/.zsh_framework
cp ./.zsh_loader.sh ~/.zsh_framework/.zsh_loader
chmod ug+x ~/.zsh_framework/.zsh_loader

# Create structure
mkdir -p ~/.zsh_framework/bin ~/.zsh_framework/plugins

# Add execution to profile [heredoc]
cat << EOF >> $HOME/.zshrc
# Zsh framework imports
export PATH=\$PATH:~/.zsh_framework/bin
source ~/.zsh_framework/.zsh_loader
EOF

# Base plugin for creating/editing new plugins
BASE_PLUGIN_ROOT="$PROJECT_ROOT/plugins/base"
mkdir -p $BASE_PLUGIN_ROOT

# Write plugin index [heredoc]
cat << EOF > $BASE_PLUGIN_ROOT/index.sh
#\!/usr/bin/env zsh

zsh_framework () {
  if [ ! -z "\$1" ]; then
    [ -d "\$PROJECT_ROOT/plugins/\$1" ] && vim \$PROJECT_ROOT/plugins/\$1/index.sh || mkdir \$PROJECT_ROOT/plugins/\$1 && vim \$PROJECT_ROOT/plugins/\$1/index.sh
    return
  fi
  echo "Specify $0 [plugin name] to create/edit plugin"
}
EOF

echo "[*] Zsh framework sucessfully installed!"
