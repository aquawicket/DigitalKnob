@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# dk_readlink(path rtn_var)
::#
::#    read the contents of a symbolic link
::#
::#    SHELL: https://man7.org/linux/man-pages/man1/realpath.1.html
::#    C:     https://pubs.opengroup.org/onlinepubs/9699919799/functions/readlink.html
::#
:dk_readlink
setlocal
    %dk_call% dk_debugFunc 1 2
    
	%dk_call% dk_assertPath "%~1"
	set "dk_readlink="
    set _path_=%1
    set _path_=%_path_:"=%
	set _path_=%_path_:/=\%
    if "%_path_:~-1%" equ "\" set _path_=%_path_:~0,-1%
    for /f "tokens=2 delims=[]" %%i in ('dir %_path_%* ^| FIND "<SYMLINK"') do set "dk_readlink=%%i"
	
	if not defined dk_readlink (
		endlocal & (
			set "dk_readlink=%_path_:\=/%"
			if "%~2" neq "" (set "%~2=%_path_:\=/%")
			%return%
		)
	)
	
	endlocal & (
		set "dk_readlink=%dk_readlink:\=/%"
		if "%~2" neq "" (set "%~2=%dk_readlink:\=/%")
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
	%dk_call% dk_set myPath "C:/Users/Administrator/Desktop/DKBuilder.cmd"
    %dk_call% dk_readlink "%myPath%"
    %dk_call% dk_printVar dk_readlink
	
    %dk_call% dk_set myPath "C:/Users/Administrator/Desktop/digitalknob"
    %dk_call% dk_readlink "%myPath%"
    %dk_call% dk_printVar dk_readlink
	
	%dk_call% dk_set myPath "C:/Users/Administrator/Desktop"
    %dk_call% dk_readlink "%myPath%"
    %dk_call% dk_printVar dk_readlink
%endfunction%
