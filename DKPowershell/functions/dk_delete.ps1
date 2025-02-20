if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_delete){ $dk_delete = 1 } else{ return } #include guard

#####################################################################
# dk_delete(path)
#
#
function Global:dk_delete($path) {
	dk_debugFunc 1

	if(!(dk_call dk_pathExists $path)){
		dk_call dk_warning "dk_delete $path does not exist"
		return
	}
	
	$path = dk_call dk_getFullPath $path
	
	#dk_call dk_call del /F /Q $path >nul 2>&1
	#dk_call dk_call rd /s /q $path >nul 2>&1
	Remove-Item -Recurse -Force $path
	
	if(dk_call dk_pathExists $path){
		dk_call dk_error "dk_delete failed to remove $path"
		return ${false}
	}
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_fileWrite "removeMe.file" "created file to test dk_delete"
	dk_call dk_delete "removeMe.file"
}
