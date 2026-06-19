@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################

rem ####################################################################
rem # dk_keyboardMenu(rtn_var)
rem #
rem #
:dk_keyboardMenu
%setlocal%

	if /i "%~1" equ "NEW" echo dk_keyboardMenu NEW
	if /i "%~1" equ "ADD" echo dk_keyboardMenu ADD
	if /i "%~1" equ "RUN" echo dk_keyboardMenu RUN
      
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
   
    %dk_call% dk_keyboardInput
    rem %dk_call% dk_keyboardInputTimeout 1 60
       
    if "%dk_keyboardInput%" equ "1"  endlocal & set "%1=option1"	& %return%
	if "%dk_keyboardInput%" equ "2"  endlocal & set "%1=option2"	& %return%
    if "%dk_keyboardInput%" equ "3"  endlocal & set "%1=option3"	& %return%
    if "%dk_keyboardInput%" equ "4"  endlocal & set "%1=option4"	& %return%
    if "%dk_keyboardInput%" equ "5"  endlocal & set "%1=option5"	& %return%
    if "%dk_keyboardInput%" equ "38" %dk_call% Option6				& %return%
    if "%dk_keyboardInput%" equ "39" %dk_call% Option7				& %return%
    if "%dk_keyboardInput%" equ "40" %dk_call% dk_exit				& %return%

    %dk_call% dk_echo %dk_keyboardInput%: invalid selection, please try again
    %dk_call% dk_unset Target_Tuple
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
	rem TODO: This is the desired functionality of the menu
    %dk_call% dk_keyboardMenu NEW myMenu
	%dk_call% dk_keyboardMenu ADD myMenu option1
	%dk_call% dk_keyboardMenu ADD myMenu option2
	%dk_call% dk_keyboardMenu ADD myMenu option2
	%dk_call% dk_keyboardMenu RUN myMenu
	
	rem This can eventually be given a one liner , something like
	%dk_call% dk_keyboardMenu Option1 Option2 Option3 rtnVar
%endfunction%
