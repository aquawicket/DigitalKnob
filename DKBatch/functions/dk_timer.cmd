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
	
	::###### DATE ######
	set t=2
	if "%date%z" LSS "A" set t=1
	for /f "skip=1 tokens=2-4 delims=(-)" %%a in ('echo/^|date') do (
		for /f "tokens=%t%-4 delims=.-/ " %%d in ('date/t') do (
			set %%a=%%d
			set %%b=%%e
			set %%c=%%f
		)
	)
	set "year=%yy%"
	set "month=%mm%"
	set "day=%dd%"
	echo DATE = %month%/%day%/%year%
	
	::###### TIME ######
	for /f "tokens=5-8 delims=:. " %%a in ('echo/^|time') do (
	  set hour=%%a
	  set minute=%%b
	  set second=%%c
	  set centisecond=%%d
	)
	echo TIME = %hour%:%minute%:%second%.%centisecond%
	
	::###### DATE-TIME #######
	echo TIMESTAMP = %month%/%day%/%year%-%hour%:%minute%:%second%.%centisecond%
	
	tm_sec + tm_min*60 + tm_hour*3600 + tm_yday*86400 + (tm_year-70)*31536000 + ((tm_year-69)/4)*86400 -((tm_year-1)/100)*86400 + ((tm_year+299)/400)*86400
	
	::###### EPOCH ######
	set /a day=100%day% %% 100
	set /a month=100%month% %% 100
	set /a z=14-month
	set /a z/=12
	set /a y=year+4800-z
	set /a m=month+12*z-3
	set /a j=153*m+2
	set /a j=j/5+day+y*365+y/4-y/100+y/400-2472633
	set /a hour=100%hour% %% 100
	set /a minute=100%minute% %% 100
	set /a second=100%second% %% 100
	set /a j=j*86400+hour*3600+minute*60+second
	echo EPOCH = %j%
	
	
	for /f "tokens=1-3 delims= " %%a in ('echo/%ID%') do (
		set last=%%a
		set first=%%b
		set init=%%c
	)
	if {%init%}=={} endlocal & set %1=0 0 %j% & goto:eof
	set /a last=j-init-first
	set /a first+=last
	endlocal & set %1=%last% %first% %init%
goto:eof


::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	call dk_minMaxArgs 0
	
	set "t1="
	call dk_timer t1
	echo t1 = %t1%
	call :show

	::wait about 1 seconds
	ping 127.0.0.1 -n 2 >nul
	call dk_timer t1
	echo t1 = %t1%
	call :show

	::wait about 2 seconds
	ping 127.0.0.1 -n 3 >nul
	call dk_timer t1
	echo t1 = %t1%
	call :show
	
	::wait about 3 seconds
	ping 127.0.0.1 -n 4 >nul
	call dk_timer t1
	echo t1 = %t1%
	call :show
goto:eof	

:show
	for /f "tokens=1-2 delims= " %%a in ('echo/%t1%') do (
		echo/Seconds since last call: %%a, seconds since first call: %%b
	)
goto:eof
