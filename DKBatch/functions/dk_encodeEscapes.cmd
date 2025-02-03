@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_encodeEscapes(variable)
::#
::#  https://stackoverflow.com/a/17584764
::#  https://www.robvanderwoude.com/escapechars.php
::#
:dk_encodeEscapes
::setlocal
    %dk_call% dk_debugFunc 1 2
   
    set org=%*
    if defined %* call set "org=%%%org%%%"  &:: FIXME: remove the need for call here
    setlocal enableDelayedExpansion
        if "!DE!" equ "" if "" == %org:~0,1%%org:~-1% set "org=!org:~1,-1!" &:: remove any surrounding quotes
        if "!DE!" neq "" if "" == %org:~0,1%%org:~-1% set "org=%org:~1,-1%" &:: remove any surrounding quotes
    endlocal & set "org=%org%"
    
    set "org=%org:^=^^%"
    set "org=%org:<=^<%"
    set "org=%org:>=^>%"
    set "org=%org:"=""%"
    ::set "org=%org:"=^"%"
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
    
    ::setlocal enableDelayedExpansion   
    ::set "org=!org:%=%%!"
    ::endlocal & set "org=%org%"
    
::  set "replaceWith=_"
::  goto rtn
    
::  set "var=%var:""=_%"
::  set "org=%var%"
    
::  set "var=%var:^^=_%"
::  set "org=%var%"
    
::  set "var=%var:^<=_%"
::  set "org=%var%"
    
::  set "var=%var:^>=_%"
::  set "org=%var%"
    
::  set "var=%var:`=_%"
::  set "org=%var%"
    
::  set "var=%var:,=_%"
::  set "org=%var%"
    
::  set "var=%var:;=_%"
::  set "org=%var%"
    
::  set "var=%var:(=_%"
::  set "org=%var%"
    
::  set "var=%var:)=_%"
::  set "org=%var%"
    
::  set "var=%var:!=_%"
::  set "org=%var%"
    
::  set "var=%var:\=_%"
::  set "org=%var%"
    
::  set "var=%var:[=_%"
::  set "org=%var%"
    
::  set "var=%var:]=_%"
::  set "org=%var%"

::  set "var=%var:.=_%"
::  set "org=%var%"

::  set "var=%var:?=_%"
::  set "org=%var%"
    
::  call :replaceEqualSign var _
::  set "org=%var%"

::  set "var=%var:|=_%"
::  set "org=%var%"
    
::  %dk_call% dk_echo ""%var%"|find "*">nul
::  if not errorlevel 1 for /f "tokens=1* delims=*" %%A in ("%var%") do (set "var=%%A%replaceWith%%%B")
::  set "org=%var%"
    
::  set "var=%var:^&=_%"
::  set "org=%var%"
    
::  set "var=%var:^|=_%"
::  set "org=%var%"
    
::  setlocal enableDelayedExpansion
::  set "var=!var:%%%%=_!"
::  if not "!var!"=="!org!" %dk_call% dk_echo "%% characters removed
::  set "org=!var!"
::  endlocal & set "org=%org%"
    
    :: Simple method to detect character in a string
    ::%dk_call% dk_echo ""%var%"|find "=">nul
    ::if not errorlevel 1 %dk_call% dk_echo "equal sign detected
    
    :rtn
    if not defined %* %dk_call% dk_echo "var = %var%
    
    %dk_call% dk_unset org
    %dk_call% dk_unset replaceWith
    
    %dk_call% dk_unset var
%endfunction%

:replaceEqualSign variable replaceWith
setlocal enableDelayedExpansion
	 ::%dk_call% dk_debugFunc 0
        set "equal=="
        set "with=%~2"
        set "_s=!%~1!#"
        set "_r="
        :_replaceEqualSign
            for /F "tokens=1* delims=%equal%" %%A in ("%_s%") do (
                if not defined _r ( set "_r=%%A" ) else ( set "_r=%_r%%~4%with%%%A" )
                set "_s=%%B"
            )
        if defined _s goto _replaceEqualSign
    endlocal&set "%~1=%_r:~0,-1%"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    
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
    
    ::set "percent=### %%%% ###"
    ::%dk_call% dk_encodeEscapes percent
    ::%dk_call% dk_echo "percent = %percent%
    
    set "allchars=### ^ < > ` , ; = ( ) ! \ [ ] . ? & | " % ###"
    %dk_call% dk_encodeEscapes allchars
    %dk_call% dk_echo "allchars = %allchars%"

    ::set "imposible=### This is impossible %path% ^& | <> "^& | <>" ^ ###"
    ::%dk_call% dk_encodeEscapes imposible
    ::%dk_call% dk_echo "imposible = %imposible%"
%endfunction%
