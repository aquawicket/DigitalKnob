if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_fileAppend){ $dk_fileAppend = 1 } else{ return }

dk_load dk_pathExists
##################################################################################
# dk_fileAppend(filepath, str)
#
#
function Global:dk_fileAppend($filepath, $str) {
	dk_debugFunc
	if($(__ARGC__) -lt 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	if(dk_pathExists "$filepath"){ echo "$str" >> "$filepath" }
	else{ echo "$str" > "$filepath" }
}




function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_fileAppend "dk_fileAppend_TEST.txt" "string appended from dk_fileAppend"
}