@echo off
call DK

::################################################################################
::# dk_readCache()
::#
::#
:dk_readCache () {
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
    ::echo reading cache...
    if not exist %DKBRANCH_DIR%\cache goto:eof
    set /a count = 0
    for /f "tokens=*" %%a in (%DKBRANCH_DIR%\cache) do (
        set a=%%a: =%
        ::echo !count!: %%a
        if !count! == 0 set "_APP_=%%a"
        if !count! == 1 set "_TARGET_OS_=%%a"
        if !count! == 2 set "_TYPE_=%%a"
        if !count! == 3 set "_LEVEL_=%%a"
        call set /a count += 1
    )
        
    set _APP_=%_APP_: =%
    set _TARGET_OS_=%_TARGET_OS_: =%
    set _TYPE_=%_TYPE_: =%
    set _LEVEL_=%_LEVEL_: =%
goto:eof