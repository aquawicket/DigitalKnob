@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# ___NEW_DKCMAKE_FUNCTION()
::#
::#
:___NEW_DKCMAKE_FUNCTION
%setlocal%
	%dk_call% dk_debugFunc 0

	::### name the new function
	%dk_call% dk_inputBox
	%dk_call% dk_printVar dk_inputBox
	
	if EXIST "%dk_inputBox%.cmake" (
		%dk_call% dk_notice "function %dk_inputBox% already exists"
		goto :edit_textfile
	)
	
	echo #!/usr/bin/cmake -P>																	"%dk_inputBox%.cmake"
	echo ### DK.cmake ############################################################>>			"%dk_inputBox%.cmake"
	echo if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")>>								"%dk_inputBox%.cmake"
	echo 	cmake_policy(SET CMP0009 NEW)>>														"%dk_inputBox%.cmake"
	echo 	file(GLOB_RECURSE DK.cmake "/DK.cmake")>> 											"%dk_inputBox%.cmake"
	echo 	list(GET DK.cmake 0 DK.cmake)>> 													"%dk_inputBox%.cmake"
	echo 	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)>> 			"%dk_inputBox%.cmake"
	echo 	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")>> 						"%dk_inputBox%.cmake"
	echo endif()>> 																				"%dk_inputBox%.cmake"
	echo include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")>>										"%dk_inputBox%.cmake"
	echo include_guard()>> 																		"%dk_inputBox%.cmake"
	echo #########################################################################>> 			"%dk_inputBox%.cmake"
	echo(>>																						"%dk_inputBox%.cmake"
	echo(>>																						"%dk_inputBox%.cmake"
	echo(>>																						"%dk_inputBox%.cmake"
	echo #########################################################################>>			"%dk_inputBox%.cmake"
	echo # %dk_inputBox%(args)>>																"%dk_inputBox%.cmake"
	echo #>> 																					"%dk_inputBox%.cmake"
	echo #	Descript what the function does here>>												"%dk_inputBox%.cmake"
	echo #>> 																					"%dk_inputBox%.cmake"
	echo #	 @arg0	- Describe the arg0 variables>> 											"%dk_inputBox%.cmake"
	echo #   @arg1	- Describe the arg1 variables>> 											"%dk_inputBox%.cmake"
	echo #>> 																					"%dk_inputBox%.cmake"
	echo function(%dk_inputBox%)>> 																"%dk_inputBox%.cmake"
	echo     dk_debugFunc(0 1)>> 																"%dk_inputBox%.cmake"
	echo(>> 																					"%dk_inputBox%.cmake"
	echo     dk_getArg(0 arg0)>> 																"%dk_inputBox%.cmake"
	echo     dk_getArg(1 arg1)>> 																"%dk_inputBox%.cmake"
	echo(>> 																					"%dk_inputBox%.cmake"
	echo 	 dk_debug("%dk_inputBox%(${arg0}, ${arg1})")>> 										"%dk_inputBox%.cmake"
	echo endfunction()>>																		"%dk_inputBox%.cmake"
	echo(>>																						"%dk_inputBox%.cmake"
	echo(>>																						"%dk_inputBox%.cmake"
	echo(>> 																					"%dk_inputBox%.cmake"
	echo(>> 																					"%dk_inputBox%.cmake"
	echo(>>																						"%dk_inputBox%.cmake"
	echo(>>																						"%dk_inputBox%.cmake"
	echo(>> 																					"%dk_inputBox%.cmake"
	echo ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######>>			"%dk_inputBox%.cmake"
	echo function(DKTEST)>>																		"%dk_inputBox%.cmake"
	echo 	dk_debugFunc(0)>>																	"%dk_inputBox%.cmake"
	echo(>> 																					"%dk_inputBox%.cmake"
	echo 	%dk_inputBox%()>>																	"%dk_inputBox%.cmake"
	echo endfunction()>>																		"%dk_inputBox%.cmake"
	echo(>>																						"%dk_inputBox%.cmake"
	
	
	:edit_textfile
	%dk_call% dk_validate notepadpp_exe "%dk_call% dk_depend notepadpp_exe"
	"%notepadpp_exe%" "%dk_inputBox%.cmake"
%endfunction%


















::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% ___NEW_DKCMAKE_FUNCTION
%endfunction%
