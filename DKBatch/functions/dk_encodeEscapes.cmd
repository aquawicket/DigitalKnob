@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_encodeEscapes(variable)
::#
::#	 https://stackoverflow.com/a/17584764
::#  https://www.robvanderwoude.com/escapechars.php
::#
:dk_encodeEscapes
	call dk_debugFunc 1 2
	
	set org=%*
	if defined %* call set "org=%%%org%%%"	&:: FIXME: remove the need for call here
	setlocal enableDelayedExpansion
		if "!!" equ "" if "" == %org:~0,1%%org:~-1% set "org=!org:~1,-1!"	&:: remove any surrounding quotes
		if "!!" neq "" if "" == %org:~0,1%%org:~-1% set "org=%org:~1,-1%"	&:: remove any surrounding quotes
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
	
::	set "replaceWith=_"
::	goto:rtn
	
::	set "var=%var:""=_%"
::	set "org=%var%"
	
::	set "var=%var:^^=_%"
::	set "org=%var%"
	
::	set "var=%var:^<=_%"
::	set "org=%var%"
	
::	set "var=%var:^>=_%"
::	set "org=%var%"
	
::	set "var=%var:`=_%"
::	set "org=%var%"
	
::	set "var=%var:,=_%"
::	set "org=%var%"
	
::	set "var=%var:;=_%"
::	set "org=%var%"
	
::	set "var=%var:(=_%"
::	set "org=%var%"
	
::	set "var=%var:)=_%"
::	set "org=%var%"
	
::	set "var=%var:!=_%"
::	set "org=%var%"
	
::	set "var=%var:\=_%"
::	set "org=%var%"
	
::	set "var=%var:[=_%"
::	set "org=%var%"
	
::	set "var=%var:]=_%"
::	set "org=%var%"

::	set "var=%var:.=_%"
::	set "org=%var%"

::	set "var=%var:?=_%"
::	set "org=%var%"
	
::	call :replaceEqualSign var _
::	set "org=%var%"

::	set "var=%var:|=_%"
::	set "org=%var%"
	
::	call dk_echo ""%var%"|find "*">nul
::	if not errorlevel 1 for /f "tokens=1* delims=*" %%A in ("%var%") do (set "var=%%A%replaceWith%%%B")
::	set "org=%var%"
	
::	set "var=%var:^&=_%"
::	set "org=%var%"
	
::	set "var=%var:^|=_%"
::	set "org=%var%"
	
::	setlocal enableDelayedExpansion
::	set "var=!var:%%%%=_!"
::	if not "!var!"=="!org!" call dk_echo "%% characters removed
::	set "org=!var!"
::	endlocal & set "org=%org%"
	
	:: Simple method to detect character in a string
	::call dk_echo ""%var%"|find "=">nul
	::if not errorlevel 1 call dk_echo "equal sign detected
	
	:rtn
	if not defined %* call dk_echo "var = %var%
	
	call dk_unset org
	call dk_unset replaceWith
	
	call dk_unset var
goto:eof

:replaceEqualSign variable replaceWith
    setlocal enableDelayedExpansion
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
goto:eof



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_echo

	set "no_special=### ###"
	call dk_encodeEscapes no_special
	call dk_echo "no_special = %no_special%"
	
	set "caret=### ^ ###"
	call dk_encodeEscapes caret
	call dk_echo "caret = %caret%"
	
	set "direct_left=### < ###"
	call dk_encodeEscapes direct_left
	call dk_echo "direct_left = %direct_left%"
	
	set "direct_right=### > ###"
	call dk_encodeEscapes direct_right
	call dk_echo "direct_right = %direct_right%"
	
	set "backtick=### ` ###"
	call dk_encodeEscapes backtick
	call dk_echo "backtick = %backtick%"
	
	set "comma=### , ###"
	call dk_encodeEscapes comma
	call dk_echo "comma = %comma%"
	
	set "semicolon=### ; ###"
	call dk_encodeEscapes semicolon
	call dk_echo "semicolon = %semicolon%"
	
	set "equal=### = ###"
	call dk_encodeEscapes equal
	call dk_echo "equal = %equal%"
	
	set "left_parenthesis=### ( ###"
	call dk_encodeEscapes left_parenthesis
	call dk_echo "left_parenthesis = %left_parenthesis%"
	
	set "right_parenthesis=### ) ###"
	call dk_encodeEscapes right_parenthesis
	call dk_echo "right_parenthesis = %right_parenthesis%"
	
	set "exclamation=### ! ###"
	call dk_encodeEscapes exclamation
	call dk_echo "exclamation = %exclamation%"
	
	set "backslash=### \ ###"
	call dk_encodeEscapes backslash
	call dk_echo "backslash = %backslash%"
	
	set "left_bracket=### [ ###"
	call dk_encodeEscapes left_bracket
	call dk_echo "left_bracket = %left_bracket%"
	
	set "right_bracket=### ] ###"
	call dk_encodeEscapes right_bracket
	call dk_echo "right_bracket = %right_bracket%"
	
	set "period=### . ###"
	call dk_encodeEscapes period
	call dk_echo "period = %period%"
	
	set "asterisk=### * ###"
	call dk_encodeEscapes asterisk
	call dk_echo "asterisk = %asterisk%"
	
	set "quote=### " ###"
	call dk_encodeEscapes quote
	call dk_echo "quote = %quote%"
	
	set "question=### ? ###"
	call dk_encodeEscapes question
	call dk_echo "question = %question%"
	
	set "and=### & ###"
	call dk_encodeEscapes and
	call dk_echo "and = %and%"
	
	set "pipe=### | ###"
	call dk_encodeEscapes pipe
	echo pipe = %pipe%
	
	::set "percent=### %%%% ###"
	::call dk_encodeEscapes percent
	::call dk_echo "percent = %percent%
	
	set "allchars=### ^ < > ` , ; = ( ) ! \ [ ] . ? & | " % ###"
	call dk_encodeEscapes allchars
	call dk_echo "allchars = %allchars%"

	::set "imposible=### This is impossible %path% ^& | <> "^& | <>" ^ ###"
	::call dk_encodeEscapes imposible
	::call dk_echo "imposible = %imposible%"
	
goto:eof
