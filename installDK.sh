#!/bin/sh

###### DK_SETUP ######
[ ! -e DKBash ] && mkdir DKBash
[ ! -e DKBash/functions ] && mkdir DKBash/functions
if [ ! -e DKBash/functions/DK.sh ]; then
	[ -z "$(command -v "curl")" ] && [ -n "$(command -v "tce-load")" ] && tce-load -wil curl
	curl -Lo DKBash/functions/DK.sh https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBash/functions/DK.sh
fi

###### DK_INIT ######
. DKBash/functions/DK.sh

###### Load Main Program ######
dk_load dk_validate
dk_load dk_validateBranch
dk_load dk_validateGit
dk_load dk_stringContains
dk_load dk_getDKPaths
dk_load dk_getHostTriple
dk_load dk_getExtension
dk_load dk_removeExtension
dk_load dk_makeDirectory
dk_load dk_replaceAll
dk_load dk_convertToCIdentifier
dk_load dk_toLower

###### Run Program ######
dk_validate DKBRANCH_DIR "call dk_validateBranch"
dk_validate GIT_EXE "call dk_validateGit"
if [ ! -e "$DKBRANCH_DIR/.git" ]; then
	$GIT_EXE clone https://github.com/aquawicket/DigitalKnob.git $DKBRANCH_DIR
	cd $DKBRANCH_DIR
	$GIT_EXE checkout $DKBRANCH
	echo "Digitalknob installation complete"
	#pause
	#exit
else
	echo "DigitalKnob is already installed at $DKBRANCH_DIR"
fi
