if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_extract){ $dk_extract = 1 } else{ return }

####################################################################
# dk_extract(file, destination)
#
#
function Global:dk_extract($file, $destination) {
	dk_debugFunc
	if($(__ARGC__) -ne 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	
	dk_info "Extracting $file to $destination . . ."
	if(!(dk_pathExists $file)){ dk_error "cannot find $file"; return $false }
	
	Expand-Archive $file -DestinationPath $destination -Force
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc
	
	
	dk_validate DKDOWNLOAD_DIR "dk_getDKPaths"
	dk_extract $DKDOWNLOAD_DIR/cmake-3.29.5-windows-x86_64.zip $DKDOWNLOAD_DIR
}
