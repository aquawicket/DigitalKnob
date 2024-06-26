<!-- ::################## ELEVATE ##################
@echo off

net session >nul 2>&1
if %ERRORLEVEL% equ 0 goto :admin
if "%~2" == "gotPrivileges" goto :gotPrivileges
goto:admin
:elevate
	echo elevate
	if "%~1" == "elevated" goto :admin
	if "%~2" == "gotPrivileges" goto :gotPrivileges
		echo "elevating permissions . . ."
		setlocal DisableDelayedExpansion
		set "DKSCRIPT_PATH=%~dpnx0"
		setlocal EnableDelayedExpansion
		cscript //nologo "%~f0?.wsf" %DKSCRIPT_PATH% gotPrivileges & exit
	:gotPrivileges
		echo gotPrivileges
		pause
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
		echo admin
		::echo Administrator privileges detected
		cd /d %~dp0
::goto:eof

::###################### ELEVATE ##################	


call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::##################################################################################
::# dk_elevate()
::#
::#
:dk_elevate () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(): not enough arguments")
	
	net session >nul 2>&1
	if %ERRORLEVEL% equ 0 (echo "Administrator privileges detected") else (echo Not an Admin & goto :elevate)
goto:eof


:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	call dk_debugFunc
	
	call dk_elevate
goto:eof

-->