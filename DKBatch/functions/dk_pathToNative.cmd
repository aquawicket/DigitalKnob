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


rem ####################################################################
rem # dk_pathToNative(<pathname>, <output>:optional)
rem #
rem #
:dk_pathToNative
%setlocal%

    set pathname=%1
    set pathname=%pathname:"=%
	set "pathname=%pathname:/=\%"
    if "%pathname:~-1%" equ "\" set pathname=%pathname:~0,-1%

	for %%Z in ("%pathname%") do set "dk_pathToNative=%%~fZ"
	
  	:return
	endlocal & (
		set "dk_pathToNative=%dk_pathToNative%"
		if "%~2" neq "" (
			set "%~2=%dk_pathToNative%"
		) else (
			rem echo %dk_pathToNative%
		)
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

rem	### Result as global variable ###
	%dk_call% dk_debug
	%dk_call% dk_debug "### Result as global variable ###"
	%dk_call% dk_pathToNative "C:/Windows/System32"
	%dk_call% dk_debug "dk_pathToNative     = '%dk_pathToNative%'"
	
rem	### Result as variable parameter ###
	%dk_call% dk_debug
	%dk_call% dk_debug "### Result as variable parameter ###"
	%dk_call% dk_pathToNative "C:/Windows/System32" myNativePathB
	%dk_call% dk_debug "dk_pathToNative     = '%dk_pathToNative%'"
	%dk_call% dk_debug "myNativePathB       = '%myNativePathB%'"
	
rem	### Result as return value ###
	%dk_call% dk_debug
	%dk_call% dk_debug "### Result as return value ###"
	for /f "usebackq delims=" %%G in (`call dk_pathToNative "C:/Windows/System32"`) do set "myNativePathC=%%G"
rem	%dk_call% dk_echo "dk_pathToNative      = '%dk_pathToNative%'"		&rem NOTE: export cannot be seen outside of command substituion
	%dk_call% dk_debug "myNativePathC       = '%myNativePathC%'"

	
rem	### Result as hashtable parameter
	%dk_call% dk_debug
	%dk_call% dk_debug "### Result as hashtable parameter ###"
	%dk_call% dk_basename "C:/Windows/System32" myNativePathD.value
	%dk_call% dk_debug "dk_pathToNative     = '%dk_pathToNative%'"
	%dk_call% dk_debug "myNativePathD.value = '%myNativePathD.value%'"

%endfunction%
