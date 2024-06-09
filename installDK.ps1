#!/bin/sh

###### install DK.ps1 ######
$DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR = "https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKPowershell/functions"
if (! (Test-Path "DKPowershell")) { New-Item -Path 'DKPowershell' -ItemType Directory }
if (! (Test-Path "DKPowershell/functions")) { New-Item -Path 'DKPowershell/functions' -ItemType Directory }
if (! (Test-Path "DKPowershell/functions/DK.ps1")) { Invoke-WebRequest -URI "$DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1" -OutFile "DKPowershell\functions\DK.ps1" }

###### DK_INIT ######
. DKPowershell\functions\DK.ps1

###### Load Main Program ######
dk_load dk_validate
dk_load dk_validateGit
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
dk_load dk_call
dk_load dk_pause
dk_load dk_exit

###### Run Program ######
dk_validate GIT_EXE "dk_validateGit"
dk_validate DKBRANCH_DIR "dk_validateBranch"
if (! (Test-Path "$DKBRANCH_DIR/.git")){
	dk_call "$GIT_EXE" clone https://github.com/aquawicket/DigitalKnob.git $DKBRANCH_DIR
	cd $DKBRANCH_DIR
	dk_call "$GIT_EXE" checkout $DKBRANCH
	echo "Digitalknob installation complete"
} else {
	echo "DigitalKnob is already installed at $DKBRANCH_DIR"
}

dk_pause
dk_exit
