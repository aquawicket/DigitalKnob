@echo off

::# http://cplusplus.bordoon.com/cmd_exe_variables.html
::####################################################################
::# test_dk_validateNotepadpp.cmd
::#
::#
::###### DK_Init ######
call "../functions/DK.cmd"

:: http://cplusplus.bordoon.com/cmd_exe_variables.html
:: d -- drive
:: p -- path
:: n -- file name
:: x -- extension
:: f -- full path
:: s -- short PATH
:: a -- attributes
:: t -- time
:: z -- size

:main
	set IN=%0
::	set "IN=%0"
::	set IN=%~0
::	set "IN=%~0"
::	set "IN=C:\Program Files\WSL\wsl.exe"
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
	
	call :get_unquoted "%IN%" unquoted
	echo unquoted   = %unquoted%
	
	call dk_getDrive "%IN%" drive
	echo drive      = %drive%
	
	call dk_getPathOnly "%IN%" path
	echo path      = %path%
	
	call dk_getNameOnly "%IN%" name
	echo name       = %name%
	
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
	
	call dk_getFilename "%IN%" fullname
	echo fullname   = %fullname%
	
	call dk_getDirectory "%IN%" directory
	echo directory   = %directory%
	
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

:get_unquoted
	set _input=%1
	set _input=%_input:"=%
	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
	for %%Z in ("%_input%") do set "OUT=%%~Z"
	endlocal & set %2=%OUT%
goto:eof

:::get_drive
::	set _input=%1
::	set _input=%_input:"=%
::	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
::	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
::	for %%Z in ("%_input%") do set "OUT=%%~dZ"
::	endlocal & set %2=%OUT%
::goto:eof

:::dk_getPathOnly
::	set _input=%1
::	set _input=%_input:"=%
::	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
::	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
::	for %%Z in ("%_input%") do set "OUT=%%~pZ"
::	endlocal & set %2=%OUT:~0,-1%
::goto:eof

:::dk_getNameOnly
::	::https://stackoverflow.com/a/59739663/688352
::	set _input=%1
::	set _input=%_input:"=%
::	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
::	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
::	for %%Z in ("%_input%") do set "OUT=%%~nZ"
::	endlocal & set %2=%OUT%
::goto:eof

:::get_extension
::	set "_input=%1"
::	set _input=%_input:"=%
::	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
::	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
::	for %%Z in ("%_input%") do set "OUT=%%~xZ"
::	endlocal & set %2=%OUT%
::goto:eof

:::get_fullPath
::	set _input=%1
::	set _input=%_input:"=%
::	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
::	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
::	for %%Z in ("%_input%") do set "OUT=%%~fZ"
::	endlocal & set %2=%OUT%
::goto:eof

:::dk_getShortPath
::	set _input=%1
::	set _input=%_input:"=%
::	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
::	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
::	for %%Z in ("%_input%") do set "OUT=%%~sZ"
::	endlocal & set %2=%OUT%
::goto:eof

:::dk_getAttributes
::	set _input=%1
::	set _input=%_input:"=%
::	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
::	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
::	for %%Z in ("%_input%") do set "OUT=%%~aZ"
::	endlocal & set %2=%OUT%
::goto:eof

:::dk_getFileTime
::	set _input=%1
::	set _input=%_input:"=%
::	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
::	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
::	for %%Z in ("%_input%") do set "OUT=%%~tZ"
::	endlocal & set %2=%OUT%
::goto:eof

:::dk_getFileSize
::	set _input=%1
::	set _input=%_input:"=%
::	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
::	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
::	for %%Z in ("%_input%") do set "OUT=%%~zZ"
::	endlocal & set %2=%OUT%
::goto:eof

:::get_fullName :: %~nxI - name and extension
::	::https://stackoverflow.com/a/59739663/688352
::	set _input=%1
::	set _input=%_input:"=%
::	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
::	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
::	for %%Z in ("%_input%") do set "OUT=%%~nxZ"
::	endlocal & set %2=%OUT%
::goto:eof

:::dk_getDirectory :: %~dpI - drive and path
::#	::https://stackoverflow.com/a/59739663/688352
::	set _input=%1
::	set _input=%_input:"=%
::	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
::	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
::	for %%Z in ("%_input%") do set "OUT=%%~dpZ"
::	endlocal & set %2=%OUT:~0,-1%
::goto:eof

pause