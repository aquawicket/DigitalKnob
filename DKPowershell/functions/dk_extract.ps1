if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_extract){ $dk_extract = 1 } else{ return } #include guard

####################################################################
# dk_extract(file, destination)
#
#
function Global:dk_extract($file, $destination){
	dk_debugFunc 2

	dk_call dk_info "Extracting $file to $destination . . ."
	if(!(dk_call dk_pathExists $file)){ dk_call dk_error "cannot find $file"; return $false }
	
	#Expand-Archive $file -DestinationPath $destination -Force
	
	Add-Type -Assembly "System.IO.Compression.Filesystem"
	[System.IO.Compression.ZipFile]::ExtractToDirectory("$file", "$destination")
}










###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST(){
	dk_debugFunc 0
	
	dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR"
	dk_call dk_extract $DKDOWNLOAD_DIR/cmake-3.29.5-windows-x86_64.zip $DKDOWNLOAD_DIR
}
