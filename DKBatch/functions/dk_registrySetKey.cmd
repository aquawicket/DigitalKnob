<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::#################################################################################
:: dk_registrySetKey() <reg_path> <key> <type> <value>
::
<<<<<<< HEAD
::
:dk_registrySetKey
    call dk_debugFunc 4
  setlocal
  
    if "%~1" equ "" %dk_call% dk_error "%__FUNCTION__%(): argument 1 is invalid"
    if "%~2" equ "" (set "_key_=/ve") else (set "_key_=/v %~2")
    if "%~3" equ "" (set "_type_=") else (set "_type_=/t %~3")
    if "%~4" equ "" (set "_value_=") else (set "_value_=%~4")

    echo "%SystemRoot%\System32\reg.exe" ADD "%~1" %_key_% %_type_% /d "%_value_%" /f
    "%SystemRoot%\System32\reg.exe" ADD "%~1" %_key_% %_type_% /d "%_value_%" /f
=======
:dk_registrySetKey
setlocal
    %dk_call% dk_debugFunc 1 4
 
    if not "%~1" equ "" (set "_reg_path_=%~1") else 	(%dk_call% dk_error "dk_registrySetKey: _reg_path_ is invalid" & %return%)
    if not "%~2" equ "" (set "_key_=/v %~2")	else	(set "_key_=/ve")
    if not "%~3" equ "" (set "_type_=/t %~3")	else 	(set "_type_=")
    if not "%~4" equ "" (set "_value_=%~4")	else	(set "_value_=")

	%dk_call% dk_validate REG_EXE "%dk_call% dk_REG_EXE"
	
    set command="%REG_EXE%" ADD "%_reg_path_:/=\%" %_key_% %_type_% /d "%_value_%" /f
	echo command = %command%
	%command%
>>>>>>> Development
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
    
    %dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DIGITALKNOB_DIR"
    %dk_call% dk_set NOTEPADPP_DIR "%DKTOOLS_DIR%\%NOTEPADPP_FOLDER%"
    %dk_call% dk_set NOTEPADPP_EXE "%NOTEPADPP_DIR%\notepad++.exe"
    %dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++" "Icon" "REG_SZ" "\"%NOTEPADPP_EXE%\""
    %dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++\command" " " " " "\"%NOTEPADPP_EXE%\" \"%%%%^1\""
=======
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_set NOTEPAD_EXE "C:\Windows\notepad.exe"
    %dk_call% dk_registrySetKey "HKCR\*\shell\Edit with Notepad" "Icon" "REG_SZ" "\"%NOTEPAD_EXE%\""
    %dk_call% dk_registrySetKey "HKCR\*\shell\Edit with Notepad\command" "" "" "\"%NOTEPAD_EXE%\" \"%%%%%%%%1\""
	
	::%dk_call% dk_registrySetKey
>>>>>>> Development
%endfunction%
