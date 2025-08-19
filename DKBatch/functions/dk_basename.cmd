@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_basename(_path, _rtn_var)
::#
::#		Strip directory and suffix from filenames
::#
::#		Reference: https://en.wikipedia.org/wiki/Basename
::#
:dk_basename
%setlocal%
	%dk_call% dk_debugFunc 1 2
	
	::###### input ######
	::# %~1 = _path
	::# %~2 = _rtn_var (optional)
	
	
	set "_path=%~1"
	set "_path=%_path:"=%"								 
	if "%_path:~-1%" equ "/" (set "_path=%_path:~0,-1%")
	if "%_path:~-1%" equ "\" (set "_path=%_path:~0,-1%")
	for %%G in ("%_path%") do (set "dk_basename=%%~nxG")
	
	
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
	
	::### Result as return value
	%dk_call% dk_echo
	for /f "usebackq delims=" %%G in (`call dk_basename "C:/directoryC/filenameC.extC"`) do set "resultC=%%G"
	%dk_call% dk_echo "resultC = %resultC%"
	::%dk_call% dk_echo "dk_basename = %dk_basename%"			&:: NOTE: export cannot be seen outside of command substituion

	::### Result as hashtable parameter
	%dk_call% dk_echo
	%dk_call% dk_basename "D:/directoryD/filenameD.extD" resultD.value
	%dk_call% dk_echo "resultD.value = %resultD.value%"
	%dk_call% dk_echo "dk_basename = %dk_basename%"
	
%endfunction%
