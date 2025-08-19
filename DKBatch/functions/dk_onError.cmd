@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################
::https://ss64.com/nt/syntax-error.html
:: https://reactos.org/archives/public/ros-diffs/2020-September/074204.html
:: https://stackoverflow.com/a/34987886/688352
:: https://stackoverflow.com/a/34987886

set "ErrCode[9009]=File Not Found"
set "ErrCode[1073750988]=Unbalanced parentheses"
set "ErrCode[1073750989]=Missing operand"
set "ErrCode[1073750990]=Syntax error"
set "ErrCode[1073750991]=Invalid number"
set "ErrCode[1073750992]=Number larger than 32-bits"
set "ErrCode[1073750993]=Division by zero"

::SomeCommand && (
::  Echo success
::) || (
::  Echo failed/error
::)

::set "dk_onError=&& (echo success) || (echo error)



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
  
    set "dk_onError=&& (%dk_call% dk_echo "success") || (%dk_call% dk_error "error")"
    set "dk_onError=&& (echo success) || (echo error)"
   
    (call ) %dk_onError%
    (call) %dk_onError%
%endfunction%
