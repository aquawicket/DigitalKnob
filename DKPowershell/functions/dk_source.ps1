if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_source_ps1){ $dk_source_ps1 = 1; } else{ return; } #include guard

####################################################################
# dk_source(func)
#
function Global:dk_source() {
	if(Test-Path "${DKPOWERSHELL_FUNCTIONS_DIR}/dk_debugFunc.ps1"){ dk_call dk_debugFunc 1; }
	${func}=$args[0];
	if(!${func}){
		Write-Host "ERROR: func:${func} is invalid";
		return;
	}
	
	#${func} = ${func} -replace "::", "/"; 
	
#############################################################################################################################
#	FROM THIS ->                          											            			     dk_color
#	FROM THIS ->                          C:\Users\Administrator\DigitalKnob\Development\3rdParty\_DKIMPORTS\git/dkconfig.txt
if(!(Test-Path "${func}")){ 
	${func} = ${func} -replace '\\', '/'; 
#                                                                                                                dk_color
#	                                      C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/git/dkconfig.txt
	${func_noext} = ${func};
	if(${func}.lastIndexOf('.') -gt 0){ ${func_noext} = ${func}.Substring(0, ${func}.lastIndexOf('.')); }
	if("${func}" -eq "${func_noext}"){  ${func} = "${func}.ps1"; } 
#                                                                                                                dk_color.ps1
#	                                      C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/git/dkconfig.txt
	if(!("${func}" -Match "C:/Users/Administrator/DigitalKnob")){ ${func} = "C:/Users/Administrator/DigitalKnob/Development/DKPowershell/functions/${func}"; }

#	TO THIS ->		                       C:/Users/Administrator/DigitalKnob/Development/DKPowershell/functions/dk_color.ps1
#	TO THIS ->                            C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/git/dkconfig.txt
	${HTTPfunc} = ${func} -replace 'C:/Users/Administrator', 'https://raw.githubusercontent.com/aquawicket';
}	
#	TO THIS ->	     https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKPowershell/functions/dk_color.ps1
#	TO THIS ->		https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/3rdParty/_DKIMPORTS/git/dkconfig.txt
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
	dk_info "dk_info test message. dk_source will download it and source it first";
}
