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
	setlocal
	
	call dk_getTime centisecond second minute hour
	call dk_dateToCentiSeconds seconds centiseconds %centisecond% %second% %minute% %hour%
	set /a cstime=%seconds%*100+%centiseconds%
	
	call set init=%%%1.init%%
	call set first=%%%1.first%%
	call set last=%%%1.last%%

	if {%init%}=={} endlocal & set "%1.init=%cstime%" & set "%1.first=0" & set "%1.last=0" & goto:eof
	set /a last=cstime-init-first
	set /a first+=last
	endlocal & set "%1.init=%init%" & set "%1.first=%first%" & set "%1.last=%last%"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	call dk_minMaxArgs 0
	
	
	call dk_timer t1
	call :show

	echo:
	echo waiting about 1 second
	call dk_sleep 1
	call dk_timer t1
	call :show

	echo:
	echo waiting about 2 seconds
	call dk_sleep 2
	call dk_timer t1
	call :show
	
	echo:
	echo waiting about 3 seconds
	call dk_sleep 3
	call dk_timer t1
	call :show
	
	echo:
	echo waiting about 5 seconds
	call dk_sleep 5
	call dk_timer t1
	call :show
goto:eof	

:show
	echo t1.init = %t1.init%
	echo t1.first = %t1.first%
	echo t1.last = %t1.last%	
	
	:: CentiSeconds to Seconds w/fraction
	set /a "last.whole=%t1.last% / 100"
	set /a "last.fraction=%t1.last% %% 100"
	set "last.result=%last.whole%.%last.fraction%"
	
	set /a "first.whole=%t1.first% / 100"
	set /a "first.fraction=%t1.first% %% 100"
	set "first.result=%first.whole%.%first.fraction%"

	echo Seconds since last call: !last.result!, Seconds since first call: !first.result!
goto:eof
