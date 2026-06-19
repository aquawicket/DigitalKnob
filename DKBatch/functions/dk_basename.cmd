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
rem # dk_basename(path, <rtn_var>:optional)
rem #
rem #		Strip directory and suffix from filenames
rem #     
rem #     TODO: add a optional 'suffix' parameter to remove from path
rem #
rem #		Reference: https://en.wikipedia.org/wiki/Basename
rem #
:dk_basename
%setlocal%
	
	rem ###### input ######
	rem # %~1 = path
	rem # %~2 = rtn_var (optional)
	
	set "dk_basename=%~1"
	set "dk_basename=%dk_basename:"=%"								 
	if "%dk_basename:~-1%" equ "/" (set "dk_basename=%dk_basename:~0,-1%")
	if "%dk_basename:~-1%" equ "\" (set "dk_basename=%dk_basename:~0,-1%")
	for %%G in ("%dk_basename%") do (set "dk_basename=%%~nxG")
	
	:return
	endlocal & (
		set "dk_basename=%dk_basename%"
		if "%~2" neq "" (
			set "%~2=%dk_basename%"
		) else (
			echo %dk_basename%
		)
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

rem	### Result as global variable ###
	%dk_call% dk_echo
	%dk_call% dk_echo "### Result as global variable ###"
	%dk_call% dk_basename "A:/directoryA/filenameA.extA"
	%dk_call% dk_echo "dk_basename   = '%dk_basename%'"
	
rem	### Result as variable parameter ###
	%dk_call% dk_echo
	%dk_call% dk_echo "### Result as variable parameter ###"
	%dk_call% dk_basename "B:/directoryB/filenameB.extB" resultB
	%dk_call% dk_echo "dk_basename   = '%dk_basename%'"
	%dk_call% dk_echo "resultB       = '%resultB%'"

rem	### Result as return value ###
	%dk_call% dk_echo
	%dk_call% dk_echo "### Result as return value ###"
	for /f "usebackq delims=" %%G in (`call dk_basename "C:/directoryC/filenameC.extC"`) do set "resultC=%%G"
rem	%dk_call% dk_echo "dk_basename   = '%dk_basename%'"		&rem NOTE: export cannot be seen outside of command substituion
	%dk_call% dk_echo "resultC       = '%resultC%'"

rem	### Result as hashtable parameter ###
	%dk_call% dk_echo
	%dk_call% dk_echo "### Result as hashtable parameter ###"
	%dk_call% dk_basename "D:/directoryD/filenameD.extD" resultD.value
	%dk_call% dk_echo "dk_basename   = '%dk_basename%'"
	%dk_call% dk_echo "resultD.value = '%resultD.value%'"

%endfunction%
