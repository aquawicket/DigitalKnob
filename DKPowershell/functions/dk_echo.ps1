if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_echo_ps1){ $dk_echo_ps1 = 1; } else{ return; } #include guard

################################################################################
# dk_echo_FILE=1
# dk_echo_LINE=1
#${global:dk_echo_NONEWLINE}=1;
################################################################################
# dk_echo(message)
#
#	Print a message to the console
#
#	@msg - The message to print
#
function Global:dk_echo() {
	dk_debugFunc 0 1;

	if(!($args[0])){
		${message} = "\n";
	} else {
		${message} = "${args}";
	}
		
	# if(!(Test-Path variable:echo_fileline)){ $global:echo_fileline = "$(__FILE__ 1):$(__LINE__ 1)   " }
	# Write-Host "${echo_fileline}   ${message}"
	
	if("${dk_echo_NONEWLINE}" -eq "1"){
		${message} = ${message} -replace "\\n", "`n";
		Write-Host -NoNewline "${message}";
	} else {
		${message} = ${message} -replace "\\n", "";
		Write-Host "${message}";
	}
	
	# if(Test-Path variable:echo_fileline){ dk_call dk_unset echo_fileline }
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	echo "This is a normal echo commmand";
	Write-Host "This is a normal Write-Host commmand";
	Write-Host -NoNewline "This is a Write-Host -NoNewline commmand";
	dk_call dk_echo;
	dk_call dk_echo "\n";
	dk_call dk_echo "This is a dk_echo line\n";
	dk_call dk_echo "${red}This is ${white}dk_echo ${blue}with color ${clr}\n";
}
