if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_btoa_ps1){ $dk_btoa_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_btoa(file_in, file_out)
#
#    Encode file_in to base-64 file_out
#    https://stackoverflow.com/a/60671753/688352
#
function Global:dk_btoa() {
	dk_debugFunc 2;
	
	${file_in} = $($args[0]);
	${file_out} = $($args[1]);

	if(!(dk_call dk_pathExists "${file_in}")){ dk_call dk_error "file_in:${file_in} NOT found" }
	if(dk_call dk_pathExists ${file_out}){ dk_call dk_error "file_out:${file_out} already exists AND cannot be overwritten" }
	
	if(dk_call dk_pathExists $file_in){ 
		[IO.File]::WriteAllBytes($file_out,[char[]][Convert]::ToBase64String([IO.File]::ReadAllBytes($file_in)))
	}
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
	$input = "${DKBRANCH_DIR}/README.md"
	$output = "${DKBRANCH_DIR}/README.md.base64"
	dk_call dk_btoa "${input}" "${output}"
}
