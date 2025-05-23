@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_readlink(path rtn_var)
::#
::#    read the contents of a symbolic link
::#
::#    SHELL: https://man7.org/linux/man-pages/man1/realpath.1.html
::#    C:     https://pubs.opengroup.org/onlinepubs/9699919799/functions/readlink.html
::#
:dk_readlink
%setlocal%
    %dk_call% dk_debugFunc 1 2
   
    set dk_readlink=%1
	::if not exist "%dk_readlink%" (%return%)
	
    set dk_readlink=%dk_readlink:"=%
	set dk_readlink=%dk_readlink:/=\%
    if "%dk_readlink:~-1%" equ "\" set dk_readlink=%dk_readlink:~0,-1%

	for /f "tokens=2 delims=[]" %%i in ('dir %dk_readlink%* ^| FIND "<SYMLINK"') do (set "dk_readlink=%%i")
	
	endlocal & (
		set "dk_readlink=%dk_readlink:\=/%"
		if "%~2" neq "" (set "%~2=%dk_readlink:\=/%")
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
  
	%dk_call% dk_set myPath "%USERPROFILE:\=/%/Desktop/DKBuilder.cmd"
    %dk_call% dk_readlink "%myPath%"
    %dk_call% dk_printVar dk_readlink
	
    %dk_call% dk_set myPath "%USERPROFILE:\=/%/Desktop/digitalknob"
    %dk_call% dk_readlink "%myPath%"
    %dk_call% dk_printVar dk_readlink
	
	%dk_call% dk_set myPath "%USERPROFILE:\=/%/Desktop"
    %dk_call% dk_readlink "%myPath%"
    %dk_call% dk_printVar dk_readlink
	
	%dk_call% dk_set myPath "%USERPROFILE:\=/%/NonExistent"
    %dk_call% dk_readlink "%myPath%"
    %dk_call% dk_printVar dk_readlink
%endfunction%
