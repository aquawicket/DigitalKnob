@echo off
call ..\functions\DK.cmd

::echo func = %func%
::echo args = %*
::for /F "delims=\" %%X in ("%func:*\=%") do set "func=%%X"
::if ":" == "%func:~0,1%" ( goto %func% )



:main
	set cmnd_out=cmnd_out
	
	:: MACRO With Arguments
	setlocal enableDelayedExpansion
	set MacroWithArgs=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-2" %%1 in ("^!args^!") do (%\n%
		call dk_echo "MacroWithArgs(%%~1, %%~2)" %\n%
		echo ARG1 = %%~1 %\n%
		echo ARG2 = %%~2 %\n%
	)) else set args=

	%MacroWithArgs% arg1 arg2
	pause
	
	
	
	echo Test A
	set cmndA=dk_test
	for /f "usebackq tokens=*" %%a in (`%cmndA%`) do set "%cmndA%=%%a"
	    call echo %cmndA% = BEFORE... %%%cmndA%%% ...AFTER
	call dk_echo "%cmndA% = BEFORE... %%%cmndA%%% ...AFTER"
	echo .
	echo .
	echo .

	echo Test B
	set cmndB=ver
	call :echo_cmnd %cmndB%
	    call echo %cmndB% = BEFORE... %%cmnd_out%% ...AFTER
	call dk_echo "%cmndB% = BEFORE... %%cmnd_out%% ...AFTER"
	echo .
	echo .
	echo .

	echo Test C
	set cmndC=dk_test
	set echo_cmndC=call :echo_cmnd %cmndC%
		%echo_cmndC%
	    call echo %cmndC% = BEFORE...%%cmnd_out%% ...AFTER
	call dk_echo "%cmndC% = BEFORE...%%cmnd_out%% ...AFTER"
	echo .
	echo .
	echo .
	
	echo Test D
	set cmndD=ver
	set echo_cmndD=&call :echo_cmnd %cmndD%
	    call echo %cmndD% = BEFORE.. %echo_cmndD% %%cmnd_out%% ...AFTER
	call dk_echo "%cmndD% = BEFORE... %echo_cmndD% %%cmnd_out%% ...AFTER"
	echo .
	echo .
	echo .
	

	echo Test E
	set cmndE=dk_test
	set echo_cmndC=&call :echo_cmnd %cmndE%
	    call echo %cmndE% = BEFORE... %echo_cmndC% %cmnd_out% ...AFTER
	call dk_echo "%cmndE% = BEFORE... %echo_cmndC% %cmnd_out% ...AFTER"
	echo .
	echo .
	echo .
	
	
	
	
	pause
:echo_cmnd
	echo 1 = %1
	set "cmnd_out="
	::echo 2 = %2
	::for /f "usebackq tokens=*" %%a in (`%1`) do set "%2=%%a"
	for /f "usebackq tokens=*" %%a in (`%1`) do set "cmnd_out=%%a"
goto:eof


	::set ver=&call :ver
::	set cmnd=dk_test
::	for /f "usebackq tokens=*" %%a in (`%cmnd%`) do set "%cmnd%=%%a"
::	    call echo ver = BEFORE... %%%cmnd%%% ...AFTER
::	call dk_echo "ver = BEFORE... %%%cmnd%%% ...AFTER"
	
	
	
	
	::set "start=&call :start "
::	set "start=&set cmnd="
::	set end=&for /f "usebackq tokens=*" %%a in (`%cmnd%`) do set "ver=%%a"
::	::set "end=echo end"
	::set start=call set end=
	::set end= & echo cmnd = ,%cmnd%,
::	echo ver = BEFORE... %start% ver %end% ...AFTER
	::call dk_echo "start = BEFORE... %start%ver%end% ...AFTER"
	
::	pause
	
::	set "start=&set cmnd= "
	::set "start=&call %~d0\:start\..%~pnx0 %*"
::	echo loading %start%dk_test%end%
::	call dk_echo "start = BEFORE... %start%dk_test%end% ...AFTER"
	
::	pause
::goto:eof




:start
	set cmnd=%1
	::set "cmnd=%1"
	::echo cmnd = %cmnd%
	::for /f "usebackq tokens=*" %%a in (`%1`) do set "start=start %%a"
	::for /f "usebackq tokens=*" %%a in (`%1`) do set "start=%%a"
	::set "start=&for /f "usebackq tokens=*" %%a in (`%1`) do set start=TEST
goto:eof


:end
	for /f "usebackq tokens=*" %%a in (`%cmnd%`) do set "end=%%a"
goto:eof


