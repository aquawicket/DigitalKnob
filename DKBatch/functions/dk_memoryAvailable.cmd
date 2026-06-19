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


rem ############################################################################
rem # dk_memoryAvailable()
rem #
:dk_memoryAvailable
%setlocal%
 
	%dk_call% dk_findFile WMIC.exe
	for /f "skip=1" %%G in ('%WMIC.exe% os get freephysicalmemory') do ( 
		set "dk_memoryAvailable=%%G"
		goto:return
	)
	
	:return
	endlocal & (
		set "dk_memoryAvailable=%dk_memoryAvailable%"
	)
	rem %dk_call% dk_debug "dk_memoryAvailable = %dk_memoryAvailable%"
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_memoryAvailable
	%dk_call% dk_debug "dk_memoryAvailable = %dk_memoryAvailable%"
%endfunction%

