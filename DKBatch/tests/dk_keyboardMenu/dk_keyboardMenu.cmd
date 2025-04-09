@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_keyboardMenu(rtn_var)
::#
::#
:dk_keyboardMenu
    ::%dk_call% dk_debugFunc 1 99
 setlocal
 
	if "%~1" == "NEW" echo dk_keyboardMenu NEW
	if "%~1" == "ADD" echo dk_keyboardMenu ADD
	if "%~1" == "RUN" echo dk_keyboardMenu RUN
       
    %dk_call% dk_echo
    echo  1)  Option1
	echo  2)  Option2
    echo  3)  Option3
    echo  4)  Option4
    echo  5)  Option5
    echo  6)  Option6
    echo  7)  Option7
    echo  8)  Option8
    echo  9)  Option9
    echo  10) Option10
    echo  11) Option11 
    
    %dk_call% dk_echo 
    %dk_call% dk_echo "Please select an Option"
    
    ::%dk_call% dk_keyboardInput choice
    %dk_call% dk_keyboardInputTimeout choice 1 60
        
    if "%choice%"=="1"  endlocal & set "%1=option1"	  & %return%
	if "%choice%"=="2"  endlocal & set "%1=option2"   & %return%
    if "%choice%"=="3"  endlocal & set "%1=option3"   & %return%
    if "%choice%"=="4"  endlocal & set "%1=option4"   & %return%
    if "%choice%"=="5"  endlocal & set "%1=option5"   & %return%
    if "%choice%"=="38" %dk_call% Option6             & %return%
    if "%choice%"=="39" %dk_call% Option7             & %return%
    if "%choice%"=="40" %dk_call% dk_exit             & %return%

    %dk_call% dk_echo %choice%: invalid selection, please try again
    %dk_call% dk_unset target_triple
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
	:: TODO: This is the desired functionality of the menu
    %dk_call% dk_keyboardMenu NEW myMenu
	%dk_call% dk_keyboardMenu ADD myMenu option1
	%dk_call% dk_keyboardMenu ADD myMenu option2
	%dk_call% dk_keyboardMenu ADD myMenu option2
	%dk_call% dk_keyboardMenu RUN myMenu
	
	:: This can eventually be given a one liner , something like
	%dk_call% dk_keyboardMenu Option1 Option2 Option3 rtnVar
%endfunction%
