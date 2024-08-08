if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_delete){ $dk_delete = 1 } else{ return }

#####################################################################
# dk_delete(path)
#
#
function Global:dk_delete($path) {
	dk_debugFunc 1

	
	
	#$path = dk_replaceAll $path "/" "\"
	if(!(dk_pathExists $path)){
		dk_warning "dk_delete $path does not exist"
		return
	}
	
	$path = dk_getFullPath $path
	
	#dk_call del /F /Q $path >nul 2>&1
	#dk_call rd /s /q $path >nul 2>&1
	Remove-Item -Recurse -Force $path
	
	if(dk_pathExists $path){
		dk_error "dk_delete failed to remove $path"
		return ${false}
	}
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc
	
	dk_fileWrite "removeMe.file" "created file to test dk_delete"
	dk_delete "removeMe.file"
}