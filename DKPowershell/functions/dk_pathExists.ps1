if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_pathExists){ $dk_pathExists = 1 } else{ return }


dk_load dk_info
dk_load dk_printVar
##################################################################################
# dk_pathExists(<filepath>)
#
#
function Global:dk_pathExists($filepath){
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }


	if(Test-Path $filepath){ $pathExists = $true } 
	else { $pathExists = $false }
	dk_printVar pathExists
	return $pathExists
}



function Global:DKTEST(){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	if(dk_pathExists "DK.ps1"){ dk_info "The file exists" }
	else{ dk_info "The file does NOT exist" }
	
	if(dk_pathExists "nofile.ext"){ dk_info "The file exists" } 
	else{ dk_info "The file does NOT exist" }
}