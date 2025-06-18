if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_getFileParams_ps1){ $dk_getFileParams_ps1 = 1 } else{ return } #include guard



################################################################################
# dk_getFileParams(filepath)
#
function Global:dk_getFileParams() {
    dk_debugFunc 0
	
	${file} = $args[0]
	
	Get-Content ${file} | ForEach-Object {		
		${line} = ${_}
		if(${line}.IndexOf("#") -ge 0){
			${line} = ${line}.SubString(0, ${line}.IndexOf("#"))
		}
		
		if(${line}){
			${line} = ${line}.replace('${','${env:')
			#echo "line = ${line}"
			${line} = ${line} -split '='
			${var} = $($line[0]).Trim()
			${value} = iex $($line[1]).Trim() # evauluate $value to expand any variables
			
			Set-Variable -Name "${var}" -Value "${value}" -Scope Global
			
			${value} = Get-Variable -Name (${var}) -ValueOnly
			dk_call dk_debug "'${var}' = '${value}'"
		}
	}
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
    dk_debugFunc 0
  
    dk_call dk_getFileParams "$(dk_call dk_DKBRANCH_DIR)/dkconfig.txt"
}
