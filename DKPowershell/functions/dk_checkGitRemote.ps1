if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_checkGitRemote){ $dk_checkGitRemote = 1 } else{ return }

dk_load dk_pathExists
##################################################################################
# dk_checkGitRemote()
#
#
function Global:dk_checkGitRemote () {
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




function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	dk_checkGitRemote
}