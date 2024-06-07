if defined DKINIT (goto:eof) else (set DKINIT=1)
@echo off


for /L %%i in (1,1,%CANCEL%) do (
   call set "isCmdLineContext=%%"
   if defined isCmdLineContext echo We are in CmdLineContext
   call echo Cancel %%i- "%%~NX0", var = %%var%%
   (goto) 2> NUL
)

set "ENABLE_dk_debugFunc=1"
set "ENABLE_dk_printVar=0"
set "KEEP_CONSOLE_OPEN=0"
::####################################################################
::# DK()
::#
::#
:DK () {
	echo Loading DigitalKnob . . .

	::############ Set DKBATCH_FUNCTIONS_DIR path ############
	for %%Z in ("%~dp0..\") do set "DKBATCH_DIR=%%~dpZ"
	set "DKBATCH_DIR=%DKBATCH_DIR:~0,-1%"
	set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_DIR%\functions"
	if not exist "%DKBATCH_FUNCTIONS_DIR%\DK.cmd" (echo "DKBATCH_FUNCTIONS_DIR does not exist" & goto:eof)
	set "PATH=%DKBATCH_FUNCTIONS_DIR%;%PATH%"
	
	::############ Set DKHTTP_DKBATCH_FUNCTIONS_DIR path ############
	set "DKHTTP_DIGITALKNOB_DIR=https://raw.githubusercontent.com/aquawicket/DigitalKnob"
	set "DKHTTP_DKBRANCH_DIR=%DKHTTP_DIGITALKNOB_DIR%/Development"
	set "DKHTTP_DKBATCH_DIR=%DKHTTP_DKBRANCH_DIR%/DKBatch"
	set "DKHTTP_DKBATCH_FUNCTIONS_DIR=%DKHTTP_DKBATCH_DIR%/functions"
	
	::############ Load Callstack ############
	if not exist "%DKBATCH_FUNCTIONS_DIR%\dk_callStack.cmd" powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_callStack.cmd', '%DKBATCH_FUNCTIONS_DIR%\dk_callStack.cmd')"
	call dk_callStack
	:dk_callStackReturn
	echo FUNCNAME[0]     = %FUNCNAME[0]%
	echo BATCH_SOURCE[0] = %BATCH_SOURCE[0]%
	echo BATCH_ARGV[0]   = %BATCH_ARGV[0]%
	echo BATCH_ARGC[0]   = %BATCH_ARGC[0]%
::	  echo FUNCNAME[1]     = %FUNCNAME[1]%
::	  echo BATCH_SOURCE[1] = %BATCH_SOURCE[1]%
::	  echo BATCH_ARGV[1]   = %BATCH_ARGV[1]%
::	  echo BATCH_ARGC[1]   = %BATCH_ARGC[1]%
	
	if not defined DKSCRIPT_PATH set "DKSCRIPT_PATH=%__FILE__%"
	set "DKSCRIPT_ARGS=%__ARGS__%"
	
	::############ Load dk_load.cmd ############
	if not exist "%DKBATCH_FUNCTIONS_DIR%\dk_load.cmd" powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_load.cmd', '%DKBATCH_FUNCTIONS_DIR%\dk_load.cmd')"
	
	
	
	::############ Get DKSCRIPT_ variables ############
	call dk_load dk_getDirname
	call dk_getDirname %DKSCRIPT_PATH% DKSCRIPT_DIR
	call dk_load dk_getFilename
	call dk_getFilename %DKSCRIPT_PATH% DKSCRIPT_NAME
	
	::if %KEEP_CONSOLE_OPEN% equ 1 if not defined in_subprocess (cmd /k set in_subprocess=y ^& set "DKINIT=" ^& "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%) & set "DKINIT=1" & exit ) :: keep window open
	
	::############ LOAD FUNCTION FILES ############
	call dk_load dk_loadAll
	call dk_loadAll
	::call dk_load %DKSCRIPT_PATH%

	call dk_assert DKSCRIPT_PATH
	
	:: Get args after %~1
	::for /f "tokens=1,* delims= " %%a in ("%*") do set ARGS_AFTER_1=%%b
	::call printVar ARGS_AFTER_1
	
	::call dk_createFunctionList
	
	::###### DKTEST MODE ######
	if "%DKSCRIPT_DIR%" neq "%DKBATCH_FUNCTIONS_DIR%" goto:eof
	echo.
    echo ###### DKTEST MODE ###### %DKSCRIPT_NAME% ###### DKTEST MODE ######
	echo.
	call :DKTEST
	echo.
	echo ########################## END TEST ################################
	echo.
	pause
	exit
	
goto:eof

:DKTEST
	%DKSCRIPT_NAME%
goto:eof