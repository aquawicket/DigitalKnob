@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_removeSpecialChars(<in> rtn_var)
::#
::#	 https://stackoverflow.com/a/17584764
::#
:dk_removeSpecialChars
	::call dk_debugFunc
	::if %__ARGC__% lss 1 call dk_error "%__FUNCTION__% not enough arguments")
	::if %__ARGC__% gtr 2 call dk_error "%__FUNCTION__% too many arguments")
@echo on
	echo.
	
	
	
	::echo "%~1"|find "&">nul
	::if not errorlevel 1 goto :skip
	::set "org=%~1"
	set org=%*
	setlocal enableDelayedExpansion	
		if "" == %org:~0,1%%org:~-1% set "org=!org:~1,-1!"
	endlocal & set "org=%org%"
	
	set "org=%org:"=""%"
	set "org=%org:<=^<%"
	set "org=%org:>=^>%"
	set "org=%org:&=^&%"
	
	::set "org="%org%""
	echo org = %org%

	set "var=%org%"
	set "replaceWith=_"
	
::	echo %org%|find """">nul
::	if errorlevel 1 goto:skip
::	set "var=%var:"=_%"
::	if not "%var%" equ "%org%"
::	echo removed quote characters
::	set "org=%var%"
::	pause
::	:skip
	
	
	
	::echo %~1
	::set "org=%~1"
	::set "org=%~1%~2%~3%~4%~5%~6%~7%~8%~9"
		
	::setlocal enableDelayedExpansion	
	::	if "" == %org:~0,1%%org:~-1% set "org=!org:~1,-1!"
	::endlocal & set "org=%org%"
	
	
	
	set "org=%org:""=_%"
	if not "%var%" equ "%org%" echo "" characters removed
	set "org=%var%"
	
	
	set "var=%var:^^=_%"
	if not "%var%"=="%org%" echo ^^ characters removed
	set "org=%var%"
	
	set "var=%var:^<=_%"
	if not "%var%"=="%org%" echo ^< characters removed
	set "org=%var%"
	
	set "var=%var:^>=_%"
	if not "%var%"=="%org%" echo ^> characters removed
	set "org=%var%"
	
	set "var=%var:`=_%"
	if not "%var%"=="%org%" echo ` characters removed
	set "org=%var%"
	
	set "var=%var:,=_%"
	if not "%var%"=="%org%" echo , characters removed
	set "org=%var%"
	
	set "var=%var:;=_%"
	if not "%var%"=="%org%" echo ; characters removed
	set "org=%var%"
	
	set "var=%var:(=_%"
	if not "%var%"=="%org%" echo ( characters removed
	set "org=%var%"
	
	set "var=%var:)=_%"
	if not "%var%"=="%org%" echo ) characters removed
	set "org=%var%"
	
	set "var=%var:!=_%"
	if not "%var%"=="%org%" echo ! characters removed
	set "org=%var%"
	
	set "var=%var:\=_%"
	if not "%var%"=="%org%" echo \ characters removed
	set "org=%var%"
	
	set "var=%var:[=_%"
	if not "%var%"=="%org%" echo [ characters removed
	set "org=%var%"
	
	set "var=%var:]=_%"
	if not "%var%"=="%org%" echo ] characters removed
	set "org=%var%"

	set "var=%var:.=_%"
	if not "%var%"=="%org%" echo . characters removed
	set "org=%var%"

	set "var=%var:?=_%"
	if not "%var%"=="%org%" echo ? characters removed
	set "org=%var%"
	
	call :replaceEqualSign var _
	if not "%var%"=="%org%" echo = characters removed
	set "org=%var%"

	set "var=%var:|=_%"
	if not "%var%"=="%org%" echo ^| characters removed
	set "org=%var%"
	
	echo "%var%"|find "*">nul
	if not errorlevel 1 for /f "tokens=1* delims=*" %%A in ("%var%") do (set "var=%%A%replaceWith%%%B")
	if not "%var%"=="%org%" echo * characters removed
	set "org=%var%"
	
	
	
	
	::set "var=%var:^&=_%"
	::if not "%var%"=="%org%" echo ^& characters removed
	::set "org=%var%"
	
	
	:: Simple method to detect character in a string
	::echo "%var%"|find "=">nul
	::if not errorlevel 1 echo equal sign detected
	
	::setlocal enableDelayedExpansion	
	::	set "var=!var:%=_!"
	::	if not "!var!"=="!org!" echo %% characters removed
	::	set "org=!var!"
	::endlocal
	
	echo var = %var%
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

	call dk_removeSpecialChars "abc xyz"
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
	::call dk_removeSpecialChars "abc % xyz"
	call dk_removeSpecialChars "abc " xyz"
	rem call dk_removeSpecialChars "abc ^| xyz"
goto:eof
