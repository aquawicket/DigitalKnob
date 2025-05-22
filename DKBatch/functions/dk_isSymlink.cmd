@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_isSymlink(path rtn_var)
::#
::#
:dk_isSymlink
%setlocal%
	%dk_call% dk_debugFunc 1 2

	%dk_call% dk_getAttributes "%~1"
	%dk_call% dk_includes "%dk_getAttributes%" "l" && set "dk_isSymlink=0" || set "dk_isSymlink=1"

    if "%~2" neq "" (endlocal & set "%~2=%dk_isSymlink%")
    exit /b %dk_isSymlink%

%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
  
    ::###### Using if return value
::	set "myPath=C:/Windows/notepad.exe"
::  %dk_call% dk_isSymlink "%myPath%" result
::  if /i "%result%" equ "true" (%dk_call% dk_info "'%myPath%' is a symlink") else (%dk_call% dk_info "'%myPath%' is NOT a symlink")
  
::	set "myPath=C:/NotADir"
::  %dk_call% dk_isSymlink "%myPath%" result
::  if /i "%result%" equ "true" (%dk_call% dk_info "'%myPath%' is a symlink") else (%dk_call% dk_info "'%myPath%' is NOT a symlink")
   
::  ::###### Using if ERRORLEVEL
::	set "myPath=C:/Windows"
::	%dk_call% dk_isSymlink "%myPath%"
::  if not ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a symlink") else (%dk_call% dk_info "'%myPath%' is NOT a symlink")
	
::  set "myPath=C:/NotADir"
::	%dk_call% dk_isSymlink "%myPath%"
::  if not ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a symlink") else (%dk_call% dk_info "'%myPath%' is NOT a symlink")
   
	::###### Using && and || conditionals
	set "myPath=C:/Users/Administrator/Desktop/DKBuilder.cmd"
    %dk_call% dk_isSymlink "%myPath%" && %dk_call% dk_info "'%myPath%' is a symlink" || %dk_call% dk_info "'%myPath%' is NOT a symlink"
	
	set "myPath=C:/Users/Administrator/Desktop/digitalknob"
    %dk_call% dk_isSymlink "%myPath%" && %dk_call% dk_info "'%myPath%' is a symlink" || %dk_call% dk_info "'%myPath%' is NOT a symlink"
	
	set "myPath=C:/Users/Administrator/Desktop"
    %dk_call% dk_isSymlink "%myPath%" && %dk_call% dk_info "'%myPath%' is a symlink" || %dk_call% dk_info "'%myPath%' is NOT a symlink"
%endfunction%
