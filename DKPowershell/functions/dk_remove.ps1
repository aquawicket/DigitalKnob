if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_remove){ $dk_remove = 1 } else{ return }

dk_load dk_call
dk_load dk_replaceAll
dk_load dk_getFullPath
#####################################################################
# dk_remove(path)
#
#
function Global:dk_remove($path) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	$path = dk_replaceAll $path "/" "\"
	if(dk_pathExists $path){
		dk_warning "dk_remove $path does not exist"
		return ${false}
	}
	
	$path = dk_getFullPath $path
	
	dk_call del /F /Q $path >nul 2>&1
	dk_call rd /s /q $path >nul 2>&1
	
	if(dk_pathExists $path){
		dk_error "dk_remove failed to remove $path"
	}
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_remove
}