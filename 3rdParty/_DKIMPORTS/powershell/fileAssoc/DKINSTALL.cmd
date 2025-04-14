@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%../../../DKBatch/functions/")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	::%dk_call% dk_validate POWERSHELL_EXE "%dk_call% %DKIMPORTS_DIR%\powershell\DKINSTALL.cmd"
	%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE"
	%dk_call% dk_installFileAssoc .ps1 %POWERSHELL_EXE%
	%dk_call% dk_installFileAssoc .psm1 %POWERSHELL_EXE%
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	setlocal
	%dk_call% dk_debugFunc 0
	
	call :DKINSTALL
%endfunction%
