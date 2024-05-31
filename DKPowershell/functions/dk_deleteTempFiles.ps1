if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_deleteTempFiles){ $dk_deleteTempFiles = 1 } else{ return }


##################################################################################
# dk_deleteTempFiles()
#
#
function Global:dk_deleteTempFiles () {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }

	dk_info "Deleting .TMP files . . ."
	
	dk_validate DIGITALKNOB_DIR dk_getDKPaths	
	#rm -rf $(find "${DIGITALKNOB_DIR}" -type d -name *.tmp)
	#rm -rf $(find "${DIGITALKNOB_DIR}" -type d -name *.TMP)
	#find "${DIGITALKNOB_DIR}" -name "*.tmp" -delete
	#find "${DIGITALKNOB_DIR}" -name "*.TMP" -delete
}




function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_deleteTempFiles
}