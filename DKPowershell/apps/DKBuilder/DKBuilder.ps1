###### DKBuilder ######

#${ENABLE_dk_debugFunc} = 1

###### INIT ######
if(!${env:DKSCRIPT_PATH})							{ ${env:DKSCRIPT_PATH} = $Script:MyInvocation.MyCommand.Path -replace '\\', '/'; }
Write-Host "env:DKSCRIPT_PATH = ${env:DKSCRIPT_PATH}";

if(!${env:DKHOME})									{ ${env:DKHOME} = "${env:USERPROFILE}" -replace '\\', '/'; }
Write-Host "env:DKHOME = ${env:DKHOME}";
if(!${env:DKHTTP})									{ ${env:DKHTTP} = "http://aquawicket.com"; }
Write-Host "env:DKHTTP = ${env:DKHTTP}";

if(!${env:DIGITALKNOB})								{ ${env:DIGITALKNOB} = "Digital Knob"; }
Write-Host "env:DIGITALKNOB = ${env:DIGITALKNOB}";
if(!${env:DIGITALKNOB_DIR})							{ ${env:DIGITALKNOB_DIR} = "${env:DKHOME}/${env:DIGITALKNOB}"; }
Write-Host "env:DIGITALKNOB_DIR = ${env:DIGITALKNOB_DIR}";
if(!${env:DKHTTP_DIGITALKNOB})								{ ${env:DKHTTP_DIGITALKNOB} = "DigitalKnob"; }
Write-Host "env:DKHTTP_DIGITALKNOB = ${env:DKHTTP_DIGITALKNOB}";
if(!${env:DKHTTP_DIGITALKNOB_DIR})					{ ${env:DKHTTP_DIGITALKNOB_DIR} = "${env:DKHTTP}/${env:DKHTTP_DIGITALKNOB}"; }
Write-Host "env:DKHTTP_DIGITALKNOB_DIR = ${env:DKHTTP_DIGITALKNOB_DIR}";
if(!(Test-Path ${env:DIGITALKNOB_DIR}))				{ New-Item -Path ${env:DIGITALKNOB_DIR} -ItemType Directory; }
Write-Host "env:DIGITALKNOB_DIR = ${env:DIGITALKNOB_DIR}";

if(!${env:DKBRANCH})								{ ${env:DKBRANCH} = "Development"; }
Write-Host "env:DKBRANCH = ${env:DKBRANCH}";
if(!${env:DKBRANCH_DIR})							{ ${env:DKBRANCH_DIR} = "${env:DIGITALKNOB_DIR}/${env:DKBRANCH}"; }
Write-Host "env:DKBRANCH_DIR = ${env:DKBRANCH_DIR}";
if(!${env:DKHTTP_DKBRANCH_DIR})						{ ${env:DKHTTP_DKBRANCH_DIR} = "${env:DKHTTP_DIGITALKNOB_DIR}/${env:DKBRANCH}"; }
Write-Host "env:DKHTTP_DKBRANCH_DIR = ${env:DKHTTP_DKBRANCH_DIR}";
if(!(Test-Path ${env:DKBRANCH_DIR}))				{ New-Item -Path ${env:DKBRANCH_DIR} -ItemType Directory; }

if(!${env:DKPOWERSHELL})							{ ${env:DKPOWERSHELL} = "DKPowershell"; }
Write-Host "env:DKPOWERSHELL = ${env:DKPOWERSHELL}";
if(!${env:DKPOWERSHELL_DIR})						{ ${env:DKPOWERSHELL_DIR} = "${env:DKBRANCH_DIR}/${env:DKPOWERSHELL}"; }
Write-Host "env:DKPOWERSHELL_DIR = ${env:DKPOWERSHELL_DIR}";
if(!${env:DKHTTP_DKPOWERSHELL_DIR})					{ ${env:DKHTTP_DKPOWERSHELL_DIR} = "${env:DKHTTP_DKBRANCH_DIR}/${env:DKPOWERSHELL}"; }
Write-Host "env:DKHTTP_DKPOWERSHELL_DIR = ${env:DKHTTP_DKPOWERSHELL_DIR}";
if(!(Test-Path ${env:DKPOWERSHELL_DIR}))			{ New-Item -Path ${env:DKPOWERSHELL_DIR} -ItemType Directory; }

if(!${env:DKPOWERSHELL_FUNCTIONS})					{ ${env:DKPOWERSHELL_FUNCTIONS} = "functions"; }
Write-Host "env:DKPOWERSHELL_FUNCTIONS = ${env:DKPOWERSHELL_FUNCTIONS}";
if(!${env:DKPOWERSHELL_FUNCTIONS_DIR})				{ ${env:DKPOWERSHELL_FUNCTIONS_DIR} = "${env:DKPOWERSHELL_DIR}/${env:DKPOWERSHELL_FUNCTIONS}"; }
Write-Host "env:DKPOWERSHELL_FUNCTIONS_DIR = ${env:DKPOWERSHELL_FUNCTIONS_DIR}";
if(!${env:DKPOWERSHELL_FUNCTIONS_DIR_})				{ ${env:DKPOWERSHELL_FUNCTIONS_DIR_} = "${env:DKPOWERSHELL_FUNCTIONS_DIR}/"; }
Write-Host "env:DKPOWERSHELL_FUNCTIONS_DIR_ = ${env:DKPOWERSHELL_FUNCTIONS_DIR_}";
if(!${env:DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR})		{ ${env:DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR} = "${env:DKHTTP_DKPOWERSHELL_DIR}/${env:DKPOWERSHELL_FUNCTIONS}"; }
Write-Host "env:DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR = ${env:DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR}";
if(!${env:DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR_})		{ ${env:DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR_} = "${env:DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR}/"; }
Write-Host "env:DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR_ = ${env:DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR_}";
if(!(Test-Path ${env:DKPOWERSHELL_FUNCTIONS_DIR}))	{ New-Item -Path ${env:DKPOWERSHELL_FUNCTIONS_DIR} -ItemType Directory; }


if(!(Test-Path ${env:DKPOWERSHELL_FUNCTIONS_DIR_}DK.ps1)){ 
	Invoke-WebRequest -URI "${env:DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR_}DK.ps1" -OutFile ${env:DKPOWERSHELL_FUNCTIONS_DIR_}DK.ps1;
}
. ${env:DKPOWERSHELL_FUNCTIONS_DIR_}DK.ps1;
if(${DKLOADED}){ exit } else{ ${global:DKLOADED}=1; }	# ignore the fork process that will return from DK.ps1 above






###### Load Main Program ######
dk_call dk_buildMain;
Read-Host -Prompt "Press Enter to exit";
