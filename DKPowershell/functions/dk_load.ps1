<<<<<<< HEAD
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_load){ $dk_load = 1 } else{ return }
=======
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_load){ $dk_load = 1 } else{ return } #include guard
>>>>>>> Development

#####################################################################
# dk_load(funcName OR funcPath)
#
#	Source a dkpowershell function. Download it if needed then parse it and source all of it's content dkpowershell functions recursivley.
#
#	@funcName OR funcPath  - The name of an existing "functions/funcname.ps1" file, or a full filepath to a .ps1 file.
#
function Global:dk_load ($var) {
	dk_call dk_notice "dk_load is temporarily disabled. Use dk_call and dk_source to download, load and run functions."
	return
	
	dk_debugFunc 1	

	if("${var}" -eq "dk_depend"){ return }  #FIXME: need to better handle non-existant files

	${funcName} = ""
	if(Test-Path "${var}"){
		${funcPath} = Resolve-Path -Path "${var}" -ErrorAction SilentlyContinue -ErrorVariable _frperror 	# works for files that don't exist.
		if(-not(${funcPath})){ ${funcPath} = $_frperror[0].TargetObject } 									# http://devhawk.net/blog/2010/1/22/fixing-powershells-busted-resolve-path-cmdlet
		${funcName} = Split-Path ${funcPath} -leaf															# get basename
		${funcName} = ${funcName}.Substring(0, ${funcName}.lastIndexOf('.'))								# remove extension
	}
	else{
		${funcName} = "${var}"
		${funcName} = Split-Path ${funcName} -leaf															# get basename
		if(${funcName}.lastIndexOf('.') -gt -1){
			${funcName} = ${funcName}.Substring(0, ${funcName}.lastIndexOf('.'))	
		}
		${funcPath} = "${DKPOWERSHELL_FUNCTIONS_DIR}/${funcName}.ps1"
	}
	${funcPath} = ${funcPath} -replace '\\', '/';

	#### download if missing ####
	if(!(Test-Path ${funcPath})){
		if(!(Test-Path "${DKPOWERSHELL_FUNCTIONS_DIR}/dk_download.ps1")){ Invoke-WebRequest -URI "$DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR/dk_download.ps1" -OutFile "${DKPOWERSHELL_FUNCTIONS_DIR}/dk_download.ps1" }
		if(!(Test-Path dk_download)){ . ${DKPOWERSHELL_FUNCTIONS_DIR}/dk_download.ps1 }
		
		dk_download "$DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR/${funcName}.ps1" "${DKPOWERSHELL_FUNCTIONS_DIR}/${funcName}.ps1"
		
		if(!(Test-Path ${funcPath})){
			Write-Host "${funcPath}: file not found"
			return
		}
	}
	
#	# Convert to unix line endings if CRLF found
#	if($(file -b - < ${funcPath}) =~ CRLF){
#		Write-Host "Converting file to Unix line endings"
#		sed -i -e 's/\r$//' ${funcPath}
#	}
	
	if(!("${DKFUNCTIONS_LIST}" -match ";${funcName};")){			#IF NOT REGEX MATCH
	
		$global:DKFUNCTIONS_LIST = "${DKFUNCTIONS_LIST};${funcName};" 			# Add to list
		# Write-Host "added ${funcName} to DKFUNCTIONS_LIST"
		
		$matchList = Select-String -path "${funcPath}" -Pattern "(dk|DK)_[a-zA-Z0-9]*" -AllMatches |
		ForEach-Object{ $_.Matches.Value }
		$matchList = $matchList | select -Unique  # remove duplicates
		
		for($i=0; $i -lt $matchList.count; $i++) {
			${match} = $matchList[$i]
			#Write-Host "match = ${match}"
			
			if("${DKFUNCTIONS_LIST}" -match ";${match};"){
				#Write-Host "${funcName}: skipping ${match}.    already in load_list"
				continue;
			}
			elseif(${funcName} -eq ${match}){
				#Write-Host "${funcName}: skipping ${match}.    already matches funcName"
				continue
			}
			elseif("${match}" -eq ""){
				#Write-Host "${funcName}: skipping ${match}.    empty"
				continue
			}
			else{
				if(!(Test-Path "${match}")){ dk_load ${match} }
			}
		}
		
		if(Test-Path "${funcPath}"){
			#Write-Host ". ${funcPath}"
			#. ${funcPath}
			#Write-Host "Import-Module -Global ${funcPath}"
			Import-Module -Global ${funcPath}
			return
		}
	}
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0

}
