<!-- ::################## ELEVATE ##################
@echo off
echo 0 = %0
echo * = %*
net session >nul 2>&1
IF %ERRORLEVEL% EQU 0 goto :admin
if "%~1" == "elevated" goto :admin
if "%~2" == "gotPrivileges" goto :gotPrivileges
	echo "elevating permissions . . ."
	setlocal DisableDelayedExpansion
	set "DKSCRIPT_PATH=%~dpnx0"
	echo DKSCRIPT_PATH = %DKSCRIPT_PATH%
	setlocal EnableDelayedExpansion
	cscript //nologo "%~f0?.wsf" %DKSCRIPT_PATH% gotPrivileges
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
	</script></job><!--
:admin	
	echo Administrator privileges detected
	cd /d %~dp0
::###################### ELEVATE ##################

call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

:DKTEST
:uninstall_launcher
	echo Uninstalling .cmd file associations . . .
	
	ftype dk_batch=
	assoc .cmd=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\dk_batch"
goto:eof
-->