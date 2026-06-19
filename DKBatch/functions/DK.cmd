@rem shebang
@echo off
rem echo DK '%0 %*'
rem echo  0 '%0'
rem echo  1 '%1'
rem echo  2 '%2'
rem echo  3 '%3'

rem ### Handle :dk_call and :func arguments
set "arg1=%~1"
if "!arg1:~0,1!" equ ":" (
	if NOT DEFINED findstr.exe (call :dk_findFile findstr.exe)
	start "" /b /wait /min "!findstr.exe:/=\!" /ri /c:"^ *%~1 " /c:"^ *%~1$" "%~f0" >nul 2>nul && (
		call %*
		if "!!" equ "" (exit /b !errorlevel!) else (call exit /b %%errorlevel%%)
	) 
)
if NOT DEFINED DK.cmd (set "DK.cmd=%~f0")
if NOT DEFINED DK_CMDLINE (
	set DK_CMDLINE=%CMDCMDLINE%
	echo CMDCMDLINE = %CMDCMDLINE%
)
if "%DK_CMDLINE:"=%" neq "%CMDCMDLINE:"=%" (
	set DK_CMDLINE=%CMDCMDLINE%
	echo CMDCMDLINE = %CMDCMDLINE%
)

if NOT DEFINED setlocal (set setlocal=setlocal enableDelayedExpansion enableExtensions)

