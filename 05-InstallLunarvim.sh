#!/bin/bash

#Variables
GLOBAL_DIR=.npm-global
GLOBAL_DIR_PATH="$HOME/$GLOBAL_DIR"
BASHRC_FILE=~/.bashrc

echo -e "[ Installing dependencies ]\n"
sudo dnf install -q -y git make python3-pip nodejs cargo

if [ ! -d $GLOBAL_DIR_PATH ]
then
		echo -e "[ Creating directory $GLOBAL_DIR_PATH for global installations ] \n"
		mkdir $GLOBAL_DIR_PATH
fi

echo -e "[ Changing NPM config ] \n"
if [ ! -e $BASHRC_FILE ]
then
		read -p "File $BASHRC_FILE not found in home directory. Do you wanna create it?" RESPONSE
		
		if [ $RESPONSE =~ "Yy" ]
		then
				echo -e "[ Creating file $BASHRC_FILE ]\n"
				touch $BASHRC_FILE
		else
				echo -e "[ So please to add the next statement to the file where you save the environment variables ] \n"
				echo "export NPM_CONFIG_PREFIX=$BASHRC_FILE"
		fi
else
		grep -q 'export NPM_CONFIG_PREFIX=' $BASHRC_FILE
		if [ $? -gt 0 ]
		then
				echo -e "[ Adding ENV varibale NPM_CONFIG_PREFIX to $BASHRC_FILE ] \n"
				echo export NPM_CONFIG_PREFIX=\"\$HOME/$GLOBAL_DIR\" >> $BASHRC_FILE
		fi
fi

echo -e "[ Installing LunarVim ] \n"
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
