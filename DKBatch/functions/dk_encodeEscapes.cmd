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
rem # dk_encodeEscapes(variable)
rem #
rem #  https://stackoverflow.com/a/17584764
rem #  https://www.robvanderwoude.com/escapechars.php
rem #
:dk_encodeEscapes
rem %setlocal%
  
    set org=%*
    if defined %* call set "org=%%%org%%%"  &rem FIXME: remove the need for call here
    %setlocal%
        if "!!" equ "" if "" == %org:~0,1%%org:~-1% set "org=!org:~1,-1!" &rem remove any surrounding quotes
        if "!!" neq "" if "" == %org:~0,1%%org:~-1% set "org=%org:~1,-1%" &rem remove any surrounding quotes
    endlocal & set "org=%org%"
   
    set "org=%org:^=^^%"
    set "org=%org:<=^<%"
    set "org=%org:>=^>%"
    set "org=%org:"=""%"
    rem set "org=%org:"=^"%"
    set "org=%org:&=^&%"
    set "org=%org:|=^|%"
    set "org=%org:'=^'%"
    set "org=%org:`=^`%"
    set "org=%org:,=^,%"
    set "org=%org:;=^;%"
    set "org=%org:(=^(%"
    set "org=%org:)=^)%"
    set "org=%org:!=^!%"
   
    set "var=%org%"
    if defined %* endlocal & set "%1=%var%"
   
    rem %setlocal%  
    rem set "org=!org:%=%%!"
    rem endlocal & set "org=%org%"
   
rem  set "replaceWith=_"
rem  goto rtn
   
rem  set "var=%var:""=_%"
rem  set "org=%var%"
   
rem  set "var=%var:^^=_%"
rem  set "org=%var%"
   
rem  set "var=%var:^<=_%"
rem  set "org=%var%"
   
rem  set "var=%var:^>=_%"
rem  set "org=%var%"
   
rem  set "var=%var:`=_%"
rem  set "org=%var%"
   
rem  set "var=%var:,=_%"
rem  set "org=%var%"
   
rem  set "var=%var:;=_%"
rem  set "org=%var%"
   
rem  set "var=%var:(=_%"
rem  set "org=%var%"
   
rem  set "var=%var:)=_%"
rem  set "org=%var%"
   
rem  set "var=%var:!=_%"
rem  set "org=%var%"
   
rem  set "var=%var:\=_%"
rem  set "org=%var%"
   
rem  set "var=%var:[=_%"
rem  set "org=%var%"
   
rem  set "var=%var:]=_%"
rem  set "org=%var%"

rem  set "var=%var:.=_%"
rem  set "org=%var%"

rem  set "var=%var:?=_%"
rem  set "org=%var%"
   
rem  call :replaceEqualSign var _
rem  set "org=%var%"

rem  set "var=%var:|=_%"
rem  set "org=%var%"
   
rem  %dk_call% dk_echo ""%var%"|find "*">nul
rem  if NOT errorlevel 1 for /f "tokens=1* delims=*" %%A in ("%var%") do (set "var=%%A%replaceWith%%%B")
rem  set "org=%var%"
   
rem  set "var=%var:^&=_%"
rem  set "org=%var%"
   
rem  set "var=%var:^|=_%"
rem  set "org=%var%"
   
rem  %setlocal%
rem  set "var=!var:%%%%=_!"
rem  if "!var!" neq "!org!" %dk_call% dk_echo "%% characters removed
rem  set "org=!var!"
rem  endlocal & set "org=%org%"
   
    rem Simple method to detect character in a string
    rem %dk_call% dk_echo ""%var%"|find "=">nul
    rem if NOT errorlevel 1 %dk_call% dk_echo "equal sign detected
   
    :rtn
    if NOT defined %* %dk_call% dk_echo "var = %var%
   
    %dk_call% dk_unset org
    %dk_call% dk_unset replaceWith
   
    %dk_call% dk_unset var
%endfunction%

