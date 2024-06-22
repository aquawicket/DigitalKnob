if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_atob){ $dk_atob = 1 } else{ return }

#dk_load dk_validate
#dk_load dk_validateBranch
#dk_load dk_pathExists
##################################################################################
# dk_atob(file_in, file_out)
#
#    Decode base-64 file_in to file_out
#    https://stackoverflow.com/a/60671753/688352
#
function Global:dk_atob ($file_in, $file_out){
	dk_debugFunc
	if($(__ARGC__) -ne 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	if(!(dk_pathExists $file_in)){ dk_error "$file_in not found" }
	if(dk_pathExists $file_out){ dk_error "$file_out already exists and cannot be overwritten" }
	
	if(dk_pathExists $file_in){ 
		[IO.File]::WriteAllBytes($file_out, [Convert]::FromBase64String([char[]][IO.File]::ReadAllBytes($file_in)))
	}
}





function Global:DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_validate DKBRANCH_DIR "dk_validateBranch"
	$input = "${DKBRANCH_DIR}/DKBuilder.ps1.base64"
	$output = "${DKBRANCH_DIR}/DKBuilder_decoded.ps1"
	dk_atob "${input}" "${output}"
}