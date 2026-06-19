if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_fileVariables_ps1){ $dk_fileVariables_ps1 = 1; } else{ return; } #include guard


################################################################################
if(!${ENV:dk_fileVariables_PRINT_VARIABLES}){ ${ENV:dk_fileVariables_PRINT_VARIABLES}=0; }
################################################################################
# dk_fileVariables(filepath)
#
function Global:dk_fileVariables() {
    dk_debugFunc 1;
	
	${file} = $args[0];
	${file} = ${file} -replace "\\", "/";
	if(!(Test-Path "${file}")){
		return;
	}
	
	if(${env:dk_fileVariables_PRINT_VARIABLES} -eq 1){
		dk_call dk_debug "### ${file} Parameters ###";
	}
	
	if(!(${file})){ return; }
	Get-Content ${file} | ForEach-Object {		
		${line} = ${_};
		if(${line}.IndexOf("#") -ge 0){
			${line} = ${line}.SubString(0, ${line}.IndexOf("#"));
		}
		
		if(${line}){
			${line} = ${line}.replace('$ENV{','${ENV:');
			#echo "line = ${line}";
			${line} = ${line} -split '=';
			${var} = $ExecutionContext.InvokeCommand.ExpandString($($line[0]).Trim()); # expand any variables in $var 
			${value} = $ExecutionContext.InvokeCommand.ExpandString($($line[1]).Trim()); # expand any variables in $value 
			
			Set-Variable -Name "${var}" -Value "${value}" -Scope Global;

			if(${dk_fileVariables_PRINT_VARIABLES} -eq 1){
				${value2} = Get-Variable -Name (${var}) -ValueOnly;
				dk_call dk_debug "'${var}' = '${value2}'";
			}
		}
	}
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
    dk_debugFunc 0;
	
	#${global:varH} = "Value of varH";
	${env:DKCACHE_DIR} = $(dk_call dk_DKCACHE_DIR);
	dk_call dk_fileWrite "${env:DKCACHE_DIR}/dk_fileVariables_TEST.txt"		'### dk_fileVariables TEST ###'
	dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_fileVariables_TEST.txt"	'varA=Value_of_varA'
	dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_fileVariables_TEST.txt"	'varB=Value_of_varB_with_trailing_comment 	# with trailing comment'
	dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_fileVariables_TEST.txt"	'varC=Value of varC with spaces'
	dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_fileVariables_TEST.txt"	' varD=Value of varD padded with spaces '
	#dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_fileVariables_TEST.txt"	'varE=\"Value of varE with value enclosed inquotes\"'
	#dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_fileVariables_TEST.txt"	'\"varF\"=Value of varF with varname enclosed in quotes'
	#dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_fileVariables_TEST.txt"	'\"varG=Value of varG with line enclosed in quotes\"'
	dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_fileVariables_TEST.txt"	'varH=Value of varH'
	dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_fileVariables_TEST.txt"	'varI=${varH}'
	dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_fileVariables_TEST.txt"	'varJ=varK'
	dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_fileVariables_TEST.txt"	'${varJ}=Value of varK'
	dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_fileVariables_TEST.txt"	'#varL=Value of varL Commented'
	
	dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_fileVariables_TEST.txt"	'ComSpec=$ENV{ComSpec}'
	dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_fileVariables_TEST.txt"	'USERPROFILE=$ENV{USERPROFILE}'
	dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_fileVariables_TEST.txt"	'SHELL=$ENV{SHELL}'
	dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_fileVariables_TEST.txt"	'_HOME=$ENV{HOME}'
	
	dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_fileVariables_TEST.txt"	'cmd_exe=&where.exe cmd.exe'

	#dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_fileVariables_TEST.txt"	'bash_exe=\$(command -v 'bash')'
	#dk_call dk_fileAppend "${env:DKCACHE_DIR}/dk_fileVariables_TEST.txt"	'HOMEDRIVE=\$(\${cmd_exe} /c echo %HOMEDRIVE% | tr -d '\r')'
	
	
	dk_call dk_debug "###### Testing dk_fileVariables.cmake ######"
	${env:dk_fileVariables_PRINT_VARIABLES}=1;
    dk_call dk_fileVariables "${env:DKCACHE_DIR}/dk_fileVariables_TEST.txt"	
	Read-Host;
}
