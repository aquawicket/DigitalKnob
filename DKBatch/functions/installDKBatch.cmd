<!-- ::################## ELEVATE ##################
@echo off
echo 0 = %0
echo * = %*
pauses
net session >nul 2>&1
if %ERRORLEVEL% equ 0 goto :admin
if "%~2" == "gotPrivileges" goto :gotPrivileges
:elevate
	echo elevate
	if "%~1" == "elevated" goto :admin
	if "%~2" == "gotPrivileges" goto :gotPrivileges
		echo "elevating permissions . . ."
		setlocal DisableDelayedExpansion
		set "DKSCRIPT_PATH=%~dpnx0"
		set "DKSCRIPT_DIR=%~dp0"
		if "%2" neq "" set "DKSCRIPT_PATH=%~dpnx2"
		if "%2" neq "" set "DKSCRIPT_DIR=%~dp2"
		setlocal EnableDelayedExpansion
		cscript //nologo "%~f0?.wsf" %DKSCRIPT_PATH% gotPrivileges & exit
	:gotPrivileges
		echo gotPrivileges
		setlocal & cd /d %DKSCRIPT_DIR%
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
		cd /d %DKSCRIPT_DIR%
::goto:eof

::###################### ELEVATE ##################	

::###### DKINIT ######
::set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
::set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\Development"
::set "DKBATCH_FUNCTION_DIR=%DKBRANCH_DIR%\DKBatch\functions"
::set "DKBATCH_FUNCTION_DIR_=%DKBATCH_FUNCTION_DIR%\"
call "%DKBATCH_FUNCTION_DIR_%DK.cmd"
	
:DKTEST
:install_cmd_fileAssociation
	if not "%*" == "" (goto:run_file)
	echo Associating .cmd files with DKBatch . . .
	
	call dk_load dk_validate
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	
	ftype dk_batch=cmd /c call "%~f0" "%DKBATCH_FUNCTIONS_DIR%" "%%1" %*
	assoc .cmd=dk_batch
	call dk_registrySetKey "HKEY_CLASSES_ROOT\dk_batch\DefaultIcon" "" "REG_SZ" "C:\Windows\System32\cmd.exe"
goto:eof

:run_file
	set "DKBATCH_FUNCTIONS_DIR=%~1"
	set "DKBATCH_FUNCTIONS_DIR_=%~1\"
	set "CMD_FILE=%~2"
	
	echo ############### Digitalknob ##################
::	echo * = %*
::	echo 1 = %1
::	echo 2 = %2
::	echo DKBATCH_FUNCTIONS_DIR = %DKBATCH_FUNCTIONS_DIR%
::	echo DKBATCH_FUNCTIONS_DIR_ = %DKBATCH_FUNCTIONS_DIR_%
::	echo CMD_FILE = %CMD_FILE%
	cmd /c call %CMD_FILE%
goto:eof

-->