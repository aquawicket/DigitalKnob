@echo off
call ../functions/DK.cmd

echo %ver%
pause
set ver=&for /f "usebackq tokens=*" %%a in (`ver`) do set "ver=%%a"

echo ver = %ver%
pause
set "myVar=%ver%"
echo myVar = %myVar%
	
::set "cmnd=&echo < "
set "$(=&call :mySub "
set ")=echo :%subfunc%"

:main
::	call :getversion
::	call echo ver = %ver%
::	%dk_call% dk_echo "text before ,%ver%, text after"
	
::	set "command=ver"
::	call echo %command% = %%%command%%%
::	%dk_call% dk_echo "text before ,%%%command%%%, text after"
	
::	set "myVar=%ver%"
::	%dk_call% dk_echo "myVar = %myVar%"
	
::	set var=%$(%cmnd%)%
::	echo var = ,%var%, 
::	pause



	
	
	

::	set "start=&call :start "

::	echo loading %start%dk_test%end%
::	%dk_call% dk_echo "startB = %start%:dk_test%end%"
	
	pause
%endfunction%


	
:funcA
	set ver=&for /f "usebackq tokens=*" %%a in (`ver`) do set "ver=%%a"
%endfunction%

:start
	::set start=&for /f "usebackq tokens=*" %%a in (`%~1`) do set "end=%%a"
	for /f "usebackq tokens=*" %%a in (`%1`) do set "start=%%a&"
%endfunction%



:cmnd
	set ver=&for /f "usebackq tokens=*" %%a in (`ver`) do set "ver=%%a"
%endfunction%

:getversion
	set varA=&for /f "usebackq tokens=*" %%a in (`ver`) do set "varA=%%a"
%endfunction%