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


rem ################################################################################
rem # dk_evalDKCmake(cmake_code rtn_var)
rem #
rem #
:dk_evalDKCmake
%setlocal%
	
	rem %dk_call% dk_validate DKCMAKE_FUNCTIONS_DIR  %dk_call% dk_DKBRANCH_DIR

	rem ### Get DKHTTP_DKCMAKE_FUNCTIONS_DIR
	rem if NOT defined DKHTTP_DKCMAKE_DIR					(set "DKHTTP_DKCMAKE_DIR=%DKHTTP_DKBRANCH_DIR%/DKCMake")
	rem if NOT defined DKHTTP_DKCMAKE_FUNCTIONS_DIR			(set "DKHTTP_DKCMAKE_FUNCTIONS_DIR=%DKHTTP_DKCMAKE_DIR%/functions")

	rem ### Download files if missing
	rem if NOT EXIST "%DKCMAKE_FUNCTIONS_DIR%/DK.cmake"		(%dk_call% dk_download "%DKHTTP_DKCMAKE_FUNCTIONS_DIR%/DK.cmake" "%DKCMAKE_FUNCTIONS_DIR%/DK.cmake")
	rem if NOT EXIST "%DKCMAKE_FUNCTIONS_DIR%/%~1.cmake"	(%dk_call% dk_download "%DKHTTP_DKCMAKE_FUNCTIONS_DIR%/%~1.cmake" "%DKCMAKE_FUNCTIONS_DIR%/%~1.cmake")

	rem %dk_call% dk_validate DKIMPORTS_DIR				%dk_call% dk_DKIMPORTS_DIR

	rem set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"

	rem ### All but first Args ###
	rem %dk_call% dk_allButFirstArgs %*
	
	set "evalFile=%DKCACHE_DIR%/dk_evalDKCmake.cmake"
	>"%evalFile:/=\%" echo !%~1!
	rem set "DKCOMMAND=%DKCOMMAND:"='%"

	rem ############ DKCMake function call ############
	%dk_call% dk_validate cmake.exe		%dk_call% dk_depend cmake.exe
	rem set DKCOMMAND="%cmake.exe%" "-DDKCOMMAND=%CMAKE_COMMAND%" "-DDKSCRIPT_PATH=%DKSCRIPT_PATH%" "-DDKCMAKE_FUNCTIONS_DIR_=%DKCMAKE_FUNCTIONS_DIR_%" "-P" "%evalFile%"
	%dk_call% dk_exec "%cmake.exe%" "-P" "%evalFile%"
	
	rem set dk_exec
	:return
	endlocal & (
		set "dk_evalDKCmake=%dk_exec%"
		set "cmake.exe=%cmake.exe%"
	)

%endfunction%



s
rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	set cmake_code=message("'arg 1' 'arg 2' 'arg 3'")
	%dk_call% dk_evalDKCmake cmake_code
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_evalDKCmake = %dk_evalDKCmake%"
	
	set cmake_code=message("'abc' '123' 'def'")
	%dk_call% dk_evalDKCmake cmake_code
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_evalDKCmake = %dk_evalDKCmake%"
%endfunction%
