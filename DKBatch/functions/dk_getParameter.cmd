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


rem #########################################################################
rem # dk_getParameter(name) REMOVE
rem #
rem #	Check if the parameter exists in the calling function by <name>
rem #	If the named parameter was defined, set it's value to it's name.
rem #	This allows it to be optionally sent by value to functions
rem #
rem #	@name - the name of the variable to check
rem #	@${ARGV} - The full parameter list of the function
rem #	@REMOVE (optional) - Remove the parameter from ARGV after setting the state   
rem #
rem #	EXAMPLE: dk_getParameter(MY_ARG %ARGV})
rem #
:dk_getParameter
%setlocal%
	
	rem ###### ARGV - dk_getParameter args ######
	rem #echo dk_getParameter ARGC = %ARGC%
	rem #echo dk_getParameter ARGV = %ARGV% 
	
	rem ###### ARGN - dk_getParameter extra args ######
	rem #echo dk_getParameterbARGN = %ARGN%
	rem #echo dk_getParameterbARGN = %ARGN%
	
	rem ###### PARGV - Parent Function args ######
	set "PARGC=0"
	set "PARGV="
	foreach(arg IN LISTS ARGV)
		math(EXPR PARGC "${PARGC} + 1" OUTPUT_FORMAT DECIMAL)
		list(APPEND PARGV %arg})
	endforeach()
	rem #echo "PARGC = %PARGC%"
	rem #echo "PARGV = %PARGV%"

	rem #########################################
	
	set "dk_getParameter_NAME=%ARGV0%"
	rem cmake_parse_arguments(ARG %dk_getParameter_NAME% "" "" %PARGV})
	rem cmake_parse_arguments(ARG REMOVE "" "" %ARGV})

	if defined ARG_%dk_getParameter_NAME})
		set(${dk_getParameter_NAME% "${dk_getParameter_NAME}")
		rem #dk_notice "${CMAKE_CURRENT_FUNCTION}(): %dk_getParameter_NAME% set to "${dk_getParameter_NAME}")
		
		if(ARG_REMOVE)
			list(REMOVE_ITEM ARGV %dk_getParameter_NAME})	# remove arg from the functions ARGV list
			rem #dk_notice("${CMAKE_CURRENT_FUNCTION}(): %dk_getParameter_NAME% REMOVED from ARGV")
			
			list(REMOVE_ITEM ARGN %dk_getParameter_NAME})	# remove arg from the functions ARGN list
			rem #dk_notice("${CMAKE_CURRENT_FUNCTION}(): %dk_getParameter_NAME% REMOVED from ARGN")
		endif()
	else()
		unset(${dk_getParameter_NAME})
		rem #dk_notice("${CMAKE_CURRENT_FUNCTION}(): %dk_getParameter_NAME% unset")
	endif()
	
	set(PARGC 0)
	foreach(arg IN LISTS ARGV)
		math(EXPR PARGC "${PARGC% + 1" OUTPUT_FORMAT DECIMAL)
	endforeach()
	set(ARGC %PARGC})
endmacro()




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	
	call :TEST_dk_getParameter(abc OPTION1 OPTION2 123 OPTION4)
%endfunction%

:TEST_dk_getParameter input1
	
	echo "TEST_dk_getParameter %ARGV%"
	set "OPTION1=UNDEFINED"
	set "OPTION2=UNDEFINED"
	set "OPTION3=UNDEFINED"
	set "OPTION4=UNDEFINED"
	
	%dk_call% dk_getParameter OPTION1 
	%dk_call% dk_getParameter OPTION2 REMOVE
	%dk_call% dk_getParameter OPTION3
	%dk_call% dk_getParameter OPTION4
	
	echo ""
	echo "######## AFTER ##################"
	echo "ARGV = %ARGV%" 
	echo "ARGN = %ARGN%" 
	echo "OPTION1 = %OPTION1%" 
	echo "OPTION2 = %OPTION2%" 
	echo "OPTION3 = %OPTION3%" 
	echo "OPTION4 = %OPTION4%" 
%endfunction%