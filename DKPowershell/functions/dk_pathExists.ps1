if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_pathExists){ $dk_pathExists = 1 } else{ return }


##################################################################################
# dk_pathExists(<filepath>)
#
#
function Global:dk_pathExists($filepath){
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }

	if(Test-Path $filepath){
		return $true;
	}
	return $false;
}



function Global:DKTEST(){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	if(dk_pathExists "DK.ps1"){
		echo "The file exists"
	} else {
		echo "The file does NOT exist"
	}
	
	if(dk_pathExists "nofile.ext"){
		echo "The file exists"
	} else {
		echo "The file does NOT exist"
	}
}