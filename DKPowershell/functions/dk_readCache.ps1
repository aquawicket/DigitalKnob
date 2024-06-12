if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_readCache){ $dk_readCache = 1 } else{ return }

dk_load dk_pathExists
dk_load dk_echo
dk_load dk_printVar
dk_load dk_validate
dk_load dk_getDKPaths
dk_load dk_assert
dk_load dk_validateBranch
dk_load dk_set
##################################################################################
# dk_readCache()
#
#
function Global:dk_readCache() {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	dk_validate DKBRANCH_DIR "dk_validateBranch"

	if(!(dk_pathExists "${DKBRANCH_DIR}\cache")){ return 0 }
	
	dk_echo "reading cache... in $DKBRANCH_DIR\cache"
	$count = 0
	
	foreach($line in Get-Content "${DKBRANCH_DIR}\cache") {
		if("${count}" -eq "0"){
			dk_set _APP_ $line
		}
		if("${count}" -eq "1"){
			dk_set _TARGET_OS_ $line
		}
		if("${count}" -eq "2"){
			dk_set _TYPE_ $line
		}
		$count++
	} 
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_readCache
}