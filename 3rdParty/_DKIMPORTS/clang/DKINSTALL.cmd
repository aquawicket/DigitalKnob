@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############ clang ############
::# https://packages.msys2.org/package/mingw-w64-x86_64-clang?repo=mingw64
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate Host_Tuple	"%dk_call% dk_Host_Tuple"
	%dk_call% dk_validate Target_Tuple	"%dk_call% Target_Tuple"

	if "%Host_Os%" equ "Windows" (
		%dk_call% dk_validate MSYS2 "%dk_call% dk_depend msys2"
	)
	%dk_call% dk_installPackage clang

%endfunction%

