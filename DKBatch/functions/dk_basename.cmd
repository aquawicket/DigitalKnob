@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_basename(<pathname>, <rtn_var>:optional)
::#
::#	Strip directory and suffix from filenames
::#
::#	Reference: https://en.wikipedia.org/wiki/Basename
::#
:dk_basename
%setlocal%
	%dk_call% dk_debugFunc 1 2
	
	::###### input ######
	set "pathname=%~1"
	set "pathname=%pathname:"=%"
	
	
	if "%pathname:~-1%" equ "/" (set "pathname=%pathname:~0,-1%")
	if "%pathname:~-1%" equ "\" (set "pathname=%pathname:~0,-1%")
	for %%A in ("%pathname%") do (set "dk_basename=%%~nxA")
	
	
	::###### output ######
	endlocal & (
		set "dk_basename=%dk_basename%"
		if "%~2" neq "" (
			set "%~2=%dk_basename%"
		) else (
			echo %dk_basename%
		)
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::### Result as global variable
	%dk_call% dk_echo
	%dk_call% dk_basename "A:/directoryA/filenameA.extA"
	%dk_call% dk_echo "dk_basename = %dk_basename%"
	
	::### Result as variable parameter
	%dk_call% dk_echo
	%dk_call% dk_basename "B:/directoryB/filenameB.extB" resultB
	%dk_call% dk_echo "resultB = %resultB%"
	%dk_call% dk_echo "dk_basename = %dk_basename%"
	
	::### Result as hashtable parameter
::	%dk_call% dk_echo
::	%dk_call% dk_basename "C:/directoryC/filenameC.extC" resultC.data
::	%dk_call% dk_echo "resultC.data = %resultC.data%"
::	%dk_call% dk_echo "dk_basename = %dk_basename%"
	
	::### Result as return value
::	%dk_call% dk_echo
::	for /f "usebackq delims=" %%G in (`%dk_call% dk_basename "D:/directoryD/filenameD.extD"`) do set "resultD=%%G"
::	%dk_call% dk_echo "resultD = %resultD%"
::	%dk_call% dk_echo "dk_basename = %dk_basename%"
%endfunction%
