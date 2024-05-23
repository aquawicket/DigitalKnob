if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_load){ $dk_load = 1 } else{ return }

. $PWD\dk_debugFunc.ps1
#####################################################################
## dk_load()
##
##
function Global:dk_load($func) {
	dk_debugFunc
	if (! (Test-Path "$DKPOWERSHELL_DIR\functions\$func.ps1")) {
		echo "dk_load $func"
		
#		if (! (Test-Path "$DKPOWERSHELL_DIR\functions\dk_download.ps1")) { Invoke-WebRequest -URI "$DKHTTP/dk_download.ps1" -OutFile "$DKPOWERSHELL_DIR\functions\dk_download.ps1" }
#		. $DKPOWERSHELL_DIR\functions\dk_download.ps1
#		dk_download "$DKHTTP/$func.ps1" "$DKPOWERSHELL_DIR\functions\$func.ps1" 
	}
	
	
	
	if (Test-Path "$func"){
		echo "Import-Module -Global $func"
		Import-Module -Global $func
		return
	}
	if (Test-Path "$DKPOWERSHELL_DIR\functions\$func.ps1"){
		echo "Import-Module -Global $DKPOWERSHELL_DIR\functions\$func.ps1"
		Import-Module -Global $DKPOWERSHELL_DIR\functions\$func.ps1
		return
	}
}





function Global:DKTEST() { ###########################################################################################
	

	
}
