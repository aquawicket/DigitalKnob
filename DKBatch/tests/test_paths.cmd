@echo off

::# http://cplusplus.bordoon.com/cmd_exe_variables.html


::###### DK_Init ######
call "../functions/DK.cmd"

:main
	set IN=%0
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
::	set "IN=C:/Users/aquawicket/digitalknob/Development/DKBatch/"
::	set "IN=C:\Users\aquawicket\digitalknob\Development\DKBatch"

	echo IN         = "%IN%"

	call :get_variable "%IN%" variable
	echo variable   = %variable%

	call dk_getUnquoted "%IN%" unquoted
	echo unquoted   = %unquoted%

	call dk_getDrive "%IN%" drive
	echo drive      = %drive%

	call dk_getPath "%IN%" pathOnly
	echo pathOnly   = %pathOnly%

	call dk_basename "%IN%" nameOnly
	echo nameOnly   = %nameOnly%

	call dk_getExtension "%IN%" extension
	echo extension  = %extension%

	call dk_getFullPath "%IN%" fullPath
	echo fullPath   = %fullPath%

	call dk_getShortPath "%IN%" shortPath
	echo shortPath  = %shortPath%

	call dk_getAttributes "%IN%" attributes
	echo attributes = %attributes%

	call dk_getFileTime "%IN%" fileTime
	echo fileTime   = %fileTime%

	call dk_getFileSize "%IN%" filesize
	echo filesize   = %filesize% bytes
	
	call dk_basename "%IN%" fullname
	echo fullname   = %fullname%
	
	call dk_dirname "%IN%" directory
	echo directory  = %directory%
	
	pause
goto:eof


:: print all variable names
::for /f "usebackq delims==" %%i in (`set`) do @echo %%i

:get_variable
	set _input=%1
	set _input=%_input:"=%
	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
	for %%Z in ("%_input%") do set "OUT=%%Z"
	endlocal & set %2=%OUT%
goto:eof

