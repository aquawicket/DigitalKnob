if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_load){ $dk_load = 1 } else{ return }


#####################################################################
# dk_load()
#
#	Source a DKPowershell function. Download it if needed then source all of is content DKPowershell functions recursivley.
#
function Global:dk_load ($var) {
	dk_debugFunc	
	if($(__ARGC__) -ne 1){ echo "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	if("$var" -eq "dk_depend"){ return }  #FIXME: need to better handle non-existant files

	$fn = ""
	if(Test-Path "$var"){
		$fpath = Resolve-Path -Path "$var" -ErrorAction SilentlyContinue -ErrorVariable _frperror #Calls Resolve-Path but works for files that don't exist.
		if(-not($fpath)){ $fpath = $_frperror[0].TargetObject } # http://devhawk.net/blog/2010/1/22/fixing-powershells-busted-resolve-path-cmdlet
		$fn = Split-Path $fpath -leaf
		$fn = $fn.Substring(0, $fn.lastIndexOf('.'))
	}
	else{
		$fn = "${var}"
		$fn = Split-Path ${fn} -leaf
		$fpath = "${DKPOWERSHELL_FUNCTIONS_DIR}/${fn}.ps1"
	}

	#### download if missing ####
	if(!(Test-Path ${fpath})){
		if(!(Test-Path "${DKPOWERSHELL_FUNCTIONS_DIR}/dk_info.ps1")){ Invoke-WebRequest -URI "$DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR/dk_info.ps1" -OutFile "$DKPOWERSHELL_FUNCTIONS_DIR/dk_info.ps1" }
		if(!(Test-Path "${DKPOWERSHELL_FUNCTIONS_DIR}/dk_download.ps1")){ Invoke-WebRequest -URI "$DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR/dk_download.ps1" -OutFile "$DKPOWERSHELL_FUNCTIONS_DIR/dk_download.ps1" }
		if(!(Test-Path dk_download)){ . ${DKPOWERSHELL_FUNCTIONS_DIR}/dk_download.ps1 }
		
		Write-Host "Dowloading ${fn}"
		dk_download "$DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR/${fn}.ps1" "$DKPOWERSHELL_FUNCTIONS_DIR/${fn}.ps1"
		if(!(Test-Path ${fpath})){ Write-Host "ERROR: ${fpath}: file not found"; return }
	}
	
#	# Convert to unix line endings if CRLF found
#	if($(file -b - < ${fpath}) =~ CRLF){
#		Write-Host "Converting file to Unix line endings"
#		sed -i -e 's/\r$//' ${fpath}
#	}
	
	if(Test-Path ${fpath}){
		$fn = ${fpath}
    }
	else {
        Write-Host "${fpath}: file not found"
		return
    }
	
	
	
	
	
	
	
	
	if(Test-Path "$var"){
		#echo "Import-Module -Global $var"
		#Import-Module -Global $var
		Write-Host ". $var"
		. $var
		return
	}
	
#	if(!(Test-Path "$DKPOWERSHELL_FUNCTIONS_DIR/$var.ps1")) {
#		echo "dk_load $var"
#		if(!(Test-Path "$DKPOWERSHELL_FUNCTIONS_DIR/dk_download.ps1")){ Invoke-WebRequest -URI "$DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR/dk_download.ps1" -OutFile "$DKPOWERSHELL_FUNCTIONS_DIR/dk_download.ps1" }
#		. $DKPOWERSHELL_FUNCTIONS_DIR/dk_download.ps1
#		dk_download "$DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR/$var.ps1" "$DKPOWERSHELL_FUNCTIONS_DIR/$var.ps1" 
#	}
	
	if(Test-Path "$DKPOWERSHELL_FUNCTIONS_DIR/$var.ps1"){
		echo "Import-Module -Global $DKPOWERSHELL_FUNCTIONS_DIR/$var.ps1"
		Import-Module -Global $DKPOWERSHELL_FUNCTIONS_DIR/$var.ps1
		return
	}
}





function Global:DKTEST () { ###########################################################################################
	dk_debugFunc

}