if NOT DEFINED endfunction (
	set endfunction=call set dk_errorlevel=%%errorlevel%% ^&^
	call set FUNC=%%%errorlevel%%% ^&^
	call rem call echo [35m %%FUNC%%= %%dk_errorlevel%% [0m ^&^
	call exit /b %%dk_errorlevel%%
)

setlocal DisableDelayedExpansion
if NOT DEFINED LF set LF=^


rem Above 2 blank lines are required - do not remove

if NOT DEFINED \n 	set ^"\n=^^^%LF%%LF%^%LF%%LF%^^"

if NOT DEFINED return set ^"return=for %%# in (1 2) do if %%#==2 (%\n%
	if "!!" neq "" echo ERROR: NO DELAYED EXPANSION IN MACRO ^& pause %\n%
	if "!!" equ "" exit /b !argv:0!=!%\n%
) else set argv="
setlocal enableDelayedExpansion

if NOT DEFINED dk_call 	(set dk_call=call "%~f0" :dk_call)
if NOT DEFINED dk_start (set dk_start=start "" /b /wait /min)

rem call :dk_ARGVC %*


rem ##################################################################################
:DK 
	call :dk_initDKPaths
	
	rem #	TODO - switch to UNICODE code page
	rem #   chcp 65001 >nul
	if 01 == 1 (set "TCC=1") else (set "CMD=1")

	rem ### include guard
	if NOT DEFINED DKINIT_cmd (set "DKINIT_cmd=1") else (%endfunction:echo.[31mendfunction UNDEFINED&pause&exit/b1%=%)

	set "clr=[0m"
	set "red=[31m"

	rem ### Print DKSHELL_NAME DKSHELL_VERSION ###
	set "DKSHELL_PATH=%ComSpec%"
	for %%Z in ("%DKSHELL_PATH:/=\%") do (set "DKSHELL_NAME=%%~nZ")
	for /f "tokens=2 delims=[]" %%v in ('ver') do (set "DKSHELL_VERSION=%%~v")
	set "DKSHELL_VERSION=%DKSHELL_VERSION:Version =%"
	echo.[42m [30m %DKSHELL_NAME% %DKSHELL_VERSION% %DKSHELL_PATH% [0m

	rem ### Reload cmd options
	if "!CMDCMDLINE!" neq "!CMDCMDLINE:/c=/k!" (set "RELOAD=1")
	if "!!" neq "" (set "RELOAD=1")
	if "%RELOAD%" equ "1" if "%RELOADED%" neq "1" (
		echo. && echo."Reloading . . ."
		set "RELOAD=0"
		set "RELOADED=1"
		set "DKINIT_cmd="

		rem ### Reload cmd options
		set COMMAND=start "" /b "%ComSpec%" /Q /D /E:ON /V:ON /K %*

		rem ### Reload cmd options without elevated permissions
		rem set COMMAND=start "" /b runas /trustlevel:0x20000 /machine:amd64 "%ComSpec% /A /Q /D /E:ON /V:ON /K !ARGV!"
		rem set COMMAND=start "" /b runas /trustlevel:0x20000 /machine:amd64 "%ComSpec%" /Q /D /E:ON /V:ON /K %*

		echo COMMAND = %%COMMAND%%
		call %%COMMAND%%
		rem call %%COMMAND%% | %DKBatch_Functions_Dir_%dk_tee.cmd %DKSCRIPT_NAME%.log

		%endfunction:echo.[31mendfunction UNDEFINED&pause&exit/b1%=%
	)

	rem ###### PRINT_DE_STATUS #####
	if NOT DEFINED DE_STATUS set DE_STATUS=if "^!DE^!" equ "" ( ^
		echo.[32mdelayed expansion = ON[0m ^&^
		title ^!CMDCMDLINE^! delayedExpansion:ON ^
	) else ( ^
		echo.[31mdelayed expansion = OFF[0m ^&^
		title ^!CMDCMDLINE^! delayedExpansion:OFF ^&^
		echo.[31m ### ERROR: DKBatch requires delayed expansion ### [0m ^&^
		pause ^&^
		exit/b ^!errorlevel^! ^
	)
	%DE_STATUS%

	rem ### global variables
	if NOT DEFINED clearerror	(set clearerror="%ComSpec%" /c exit /b 0)
	if NOT DEFINED seterror		(set seterror="%ComSpec%" /c exit /b)
	if NOT DEFINED true			(set true=0)
	if NOT DEFINED false		(set false=1)
	if NOT DEFINED NO_STDOUT	(set NO_STDOUT=1>nul)
	if NOT DEFINED NO_STDERR	(set NO_STDERR=2>nul)
	if NOT DEFINED NO_OUTPUT	(set NO_OUTPUT=1>nul 2>nul)
	if NOT DEFINED TO_STDERR	(set TO_STDERR=1^>^&2)

	rem ### Get DK path variables
	rem call :dk_DKSCRIPT_VARS !ARGV!
	call :dk_DKSCRIPT_VARS %*
	rem call :dk_initDKPaths
	call :initDKCall

	%dk_call% dk_color
	rem %dk_call% dk_setLineNumbers "%~f0"

	rem ######## dirname loop ########
goto:end_current_dir_loop
	set "current_dir=%~dp1"
	:current_dir_loop
	for %%C in ("%current_dir:~0,-1%") do (
		set "current_dir=%%~dpC"
		set "current_drive=%%~dC"
	)
	if "%current_dir%" equ "%current_drive%\" (goto:end_current_dir_loop)
	if EXIST "%current_dir%dkconfig.txt" (
		%dk_call% dk_fileVariables "%current_dir%dkconfig.txt"
		goto:end_current_dir_loop
	)
	if EXIST "%current_dir%" goto:current_dir_loop
	:end_current_dir_loop
	rem ############################


	rem ############ load dkconfig.txt ############
	rem if EXIST "%DKBranch_Dir%/dkconfig.txt" (%dk_call% dk_fileVariables "%DKBranch_Dir%/dkconfig.txt")
	rem if EXIST "%DKSCRIPT_Dir%/dkconfig.txt" (%dk_call% dk_fileVariables "%DKSCRIPT_Dir%/dkconfig.txt")

	if /i "%DKSCRIPT_FILE%" equ "DKBuilder.cmd" (
		rem # Copy DKBuilder.cmd to DKCACHE_Dir
		copy /V "%DKSCRIPT_PATH:/=\%" "%DKCACHE_Dir:/=\%"

		rem # Copy DKBuilder.cmd to DKBatch_Functions_Dir/DKBuilder if missing
		if NOT EXIST "%DKBatch_Functions_Dir_%DKBuilder/DKBuilder.cmd" (
			copy "%DKSCRIPT_PATH:/=\%" "%DKBatch_Functions_Dir_:/=\%DKBuilder\DKBuilder.cmd"
		)
	)

	if "%DKOFFLINE%" equ "1" (echo."[43m[30m###### OFFLINE MODE ###### OFFLINE MODE ###### OFFLINE MODE ######[0m")

	rem ############ Elevate Permissions ############
	if NOT EXIST "%net.exe%" (call :dk_findFile net.exe)
	%dk_start% "%net.exe:/=\%" session 1>nul 2>nul || (%dk_call% dk_elevate "%DKSCRIPT_PATH%")
	%dk_start% "%net.exe:/=\%" session 1>nul 2>nul && (echo.Admin) || (echo.NOT Admin)

	%dk_call% dk_logo

	if "%DKSCRIPT_EXT%" neq ".cmd" (
		if "%DKSCRIPT_EXT%" neq ".bat" (
			echo. [31mERROR: DKSCRIPT_EXT:'%DKSCRIPT_EXT%' is NOT .cmd or .bat[0m & pause
			%endfunction:echo.[31mendfunction UNDEFINED&pause&exit/b1%=%
		)
	)

	rem ###### DKTEST() ######
	rem	%dk_call% dk_fileContains "%DKSCRIPT_PATH%" ":DKTEST" && (
	"!findstr.exe:/=\!" /ri /c:"^ *:DKTEST " /c:"^ *:DKTEST$" "%DKSCRIPT_PATH:/=\%" >nul 2>nul && (
		echo.
		echo.[45m[37m###### DKTEST MODE ###### %DKSCRIPT_FILE% ###### DKTEST MODE ######[0m
		echo.
		%dk_call% dk_callFileLabel "%DKSCRIPT_PATH%" ":DKTEST" %DKSCRIPT_ARGS%
		echo.
		echo.[45m[37m######## END TEST ####### %DKSCRIPT_FILE% ######## END TEST #######[0m
		echo.
		pause
		%endfunction:echo.[31mendfunction UNDEFINED&pause&exit/b1%=%
	) || (call )

	rem ###### DKSCRIPT_NAME() ######
	rem	%dk_call% dk_fileContains "%DKSCRIPT_PATH%" ":%DKSCRIPT_NAME%" && (
	"!findstr.exe:/=\!" /ri /c:"^ *:%DKSCRIPT_NAME% " /c:"^ *:%DKSCRIPT_NAME%$" "%DKSCRIPT_PATH:/=\%" >nul 2>nul && (
		%dk_call% dk_callFileLabel "%DKSCRIPT_PATH%" ":%DKSCRIPT_NAME%" %DKSCRIPT_ARGS%
		pause
		%endfunction:echo.[31mendfunction UNDEFINED&pause&exit/b1%=%
	) || (call )

	%dk_call% "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%
	pause
%endfunction:echo.[31mendfunction UNDEFINED&pause&exit/b1%=%


rem ##################################################################################
rem dk_ARGVC %0 %*
:dk_ARGVC
	call :pushStack "%~n0%~0" %*
	
	rem ### Set ARGV, ARGC and ARGV# variables
	set ARGV=%*
	if NOT DEFINED ARGV (set ARGV="%~f0")
	set "ARGC=0"
	for %%V in (%ARGV%) do (
		call set -ARGV%%ARGC%%=%%~V
		call set ARGV%%ARGC%%=%%V
		set /a "ARGC+=1"
	)

	rem ### Print ARGV, ARGC and ARGV# variables
	echo ARGV = '%ARGV%'
	echo ARGC = '%ARGC%'
	set /a "count=ARGC-1"
	for /L %%N in (0,1,%count%) do (
		call echo -ARGV%%N = %%-ARGV%%N%%
		call echo ARGV%%N = %%ARGV%%N%%
	)
%endfunction:echo.[31mendfunction UNDEFINED&pause&exit/b1%=%
	


rem ##################################################################################
:dk_DKSCRIPT_VARS
	call :pushStack "%~n0%~0" %*

	if NOT DEFINED DKSCRIPT_*		(set DKSCRIPT_*=%*)
	if NOT DEFINED DKSCRIPT_PATH	(set "DKSCRIPT_PATH=%~1")
	for %%Z in ("%DKSCRIPT_PATH:/=\%") do (
		set "DKSCRIPT_Dir=%%~dpZ"
		set "DKSCRIPT_FILE=%%~nxZ"
		set "DKSCRIPT_NAME=%%~nZ"
		set "DKSCRIPT_EXT=%%~xZ"
	)
	if EXIST "%DKSCRIPT_PATH%"		(set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%")
	if EXIST "%DKSCRIPT_Dir%"		(set "DKSCRIPT_Dir=%DKSCRIPT_Dir:\=/%")
	if "%DKSCRIPT_Dir:~-1%" equ "/"	(set "DKSCRIPT_Dir=%DKSCRIPT_Dir:~0,-1%")

	set "DKSCRIPT_ARGS=%*"
	set "DKSCRIPT_ARGS=!DKSCRIPT_ARGS:%1=!"	
	rem for /f "tokens=1*" %%a in ("%*") do (set DKSCRIPT_ARGS=%%b)

	if NOT EXIST "%DKSCRIPT_PATH%"	(echo.DKSCRIPT_PATH:'%DKSCRIPT_PATH%' NOT FOUND & pause & exit /b !errorlevel!)
	if NOT EXIST "%DKSCRIPT_Dir%"	( echo.DKSCRIPT_Dir:'%DKSCRIPT_Dir%' NOT FOUND  & pause & exit /b !errorlevel!)
	if NOT DEFINED DKSCRIPT_PATH	(echo.DKSCRIPT_PATH:'%DKSCRIPT_PATH%' UNDEFINED & pause & exit /b !errorlevel!)
	if NOT DEFINED DKSCRIPT_Dir		( echo.DKSCRIPT_Dir:'%DKSCRIPT_Dir%' UNDEFINED  & pause & exit /b !errorlevel!)
	if NOT DEFINED DKSCRIPT_FILE	(echo.DKSCRIPT_FILE:'%DKSCRIPT_FILE%' UNDEFINED & pause & exit /b !errorlevel!)
	if NOT DEFINED DKSCRIPT_NAME	(echo.DKSCRIPT_NAME:'%DKSCRIPT_NAME%' UNDEFINED & pause & exit /b !errorlevel!)
	if NOT DEFINED DKSCRIPT_EXT		( echo.DKSCRIPT_EXT:'%DKSCRIPT_EXT%' UNDEFINED  & pause & exit /b !errorlevel!)

	set DKSCRIPT_
%endfunction:echo.[31mendfunction UNDEFINED&pause&exit/b1%=%

rem ##################################################################################
:dk_initDKPaths
	call :pushStack "%~n0%~0" %*
   
	if NOT DEFINED DigitalKnob						(set "DigitalKnob=Digital Knob")
	
	if NOT DEFINED _DigitalKnob				  		(set "_DigitalKnob=DigitalKnob")
	if NOT DEFINED _DKBranch						(set "_DKBranch=Development")
	if NOT DEFINED _DK3rdParty						(set "_DK3rdParty=3rdParty")
	if NOT DEFINED _DKImports						(set "_DKImports=_DKIMPORTS")
	if NOT DEFINED _DKBatch							(set "_DKBatch=DKBatch")
	if NOT DEFINED _DKFunctions						(set "_DKFunctions=functions")
	if NOT DEFINED _DKStorage						(set "_DKStorage=DKStorage")
	if NOT DEFINED _DKCache							(set "_DKCache=.dk")
	if NOT DEFINED _DKDownload						(set "_DKDownload=download")
	
	::call :dk_setDKPaths "test_"
	if NOT DEFINED DKHome_Dir						(set "DKHome_Dir=%USERPROFILE:\=/%")
	if NOT DEFINED Dir (set "Dir=%USERPROFILE:\=/%")
	call :dk_setDKPaths ""
	
	rem if NOT DEFINED DKHttp_Dir (set "DKHttp_Dir=http://aquawicket.com")
	rem call :dk_setDKPaths "DKHttp_"
	
	if NOT DEFINED DKHttp_Dir (
		for %%i in (Z Y X W V U T S R Q P O N M L K J I H G F E D C B A) do (
			if EXIST "%%i:/DigitalKnob/Development.git" (
				set "USB_Drive=%%i:"	
			)
		)
	)
	echo USB_Drive = '%USB_Drive%'
	set "USB_DK_Dir=%USB_Drive%/DigitalKnob"
	echo USB_DK_Dir = '%USB_DK_Dir%'
	set "DKHttp_Dir=file:///%USB_Drive%"
	
	
	call :dk_setDKPaths "DKHttp_"
	
	if NOT DEFINED DigitalKnob_bundle				(set "DigitalKnob_bundle=%DKStorage_Dir%/%DigitalKnob%.bundle")
	if NOT DEFINED DigitalKnob_tar_gz				(set "DigitalKnob_tar_gz=%DKStorage_Dir%/%DigitalKnob%.tar.gz")
%endfunction:echo.[31mendfunction UNDEFINED&pause&exit/b1%=%



rem ##################################################################################
rem # dk_call(command args)
rem # 
rem #	%~1 = :dk_call
rem #	%~2 = command
rem #	%~3 = args
:dk_call
	rem echo :dk_call %*
	rem if NOT DEFINED dk_call_ENTRIES_TO_CONSOLE	(set "dk_call_ENTRIES_TO_CONSOLE=1")
	rem if NOT DEFINED dk_call_ENTRIES_TO_FILE		(set "dk_call_ENTRIES_TO_FILE=1")
	rem if NOT DEFINED dk_call_ENTRIES_TO_PIPE		(set "dk_call_ENTRIES_TO_PIPE=1")
	rem if NOT DEFINED dk_call_EXITS_TO_CONSOLE		(set "dk_call_EXITS_TO_CONSOLE=1")
	rem if NOT DEFINED dk_call_EXITS_TO_FILE		(set "dk_call_EXITS_TO_FILE=1")
	rem if NOT DEFINED dk_call_EXITS_TO_PIPE		(set "dk_call_EXITS_TO_PIPE=1")
	rem if NOT DEFINED dk_call_HANDLE_ENTRIES		(set "dk_call_HANDLE_ENTRIES=1")
	rem if NOT DEFINED dk_call_HANDLE_EXITS			(set "dk_call_HANDLE_EXITS=1")
	rem if NOT DEFINED dk_call_PRINT_CALLS			(set "dk_call_PRINT_CALLS=1")
	rem if NOT DEFINED dk_call_PRINT_SCOPE			(set "dk_call_PRINT_SCOPE=1")
	rem if NOT DEFINED dk_call_STACK_TO_FILE		(set "dk_call_STACK_TO_FILE=1")

	if "%~1" equ "" (echo [31m ERROR: %%1:'%1' UNDEFINED [0m & pause & exit/b1)

	rem ###### Stack Variables ######
rem	call :dk_timer name
rem	(set __CLOCK__=%dk_timer%)
	set "CMND_IN="
	set "CMND_IN=%~1"
rem	echo CMND_IN = '%CMND_IN%'

	set "__FUNCTION__="
	set "__FUNCTION__=%~n1"
rem	echo __FUNCTION__ = '%__FUNCTION__%'

	set "__EXTENSION__="
	set "__EXTENSION__=%~x1"
rem	echo __EXTENSION__ = '%__EXTENSION__%'

	set "__PATH__=%~1"
	set "__PATH__=%__PATH__:\=/%"
	set "__PATH__=%__PATH__:::=/%"
	if NOT EXIST "%__PATH__%" (set "__PATH__=%~f1")
	if NOT EXIST "%__PATH__%" (set "__PATH__=%~dp0%~1")
	rem if NOT EXIST "%__PATH__%" (set "__PATH__=%~dp0%~1.cmd")

rem	for /f "tokens=1*" %%a in ("%*") do (set __ARGS__=%%b)
	set __ARGS__=%2 %3 %4 %5 %6 %7 %8 %9
rem	echo __ARGS__ = '%__ARGS__%'

	rem	if /i "!dk_call_IGNORE:%__FUNC__%=!" equ "%dk_call_IGNORE%" (set "__IGNORE__=1") else (set "__IGNORE__=")
	rem TODO - use dk_getFileLine to add the file line to the stack entry
	call :pushStack %*

	rem ###### Print function entry ####
	if "%dk_call_HANDLE_ENTRIES%" gtr "0" (call :dk_call_HANDLE_ENTRIES)

	if %LVL% lss 1 (exit /b !errorlevel!)

	rem ##### Prepair #######################################
	if NOT EXIST "%__PATH__%" (

rem		rem ### Search for function in the current directory
rem		set "CMND_OUT="%CD:\=/%/%CMND_IN:.cmd=%.cmd""
rem		if EXIST "!CMND_OUT!" (	
rem			goto:run
rem		)

		if "%__EXTENSION__%" neq "" (
			set "__PATH__=!%CMND_IN%!"
			if EXIST "!__PATH__!" (
				goto:run
			)
		)

		rem ### Search for plugin in 3rdParty/_DKIMPORTS
		if EXIST "%DKIMPORTS_DIR%/%CMND_IN%/DKINSTALL.cmd" (
			call "%DKBatch_Functions_Dir_%dk_depend.cmd" %CMND_IN%

			set "__PATH__=!%CMND_IN%!"
			if EXIST "!%CMND_IN%!" (
				goto:run
			) 
		)

		rem ### Search for function file in DKBatch_Functions_Dir_
rem		set "__PATH__=%DKBatch_Functions_Dir_%%CMND_IN:.cmd=%.cmd"
rem		if EXIST "!__PATH__!" (
rem			goto:run
rem		)

		rem ### Search for file
rem		echo call :dk_findFile %CMND_IN%.cmd "%DKBranch_Dir:/=\%" __PATH__
rem		call :dk_findFile %CMND_IN%.cmd "%DKBranch_Dir:/=\%" __PATH__
rem		set "__PATH__=!__PATH__!"
rem		echo __PATH__ = !__PATH__!
rem		if EXIST "!__PATH__!" (
rem			goto:run
rem		)
		
		rem ### Seatch for file stepping up from DKBatch_Functions_Dir
		rem set dk_dirname=%DKBatch_Functions_Dir_%
		rem set "dk_dirname=%DKBatch_Functions_Dir_%%CMND_IN:.cmd=%.cmd"
		if "%__EXTENSION__%" equ "" (
			set "dk_dirname=%DKBatch_Functions_Dir_%"
		)
		
		:search
		rem call :dk_findFile %CMND_IN:.cmd=%.cmd "!dk_dirname:%DKBatch_Functions_Dir_%!=!" __PATH__
		call :dk_findFile %CMND_IN% "!dk_dirname!" __PATH__
		if EXIST "!__PATH__!" (
			goto:run
		) else (
			call "%DKBatch_Functions_Dir_%dk_dirname.cmd" "!dk_dirname!"
			goto :search
		)
		
		rem ### Search url for download if missing
		echo DKBatch_Functions_Dir_ = %DKBatch_Functions_Dir_%
		echo DKHttp_DKBatch_Functions_Dir_ = %DKHttp_DKBatch_Functions_Dir_%
		echo 
		set "__PATH__=%CMND_IN:.cmd=%.cmd"
		set "__PATH__=%DKBatch_Functions_Dir_%!__PATH__:%DKBatch_Functions_Dir_%=!"
		set "__URL__=!__PATH__:%DKBatch_Functions_Dir_%=%DKHttp_DKBatch_Functions_Dir_%!"
		rem	call :dk_urlExists !__URL__:\=/! && (
			call :dk_download "!__URL__:\=/!" "!__PATH__!"
			if EXIST "!__PATH__!" (
				goto:run
			)
rem		)
		
	) else (
		goto:run
	)

	echo [31m ERROR: dk_call CMND_IN:'%CMND_IN%':'!CMND_IN!', __PATH__:'!__PATH__!':'!%__PATH__%!' NOT FOUND [0m
	exit/b1


	rem %dk_call% dk_isCRLF "%CMND_OUT%" || %dk_call% dk_fileToCRLF "%CMND_OUT%"
	rem ###### Entry ############################################################################################
:run
	rem if "%dk_call_PRINT_CALLS%" equ "1" (echo dk_call ^> "%__PATH__:/=\%" %__ARGS__%)

	rem	if defined dk_call_IGNORE if /i "X!dk_call_IGNORE:%__FUNC__%=!X" equ "X%dk_call_IGNORE%X" title DKBatch: %__FUNC__%(%__ARGS__%)
	rem	call %DKBatch_Functions_Dir_%dk_isCRLF "%CMND_OUT%" || call %DKBatch_Functions_Dir_%dk_fileToCRLF "%CMND_OUT%"
	for %%Z in ("%__PATH__%") do (
		if "%%~xZ" equ ".cmd" (
			set __CALL__=call
		) else (
			set __CALL__=%dk_start% 
		)
	)

rem echo %__CALL__% "%__PATH__:/=\%" %__ARGS__%
     %__CALL__% "%__PATH__:/=\%" %__ARGS__% && (
		set "__STATUS__=!errorlevel!"
		set "__BOOL__=true"
		if defined __STACK__%ENTRY% (call :setGlobal "__STACK__%ENTRY%" [90m!__STACK__%ENTRY%! [37mstatus:[32m!__STATUS__![0m)

		rem ###### Print function exit ######
		if "%dk_call_HANDLE_EXITS%" gtr "0" (call :dk_call_HANDLE_EXITS)
		set /a LVL-=1
	) || (
		set "__STATUS__=!errorlevel!"
		set "__BOOL__=false"
		if defined __STACK__%ENTRY% (call :setGlobal "__STACK__%ENTRY%" [90m!__STACK__%ENTRY%! [37mstatus:[31m!__STATUS__![0m)

		rem ###### Print function exit ######
		if "%dk_call_HANDLE_EXITS%" gtr "0" (call :dk_call_HANDLE_EXITS)
	)

	rem ### NOTE: We can keep the whole stack if we comment this out.
	call :popStack
exit /b %__STATUS__%

rem ##################################################################################
:pushStack file args
	if NOT defined LVL		(set /a "LVL=0")
	if NOT defined ENTRY 	(set /a "ENTRY=0")
	(set /a LVL+=1)
	(set /a ENTRY+=1)
	call :setGlobal __STACK__%ENTRY% %*
exit /b !errorlevel!


rem ##################################################################################
:updateIndent
	if "%~1" neq "" (set "num=%~1") else (set "num=%LVL%")
	(set pad=)
	for /l %%x in (1, 1, %num%) do (set pad=!pad!%indent%)
exit /b !errorlevel!


rem ##################################################################################
:dk_call_HANDLE_ENTRIES
	rem	if defined dk_call_IGNORE if "X!dk_call_IGNORE:%__FUNC__%=!X" neq "X%dk_call_IGNORE%X" (%return%)
	if "%~1" neq "" (set "_ent_=%~1") else (set "_ent_=%ENTRY%")
	if "%~1" neq "" (set "_lvl_=%~2") else (set "_lvl_=%LVL%")

	call :updateIndent %_lvl_%
	if "%dk_call_ENTRIES_TO_CONSOLE%"	equ "1" (echo %pad%%_lvl_%х!__STACK__%_ent_%!)
	if "%dk_call_ENTRIES_TO_PIPE%"	 	equ "1" (>"\\.\pipe\TestPipe"		echo %pad%%_lvl_%х!__STACK__%_ent_%!)
	if "%dk_call_ENTRIES_TO_FILE%"		equ "1" (>>"%DKSCRIPT_NAME%.log"	echo %pad%%_lvl_%х!__STACK__%_ent_%!)
exit /b !errorlevel!


rem ##################################################################################
:dk_call_HANDLE_EXITS
	rem	if defined dk_call_IGNORE if "X!dk_call_IGNORE:%__FUNC__%=!X" neq "X%dk_call_IGNORE%X" (%return%)
	if "%~1" neq "" (set "_ent_=%~1") else (set "_ent_=%ENTRY%")
	if "%~1" neq "" (set "_lvl_=%~2") else (set "_lvl_=%LVL%")

	call :updateIndent %_lvl_%
	if "!__STATUS__!" equ "0" (set STATUS=[32m!__STATUS__!:!__BOOL__![0m) else (set STATUS=[31m!__STATUS__!:!__BOOL__![0m)
	if "%dk_call_EXITS_TO_CONSOLE%" equ "1"	(echo %pad% им!__STACK__%_ent_%!)
	if "%dk_call_EXITS_TO_PIPE%" 	equ "1"	(>"\\.\pipe\TestPipe"		echo %pad% им!__STACK__%_ent_%!)
	if "%dk_call_EXITS_TO_FILE%" 	equ "1"	(>>"%DKSCRIPT_NAME%.log"	echo %pad% им!__STACK__%_ent_%!)
exit /b !errorlevel!


rem ##################################################################################
:setGlobal name value
%setlocal%
	for /f "tokens=1*" %%a in ("%*") do endlocal & (set %~1=%%b)
exit /b %errorlevel%


rem ##################################################################################
rem :setReturn name value
rem		(set argv=%*)
rem		if defined argv 		(set argv=!argv:*%1 =!)
rem		(set %~1=%argv%)
rem		(set dk.rtn.%~1=%argv%)	&rem prefix the variable name with dk.rtn. and assign a value
rem exit /b !errorlevel!


rem ##################################################################################
:popStack
	call :setGlobal __STACK__%ENTRY%
	(set /a ENTRY-=1)
exit /b !errorlevel!


rem ##################################################################################
:initDKCall
	call :pushStack "%~n0%~0" %*

	if NOT DEFINED setlocal (
		set setlocal=setlocal enableDelayedExpansion enableExtensions ^&^&^
		set /a _SCOPE_LVL_+=1
	)

	rem	set return=(if "^!DE^!" neq "" setlocal enableDelayedExpansion enableExtensions) ^&^
	rem		(^^!dk_call^^! :return_callback ^^!errorlevel^^! ^^!__PATH__^^! ^^!__FUNCTION__^^! ^^!CMND_OUT^^!) ^&^
	rem		(exit/b ^^!errorlevel^^!)

	rem	set endfunction=(if "^!DE^!" neq "" setlocal enableDelayedExpansion enableExtensions) ^&^
	rem		(^^!dk_call^^! :endfunction_callback ^^!errorlevel^^! ^^!__PATH__^^! ^^!__FUNCTION__^^! ^^!CMND_OUT^^!) ^&^
	rem		(exit/b ^^!errorlevel^^!)

	set checkerror=(if "^!DE^!" neq "" setlocal enableDelayedExpansion enableExtensions) ^&^
		(if 0 neq ^^!errorlevel^^! ^^!dk_call^^! dk_error "checkerror:ERROR:^!errorlevel^! @ ^!__PATH__^!" ^& exit/b ^^!errorlevel^^!)

	if NOT defined pad (set "pad=[0m")
	if NOT defined indent (set "indent=   ")

	if "%dk_call_HANDLE_ENTRIES%" equ "1" (
		for /l %%x in (1, 1, %ENTRY%) do (
			call :dk_call_HANDLE_ENTRIES %%x %%x
		)
	)
%endfunction:echo.[31mendfunction UNDEFINED&pause&exit/b1%=%

rem ##################################################################################
:return_callback rtn_var
	if "%~3" neq "0" (
		!dk_call! dk_error "return:ERROR:%~3 @ %~5"
	)
	rem	echo Elap:'!__CLOCK__!'  Scop:'!_SCOPE_LVL_!'  Path:'!__PATH__!'  Func:'!__FUNCTION__!'  Args:'!__ARGS__!'
exit /b %~3

rem ##################################################################################
:endfunction_callback
	if "%~3" neq "0" (
		!dk_call! dk_error "endfunction:ERROR:%~3 @ %~5"
	)
	rem	echo Elap:'!__CLOCK__!'  Scop:'!_SCOPE_LVL_!'  Path:'!__PATH__!'  Func:'!__FUNCTION__!'  Args:'!__ARGS__!'
exit /b %~3


rem ##################################################################################
:dk_download url destination
	call :pushStack "%~n0%~0" %*
	if NOT defined dk_download_BACKUP_SERVER (set "dk_download_BACKUP_SERVER=%DKHttp_DKDownload_Dir%")
%setlocal%
	set "dk_download_url=%~1"
    set "dk_download_url=%dk_download_url:\=/%"
	
	rem ### Test that url exists, if NOT try dk_download_BACKUP_SERVER ###
    call :dk_urlExists "%dk_download_url%" || (
		echo dk_download_url:'%dk_download_url%' NOT FOUND
		set "dk_download_url=%dk_download_BACKUP_SERVER%/%~nx1"
		echo Trying Backup Server url:'!dk_download_url!' . . .
	)
    call :dk_urlExists "%dk_download_url%" || (
		echo ERROR: dk_download_url:'%dk_download_url%' NOT FOUND
		goto:return
	)
	
	set "dk_download=%~2"
	set "dk_download_dir=%~dp2"
	if EXIST "%_dest_%" (echo [31m ERROR: dk_download:'%dk_download%' Already Exists [0m & pause & exit/b1)
	if NOT EXIST "%dk_download_dir%" (mkdir "%dk_download_dir:/=\%")

	echo downloading %~1 . . .

	if NOT EXIST "%curl.exe%" (call :dk_findFile curl.exe)
	%dk_start% "!curl.exe:/=\!" --version 1>nul 2>nul && (
		%dk_start% "!curl.exe:/=\!" --silent --show-error --location "%dk_download_url:\=/%" --create-dirs --output "%dk_download:/=\%"
	) || (
		echo [31m ERROR: curl.exe:'!curl.exe!' FAILED [0m & pause & exit/b1
	)

	if "%dk_download%" neq "%~2" (
		echo [31m ERROR: dk_download:'%dk_download%' changed from '%~2' [0m & pause & exit/b1
	)

	:return
	rem	endlocal & (
	rem		set "dk_download=%dk_download%"
	rem	)
%endfunction:echo.[31mendfunction UNDEFINED&pause&exit/b1%=%


rem ##################################################################################
:dk_fileContains file string
	call :pushStack "%~n0%~0" %*

	set "_file_=%~1"
	if NOT EXIST "%_file_%" (echo [31m ERROR: _file_:'%_file_%' NOT FOUND [0m & pause & exit/b1)

	if NOT EXIST "%findstr.exe%" (call :dk_findFile findstr.exe)
	>nul "%findstr.exe:/=\%" /c:"%~2" "%_file_:/=\%" || (exit/b1)
%endfunction:echo.[31mendfunction UNDEFINED&pause&exit/b1%=%


rem ##################################################################################
rem #  dk_findFile(file search_path rtn_var:OPTIONAL )
:dk_findFile
	call :pushStack "%~n0%~0" %*
%setlocal%
	rem echo DK:dk_findFile

	if "%~1" equ "" (%return:echo.[31mreturn UNDEFINED&pause&exit/b1%=%)
	set "search_path=%~2"
	set "search_path=%search_path:/=\%"
	if "%search_path:~-1%" equ "\" set "search_path=%search_path:~0,-1%"

	if "%~x1" neq "" (
		set "extensions=%~x1"
	) else (
		set "extensions=.cmd;%PATHEXT%"
	)
	
	set "dk_findFile="
	if EXIST "%~dpnx1"				(set "dk_findFile=%~dpnx1"		& goto:return)
	for %%X in (%extensions%) do (
		if EXIST "%~1%%X"			(set "dk_findFile=%~f1%%X"		& goto:return)
	)
	if EXIST "%~$PATH:1"			(set "dk_findFile=%~$PATH:1"	& goto:return)
	for %%X in (%extensions%) do (
		for %%N in (%~1%%X) do (
			if EXIST "%%~$PATH:N"	(set "dk_findFile=%%~$PATH:N"	& goto:return)
		)
	)

	if not defined dk_findFile if DEFINED search_path (
			for %%X in (%extensions%) do (
				rem echo searching "%search_path:/=\%" for %~nx1 . . .
				rem for /F "delims=" %%G IN ('dir /b/s/a:-d "%search_path:/=\%\%~nx1" 2^>nul') do (
				
				rem echo searching "%search_path:/=\%" for %~n1%%X . . .
				for /F "delims=" %%G IN ('dir /b/s/a:-d "%search_path:/=\%\%~n1%%X" 2^>nul') do (
					if %%~zG neq 0 (
						rem echo %%~dpnxG %%~zG
						rem set "dk_findFile=%%~dpnxG"
						
						rem echo %%~dpnG%%X %%~zG bytes
						set "dk_findFile=%%~dpnG%%X"
						goto:return
					)
				)
			)
		) else if not defined dk_findFile (
			rem echo searching "%SystemDrive%/" for %~nx1 . . .
			for /F "delims=" %%G IN ('dir /b/s/a:-d "%SystemDrive%\%~nx1" 2^>nul') do (
				if %%~zG neq 0 (
					rem echo %%~dpnxG %%~zG bytes
					set "dk_findFile=%%~dpnxG"
					goto:return
				)
			)
		)
		
	

	:return
	for %%A in ("%dk_findFile%") do (set "dk_findFile=%%~dpnxA")
	endlocal & (
		set "%~1=%dk_findFile%"
		if "%~3" neq "" (set "%~3=%dk_findFile%")
	)
%endfunction:echo.[31mendfunction UNDEFINED&pause&exit/b1%=%


rem #######################################
rem #	dk_timer(name) 
rem #
rem #
rem :dk_timer
rem %setlocal%
rem	set "T=%~1" 
rem	if not defined %T%.startTime (
rem		set "%T%.startTime=%time: =0%"
rem		rem echo %T%.startTime = !%T%.startTime!
rem		exit/b0
rem	)
rem	set "%T%.endTime=%time: =0%"
rem	
rem	rem Get elapsed time:
rem	set "end=!%T%.endTime:%time:~8,1%=%%100)*100+1!"  &  set "start=!%T%.startTime:%time:~8,1%=%%100)*100+1!"
rem	set /A "%T%.elap=((((10!end:%time:~2,1%=%%100)*60+1!%%100)-((((10!start:%time:~2,1%=%%100)*60+1!%%100), %T%.elap-=(%T%.elap>>31)*24*60*60*100"
rem	
rem	rem Convert elapsed time to HH:MM:SS:CC format:
rem	set /A "cc=%T%.elap%%100+100,%T%.elap/=100,ss=%T%.elap%%60+100,%T%.elap/=60,mm=%T%.elap%%60+100,hh=%T%.elap/60+100"
rem	set %T%.elapsed=%hh:~1%%time:~2,1%%mm:~1%%time:~2,1%%ss:~1%%time:~8,1%%cc:~1%
rem	set "%T%.startTime=%time: =0%"
rem	
rem	:return
rem	rem echo %T%.startTime" = !%T%.startTime!"
rem	rem echo %T%.endTime" 	= !%T%.endTime!"
rem	rem echo %T%.elapsed" 	= !%T%.elapsed!"
rem	set "dk_timer=!%T%.elapsed!"
rem	endlocal & (
rem		set "dk_timer=%dk_timer%"
rem	)
rem %endfunction:echo.[31mendfunction UNDEFINED&pause&exit/b1%=%


rem #######################################
rem #	dk_urlExists(url) 
rem #
rem #
:dk_urlExists
%setlocal%
	set "url=%~1"
	set /a "dk_urlExists=false"
	
	if exist "%url:file:///=%" (
		echo searching for %url:file:///=% 
		set /a "dk_urlExists=true"
		goto:return
	)
	
	if NOT EXIST "%curl.exe%" (call :dk_findFile curl.exe)
	for /f "usebackq tokens=*" %%a in (`%dk_start% "!curl.exe:/-\!" --output nul --silent --head --fail --write-out '%%{http_code}' %~1`) do (set dk_httpStatus=%%~a)
	if %dk_httpStatus% gtr 0 (
		if %dk_httpStatus% lss 400 (
			set /a "dk_urlExists=true"
		) 
	)
	
	:return
	endlocal & (
		set "dk_urlExists=%dk_urlExists%"
		exit /b %dk_urlExists%
	)
%endfunction:echo.[31mendfunction UNDEFINED&pause&exit/b1%=%


rem #######################################
rem #	dk_setDKPaths(DKROOT_ HomePath) 
rem #
rem #
:dk_setDKPaths
rem %setlocal%
	
	rem endlocal & (
	set "DKROOT=%~1"
	echo DKROOT = %DKROOT%
	echo %DKROOT%Dir = !%DKROOT%Dir!
	if NOT DEFINED %DKROOT%DigitalKnob				(set "%DKROOT%DigitalKnob=%_DigitalKnob%")
	rem if NOT DEFINED DKROOT if NOT EXIST "!%DKROOT%DigitalKnob!" (mkdir "!%DKROOT%DigitalKnob:/=\!")
	echo %DKROOT%DigitalKnob = !%DKROOT%DigitalKnob!
	if NOT DEFINED %DKROOT%DigitalKnob_Dir			(set "%DKROOT%DigitalKnob_Dir=!%DKROOT%Dir!/!%DKROOT%DigitalKnob!")
	echo %DKROOT%DigitalKnob_Dir = !%DKROOT%DigitalKnob_Dir!
	if NOT DEFINED %DKROOT%DKBranch					(set "%DKROOT%DKBranch=%_DKBranch%")
	echo %DKROOT%DKBranch = !%DKROOT%DKBranch!
	if NOT DEFINED %DKROOT%DKBranch_Dir				(set "%DKROOT%DKBranch_Dir=!%DKROOT%DigitalKnob_Dir!/!%DKROOT%DKBranch!")
	echo %DKROOT%DKBranch_Dir = !%DKROOT%DKBranch_Dir!
	if NOT DEFINED %DKROOT%DK3rdParty				(set "%DKROOT%DK3rdParty=%_DK3rdParty%")
	echo %DKROOT%DK3rdParty = !%DKROOT%DK3rdParty!
	if NOT DEFINED %DKROOT%DK3rdParty_Dir			(set "%DKROOT%DK3rdParty_Dir=!%DKROOT%DKBranch_Dir!/!%DKROOT%DK3rdParty!")
	echo %DKROOT%DK3rdParty_Dir = !%DKROOT%DK3rdParty_Dir!
	if NOT DEFINED %DKROOT%DKImports				(set "%DKROOT%DKImports=%_DKImports%")
	echo %DKROOT%DKImports = !%DKROOT%DKImports!
	if NOT DEFINED %DKROOT%DKImports_Dir			(set "%DKROOT%DKImports_Dir=!%DKROOT%DK3rdParty_Dir!/!%DKROOT%DKImports!")
	echo %DKROOT%DKImports_Dir = !%DKROOT%DKImports_Dir!
	if NOT DEFINED %DKROOT%DKBatch					(set "%DKROOT%DKBatch=%_DKBatch%")
	echo %DKROOT%DKBatch = !%DKROOT%DKBatch!
	if NOT DEFINED %DKROOT%DKBatch_Dir 				(set "%DKROOT%DKBatch_Dir=!%DKROOT%DKBranch_Dir!/!%DKROOT%DKBatch!")
	echo %DKROOT%DKBatch_Dir = !%DKROOT%DKBatch_Dir!
	if NOT DEFINED %DKROOT%Functions				(set "%DKROOT%Functions=%_DKFunctions%")
	echo %DKROOT%Functions = !%DKROOT%Functions!
	if NOT DEFINED %DKROOT%DKBatch_Functions_Dir_	(set "%DKROOT%DKBatch_functions_Dir_=!%DKROOT%DKBatch_Dir!/!%DKROOT%Functions!/")
	echo %DKROOT%DKBatch_Functions_Dir_ = !%DKROOT%DKBatch_Functions_Dir_!
	if NOT DEFINED %DKROOT%DKStorage				(set "%DKROOT%DKStorage=%_DKStorage%")
	echo %DKROOT%DKStorage = !%DKROOT%DKStorage!
	if NOT DEFINED %DKROOT%DKStorage_Dir			(set "%DKROOT%DKStorage_Dir=!%DKROOT%DigitalKnob_Dir!/!%DKROOT%DKStorage!")
	echo %DKROOT%DKStorage_Dir = !%DKROOT%DKStorage_Dir!
	if NOT DEFINED %DKROOT%DKCache					(set "%DKROOT%DKCache=%_DKCache%")
	echo %DKROOT%DKCache = !%DKROOT%DKCache!
	if NOT DEFINED %DKROOT%DKCache_Dir				(set "%DKROOT%DKCache_Dir=!%DKROOT%DigitalKnob_Dir!/!%DKROOT%DKCache!")
	echo %DKROOT%DKCache_Dir = !%DKROOT%DKCache_Dir!
	if NOT DEFINED %DKROOT%DKDownload				(set "%DKROOT%DKDownload=%_DKDownload%")
	echo %DKROOT%DKDownload = !%DKROOT%DKDownload!
	if NOT DEFINED %DKROOT%DKDownload_Dir			(set "%DKROOT%DKDownload_Dir=!%DKROOT%DigitalKnob_Dir!/!%DKROOT%DKDownload!")
	echo %DKROOT%DKDownload_Dir = !%DKROOT%DKDownload_Dir!
	rem )
	
	if NOT EXIST "%DKCache_Dir%"					(mkdir "%DKCache_Dir:/=\%")
%endfunction:echo.[31mendfunction UNDEFINED&pause&exit/b1%=%


rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	call :dk_setDKPaths Test_
%endfunction:echo.[31mendfunction UNDEFINED&pause&exit/b1%=%





rem ###### _SCOPE ######
rem	if "%dk_call_PRINT_SCOPE%" equ "1" (
rem		(set "_SCOPE_=DK")
rem		(set /a "_SCOPE_LVL_=0")
rem		echo SCOPE: !_SCOPE_LVL_!:!_SCOPE_!
rem		(set "setlocal=setlocal EnableDelayedExpansion & (set _SCOPE_=^!__PATH__^!) & (set /a _SCOPE_LVL_+=1) & echo SCOPE: ^!_SCOPE_LVL_^!:^!_SCOPE_^!")
rem	)
rem	   set setlocal=(setlocal EnableDelayedExpansion ^& set _SCOPE_=^^!__PATH__^^!) ^& (set /a _SCOPE_LVL_+=1) ^& (echo SCOPE: ^^!_SCOPE_LVL_^^!:^^!_SCOPE_^^!)
rem	   set setlocal=(setlocal EnableDelayedExpansion ^& set _SCOPE_=1)

rem ###### init paths ######
rem echo DK.cmd_DIR   = %~dp0
rem echo DKSCRIPT_DIR = %~dp1

rem echo ######## dirname loop ########
rem set "current_dir=%~dp1"
rem :current_dir_loop
rem for %%C in ("%current_dir:~0,-1%") do set current_dir=%%~dpC
rem echo current_dir = %current_dir%
rem if EXIST "%current_dir%" goto:current_dir_loop
rem echo ############################

rem	set globalize=(for /F "delims=" %%a in ('set dk.') do ^
rem		endlocal^
rem		^& call set _line_=%%a^
rem		^& call set %%_line_%%^
rem		^& call set %%_line_:dk.gbl.=%%) 2^>nul

rem		rem ### Set -ARGV variables
rem		set "-ARGV="
rem		set "-ARGC=0"
rem		for %%A in (%ARGV%) do (
rem			if DEFINED -ARGV (call set -ARGV=%%-ARGV%% %%~A) else (set -ARGV=%%A)
rem			call set "-ARGV%%ARGC%%=%%~A"
rem			set /a "-ARGC+=1"
rem		)
rem		
rem		rem ### Print -ARGV variables
rem		echo -ARGV = '%-ARGV%'
rem		echo -ARGC = '%-ARGC%'
rem		set "n=0"
rem		for %%a in (%-ARGV%) do (
rem			call echo -ARGV%%n%% = '%%~a'
rem			set /a "n+=1"
rem		)
rem %endfunction:echo.[31mendfunction UNDEFINED&pause&exit/b1%=%