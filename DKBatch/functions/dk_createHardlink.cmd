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
rem # dk_createHardlink(src_path, hardlink_path)
rem #
rem #
:dk_createHardlink
%setlocal%
	
	set "src_path=%~1"
	set "hardlink_path=%~2"
	
	%dk_call% dk_assertPath %src_path%
	
	if EXIST "%hardlink_path%" (
		%dk_call% dk_notice "hardlink_path:'%hardlink_path%' already exists"
		%return%
	)
	
	%dk_call% dk_assertPath "%src_path%"
	%dk_call% dk_isDirectory "%src_path%" && (set "/D=/D")
	
	rem FIXME:  mklink is a internal command only in Windows Vista and up
	mklink %/D% /H "%hardlink_path:/=\%" "%src_path:/=\%"
	
	rem ### cmake ###
	rem	%dk_call% cmake.exe -E create_symlink "%src_path%" "%hardlink_path%"
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem ### Create a file symlink ###
	%dk_call% dk_createHardlink "%USERPROFILE:\=/%/test.txt" "%USERPROFILE:\=/%/Desktop/test.txt"
	
	rem ### Create a directory symlink ###
    %dk_call% dk_createHardlink "%USERPROFILE:\=/%/test" "%USERPROFILE:\=/%/Desktop/test"
	
	rem ### Test Non-Existent Error ###
    rem %dk_call% dk_createHardlink "%USERPROFILE:\=/%/Desktop/Non-Existent" "C:/Non-Existent"
%endfunction%
