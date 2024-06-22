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
	if("${var}" -eq "dk_depend"){ return }  #FIXME: need to better handle non-existant files

	${fn} = ""
	if(Test-Path "${var}"){
		${fpath} = Resolve-Path -Path "${var}" -ErrorAction SilentlyContinue -ErrorVariable _frperror #Calls Resolve-Path but works for files that don't exist.
		if(-not(${fpath})){ ${fpath} = $_frperror[0].TargetObject } # http://devhawk.net/blog/2010/1/22/fixing-powershells-busted-resolve-path-cmdlet
		${fn} = Split-Path ${fpath} -leaf
		${fn} = ${fn}.Substring(0, ${fn}.lastIndexOf('.'))
	}
	else{
		${fn} = "${var}"
		${fn} = Split-Path ${fn} -leaf
		${fpath} = "${DKPOWERSHELL_FUNCTIONS_DIR}/${fn}.ps1"
	}
	${fpath} = ${fpath} -replace '\\', '/';

	#### download if missing ####
	if(!(Test-Path ${fpath})){
		if(!(Test-Path "${DKPOWERSHELL_FUNCTIONS_DIR}/dk_info.ps1")){ Invoke-WebRequest -URI "$DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR/dk_info.ps1" -OutFile "$DKPOWERSHELL_FUNCTIONS_DIR/dk_info.ps1" }
		if(!(Test-Path "${DKPOWERSHELL_FUNCTIONS_DIR}/dk_download.ps1")){ Invoke-WebRequest -URI "$DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR/dk_download.ps1" -OutFile "$DKPOWERSHELL_FUNCTIONS_DIR/dk_download.ps1" }
		if(!(Test-Path dk_download)){ . ${DKPOWERSHELL_FUNCTIONS_DIR}/dk_download.ps1 }
		
		Write-Host "Dowloading ${fn}"
		dk_download "$DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR/${fn}.ps1" "$DKPOWERSHELL_FUNCTIONS_DIR/${fn}.ps1"
	}
	if(!(Test-Path ${fpath})){
		Write-Host "${fpath}: file not found"
		return
    }
	
	
#	# Convert to unix line endings if CRLF found
#	if($(file -b - < ${fpath}) =~ CRLF){
#		Write-Host "Converting file to Unix line endings"
#		sed -i -e 's/\r$//' ${fpath}
#	}
	

	if(!("${dkload_list}" -match ";${fn};")){			#IF NOT REGEX MATCH
	
		$global:dkload_list = "${dkload_list};${fn};" 			# Add to list
		# Write-Host "added ${fn} to dkload_list"
		
		$matchList = Select-String -path "${fpath}" -Pattern "(dk|DK)_[a-zA-Z0-9]*" -AllMatches |
		ForEach-Object{ $_.Matches.Value }
		$matchList = $matchList | select -Unique  # remove duplicates
		
		for($i=0; $i -lt $matchList.count; $i++) {
			${match} = $matchList[$i]
			#Write-Host "match = ${match}"
			
			if("${dkload_list}" -match ";${match};"){
				#echo "${fn}: skipping ${match}.    already in load_list"
				continue;
			}
			elseif(${fn} -eq ${match}){
				#echo "${fn}: skipping ${match}.    already matches fn"
				continue
			}
			elseif("${match}" -eq ""){
				#echo "${fn}: skipping ${match}.    empty"
				continue
			}
			else{
				if(!(Test-Path "${match}")){ dk_load ${match} }
			}
		}
		
		if(Test-Path "${fpath}"){
			Write-Host ". ${fpath}"
			. ${fpath}
			return
		}
		
#		if(Test-Path "${var}"){
#  echo "if(Test-Path ${var}){"
#			Write-Host ". ${var}"
#			. ${var}
#			return
#		}
#		if(Test-Path "$DKPOWERSHELL_FUNCTIONS_DIR/${var}.ps1"){
# echo "if(Test-Path $DKPOWERSHELL_FUNCTIONS_DIR/${var}.ps1){"
#			echo "Import-Module -Global $DKPOWERSHELL_FUNCTIONS_DIR/${var}.ps1"
#			Import-Module -Global $DKPOWERSHELL_FUNCTIONS_DIR/${var}.ps1
#			return
#		}
	}	
}





function Global:DKTEST () { ###########################################################################################
	dk_debugFunc

}
