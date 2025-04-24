@echo off
<<<<<<< HEAD
call ..\functions\DK.cmd
=======
call ../functions/DK.cmd
>>>>>>> Development

::echo func = %func%
::echo args = %*
::for /F "delims=\" %%X in ("%func:*\=%") do set "func=%%X"
<<<<<<< HEAD
::if ":" == "%func:~0,1%" ( goto %func% )
=======
::if ":" equ "%func:~0,1%" ( goto %func% )
>>>>>>> Development



:main
	set cmnd_out=cmnd_out
	
	:: Simple variable replacement
::	set cmndA=ver
::	for /f "usebackq tokens=*" %%a in (`%cmndA%`) do set "%cmndA%=%%a"
::	call echo %%%cmndA%%%


	set "testB=&for /f "usebackq tokens=*" %%a in (`ver`) do set "testB=%%a" & echo %testB%"
	echo %testB%
	
	:: MACRO
<<<<<<< HEAD
	setlocal enableDelayedExpansion
=======
setlocal enableDelayedExpansion
>>>>>>> Development
	set Macro=&(%\n%
		%dk_call% dk_echo "Macro()" %\n%
	)

	%Macro%
	
	:: MACRO One Argument
<<<<<<< HEAD
	setlocal enableDelayedExpansion
=======
setlocal enableDelayedExpansion
>>>>>>> Development
	set MacroWithOneArg=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
		%dk_call% dk_echo "MacroWithOneArg(%%~1)" %\n%
		echo ARG1 = %%~1 %\n%
	)) else set args=

	%MacroWithOneArg% abc
	
	
	:: MACRO Two Arguments
<<<<<<< HEAD
	setlocal enableDelayedExpansion
=======
setlocal enableDelayedExpansion
>>>>>>> Development
	set MacroWithArgs=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
		%dk_call% dk_echo "MacroWithArgs(%%~1, %%~2)" %\n%
		echo ARG1 = %%~1 %\n%
		echo ARG2 = %%~2 %\n%
	)) else set args=

	%MacroWithArgs% abc 123
	pause
	
	
	echo Test A
	set cmndA=dk_test
	for /f "usebackq tokens=*" %%a in (`%cmndA%`) do set "%cmndA%=%%a"
	    call echo %cmndA% = BEFORE... %%%cmndA%%% ...AFTER
	%dk_call% dk_echo "%cmndA% = BEFORE... %%%cmndA%%% ...AFTER"
	echo .
	echo .
	echo .

	echo Test B
	set cmndB=ver
	call :echo_cmnd %cmndB%
	    call echo %cmndB% = BEFORE... %%cmnd_out%% ...AFTER
	%dk_call% dk_echo "%cmndB% = BEFORE... %%cmnd_out%% ...AFTER"
	echo .
	echo .
	echo .

	echo Test C
	set cmndC=dk_test
	set echo_cmndC=call :echo_cmnd %cmndC%
		%echo_cmndC%
	    call echo %cmndC% = BEFORE...%%cmnd_out%% ...AFTER
	%dk_call% dk_echo "%cmndC% = BEFORE...%%cmnd_out%% ...AFTER"
	echo .
	echo .
	echo .
	
	echo Test D
	set cmndD=ver
	set echo_cmndD=&call :echo_cmnd %cmndD%
	    call echo %cmndD% = BEFORE.. %echo_cmndD% %%cmnd_out%% ...AFTER
	%dk_call% dk_echo "%cmndD% = BEFORE... %echo_cmndD% %%cmnd_out%% ...AFTER"
	echo .
	echo .
	echo .
	

	echo Test E
	set cmndE=dk_test
	set echo_cmndC=&call :echo_cmnd %cmndE%
	    call echo %cmndE% = BEFORE... %echo_cmndC% %cmnd_out% ...AFTER
	%dk_call% dk_echo "%cmndE% = BEFORE... %echo_cmndC% %cmnd_out% ...AFTER"
	echo .
	echo .
	echo .
	
	
	
	
	pause
:echo_cmnd
	echo 1 = %1
	set "cmnd_out="
	::echo 2 = %2
<<<<<<< HEAD
	::for /f "usebackq tokens=*" %%a in (`%1`) do set "%2=%%a"
=======
	::for /f "usebackq tokens=*" %%a in (`%1`) do set "%~2=%%a"
>>>>>>> Development
	for /f "usebackq tokens=*" %%a in (`%1`) do set "cmnd_out=%%a"
%endfunction%


	::set ver=&call :ver
::	set cmnd=dk_test
::	for /f "usebackq tokens=*" %%a in (`%cmnd%`) do set "%cmnd%=%%a"
::	    call echo ver = BEFORE... %%%cmnd%%% ...AFTER
::	%dk_call% dk_echo "ver = BEFORE... %%%cmnd%%% ...AFTER"
	
	
	
	
	::set "start=&call :start "
::	set "start=&set cmnd="
::	set end=&for /f "usebackq tokens=*" %%a in (`%cmnd%`) do set "ver=%%a"
::	::set "end=echo end"
	::set start=call set end=
	::set end= & echo cmnd = ,%cmnd%,
::	echo ver = BEFORE... %start% ver %end% ...AFTER
	::%dk_call% dk_echo "start = BEFORE... %start%ver%end% ...AFTER"
	
::	pause
	
::	set "start=&set cmnd= "
	::set "start=&call %~d0\:start\..%~pnx0 %*"
::	echo loading %start%dk_test%end%
::	%dk_call% dk_echo "start = BEFORE... %start%dk_test%end% ...AFTER"
	
::	pause
::%endfunction%




:start
	set cmnd=%1
	::set "cmnd=%1"
	::echo cmnd = %cmnd%
	::for /f "usebackq tokens=*" %%a in (`%1`) do set "start=start %%a"
	::for /f "usebackq tokens=*" %%a in (`%1`) do set "start=%%a"
	::set "start=&for /f "usebackq tokens=*" %%a in (`%1`) do set start=TEST
%endfunction%


:end
	for /f "usebackq tokens=*" %%a in (`%cmnd%`) do set "end=%%a"
%endfunction%


