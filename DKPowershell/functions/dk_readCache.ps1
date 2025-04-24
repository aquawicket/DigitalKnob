<<<<<<< HEAD
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_readCache){ $dk_readCache = 1 } else{ return }
=======
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_readCache){ $dk_readCache = 1 } else{ return } #include guard
>>>>>>> Development

##################################################################################
# dk_readCache()
#
#
<<<<<<< HEAD
function Global:dk_readCache($APP, $triple, $TYPE) {
	dk_debugFunc 3
	
	dk_call dk_validate DKCACHE_DIR "dk_call dk_DKHOME_DIR"

	if(!(dk_call dk_pathExists "${DKCACHE_DIR}/cache")){ return }
	
	dk_call dk_echo "reading cache... in $DKCACHE_DIR/cache"
	$count = 0
	
	foreach($line in Get-Content "${DKCACHE_DIR}/cache") {
		if("${count}" -eq "0"){
			Set-Variable -scope global -Name "$APP" -Value $line
		}
		if("${count}" -eq "1"){
			Set-Variable -scope global -Name "$triple" -Value $line
		}
		if("${count}" -eq "2"){
			Set-Variable -scope global -Name "$TYPE" -Value $line
=======
function Global:dk_readCache($target_app, $target_triple, $target_type) {
	dk_debugFunc 3
	
	dk_call dk_validate DKCACHE_DIR "dk_call dk_DKCACHE_DIR"

	if(!(dk_call dk_pathExists "${DKCACHE_DIR}/DKBuilder.cache")){ return }
	
	dk_call dk_echo "reading $DKCACHE_DIR/DKBuilder.cache . . ."
	$count = 0
	
	foreach($line in Get-Content "${DKCACHE_DIR}/DKBuilder.cache") {
		if("${count}" -eq "0"){
			Set-Variable -scope global -Name "$target_app" -Value $line
		}
		if("${count}" -eq "1"){
			Set-Variable -scope global -Name "$target_triple" -Value $line
		}
		if("${count}" -eq "2"){
			Set-Variable -scope global -Name "$target_type" -Value $line
>>>>>>> Development
		}
		$count++
	}
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
    dk_readCache _APP_ _triple_ _TYPE_
	
	dk_printVar $_APP_
	dk_printVar $_triple_
	dk_printVar $_TYPE_
}