:replaceEqualSign variable replaceWith
%setlocal%

        set "equal=="
        set "with=%~2"
        set "_s=!%~1!#"
        set "_r="
        :_replaceEqualSign
            for /F "tokens=1* delims=%equal%" %%A in ("%_s%") do (
                if NOT defined _r ( set "_r=%%A" ) else ( set "_r=%_r%%~4%with%%%A" )
                set "_s=%%B"
            )
        if defined _s (goto _replaceEqualSign)
    endlocal&set "%~1=%_r:~0,-1%"
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

   
    %dk_call% dk_echo

    set "no_special=### ###"
    %dk_call% dk_encodeEscapes no_special
    %dk_call% dk_echo "no_special = %no_special%"
   
    set "caret=### ^ ###"
    %dk_call% dk_encodeEscapes caret
    %dk_call% dk_echo "caret = %caret%"
   
    set "direct_left=### < ###"
    %dk_call% dk_encodeEscapes direct_left
    %dk_call% dk_echo "direct_left = %direct_left%"
   
    set "direct_right=### > ###"
    %dk_call% dk_encodeEscapes direct_right
    %dk_call% dk_echo "direct_right = %direct_right%"
   
    set "backtick=### ` ###"
    %dk_call% dk_encodeEscapes backtick
    %dk_call% dk_echo "backtick = %backtick%"
   
    set "comma=### , ###"
    %dk_call% dk_encodeEscapes comma
    %dk_call% dk_echo "comma = %comma%"
   
    set "semicolon=### ; ###"
    %dk_call% dk_encodeEscapes semicolon
    %dk_call% dk_echo "semicolon = %semicolon%"
   
    set "equal=### = ###"
    %dk_call% dk_encodeEscapes equal
    %dk_call% dk_echo "equal = %equal%"
   
    set "left_parenthesis=### ( ###"
    %dk_call% dk_encodeEscapes left_parenthesis
    %dk_call% dk_echo "left_parenthesis = %left_parenthesis%"
   
    set "right_parenthesis=### ) ###"
    %dk_call% dk_encodeEscapes right_parenthesis
    %dk_call% dk_echo "right_parenthesis = %right_parenthesis%"
   
    set "exclamation=### ! ###"
    %dk_call% dk_encodeEscapes exclamation
    %dk_call% dk_echo "exclamation = %exclamation%"
   
    set "backslash=### \ ###"
    %dk_call% dk_encodeEscapes backslash
    %dk_call% dk_echo "backslash = %backslash%"
   
    set "left_bracket=### [ ###"
    %dk_call% dk_encodeEscapes left_bracket
    %dk_call% dk_echo "left_bracket = %left_bracket%"
   
    set "right_bracket=### ] ###"
    %dk_call% dk_encodeEscapes right_bracket
    %dk_call% dk_echo "right_bracket = %right_bracket%"
   
    set "period=### . ###"
    %dk_call% dk_encodeEscapes period
    %dk_call% dk_echo "period = %period%"
   
    set "asterisk=### * ###"
    %dk_call% dk_encodeEscapes asterisk
    %dk_call% dk_echo "asterisk = %asterisk%"
   
    set "quote=### " ###"
    %dk_call% dk_encodeEscapes quote
    %dk_call% dk_echo "quote = %quote%"
   
    set "question=### ? ###"
    %dk_call% dk_encodeEscapes question
    %dk_call% dk_echo "question = %question%"
   
    set "and=### & ###"
    %dk_call% dk_encodeEscapes and
    %dk_call% dk_echo "and = %and%"
   
    set "pipe=### | ###"
    %dk_call% dk_encodeEscapes pipe
    echo pipe = %pipe%
   
    rem set "percent=### %%%% ###"
    rem %dk_call% dk_encodeEscapes percent
    rem %dk_call% dk_echo "percent = %percent%
   
    set "allchars=### ^ < > ` , ; = ( ) ! \ [ ] . ? & | " % ###"
    %dk_call% dk_encodeEscapes allchars
    %dk_call% dk_echo "allchars = %allchars%"

    rem set "imposible=### This is impossible %path% ^& | <> "^& | <>" ^ ###"
    rem %dk_call% dk_encodeEscapes imposible
    rem %dk_call% dk_echo "imposible = %imposible%"
%endfunction%
