@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# dk_UninstallPackage(name)
::#
:dk_UninstallPackage
setlocal
	%dk_call% dk_debugFunc 1

	%dk_call% dk_validate ADB_EXE "%dk_call% dk_ADB_EXE"
	"%ADB_EXE%" shell pm uninstall %~1
    "%ADB_EXE%" shell pm uninstall --user 0 %~1
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% Android/dk_UninstallPackage TODO
%endfunction%
