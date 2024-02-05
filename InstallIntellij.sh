#!/bin/bash

# Variables
OPT_PATH="/opt/IntellijIdea"
FILE_NAME="Intellij.tar.gz"
DESKTOP_PATH="$HOME/.local/share/applications/IntellijIdea.desktop"
SYMBOLIC_PATH="/usr/local/bin/intellij"

# Reading the URL of package from cli
read -t 1 URL

function checkForError {
	if [ ! $2 -eq 0 ]
	then
		echo "The installation failed at step $1"
		exit 1	
	fi
}

function createDesktopFile {
	cat <<- EOF > $DESKTOP_PATH
		[Desktop Entry]
		Name=Intellij Idea
		Exec=/usr/local/bin/intellij
		Type=Application
		Icon=$OPT_PATH/bin/idea.png
		Comment=Jetbrains IDE for Java development
		Categories=Development
		StartupNotify=true
	EOF

	checkForError "Creating desktop file" $?
}

function removePreviousVersion {
	# Checking if desktop file exists
	if [ -e $DESKTOP_PATH ]
	then
		rm -f $DESKTOP_PATH
		checkForError "Removing desktop file" $?
	fi

	# Checking if symbolic link exists
	if [ -e $SYMBOLIC_PATH ]
	then
		sudo rm -f $SYMBOLIC_PATH
		checkForError "Removing symbolic link" $?
	fi

	# Checking if Idea directory exists
	if [ -d $OPT_PATH ]
	then
		sudo rm -rf $OPT_PATH
		checkForError "Removing Idea directory" $?
	fi
}

function installVersion {
	echo -e "[ Downloading package from $URL... ]\n"
	wget --quiet --progress bar --show-progress -O $FILE_NAME $URL
	checkForError "Downloading file" $?

	echo -e "\n[ Extracting file ]\n"
	tar -zxf $FILE_NAME
	checkForError "Extraing file" $?

	echo -e "[ Moving file to $OPT_PATH ]\n"
	sudo mv idea-* $OPT_PATH
	checkForError "Moving file" $?

	echo -e "[ Creating symbolic link at /usr/local/bin ]\n"
	sudo ln -s $OPT_PATH/bin/idea.sh $SYMBOLIC_PATH
	checkForError "Creating symbolic link" $?

	echo -e "[ Creating desktop file at /$HOME/.local/share/applications if it does not exist ]\n"
	createDesktopFile

	echo -e "[ Removing extra files ]\n"
	rm -f $FILE_NAME
	checkForError "Removing extra files" $?
}


# If URL is not empty, download the package
if [ ! -z $URL ]
then
	echo -e "[ Removing files for previous version ]\n"
	removePreviousVersion

	echo -e "[ Installing new version ]\n"
	installVersion

	echo -e "[ Installation completed ]\n"
else
	echo 'Please pass the URL from where the file should be downloaded. Do it like this: ./InstallIntellij.sh <<< "URL"'
fi
