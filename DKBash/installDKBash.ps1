#if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$installDKBash){ $installDKBash = 1 } else{ return }

####################################################################
# installDKBash()
#
#function Global:installDKBash() {
	#dk_debugFunc
	#if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }

	if($args.count -ne 0){ 
		runBash $args
		exit
	}
	
	Write-Host "Associating .sh files with DKBash . . ."

	###### DKINIT ######
	$global:DIGITALKNOB_DIR = "$env:HOMEDRIVE$env:HOMEPATH\digitalknob"
	$global:DKBRANCH_DIR = "$DIGITALKNOB_DIR\Development"
	$global:DKPOWERSHELL_FUNCTION_DIR = "$DKBRANCH_DIR\DKPowershell\functions"
	#$global:DKPOWERSHELL_FUNCTION_DIR_ = "$DKPOWERSHELL_FUNCTION_DIR\"
	. $DKPOWERSHELL_FUNCTION_DIR\DK.ps1

	dk_load dk_validate
	dk_validate DKIMPORTS_DIR "dk_validateBranch"
	dk_validate GITBASH_EXE "dk_installGit"

	Write-Host "PSCommandPath = $PSCommandPath"
	$global:DKBASH_FUNCTIONS_DIR = "$DKBRANCH_DIR\DKBash\functions"
	Write-Host "DKBASH_FUNCTIONS_DIR = $DKBASH_FUNCTIONS_DIR"
	Write-Host "GITBASH_EXE = $GITBASH_EXE"
	
	###### Git Bash ######
#	ftype dkbash=cmd /c call "%~f0" "%DKBASH_FUNCTIONS_DIR%" "%GITBASH_EXE%" "%%1" %*
	cmd /c ftype dkbash=powershell $PSCommandPath $DKBASH_FUNCTIONS_DIR $GITBASH_EXE "%%1" %*
	cmd /c assoc .sh=dkbash
#	dkregistrySetKey "HKEY_CLASSES_ROOT\dkbash\DefaultIcon" "" "REG_SZ" "%GITBASH_EXE%"	
#}
pause

function Global:runDKBash() {
	pause
	$DKBASH_FUNCTIONS_DIR = $1
	$GITBASH_EXE = $2
	$SH_FILE = $3

	Write-Host "############### Digitalknob ##################"
	start $GITBASH_EXE $SH_FILE
}