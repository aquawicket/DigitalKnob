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
rem # dk_fileMD5(file <rtn_var:optional>)
rem #
rem #
:dk_fileMD5
%setlocal%

	set "_file_=%~1"
	%dk_call% dk_validate certutil.exe %dk_call% dk_findFile certutil.exe
	
	set /a count=1
	for /f "skip=1 delims=:" %%a in ('%certutil.exe:/=\% -hashfile "%_file_:/=\%" MD5') do (
	  if !count! equ 1 (set "dk_fileMD5=%%a")
	  set/a count+=1
	)
	set "dk_fileMD5=%dk_fileMD5: =%"
	
	:return
	endlocal & (
		set "dk_fileMD5=%dk_fileMD5%"
		if "%~2" neq "" (set "%~2=%dk_fileMD5%")
	)
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
 
	%dk_call% dk_selectFile
	%dk_call% dk_fileMD5 "%dk_selectFile%"
	%dk_call% dk_debug "%dk_selectFile% MD5 = '%dk_fileMD5%'"
%endfunction%
