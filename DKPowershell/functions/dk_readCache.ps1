if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_readCache){ $dk_readCache = 1 } else{ return }

##################################################################################
# dk_readCache()
#
#
function Global:dk_readCache() {
	dk_debugFunc 0

	dk_call dk_validate DKBRANCH_DIR "dk_call dk_validateBranch"

	if(!(dk_call dk_pathExists "${DKBRANCH_DIR}/cache")){ return }
	
	dk_call dk_echo "reading cache... in $DKBRANCH_DIR/cache"
	$count = 0
	
	foreach($line in Get-Content "${DKBRANCH_DIR}/cache") {
		if("${count}" -eq "0"){
			dk_call dk_set _APP_ $line
		}
		if("${count}" -eq "1"){
			dk_call dk_set _TARGET_OS_ $line
		}
		if("${count}" -eq "2"){
			dk_call dk_set _TYPE_ $line
		}
		$count++
	} 
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_readCache
}
