@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_timer(ID)
::#
::#    Func: Returns number of seconds elapsed since the function was last
::#        called and first called. For NT4/2000/XP/2003.
::#
::#    Args: %1 (by ref) The first time this function is called, this variable
::#        is initialised to '<last> <first> <init>' where <last> and <first>
::#        are zero and <init> is the number of elapsed seconds since
::#        1970-01-01 00:00:00. This value is used by subsequent calls to
::#        determine the elapsed number of seconds since the last call
::#        (<last>) and the first call (<first>).
::#
::#    REFERENCE: https://ritchielawrence.github.io/batchfunctionlibrary/
::#
:dk_timer
	setlocal enableExtensions

	call set ID=%%%1%%
	
	call dk_getTime centisecond second minute hour
	call dk_dateToCentiSeconds seconds centiseconds %centisecond% %second% %minute% %hour%
	set /a cstime=%seconds%*100+%centiseconds%
	
	::###### Timer / Elapsed Time ######
	for /f "tokens=1-3 delims= " %%a in ('echo/%ID%') do (
		set last=%%a
		set first=%%b
		set init=%%c
	)
	if {%init%}=={} endlocal & set %1=0 0 %cstime% & goto:eof
	set /a last=cstime-init-first
	set /a first+=last
	endlocal & set %1=%last% %first% %init%
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	call dk_minMaxArgs 0
	
	set "t1="
	call dk_timer t1
	call :show

	::wait about 1 seconds
	ping 127.0.0.1 -n 2 >nul
	call dk_timer t1
	call :show

	::wait about 2 seconds
	ping 127.0.0.1 -n 3 >nul
	call dk_timer t1
	call :show
	
	::wait about 3 seconds
	ping 127.0.0.1 -n 4 >nul
	call dk_timer t1
	call :show
goto:eof	

:show
	echo t1 = %t1%
	for /f "tokens=1-2 delims= " %%a in ('echo/%t1%') do (
		set /a "last.seconds=%%a/100"
		set /a "last.centiseconds=%%a-last.seconds*100"
		set /a "first.seconds=%%b/100"
		set /a "first.centiseconds=%%b-first.seconds*100"
		echo Seconds since last call: !last.seconds!.!last.centiseconds!, seconds since first call: !first.seconds!.!first.centiseconds!
	)
goto:eof
