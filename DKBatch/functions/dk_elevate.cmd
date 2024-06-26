<!-- :
@echo off
::NET FILE 1>NUL 2>NUL
::if '%errorlevel%' == '0' ( echo admin & pause & goto:eof )
	
if '%1'=='ELEV' (
	set "DKSCRIPT_PATH=%~2"
	set "DKSCRIPT_DIR=%~3"
	
	setlocal & cd /d %3
    if '%1'=='ELEV' (shift /1)
	cmd /c "%~2"
	goto:eof
)

call DK.cmd



::##################################################################################
::# dk_elevate()
::#
::#
:dk_elevate () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(): not enough arguments")
	
	NET FILE 1>NUL 2>NUL
	if '%errorlevel%' == '0' ( echo admin & pause & goto:eof )
	
	set "DKELEVATE_CMD=%~f0"
	echo DKELEVATE_CMD = %DKELEVATE_CMD%
	echo DKSCRIPT_PATH = %DKSCRIPT_PATH%
	echo DKSCRIPT_ARGS = %DKSCRIPT_ARGS%
	cscript //nologo "%~f0?.wsf" %DKSCRIPT_PATH% %DKSCRIPT_DIR% & exit
goto:eof




:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	call dk_debugFunc
	
	call dk_elevate
goto:eof



-->
<job><script language="VBScript">
	Set oShell = CreateObject( "WScript.Shell" )
	DKELEVATE_CMD=oShell.ExpandEnvironmentStrings("%DKELEVATE_CMD%")
	DKSCRIPT_PATH=oShell.ExpandEnvironmentStrings("%DKSCRIPT_PATH%")
	DKSCRIPT_DIR=oShell.ExpandEnvironmentStrings("%DKSCRIPT_DIR%")
	Set UAC = CreateObject("Shell.Application") 
	args = "ELEV " 
	For Each strArg in WScript.Arguments 
	args = args & strArg & " "  
	Next
	args = "/c """ + DKELEVATE_CMD + """ " + args 
	UAC.ShellExecute "C:\WINDOWS\System32\cmd.exe", args, "", "runas", 1
</script></job>

