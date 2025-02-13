@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_callDKCmake(function, arguments..., rtn_var)
::#
::#
:dk_callDKCmake
setlocal
    %dk_call% dk_debugFunc 1 4


	::### Get DKCMAKE_FUNCTIONS_DIR
	%dk_call% dk_validate DKCMAKE_FUNCTIONS_DIR  "%dk_call% dk_DKBRANCH_DIR"
	if not exist "%DKCMAKE_FUNCTIONS_DIR%"       	(set "DKCMAKE_FUNCTIONS_DIR=%CD%/DKCMake/functions")
	if not exist "%DKCMAKE_FUNCTIONS_DIR%"       	(mkdir "%DKCMAKE_FUNCTIONS_DIR%")
	%dk_call% dk_assertPath DKCMAKE_FUNCTIONS_DIR
	
	::### Get DKHTTP_DKCMAKE_FUNCTIONS_DIR
	if not defined DKHTTP_DKCMAKE_DIR				(set "DKHTTP_DKCMAKE_DIR=%DKHTTP_DKBRANCH_DIR%/DKCMake")
	if not defined DKHTTP_DKCMAKE_FUNCTIONS_DIR		(set "DKHTTP_DKCMAKE_FUNCTIONS_DIR=%DKHTTP_DKCMAKE_DIR%/functions")
	
	::### Download files if missing
	if not exist %DKCMAKE_FUNCTIONS_DIR%/DK.cmake	(%dk_call% dk_download "%DKHTTP_DKCMAKE_FUNCTIONS_DIR%/DK.cmake" "%DKCMAKE_FUNCTIONS_DIR%/DK.cmake")
	if not exist %DKCMAKE_FUNCTIONS_DIR%/%~1.cmake	(%dk_call% dk_download "%DKHTTP_DKCMAKE_FUNCTIONS_DIR%/%~1.cmake" "%DKCMAKE_FUNCTIONS_DIR%/%~1.cmake")
	
	
    %dk_call% dk_validate DKIMPORTS_DIR         	"%dk_call% dk_DKIMPORTS_DIR"
    %dk_call% dk_validate CMAKE_EXE             	"%dk_call% %DKIMPORTS_DIR%/cmake/dk_install.cmd"

	set "DKCMAKE_FUNCTIONS_DIR=%DKCMAKE_FUNCTIONS_DIR:\=/%"
	set "DKCMAKE_FUNCTIONS_DIR_=%DKCMAKE_FUNCTIONS_DIR%/"
	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"
    
	set ALL_BUT_FIRST=%*
	if defined ALL_BUT_FIRST (set ALL_BUT_FIRST=!ALL_BUT_FIRST:*%1=!)
    set "ALL_BUT_FIRST=%ALL_BUT_FIRST:"='%"
    
    :: get LAST_ARG
	for %%a in (%*) do set LAST_ARG=%%a
    
    ::Create Run function Script
    set "DKCOMMAND=%~1(%ALL_BUT_FIRST%)"

    :: Call DKCmake function
    set "DKCMAKE_COMMAND=%CMAKE_EXE% "-DDKCOMMAND=%DKCOMMAND%" "-DDKSCRIPT_PATH=%DKSCRIPT_PATH%" "-DQUEUE_BUILD=ON" "-DDKCMAKE_FUNCTIONS_DIR_=%DKCMAKE_FUNCTIONS_DIR_%" -P %DKCMAKE_DIR%/DKEval.cmake"
    ::echo %DKCMAKE_COMMAND%    
    for /f "delims=" %%Z in ('%DKCMAKE_COMMAND%') do (
        echo %%Z                	&rem  Display the other shell's stdout
        set "dk_callDKCmake=%%Z"	&rem  Set the return value to the last line of output
    )
    
	endlocal & (
		set "dk_callDKCmake=%dk_callDKCmake%""
		if "%LAST_ARG%" == "rtn_var" (set "%LAST_ARG%=%dk_callDKCmake%")
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_callDKCmake dk_test "FROM DKBatch" "dk_callDKCmake.cmd" rtn_var
	%dk_call% dk_echo
    %dk_call% dk_echo "rtn_var = %rtn_var%"
%endfunction%
