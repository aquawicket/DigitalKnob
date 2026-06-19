if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_gitCheckRemote_ps1){ $dk_gitCheckRemote_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_gitCheckRemote()
#
#
function Global:dk_gitCheckRemote() {
	dk_debugFunc 0;

	$ahead=0
	$global:behind=0
	if(dk_call dk_pathExists "${DKBRANCH_DIR}/.git"){
		cd "${DKBRANCH_DIR}"
		dk_call $git_exe remote update
		$branch = $(dk_call ${git_exe} rev-parse --abbrev-ref HEAD)
		$ahead  = $(dk_call ${git_exe} rev-list --count origin/$branch..$branch)
		$behind = $(dk_call ${git_exe} rev-list --count $branch..origin/$branch)
		dk_call dk_info "$ahead commits ahead, $behind commits behind"
	}
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_gitCheckRemote
}
