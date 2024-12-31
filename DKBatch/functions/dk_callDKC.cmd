@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_callDKC(function, arguments..., rtn_var)
::#
::#
:dk_callDKC
    %dk_call% dk_debugFunc 1 99
 setlocal

	::### Get DKC_FUNCTIONS_DIR
	%dk_call% dk_validate DKC_FUNCTIONS_DIR  "%dk_call% dk_DKBRANCH_DIR"
	if not exist "%DKC_FUNCTIONS_DIR%"       set "DKC_FUNCTIONS_DIR=%CD%\DKC\functions"
	if not exist "%DKC_FUNCTIONS_DIR%"       mkdir "%DKC_FUNCTIONS_DIR%"
	%dk_call% dk_assertPath DKC_FUNCTIONS_DIR
	
	::### Get DKHTTP_DKC_FUNCTIONS_DIR
	if not defined DKHTTP_DKC_DIR         	 set "DKHTTP_DKC_DIR=%DKHTTP_DKBRANCH_DIR%/DKC"
	if not defined DKHTTP_DKC_FUNCTIONS_DIR  set "DKHTTP_DKC_FUNCTIONS_DIR=%DKHTTP_DKC_DIR%/functions"
	
	::### Download any missing
	if not exist %DKC_FUNCTIONS_DIR%\DK.h    %dk_call% dk_download "%DKHTTP_DKC_FUNCTIONS_DIR%/DK.h" "%DKC_FUNCTIONS_DIR%/DK.h"
	if not exist %DKC_FUNCTIONS_DIR%\%~1.c   %dk_call% dk_download "%DKHTTP_DKC_FUNCTIONS_DIR%/%~1.c" "%DKC_FUNCTIONS_DIR%/%~1.c"


	:: get ALL_BUT_FIRST_ARGS
::	for /f "tokens=1,* delims= " %%a in ("%*") do set ALL_BUT_FIRST_ARGS=%%b

    :: get LAST_ARG
::	for %%a in (%*) do set LAST_ARG=%%a
    
::	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"
::    set "DKSCRIPT_PATH=%DKSCRIPT_PATH:C:=/c%"
	
::	set "DKC_FUNCTIONS_DIR=%DKC_FUNCTIONS_DIR:\=/%"
::    set "DKC_FUNCTIONS_DIR=%DKC_FUNCTIONS_DIR:C:=/c%"

::    set "DKC_FUNCTIONS_DIR_=%DKC_FUNCTIONS_DIR_:\=/%"
::    set "DKC_FUNCTIONS_DIR_=%DKC_FUNCTIONS_DIR_:C:=/c%"
	

	::###### DEFAULT ENVIRONMENT ######
	:: clang, cosmocc, gcc, msvc 
	set "default_host_os=cosmocc"
	set "default_host_arch=cosmocc"
	set "default_host_env=cosmocc"
	
	::###### Install DKC ######
::	%dk_call% dk_echo "Installing DKC . . ."
	
	::###### OS ######
	::%dk_call% dk_validate host_os "%dk_call% dk_host_triple"
	::if not defined OS set "OS=%host_os%"
	set "OS=%default_host_os%"
	%dk_call% dk_printVar OS
	
	::###### arch ######
	::%dk_call% dk_validate host_arch "%dk_call% dk_host_triple"
	::if not defined arch set "arch=%host_arch%"
	set "host_arch=%default_host_arch%"
	%dk_call% dk_printVar arch
	
	::###### host_env ######
	::if not defined host_env set "host_env=%default_host_env%"
	::if not defined env set "env=%host_env%"
	set "host_env=%default_host_env%"
	%dk_call% dk_printVar host_env
	
	
    ::###### COMPILER_EXE ######
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"

	if "%host_env%"=="cosmocc"      %dk_call% dk_validate SH_EXE               "%dk_call% %DKIMPORTS_DIR%\sh\dk_install.cmd"
	if "%host_env%"=="cosmocc"      %dk_call% dk_validate COSMOCC_C_COMPILER   "%dk_call% %DKIMPORTS_DIR%\cosmocc\dk_install.cmd"
	if "%host_env%"=="clang"  		%dk_call% dk_validate CLANG_C_COMPILER     "%dk_call% %DKIMPORTS_DIR%\clang\dk_install.cmd"
	if "%host_env%"=="gcc"    		%dk_call% dk_validate GCC_C_COMPILER       "%dk_call% %DKIMPORTS_DIR%\gcc\dk_install.cmd"

	if "%host_env%"=="cosmocc"      set "COMPILER_EXE=%SH_EXE% %COSMOCC_C_COMPILER%"
	if "%host_env%"=="clang"  		set "COMPILER_EXE=%CLANG_C_COMPILER%"
	if "%host_env%"=="gcc"	  		set "COMPILER_EXE=%GCC_C_COMPILER%"
	%dk_call% dk_assertVar COMPILER_EXE
	%dk_call% dk_printVar COMPILER_EXE

	set DKC_COMMAND=%COMSPEC% /c call "%~f0" "%COMPILER_EXE%" "%%1" %%*

    echo %DKC_COMMAND%
	for /f "delims=" %%Z in ('%DKC_COMMAND%') do (
        echo %%Z                &rem  Display the other shell's stdout
        set "rtn_value=%%Z"     &rem  Set the return value to the last line of output
	)
    ::echo rtn_value = !rtn_value!
    
	if "%LAST_ARG%" == "rtn_var" endlocal & set "%LAST_ARG%=%rtn_value%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
 
	::%dk_call% dk_callDKC dk_test "FROM DKC" "dk_callDKC.cmd" rtn_var
	%dk_call% dk_callDKC dk_echo "This is a string from c dk_echo" rtn_var
    %dk_call% dk_echo
	if defined rtn_var  %dk_call% dk_echo "rtn_var = %rtn_var%"
%endfunction%
