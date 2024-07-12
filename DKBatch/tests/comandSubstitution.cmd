@echo off
call ..\functions\DK.cmd

::echo func = %func%
::echo args = %*
::for /F "delims=\" %%X in ("%func:*\=%") do set "func=%%X"
::if ":" == "%func:~0,1%" ( goto %func% )



:main
::	call :getversion
::	call echo ver = %ver%
::	call dk_echo "text before ,%ver%, text after"
	
::	set "command=ver"
::	call echo %command% = %%%command%%%
::	call dk_echo "text before ,%%%command%%%, text after"
	
::	set "myVar=%ver%"
::	call dk_echo "myVar = %myVar%"
	
::	set var=%$(%cmnd%)%
::	echo var = ,%var%, 
::	pause

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
	call :echo_cmnd %cmndB% cmnd_outB
	    call echo %cmndB% = BEFORE... %%cmnd_outB%% ...AFTER
	call dk_echo "%cmndB% = BEFORE... %%cmnd_outB%% ...AFTER"
	echo .
	echo .
	echo .

	echo Test C
	set cmndC=dk_test
	set echo_cmndC=call :echo_cmnd %cmndC% cmnd_outC
		%echo_cmndC%
	    call echo %cmndC% = BEFORE...%%cmnd_outC%% ...AFTER
	call dk_echo "%cmndC% = BEFORE...%%cmnd_outC%% ...AFTER"
	echo .
	echo .
	echo .
	
	echo Test D
	set cmndD=ver
	set echo_cmndD=&call :echo_cmnd %cmndD% cmnd_outD
	    call echo %cmndD% = BEFORE.. %echo_cmndD% %%cmnd_outD%% ...AFTER
	call dk_echo "%cmndD% = BEFORE... %echo_cmndD% %%cmnd_outD%% ...AFTER"
	echo .
	echo .
	echo .
	

	echo Test E
	set cmndE=dk_test
	set echo_cmndE=&call :echo_cmnd %cmndE% cmnd_outE
	    call echo %cmndE% = BEFORE.. %echo_cmndE% %%cmnd_outE%% ...AFTER
	call dk_echo "%cmndE% = BEFORE... %echo_cmndE% %%cmnd_outE%% ...AFTER"
	echo .
	echo .
	echo .
	
	
	
	
	pause
:echo_cmnd
	echo 1 = %1
	echo 2 = %2
	for /f "usebackq tokens=*" %%a in (`%1`) do set "%2=%%a"
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


