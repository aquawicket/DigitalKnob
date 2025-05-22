<!-- :
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

::::::::::::::::::::::::::::::::::::::::::::
:: Elevate.cmd - Version 5
:: Automatically check & get admin rights
:: see "https://stackoverflow.com/a/12264592/1016343" for description
::::::::::::::::::::::::::::::::::::::::::::

setlocal DisableDelayedExpansion
set "batchPath=%~dpnx0"
for %%k in (%0) do set batchName=%%~nk
setlocal EnableDelayedExpansion
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges )
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
cscript //nologo "%~f0?.wsf" %* & exit
	
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


:: Elevated User code
echo %batchName% Arguments: P1=%1 P2=%2 P3=%3 P4=%4 P5=%5 P6=%6 P7=%7 P8=%8 P9=%9
%ComSpec% /k
pause


