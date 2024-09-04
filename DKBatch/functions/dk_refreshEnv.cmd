<!-- : BATCH SCRIPT
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0


::################################################################################
::# dk_refreshEnv()
::#
::#    Reference: https://stackoverflow.com/a/171737/688352
::#
:dk_refreshEnv
	call dk_debugFunc 0

	if exist "%TEMP%\refreshEnv.bat" del "%TEMP%\refreshEnv.bat"
	cscript.exe //nologo "%~f0?.wsf"
	if exist "%TEMP%\refreshEnv.bat" call "%TEMP%\refreshEnv.bat"
	if exist "%TEMP%\refreshEnv.bat" del "%TEMP%\refreshEnv.bat"
	exit /b 0 
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
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
goto:eof






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