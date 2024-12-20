<!-- : BATCH SCRIPT
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*


::################################################################################
::# dk_refreshEnv()
::#
::#	   This will pull un environment variable changed with setx or chenged from outside
::#    of the context without restarting the ComSpec 
::#
::#    Reference: https://stackoverflow.com/a/171737/688352
::#
:dk_refreshEnv
:: setloal
	call dk_debugFunc 0
	
	cscript.exe //nologo "%~f0?.wsf"
	if not exist "%TEMP%\refreshEnv.bat" call dk_error "%TEMP%\refreshEnv.bat does not exist"
	call "%TEMP%\refreshEnv.bat"
		
	exit /b %errorlevel%
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
    
	set "MYVAR="
	echo The MYVAR variable should be empty
	echo MYVAR = %MYVAR%
	
	echo:
	echo setting MYVAR variable with setx
	setx MYVAR "TEST VALUE oF MYVAR" 1>nul 2>nul
	
	echo The MYVAR variable will still be empty
	echo MYVAR = %MYVAR%
	
	echo:
	echo Lets refresh the environment
    %dk_call% dk_refreshEnv
	
	echo:
	echo Now the variable should have value
	echo MYVAR = %MYVAR%
%endfunction%






----- VBScript --->
<job><script language="VBScript">
	Set oShell = WScript.CreateObject("WScript.Shell")
	filename = oShell.ExpandEnvironmentStrings("%TEMP%\refreshEnv.bat")
	Set objFileSystem = CreateObject("Scripting.fileSystemObject")
	Set oFile = objFileSystem.CreateTextFile(filename, TRUE)

	set oEnv=oShell.Environment("System")
	for each sitem in oEnv 
		oFile.WriteLine("SET " & sitem)
	next
	path = oEnv("PATH")

	set oEnv=oShell.Environment("User")
	for each sitem in oEnv 
		oFile.WriteLine("SET " & sitem)
	next

	path = path & ";" & oEnv("PATH")
	oFile.WriteLine("SET PATH=" & path)
	oFile.Close
</script></job>