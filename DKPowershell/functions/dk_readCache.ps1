if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_readCache){ $dk_readCache = 1 } else{ return }

dk_load dk_fileExists
##################################################################################
# dk_readCache()
#
#
function Global:dk_readCache() {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	if(!(dk_fileExists "${DKBRANCH_DIR}\cache")){ return 0 }
	$_APP_ = ""
	$_TARGET_OS_ = ""
	$_TYPE_ = "" 
	
	dk_echo "reading cache..."
	$count = 0
	while( read p){
		if("${count}" -eq "0"){
			$_APP_ = $(echo "${p}" | tr -d '\r')
			#dk_printVar _APP_
		}
		if("${count}" -eq "1"){
			$_TARGET_OS_ = $(echo "${p}" | tr -d '\r')
			#dk_printVar _TARGET_OS_ 
		}
		if("${count}" -eq "2"){
			$_TYPE_ = $(echo "${p}" | tr -d '\r')
			#dk_printVar _TYPE_
		}
		#if("${count}" -eq "3"){
		#	_DKENV_ = $(echo ${p} | tr -d '\r')
		#	#dk_printVar _DKENV_
		#}
		$count++
	}
	#done < "${DKBRANCH_DIR}"/cache
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_readCache
}