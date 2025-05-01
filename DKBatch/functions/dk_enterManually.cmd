@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_enterManually()
::#
::#
:dk_enterManually
 ::%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_info "Please type the name of the library, tool or app to build. Then press enter."
	%dk_call% dk_keyboardInput input

	set "target_app=_%input%_"

	::Search digitalknob for the matching entry containing a DKINSTALL.cmake file  
	::%dk_call% dk_chdir %DIGITALKNOB_DIR%
	::for /f "delims=" %%a in ('dir /b /s /a-d DKINSTALL.cmake ^| findstr /E /R "%input%\\DKINSTALL.cmake" ') do set "path=%%a"
	::set "TARGET_PATH=%path:~0,-13%"
	%dk_call% dk_validate DKIMPORTS_DIR		"%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate DKCPP_PLUGINS_DIR	"%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate DKCPP_APPS_DIR	"%dk_call% dk_DKBRANCH_DIR"
	if exist "%DKIMPORTS_DIR%\%input%\DKINSTALL.cmake" 	(set "TARGET_PATH=%DKIMPORTS_DIR%\%input%")
	if exist "%DKCPP_PLUGINS_DIR%\%input%\DKINSTALL.cmake" (set "TARGET_PATH=%DKCPP_PLUGINS_DIR%\%input%")
	if exist "%DKCPP_APPS_DIR%\%input%\DKINSTALL.cmake"	(set "TARGET_PATH=%DKCPP_APPS_DIR%\%input%")
	%dk_call% dk_printVar TARGET_PATH

	%dk_call% dk_folderName "%TARGET_PATH%" parent
	%dk_call% dk_printVar parent

	if "%parent%" equ "apps" %return%
	%dk_call% dk_mkdir "%DKCPP_APPS_DIR%\%target_app%"

	:: create apps/<target_app>/DKINSTALL.cmake
	echo dk_depend(%input%) > "%DKCPP_APPS_DIR%\%target_app%\DKINSTALL.cmake"
	::%dk_call% dk_fileWrite "%DKCPP_APPS_DIR%\%target_app%\DKINSTALL.cmake" dk_depend(%input%)

	:: create apps/<target_app>/main.cpp
	echo int main(int argc, char** argv) { return 0; } > "%DKCPP_APPS_DIR%\%target_app%\main.cpp"
	::%dk_call% dk_fileWrite "%DKCPP_APPS_DIR%\%target_app%\main.cpp" "int main(int argc, char** argv) { return 0; }"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_enterManually
%endfunction%
