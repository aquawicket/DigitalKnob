@echo off
call DK

::#####################################################################
::# dk_pickApp()
::#
::#
:dk_pickApp () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
    TITLE DigitalKnob - %APP% %TARGET_OS% %TYPE%

    call dk_readCache

    echo.
    if exist "%DKBRANCH_DIR%\cache" if "%_APP_%" neq "" if "%_TARGET_OS_%" neq "" if "%_TYPE_%" neq "" echo  0) Repeat cache [%_APP_% - %_TARGET_OS_% - %_TYPE_%]
    echo  1) HelloWorld
    echo  2) DKCore
    echo  3) DKJavascript
    echo  4) DKSDL
    echo  5) DKSDLRml
    echo  6) DKDomTest
    echo  7) DKTestAll
    echo  8) Enter Manually
    echo  9) Clear Screen
    echo 10) Reload
    echo 11) Go Back
    echo 12) Exit
    set choice=
    set /p choice=Please select an app to build: 
    
    ::if not '%choice%'=='' set choice=%choice:~0,1%        ::What does this do?
    if "%choice%"=="0"  set "APP=%_APP_%" & set "TARGET_OS=%_TARGET_OS_%" & set "TYPE=%_TYPE_%" & goto:eof
    if "%choice%"=="1"  set "APP=HelloWorld"   & goto:eof
    if "%choice%"=="2"  set "APP=DKCore"       & goto:eof
    if "%choice%"=="3"  set "APP=DKJavascript" & goto:eof
    if "%choice%"=="4"  set "APP=DKSDL"        & goto:eof
    if "%choice%"=="5"  set "APP=DKSDLRml"     & goto:eof
    if "%choice%"=="6"  set "APP=DKDomTest"    & goto:eof
    if "%choice%"=="7"  set "APP=DKTestAll"    & goto:eof
    if "%choice%"=="8"  call dk_enterManually  & goto:eof
    if "%choice%"=="9" call dk_clearScreen     & goto:eof
    if "%choice%"=="10" call dk_reload         & goto:eof
    if "%choice%"=="11" set "UPDATE="          & goto:eof
    if "%choice%"=="12" call dk_exit           & goto:eof
        
    echo %choice%: invalid selection, please try again
    set APP=
goto:eof