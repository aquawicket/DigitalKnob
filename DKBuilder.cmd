<!-- ::################## ELEVATE ##################
@echo off

net session >nul 2>&1
IF %ERRORLEVEL% EQU 0 goto :admin
if "%~1" == "elevated" goto :admin
if "%~2" == "gotPrivileges" goto :gotPrivileges
	echo "elevating permissions . . ."
	setlocal DisableDelayedExpansion
	set "DKSCRIPT_PATH=%~dpnx0"
	setlocal EnableDelayedExpansion
	cscript //nologo "%~f0?.wsf" %DKSCRIPT_PATH% gotPrivileges & exit
:gotPrivileges
	setlocal & cd /d %~dp0
	cmd /k "%~0" elevated
--><job><script language="VBScript">
		Set oShell = CreateObject( "WScript.Shell" )
		DKSCRIPT_PATH=oShell.ExpandEnvironmentStrings("%DKSCRIPT_PATH%")
		Set UAC = CreateObject("Shell.Application") 
		args = "" 
		For Each strArg in WScript.Arguments 
		args = args & strArg & " "  
		Next
		args = "/c """ + DKSCRIPT_PATH + """ " + args 
		UAC.ShellExecute "cmd", args, "", "runas", 1
	</script></job>
:admin	
	echo Administrator privileges detected
	cd /d %~dp0
::###################### ELEVATE ##################	
	
	
	
::################## DKBuilder ####################
::###### DK_INIT ######
set "DKHTTP_DKBATCH_FUNCTIONS_DIR=https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBatch/functions"
set "DKBATCH_DIR=%CD%\DKBatch"
set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_DIR%\functions"
set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_DIR%\functions\"
if not exist "%DKBATCH_FUNCTIONS_DIR%" mkdir "%DKBATCH_FUNCTIONS_DIR%"
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/DK.cmd', '%DKBATCH_FUNCTIONS_DIR_%DK.cmd')"
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::###### Load Main Program ######
call dk_source dk_buildMain
call dk_buildMain
