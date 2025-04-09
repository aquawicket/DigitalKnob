@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::#################################################################################
:: dk_registrySetKey() <reg_path> <key> <type> <value>
::
:dk_registrySetKey
setlocal
    %dk_call% dk_debugFunc 1 4
 
    if not "%~1"=="" (set "_reg_path_=%~1") else 	(%dk_call% dk_error "dk_registrySetKey: _reg_path_ is invalid" & %return%)
    if not "%~2"=="" (set "_key_=/v %~2")	else	(set "_key_=/ve")
    if not "%~3"=="" (set "_type_=/t %~3")	else 	(set "_type_=")
    if not "%~4"=="" (set "_value_=%~4")	else	(set "_value_=")

	%dk_call% dk_validate REG_EXE "%dk_call% dk_REG_EXE"
	
    set command="%REG_EXE%" ADD "%_reg_path_:/=\%" %_key_% %_type_% /d "%_value_%" /f
	echo command = %command%
	%command%
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_set NOTEPAD_EXE "C:\Windows\notepad.exe"
    %dk_call% dk_registrySetKey "HKCR\*\shell\Edit with Notepad" "Icon" "REG_SZ" "\"%NOTEPAD_EXE%\""
    %dk_call% dk_registrySetKey "HKCR\*\shell\Edit with Notepad\command" "" "" "\"%NOTEPAD_EXE%\" \"%%%%%%%%1\""
	
	::%dk_call% dk_registrySetKey
%endfunction%
