#!/bin/sh

# wget http://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/installDK.sh
# chmod 777 installDK.sh
# ./installDK.sh

###### install DK.sh ######
export DKHTTP_DKBASH_FUNCTIONS_DIR="https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBash/functions"
export DKBASH_DIR="$PWD/DKBash"
export DKBASH_FUNCTIONS_DIR="${DKBASH_DIR}/functions"
[ ! -e ${DKBASH_DIR} ] && mkdir ${DKBASH_DIR}
[ ! -e ${DKBASH_FUNCTIONS_DIR} ] && mkdir ${DKBASH_FUNCTIONS_DIR}
if [ ! -e ${DKBASH_FUNCTIONS_DIR}/DK.sh ]; then
	[ -z "$(command -v "curl")" ] && [ -n "$(command -v "tce-load")" ] && tce-load -wil curl
	[ -z "$(command -v "curl")" ] && [ -n "$(command -v "apk")" ] && apk add curl
	curl -Lo ${DKBASH_FUNCTIONS_DIR}/DK.sh ${DKHTTP_DKBASH_FUNCTIONS_DIR}/DK.sh
fi

###### DK_INIT ######
. ${DKBASH_FUNCTIONS_DIR}/DK.sh

###### Load Main Program ######
dk_load dk_validate
dk_load dk_installGit
dk_load dk_validateBranch
dk_load dk_stringContains
dk_load dk_getDKPaths
dk_load dk_getHostTriple
dk_load dk_getExtension
dk_load dk_removeExtension
dk_load dk_makeDirectory
dk_load dk_replaceAll
dk_load dk_convertToCIdentifier
dk_load dk_toLower
dk_load dk_pause
dk_load dk_exit

###### Run Program ######
dk_validate GIT_EXE "dk_installGit"
dk_validate DKBRANCH_DIR "dk_validateBranch"
if [ ! -e "$DKBRANCH_DIR/.git" ]; then
	$GIT_EXE clone https://github.com/aquawicket/DigitalKnob.git $DKBRANCH_DIR
	cd $DKBRANCH_DIR
	$GIT_EXE checkout $DKBRANCH
	echo "Digitalknob installation complete"
else
	echo "DigitalKnob is already installed at $DKBRANCH_DIR"
fi

dk_pause
dk_exit