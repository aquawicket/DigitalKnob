if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_btoa){ $dk_btoa = 1 } else{ return }

##################################################################################
# dk_btoa(file_in, file_out)
#
#    Encode file_in to base-64 file_out
#    https://stackoverflow.com/a/60671753/688352
#
function Global:dk_btoa ($file_in, $file_out){
	dk_debugFunc 2

	
	if(!(dk_pathExists "${file_in}")){ dk_error "file_in:${file_in} not found" }
	if(dk_pathExists ${file_out}){ dk_error "file_out:${file_out} already exists and cannot be overwritten" }
	
	if(dk_pathExists $file_in){ 
		[IO.File]::WriteAllBytes($file_out,[char[]][Convert]::ToBase64String([IO.File]::ReadAllBytes($file_in)))
	}
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_validate DKBRANCH_DIR "dk_validateBranch"
	$input = "${DKBRANCH_DIR}/DKBuilder.ps1"
	$output = "${DKBRANCH_DIR}/DKBuilder.ps1.base64"
	dk_btoa "${input}" "${output}"
}