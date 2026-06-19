<!-- : BATCH SCRIPT
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


rem ################################################################################
rem # dk_refreshEnv()
rem #
rem #	   This will pull un environment variable changed with setx or chenged from outside
rem #    of the context without restarting the ComSpec
rem #
rem #    Reference: https://stackoverflow.com/a/171737/688352
rem #
:dk_refreshEnv
rem setloal
	
	%dk_call% dk_validate cscript.exe %dk_call% dk_findFile cscript.exe
	%cscript.exe% //nologo "%~f0?.wsf"
	if NOT EXIST "%TEMP%\refreshEnv.bat" %dk_call% dk_error "%TEMP%\refreshEnv.bat NOT FOUND"
	%dk_call% "%TEMP%\refreshEnv.bat"
		
	exit /b %errorlevel%
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
	set "MYVAR="
	echo The MYVAR variable should be empty
	echo MYVAR = %MYVAR%
	
	echo.
	echo setting MYVAR variable with setx
	setx MYVAR "TEST VALUE oF MYVAR" 1>nul 2>nul
	
	echo The MYVAR variable will still be empty
	echo MYVAR = %MYVAR%
	
	echo.
	echo Lets refresh the environment
    %dk_call% dk_refreshEnv
	
	echo.
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