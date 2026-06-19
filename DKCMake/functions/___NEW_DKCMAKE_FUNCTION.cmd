rem shebang
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
::# ___NEW_DKCMAKE_FUNCTION()
::#
::#
:___NEW_DKCMAKE_FUNCTION
%setlocal%

	::### name the new function
	%dk_call% dk_inputBox
	%dk_call% dk_printVar dk_inputBox
	
	%dk_call% dk_validate DKCMAKE_FUNCTIONS_DIR %dk_call% dk_DKBRANCH_DIR
	set "newFile=%DKCMAKE_FUNCTIONS_DIR:/=\%\%dk_inputBox%.cmake"
	if EXIST "%newFile%" (
		%dk_call% dk_notice "function %newfile% already exists"
		goto :edit_textfile
	)
	
	>"%newFile%" (
		echo #!/usr/bin/cmake -P
		echo ### DK.cmake ############################################################
		echo if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		echo 	cmake_policy(SET CMP0009 NEW)
		echo 	file(GLOB_RECURSE DK.cmake "/DK.cmake")
		echo 	list(GET DK.cmake 0 DK.cmake)
		echo 	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
		echo 	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
		echo endif()
		echo include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		echo include_guard()
		echo #########################################################################
		echo.
		echo.
		echo.
		echo #########################################################################
		echo # %dk_inputBox%(args)
		echo #
		echo #	Descript what the function does here
		echo #
		echo #	 @arg0	- Describe the arg0 variables
		echo #   @arg1	- Describe the arg1 variables
		echo #
		echo function(%dk_inputBox%)
		echo     dk_debugFunc(0 1)
		echo.
		echo     dk_getArg(0 arg0)
		echo     dk_getArg(1 arg1)
		echo.
		echo 	 dk_debug("%dk_inputBox%(${arg0}, ${arg1})")
		echo endfunction()
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.
		echo ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
		echo function(DKTEST)
		echo 		echo.
		echo 	%dk_inputBox%()
		echo endfunction()
		echo.
	)
	
	:edit_textfile
	%dk_call% dk_validate notepadpp_exe %dk_call% dk_depend notepadpp_exe
	"%notepadpp_exe%" "%newFile%"
%endfunction%


















rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% "%~dp0\___NEW_DKCMAKE_FUNCTION.cmd"
%endfunction%
