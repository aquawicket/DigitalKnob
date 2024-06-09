if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_load){ $dk_load = 1 } else{ return }


#####################################################################
## dk_load()
##
##
function Global:dk_load($func) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	if(Test-Path "$func"){
		#echo "Import-Module -Global $func"
		#Import-Module -Global $func
		echo . $func
		. $func
		return
	}
	
	if(!(Test-Path "$DKPOWERSHELL_FUNCTIONS_DIR\$func.ps1")) {
		echo "dk_load $func"
		if (! (Test-Path "$DKPOWERSHELL_FUNCTIONS_DIR\dk_download.ps1")) { Invoke-WebRequest -URI "$DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR/dk_download.ps1" -OutFile "$DKPOWERSHELL_FUNCTIONS_DIR\dk_download.ps1" }
		. $DKPOWERSHELL_FUNCTIONS_DIR\dk_download.ps1
		dk_download "$DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR/$func.ps1" "$DKPOWERSHELL_FUNCTIONS_DIR\$func.ps1" 
	}
	
	if(Test-Path "$DKPOWERSHELL_FUNCTIONS_DIR\$func.ps1"){
		echo "Import-Module -Global $DKPOWERSHELL_FUNCTIONS_DIR\$func.ps1"
		Import-Module -Global $DKPOWERSHELL_FUNCTIONS_DIR\$func.ps1
		return
	}
}





function Global:DKTEST() { ###########################################################################################
	

	
}
