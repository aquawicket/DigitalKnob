@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::#################################################################################
:: dk_registrySetKey() <reg_path> <key> <type> <value>
::
:dk_registrySetKey
%setlocal%
    %dk_call% dk_debugFunc 1 4
 
    if "%~1" neq "" (set "_reg_path_=%~1") else 	(%dk_call% dk_error "dk_registrySetKey: _reg_path_ is invalid" & %return%)
    if "%~2" neq "" (set "_key_=/v %~2")	else	(set "_key_=/ve")
    if "%~3" neq "" (set "_type_=/t %~3")	else 	(set "_type_=")
    if "%~4" neq "" (set "_value_=%~4")	else	(set "_value_=")

	%dk_call% dk_validate REG_EXE "%dk_call% dk_REG_EXE"
	
    set command="%REG_EXE%" ADD "%_reg_path_:/=\%" %_key_% %_type_% /d "%_value_%" /f
	echo command = %command%
	%command%
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_set NOTEPAD_EXE "C:/Windows/notepad.exe"
    %dk_call% dk_registrySetKey "HKCR/*/shell/Edit with Notepad" "Icon" "REG_SZ" "\"%NOTEPAD_EXE:/=\%\""
    %dk_call% dk_registrySetKey "HKCR/*/shell/Edit with Notepad/command" "" "" "\"%NOTEPAD_EXE:/=\%\" \"%%%%%%%%1\""
	
	::%dk_call% dk_registrySetKey
%endfunction%
