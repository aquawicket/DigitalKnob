@echo off
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::#################################################################################
::# dk_registryGetKey(<reg_path>, <key>, <rtn_var:optional>
::#
::#
:dk_registryGetKey
setlocal
    %dk_call% dk_debugFunc 2 3

	set "_reg_path_=%~1"
	set "_key_=%~2"
	
	%dk_call% dk_validate REG_EXE "%dk_call% dk_REG_EXE"
	
	set "currentScope=1"
    for /F "tokens=2* skip=2" %%a in ('%REG_EXE% query "%_reg_path_:/=\%" /v "%_key_:/=\%"') do ( 
        if defined currentScope endlocal
		set "dk_registryGetKey=%%b"
		if not "%~2"=="" (set "%~2=%%b")
		if not "%~3"=="" (set "%~3=%%b")
    )
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_registryGetKey "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework" "InstallRoot" rtn_var
	%dk_call% dk_printVar dk_registryGetKey
	%dk_call% dk_printVar InstallRoot
	%dk_call% dk_printVar rtn_var
%endfunction%
