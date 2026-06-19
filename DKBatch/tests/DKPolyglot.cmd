@{' 2>nul&::'={\"<<BATCH_SCRIPT 2>/dev/null;#"}}[0]<#
@echo off
::########################## Batch Script Begin ##########################

@echo off
::########################## Batch Script Begin ##########################

::###### WSLENV flags ######
::# /p - translates the path between WSL/Linux style paths and Win32 paths.
::# /l - indicates the environment variable is a list of paths.
::# /u - indicates that this environment variable should only be included when running WSL from Win32.
::# /w - indicates that this environment variable should only be included when running Win32 from WSL.

::### CMD to WSL
::# set WSLENV=pathVar/p		# Translate pathVar to WSL
::# set WSLENV=pathList/l		# Translate pathList to WSL
::# set WSLENV=varA				# from CMD to WSL
::# set WSLENV=varB/u			# from CMD to WSL only
::# set WSLENV=varC/w			# from WSL to CMD only

::### WSL to CMD
::# export WSLENV=pathVar/p		# Translate pathVar to CMD
::# export WSLENV=pathList/l	# Translate pathList to CMD
::# export WSLENV=varA			# from WSL to CMD
::# export WSLENV=varB/u		# from CMD to WSL only
::# export WSLENV=varC/w		# from WSL to CMD only

set "nooption=%USERPROFILE%"
set "option_u=%USERPROFILE%"
set "option_w=%USERPROFILE%"
set "option_p=%USERPROFILE%"
set "option_l=%USERPROFILE%"
set WSLENV=%WSLENV%:^
nooption:^
option_u/u:^
option_w/w:^
option_p/p:^
option_l/l

echo.
echo ########## BATCH (%*) ##########
echo WSLENV   = %WSLENV%
echo nooption = %nooption%
echo option_u = %option_u%
echo option_w = %option_w%
echo option_p = %option_p%
echo option_l = %option_l%

 
::wsl /bin/bash -c "export nooption='%nooption%' && export option_u='%option_u%' && export option_w='%option_w%' &&  export option_p='%option_p%' && export option_l='%option_l%' && /mnt/c/Users/Administrator/Desktop/WSL_CMD.sh"
wsl /mnt/c/Users/Administrator/Desktop/DKPolyglot.cmd


echo.
echo ########## BATCH (%*) ##########
echo WSLENV   = %WSLENV%
echo nooption = %nooption%
echo option_u = %option_u%
echo option_w = %option_w%
echo option_p = %option_p%
echo option_l = %option_l%

pause

::########################## Batch Script End ##########################
exit /b 0
goto: eof
type con >nul
BATCH_SCRIPT
#>





echo \" <<'POWERSHELL_SCRIPT' >/dev/null # " | Out-Null
########################## PowerShell Script Begin ##########################

### Print Powershell Version Info ###
${DKSHELL} = (Get-Process -Id $pid).Name;
${DKSHELL_VERSION} = $PSVersionTable.PSVersion.ToString();
${DKSHELL_PATH} = (get-command ${DKSHELL}).Path;
if(!${global:ESC}){ ${global:ESC} = "$([char]27)"; }				# escape character
Write-Host "${ESC}[44m${ESC}[30m ${DKSHELL} Version ${DKSHELL_VERSION} ${ESC}[0m ${DKSHELL_PATH}";

Write-Host "";
${DKSCRIPT_PATH} = "${PSCommandPath}";
${DKSCRIPT_ARGS} = "";
Write-Host "DKSCRIPT_PATH = ${DKSCRIPT_PATH}";
Write-Host "DKSCRIPT_ARGS = ${DKSCRIPT_ARGS}";
Write-Host "";

Read-Host;


########################## PowerShell Script End ##########################
while ( ! $MyInvocation.MyCommand.Source ) { $input_line = Read-Host }
exit
<#
POWERSHELL_SCRIPT





set +o histexpand 2>/dev/null
########################## Bash Script Begin ##########################

echo "\n";
echo "########## BASH ($*) ##########";
echo "WSLENV   = ${WSLENV}"
echo "nooption = ${nooption}"
echo "option_u = ${option_u}"
echo "option_w = ${option_w}"
echo "option_p = ${option_p}"
echo "option_l = ${option_l}"

export nooption="${PWD}"
export option_u="${PWD}"
export option_w="${PWD}"
export option_p="${PWD}"
export option_l="${PWD}"

echo "\n";
echo "########## BASH ($*) ##########";
echo "WSLENV   = ${WSLENV}"
echo "nooption = ${nooption}"
echo "option_u = ${option_u}"
echo "option_w = ${option_w}"
echo "option_p = ${option_p}"
echo "option_l = ${option_l}"

read -rp ''

########################## Bash Script End ##########################
case $- in *"i"*) cat /dev/stdin >/dev/null ;; esac
exit
#>