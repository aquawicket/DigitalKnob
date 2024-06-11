if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_assert){ $dk_assert = 1 } else{ return }


#####################################################################
# dk_remove(path)
#
#
function Global:dk_remove($path) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	if(!(dk_pathExists ${path})){
		dk_warning "dk_remove(): $path does not exist"
	}
	
	rm -r -f $path
	dk_sleep 1 # give the path a second to delete
	
	if(dk_pathExists $path){
		dk_error "dk_remove(): failed to remove $path"
		return ${false}
	}
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_remove
}