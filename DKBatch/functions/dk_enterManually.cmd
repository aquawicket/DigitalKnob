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
rem # dk_enterManually()
rem #
rem #
:dk_enterManually
 rem %setlocal%

	%dk_call% dk_info "Please type the name of the library, tool or app to build. Then press enter."
	%dk_call% dk_keyboardInput

	set "Target_App=_%dk_keyboardInput%_"

	rem Search DigitalKnob for the matching entry containing a DKINSTALL.cmake file 
	rem %dk_call% dk_chdir %DIGITALKNOB_DIR%
	rem for /f "delims=" %%a in ('dir /b/s/a:-d DKINSTALL.cmake ^| %findstr.exe% /E /R "%dk_keyboardInput%\\DKINSTALL.cmake" ') do set "path=%%a"
	rem set "Target_App_Dir=%path:~0,-13%"
	%dk_call% dk_validate DKIMPORTS_DIR		%dk_call% dk_DKIMPORTS_DIR
	%dk_call% dk_validate DKCPP_PLUGINS_DIR	%dk_call% dk_DKBRANCH_DIR
	%dk_call% dk_validate DKCPP_APPS_DIR	%dk_call% dk_DKBRANCH_DIR
	if EXIST "%DKIMPORTS_DIR%/%dk_keyboardInput%/DKINSTALL.cmake" 	(set "Target_App_Dir=%DKIMPORTS_DIR%/%dk_keyboardInput%")
	if EXIST "%DKCPP_PLUGINS_DIR%/%dk_keyboardInput%/DKINSTALL.cmake" (set "Target_App_Dir=%DKCPP_PLUGINS_DIR%/%dk_keyboardInput%")
	if EXIST "%DKCPP_APPS_DIR%/%dk_keyboardInput%/DKINSTALL.cmake"	(set "Target_App_Dir=%DKCPP_APPS_DIR%/%dk_keyboardInput%")
	%dk_call% dk_printVar Target_App_Dir

	%dk_call% dk_folderName "%Target_App_Dir%" parent
	%dk_call% dk_printVar parent

	if /i "%parent%" equ "apps" %return%
	%dk_call% dk_mkdir "%DKCPP_APPS_DIR%/%Target_App%"

	rem create apps/<Target_App>/DKINSTALL.cmake
	echo dk_depend(%dk_keyboardInput%) > "%DKCPP_APPS_DIR%\%Target_App%\DKINSTALL.cmake"
	rem %dk_call% dk_fileWrite "%DKCPP_APPS_DIR%/%Target_App%/DKINSTALL.cmake" dk_depend(%dk_keyboardInput%)

	rem create apps/<Target_App>/main.cpp
	echo int main(int argc, char** argv) { return 0; } > "%DKCPP_APPS_DIR%\%Target_App%\main.cpp"
	rem %dk_call% dk_fileWrite "%DKCPP_APPS_DIR%/%Target_App%/main.cpp" "int main(int argc, char** argv) { return 0; }"
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_enterManually
%endfunction%
