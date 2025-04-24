<<<<<<< HEAD
@echo off

::# http://cplusplus.bordoon.com/cmd_exe_variables.html


::###### DK_Init ######
call "../functions/DK.cmd"

:main
	set IN=%0
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::# http://cplusplus.bordoon.com/cmd_exe_variables.html

:main
::	set IN=%0
set "IN=%WINDIR%\NonExistent.file
>>>>>>> Development
::	set "IN=%0"
::	set IN=%~0
::	set "IN=%~0"
::	set "IN=%ProgramFiles%\WSL\wsl.exe"
<<<<<<< HEAD
::	set "IN=C:\Users\aquawicket\digitalknob\Development\DKBatch\tests\test_blank.cmd"
=======
::	set "IN=%USERPROFILE%\digitalknob\Development\DKBatch\tests\test_blank.cmd"
>>>>>>> Development
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
<<<<<<< HEAD
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

	%dk_call% dk_basename "%IN%" nameOnly
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
	
	%dk_call% dk_basename "%IN%" fullname
	echo fullname   = %fullname%
	
	call dk_dirname "%IN%" directory
	echo directory  = %directory%
	
	pause
=======
::	set IN=%USERPROFILE%\digitalknob\Development\DKBatch\
::	set "IN=%USERPROFILE%/digitalknob/Development/DKBatch/DK.cmd"
::	set "IN=%USERPROFILE%\digitalknob\Development\DKBatch"

	echo IN         = "%IN%"

	%dk_call% dk_pathExists "%IN%"
	%dk_call% dk_pathExists "%IN%" && (echo "%IN%" exists) || (echo "%IN%" does NOT exist)
	
	call :get_variable "%IN%" get_variable
	echo get_variable   = %get_variable%

	%dk_call% dk_getUnquoted "%IN%" dk_getUnquoted
	echo dk_getUnquoted   = %dk_getUnquoted%

	%dk_call% dk_realpath "%IN%" dk_realpath
	echo dk_realpath   = %dk_realpath%
	
	%dk_call% dk_dirname "%IN%" dk_dirname
	echo dk_dirname   = %dk_dirname%
	
	%dk_call% dk_basename "%IN%" dk_basename
	echo dk_basename   = %dk_basename%
	
	%dk_call% dk_driveName "%IN%" dk_driveName
	echo dk_driveName      = %dk_driveName%

	%dk_call% dk_getExtension "%IN%" dk_getExtension
	echo dk_getExtension  = %dk_getExtension%

	%dk_call% dk_getShortPath "%IN%" dk_getShortPath
	echo dk_getShortPath  = %dk_getShortPath%

	%dk_call% dk_getAttributes "%IN%" dk_getAttributes
	echo dk_getAttributes = %dk_getAttributes%

	%dk_call% dk_getFileTime "%IN%" dk_getFileTime
	echo dk_getFileTime   = %dk_getFileTime%

	%dk_call% dk_fileSize "%IN%" dk_fileSize
	echo dk_fileSize   = %dk_fileSize% bytes
	
>>>>>>> Development
%endfunction%


:: print all variable names
::for /f "usebackq delims==" %%i in (`set`) do @echo %%i

:get_variable
	set _input=%1
	set _input=%_input:"=%
<<<<<<< HEAD
	if [%_input:~-1%] == [\] set _input=%_input:~0,-1%
	if [%_input:~-1%] == [/] set _input=%_input:~0,-1%
	for %%Z in ("%_input%") do set "OUT=%%Z"
	endlocal & set %2=%OUT%
=======
	if "%_input:~-1%" equ "\" set _input=%_input:~0,-1%
	if "%_input:~-1%" equ "/" set _input=%_input:~0,-1%
	for %%Z in ("%_input%") do set "OUT=%%Z"
	endlocal & (
		set %~2=%OUT%
	)
>>>>>>> Development
%endfunction%

