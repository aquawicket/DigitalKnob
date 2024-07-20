if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_gitCheckRemote){ $dk_gitCheckRemote = 1 } else{ return }

##################################################################################
# dk_gitCheckRemote()
#
#
function Global:dk_gitCheckRemote() {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	
	$ahead=0
	$behind=0
	if(dk_pathExists "${DKBRANCH_DIR}/.git"){
		cd "${DKBRANCH_DIR}"
		dk_call $GIT_EXE remote update
		$branch = $(dk_call ${GIT_EXE} rev-parse --abbrev-ref HEAD)
		$ahead  = $(dk_call ${GIT_EXE} rev-list --count origin/$branch..$branch)
		$behind = $(dk_call ${GIT_EXE} rev-list --count $branch..origin/$branch)
		dk_info "$ahead commits ahead, $behind commits behind"
	}
}




function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc
	
	
	dk_gitCheckRemote
}