if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_source_ps1){ $dk_source_ps1 = 1; } else{ return; } #include guard

####################################################################
# dk_source(milliseconds)
#
function Global:dk_source($func) {
	#if(Test-Path "${DKPOWERSHELL_FUNCTIONS_DIR}/dk_debugFunc.ps1"){ dk_debugFunc 1 }

	if(!${func}){
		Write-Host "ERROR: func:${func} is invalid";
		return;
	}
	
	#${func} = ${func} -replace "::", "/"; 
	
#############################################################################################################################
#	FROM THIS ->                          											            			     dk_color
#	FROM THIS ->                          C:\Users\Administrator\Digital Knob\Development\3rdParty\_DKIMPORTS\git/dkconfig.txt
if(!(Test-Path "${func}")){ 
	${func} = ${func} -replace '\\', '/';
	${ENV:USERPROFILE} = ${ENV:USERPROFILE} -replace '\\', '/'; 
#                                                                                                                dk_color
#	                                      ${ENV:USERPROFILE}/Digital Knob/Development/3rdParty/_DKIMPORTS/git/dkconfig.txt
	${func_noext} = ${func};
	if(${func}.lastIndexOf('.') -gt 0){ ${func_noext} = ${func}.Substring(0, ${func}.lastIndexOf('.')); }; 
	if("${func}" -eq "${func_noext}"){  ${func} = "${func}.ps1"; } 
#                                                                                                                dk_color.ps1
#	                                      ${ENV:USERPROFILE}/Digital Knob/Development/3rdParty/_DKIMPORTS/git/dkconfig.txt
	if(! ("${func}" -Match "${ENV:USERPROFILE}/Digital Knob")){ ${func} = "${ENV:USERPROFILE}/Digital Knob/Development/DKPowershell/functions/${func}"; }

#	TO THIS ->		                       ${ENV:USERPROFILE}/Digital Knob/Development/DKPowershell/functions/dk_color.ps1
#	TO THIS ->                            ${ENV:USERPROFILE}/Digital Knob/Development/3rdParty/_DKIMPORTS/git/dkconfig.txt
	${HTTPfunc} = ${func} -replace '${ENV:USERPROFILE}', 'http://aquawicket.com';
}	
#	TO THIS ->	     http://aquawicket.com/DigitalKnob/Development/DKPowershell/functions/dk_color.ps1
#	TO THIS ->		http://aquawicket.com/DigitalKnob/Development/3rdParty/_DKIMPORTS/git/dkconfig.txt
if(!(Test-Path "${func}")){ Write-Host "downloading ${func} . . ."; }
${dirname} = Split-Path ${func} -Parent;
if(!(Test-Path "${dirname}")){ New-Item -Path ${dirname} -ItemType Directory | Out-Null; }
if(!(Test-Path "${func}")){ 
	try
	{
		Invoke-WebRequest -URI "${HTTPfunc}" -OutFile "${func}"; 
	}
	catch
	{
		Write-Output "ERROR: dk_source.ps1:41 threw an exception"
		Write-Output "File: ${HTTPfunc}"
		Write-Output $_
		Read-Host;
	}
}
if(!(Test-Path "${func}")){ Write-Host "ERROR: Failed to download ${func}."; return; }	
#############################################################################################################################


	if(Test-Path "${func}"){
		if("${func}" -Match ".ps1"){
			. "${func}";
		}
		return;
	}
}


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	dk_source dk_info;
	dk_info "test message using dk_source to download it first";
}
