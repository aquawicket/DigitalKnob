#if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$installDKBash){ $installDKBash = 1 } else{ return }

####################################################################
# dk_install()
#
#function Global:dk_install() {
	#dk_debugFunc 0;

	if(${args}.count -ne 0){ 
		runBash ${args}
		exit
	}
	
	Write-Host "Associating .sh files with DKBash . . ."

	###### INIT ######
	$global:DIGITALKNOB_DIR = "$env:USERPROFILE/DigitalKnob"
	$global:DKBRANCH_DIR = "$DIGITALKNOB_DIR/Development"
	$global:DKPOWERSHELL_FUNCTION_DIR = "$DKBRANCH_DIR/DKPowershell/functions"
	#$global:DKPOWERSHELL_FUNCTION_DIR_ = "$DKPOWERSHELL_FUNCTION_DIR/"
	. $DKPOWERSHELL_FUNCTION_DIR/DK.ps1

	dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR"
	dk_call dk_validate gitbash_exe "dk_call dk_installGit"

	Write-Host "PSCommandPath = $PSCommandPath"
	$global:DKBASH_FUNCTIONS_DIR = "$DKBRANCH_DIR/DKBash/functions"
	Write-Host "DKBASH_FUNCTIONS_DIR = $DKBASH_FUNCTIONS_DIR"
	Write-Host "gitbash_exe = $gitbash_exe"
	
	###### Git Bash ######
#	ftype dkbash=cmd /c call "%~f0" "%DKBASH_FUNCTIONS_DIR%" "%gitbash_exe%" "%%1" %*
	cmd /c ftype dkbash=powershell $PSCommandPath $DKBASH_FUNCTIONS_DIR $gitbash_exe "%%1" %*
	cmd /c assoc .sh=dkbash
#	dkregistrySetKey "HKEY_CLASSES_ROOT/dkbash/DefaultIcon" "" "REG_SZ" "%gitbash_exe%"	
#}
pause

function Global:runDKBash() {
	pause
	$DKBASH_FUNCTIONS_DIR = $1
	$gitbash_exe = $2
	$DKSCRIPT_PATH = $3

	Write-Host "############### Digitalknob ##################"
	start $gitbash_exe $DKSCRIPT_PATH
}