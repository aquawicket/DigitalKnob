@echo off
if not defined DKBATCH_FUNCTIONS_DIR_  set "DKBATCH_FUNCTIONS_DIR_=../functions/"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::# http://cplusplus.bordoon.com/cmd_exe_variables.html



:main
::	set IN=%0
set "IN=C:\Windows\NonExistent.file
::	set "IN=%0"
::	set IN=%~0
::	set "IN=%~0"
::	set "IN=%ProgramFiles%\WSL\wsl.exe"
::	set "IN=C:\Users\aquawicket\digitalknob\Development\DKBatch\tests\test_blank.cmd"
::	set "IN=C:/Program Files/WSL/wsl.exe"
::  set "IN=test_dk_echo.cmd"
::  set "IN=/test_dk_echo.cmd"
::  set "IN=\test_dk_echo.cmd"
::	set "IN=../docs.txt"
::	set "IN=..\docs.txt"
::	set "IN=..\functions\DK.cmd"
::	set "IN=../functions/DK.cmd"
::	set "IN=../functions\DK.cmd"
::	set "IN=..\functions/DK.cmd"
::	set "IN=..\\functions\\DK.cmd"
::	set "IN=..//functions//DK.cmd"
::	set "IN=..\..\DKBatch\functions\DK.cmd"
::	set "IN=..\..\DKBatch\..\Batch\functions\DK.cmd"
::	set IN=C:\Users\aquawicket\digitalknob\Development\DKBatch\
::	set "IN=C:/Users/aquawicket/digitalknob/Development/DKBatch/DK.cmd"
::	set "IN=C:\Users\aquawicket\digitalknob\Development\DKBatch"

	echo IN         = "%IN%"

	%dk_call% dk_pathExists "%IN%"
	%dk_call% dk_pathExists "%IN%" && (echo "%IN%" exists) || (echo "%IN%" does NOT exists)
	
	call :get_variable "%IN%" variable
	echo variable   = %variable%

	%dk_call% dk_getUnquoted "%IN%" unquoted
	echo unquoted   = %unquoted%

	%dk_call% dk_realpath "%IN%" realpath
	echo realpath   = %realpath%
	
	%dk_call% dk_dirname "%IN%" dirname
	echo dirname   = %dirname%
	
	%dk_call% dk_basename "%IN%" basename
	echo basename   = %basename%
	
	%dk_call% dk_getDrive "%IN%" drive
	echo drive      = %drive%

	%dk_call% dk_getExtension "%IN%" extension
	echo extension  = %extension%

	%dk_call% dk_getShortPath "%IN%" shortPath
	echo shortPath  = %shortPath%

	%dk_call% dk_getAttributes "%IN%" attributes
	echo attributes = %attributes%

	%dk_call% dk_getFileTime "%IN%" fileTime
	echo fileTime   = %fileTime%

	%dk_call% dk_getFileSize "%IN%" filesize
	echo filesize   = %filesize% bytes
	
%endfunction%


:: print all variable names
::for /f "usebackq delims==" %%i in (`set`) do @echo %%i

:get_variable
	set _input=%1
	set _input=%_input:"=%
	if [%_input:~-1%] == [\] set _input=%_input:~0,-1%
	if [%_input:~-1%] == [/] set _input=%_input:~0,-1%
	for %%Z in ("%_input%") do set "OUT=%%Z"
	endlocal & set %2=%OUT%
%endfunction%

