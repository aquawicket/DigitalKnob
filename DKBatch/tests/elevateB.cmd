<!-- :
@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################

::::::::::::::::::::::::::::::::::::::::::::
rem Elevate.cmd - Version 5
rem Automatically check & get admin rights
rem see "https://stackoverflow.com/a/12264592/1016343" for description
::::::::::::::::::::::::::::::::::::::::::::

setlocal DisableDelayedExpansion
set "batchPath=%~dpnx0"
for %%k in (%0) do set batchName=%%~nk
setlocal EnableDelayedExpansion
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges )
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
cscript.exe //nologo "%~f0?.wsf" %* & exit
	
--><job><script language="VBScript">
	Set oShell = CreateObject( "WScript.Shell" )
	batchPath=oShell.ExpandEnvironmentStrings("%batchPath%")
	Set UAC = CreateObject("Shell.Application")
	args = "ELEV "
	For Each strArg in WScript.Arguments
	args = args & strArg & " " 
	Next
	args = "/c """ + batchPath + """ " + args
	UAC.ShellExecute "%ComSpec%", args, "", "runas", 1
</script></job><!--

:gotPrivileges
    setlocal & cd /d %~dp0
    if '%1'=='ELEV' (shift /1)
::-->


rem Elevated User code
echo %batchName% Arguments: P1=%1 P2=%2 P3=%3 P4=%4 P5=%5 P6=%6 P7=%7 P8=%8 P9=%9
%ComSpec% /k
pause


