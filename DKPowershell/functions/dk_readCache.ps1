if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_readCache){ $dk_readCache = 1 } else{ return }

dk_load dk_pathExists
##################################################################################
# dk_readCache()
#
#
function Global:dk_readCache() {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	if(!(dk_pathExists "${DKBRANCH_DIR}\cache")){ return 0 }
	$_APP_ = ""
	$_TARGET_OS_ = ""
	$_TYPE_ = "" 
	
	dk_echo "reading cache..."
	$count = 0
	
	foreach($line in Get-Content "${DKBRANCH_DIR}\cache") {
		if("${count}" -eq "0"){
			$_APP_ = $line
			#dk_printVar _APP_
		}
		if("${count}" -eq "1"){
			$_TARGET_OS_ = $line
			#dk_printVar _TARGET_OS_ 
		}
		if("${count}" -eq "2"){
			$_TYPE_ = $line
			#dk_printVar _TYPE_
		}
		#if("${count}" -eq "3"){
		#	_DKENV_ = $line
		#	#dk_printVar _DKENV_
		#}
		$count++
	} 
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_readCache
}