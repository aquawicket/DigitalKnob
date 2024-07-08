@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_removeSpecialChars(rtn_var)
::#
::#	 https://stackoverflow.com/a/17584764
::#
:dk_removeSpecialChars
	call dk_debugFunc
	if %__ARGC__% lss 1 call dk_error "%__FUNCTION__% not enough arguments"
	::if %__ARGC__% gtr 2 call dk_error "%__FUNCTION__% too many arguments"
	
	echo.
	set org=%*
	
	if defined %* call set "org=%%%org%%%"
	
	setlocal enableDelayedExpansion	
		if "" == %org:~0,1%%org:~-1% set "org=!org:~1,-1!"
	endlocal & set "org=%org%"
	
	set "org=%org:"=""%"
	set "org=%org:^=^^%"
	set "org=%org:<=^<%"
	set "org=%org:>=^>%"
	set "org=%org:&=^&%"
	set "org=%org:|=^|%"
	::setlocal enableDelayedExpansion	
	::set "org=!org:%=%%!"
	::endlocal & set "org=%org%"
	echo org = %org%
	set "var=%org%"
	set "replaceWith=_"

	set "var=%var:""=_%"
	set "org=%var%"
	
	set "var=%var:^^=_%"
	set "org=%var%"
	
	set "var=%var:^<=_%"
	set "org=%var%"
	
	set "var=%var:^>=_%"
	set "org=%var%"
	
	set "var=%var:`=_%"
	set "org=%var%"
	
	set "var=%var:,=_%"
	set "org=%var%"
	
	set "var=%var:;=_%"
	set "org=%var%"
	
	set "var=%var:(=_%"
	set "org=%var%"
	
	set "var=%var:)=_%"
	set "org=%var%"
	
	set "var=%var:!=_%"
	set "org=%var%"
	
	set "var=%var:\=_%"
	set "org=%var%"
	
	set "var=%var:[=_%"
	set "org=%var%"
	
	set "var=%var:]=_%"
	set "org=%var%"

	set "var=%var:.=_%"
	set "org=%var%"

	set "var=%var:?=_%"
	set "org=%var%"
	
	call :replaceEqualSign var _
	set "org=%var%"

	set "var=%var:|=_%"
	set "org=%var%"
	
	echo "%var%"|find "*">nul
	if not errorlevel 1 for /f "tokens=1* delims=*" %%A in ("%var%") do (set "var=%%A%replaceWith%%%B")
	set "org=%var%"
	
	set "var=%var:^&=_%"
	set "org=%var%"
	
	set "var=%var:^|=_%"
	set "org=%var%"
	
::	setlocal enableDelayedExpansion
::	set "var=!var:%%%%=_!"
::	if not "!var!"=="!org!" echo %% characters removed
::	set "org=!var!"
::	endlocal & set "org=%org%"
	
	:: Simple method to detect character in a string
	::echo "%var%"|find "=">nul
	::if not errorlevel 1 echo equal sign detected
	
	echo var = %var%
	
	call dk_unset org
	call dk_unset var
	call dk_unset replaceWith
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



::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
:DKTEST
	call dk_debugFunc

	echo ####### Parameters by string ########
	call dk_removeSpecialChars "abc   xyz"
	call dk_removeSpecialChars "abc ^ xyz"
	call dk_removeSpecialChars "abc < xyz"
	call dk_removeSpecialChars "abc > xyz"
	call dk_removeSpecialChars "abc ` xyz"
	call dk_removeSpecialChars "abc , xyz"
	call dk_removeSpecialChars "abc ; xyz"
	call dk_removeSpecialChars "abc = xyz"
	call dk_removeSpecialChars "abc ( xyz"
	call dk_removeSpecialChars "abc ) xyz"
	call dk_removeSpecialChars "abc ! xyz"
	call dk_removeSpecialChars "abc \ xyz"
	call dk_removeSpecialChars "abc [ xyz"
	call dk_removeSpecialChars "abc ] xyz"
	call dk_removeSpecialChars "abc . xyz"
	call dk_removeSpecialChars "abc * xyz"
	call dk_removeSpecialChars "abc & xyz"
	call dk_removeSpecialChars "abc ? xyz"
	call dk_removeSpecialChars "abc " xyz"
	call dk_removeSpecialChars "abc | xyz"
::	call dk_removeSpecialChars "abc %%%% xyz"

	echo.
	echo.
	echo ####### Parameters by variable ########
	set "no_special=abc xyz"
	call dk_removeSpecialChars no_special
	
	set "caret=abc ^ xyz"
	call dk_removeSpecialChars caret
	
	set "direct_left=abc < xyz"
	call dk_removeSpecialChars direct_left
	
	set "direct_right=abc > xyz"
	call dk_removeSpecialChars direct_right
	
	set "backtick=abc ` xyz"
	call dk_removeSpecialChars backtick
	
	set "comma=abc , xyz"
	call dk_removeSpecialChars comma
	
	set "semicolon=abc ; xyz"
	call dk_removeSpecialChars semicolon
	
	set "equal=abc = xyz"
	call dk_removeSpecialChars equal
	
	set "left_parenthesis=abc ( xyz"
	call dk_removeSpecialChars left_parenthesis
	
	set "right_parenthesis=abc ) xyz"
	call dk_removeSpecialChars right_parenthesis
	
	set "exclamation=abc ! xyz"
	call dk_removeSpecialChars exclamation
	
	set "backslash=abc \ xyz"
	call dk_removeSpecialChars backslash
	
	set "left_bracket=abc [ xyz"
	call dk_removeSpecialChars left_bracket
	
	set "right_bracket=abc ] xyz"
	call dk_removeSpecialChars right_bracket
	
	set "period=abc . xyz"
	call dk_removeSpecialChars period
	
	set "asterisk=abc * xyz"
	call dk_removeSpecialChars asterisk
	
	set "and=abc & xyz"
	call dk_removeSpecialChars and
	
	set "question=abc ? xyz"
	call dk_removeSpecialChars question
	
	set "quote=abc " xyz"
	call dk_removeSpecialChars quote
	
	set "pipe=abc | xyz"
	call dk_removeSpecialChars pipe
::	call dk_removeSpecialChars "abc %%%% xyz"
goto:eof
