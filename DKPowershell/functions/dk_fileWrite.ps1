if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_fileWrite){ $dk_fileWrite = 1 } else{ return }

dk_load dk_error
##################################################################################
# dk_fileWrite(filepath, str)
#
#
function Global:dk_fileWrite($filepath, $str) {
	dk_debugFunc
	if($(__ARGC__) -lt 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	echo "$str" > "$filepath" 
}




function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc

	dk_fileWrite "dk_fileWrite_TEST.txt" "string written by dk_fileWrite"
}