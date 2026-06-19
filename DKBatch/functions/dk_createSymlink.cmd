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
rem # dk_createSymlink(src_path, symlink_path)
rem #
rem #		FIXME:  mklink is a internal command only in Windows Vista and up
rem #
:dk_createSymlink
%setlocal%
	
	set "src_path=%~1"
	set "symlink_path=%~2"
	
	%dk_call% dk_assertPath %src_path%
	
	if EXIST "%symlink_path%" (
		%dk_call% dk_notice "symlink_path:'%symlink_path%' already exists"
		%return%
	)
	
	%dk_call% dk_assertPath "%src_path%"
	%dk_call% dk_isDirectory "%src_path%" && (set "/D=/D")
	
	rem FIXME:  mklink is a internal command only in Windows Vista and up
	mklink %/D% "%symlink_path:/=\%" "%src_path:/=\%"	
%endfunction%










rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem ### Create a directory symlink ###
    %dk_call% dk_createSymlink "%USERPROFILE:\=/%/Digital Knob" "%USERPROFILE:\=/%/Desktop/DigitalKnob"
	
	rem ### Create a file symlink ###
	%dk_call% dk_createSymlink "%USERPROFILE:\=/%/Digital Knob/Development/DKBatch/functions/DKBuilder/DKBuilder.cmd" "%USERPROFILE:\=/%/Desktop/DKBuilder.cmd" &rem OVERWRITE
	
	rem ### Test Non-Existent Error ###
    rem %dk_call% dk_createSymlink "C:/Non-Existent" "%USERPROFILE:\=/%/Desktop/Non-Existent"
%endfunction%
