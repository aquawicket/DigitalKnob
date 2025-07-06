if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_getFileParams_ps1){ $dk_getFileParams_ps1 = 1; } else{ return; } #include guard


################################################################################
# ${env:dk_getFileParams_PRINT_VARIABLES}=1
################################################################################
# dk_getFileParams(filepath)
#
function Global:dk_getFileParams() {
    dk_debugFunc 0;
	
	${file} = $args[0];
	if(!(Test-Path "${file}")){
		return;
	}
	
	if(${env:dk_getFileParams_PRINT_VARIABLES} -eq 1){
		dk_call dk_debug "### ${file} Parameters ###" 
	}
	
	Write-Host "file = ${file}";
	if(!(${file})){ return; }
	Get-Content ${file} | ForEach-Object {		
		${line} = ${_}
		if(${line}.IndexOf("#") -ge 0){
			${line} = ${line}.SubString(0, ${line}.IndexOf("#"))
		}
		
		if(${line}){
			${line} = ${line}.replace('${','${env:')
			#echo "line = ${line}"
			${line} = ${line} -split '='
			${var} = $ExecutionContext.InvokeCommand.ExpandString($($line[0]).Trim()) # expand any variables in $var 
			${value} = $ExecutionContext.InvokeCommand.ExpandString($($line[1]).Trim()) # expand any variables in $value 
			
			Set-Variable -Name "${var}" -Value "${value}" -Scope Global
			
			if(${env:dk_getFileParams_PRINT_VARIABLES} -eq 1){
				${value} = Get-Variable -Name (${var}) -ValueOnly
				dk_call dk_debug "'${var}' = '${value}'"
			}
		}
	}
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
    dk_debugFunc 0;
  
	${env:DKCACHE_DIR} = $(dk_call dk_DKCACHE_DIR)
	dk_call dk_fileWrite "${env:DKCACHE_DIR}/dk_getFileParams_TEST.txt"		"Testing=dk_getFileParams.ps1"
	dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_getFileParams_TEST.txt"	"varA=ValueOfA"
	dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_getFileParams_TEST.txt"	"varB=ValueOfB 	# with trailing comment"
	dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_getFileParams_TEST.txt"	" varC=ValueOfC "
	dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_getFileParams_TEST.txt"	"varD = ValueOfD"
	dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_getFileParams_TEST.txt"	"#varNONE=ValueOfNONE"
	
	${env:dk_getFileParams_PRINT_VARIABLES}=1
    dk_call dk_getFileParams "${env:DKCACHE_DIR}/dk_getFileParams_TEST.txt"
}
