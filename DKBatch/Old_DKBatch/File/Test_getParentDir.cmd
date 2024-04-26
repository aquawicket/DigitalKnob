@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit ) :: keep window open

:main
	call::get_current_dir current_dir
	echo current_dir = %current_dir%
	call::get_dir_name %current_dir% current_dir_name
	echo current_dir_name = %current_dir_name%
	echo.
	
	call:get_parent_dir %current_dir% parent_dirA
	echo parent_dirA = %parent_dirA%
	call::get_dir_name %current_dir% parent_folderA
	echo parent_folderA = %parent_folderA%
	echo.
	
	call:get_parent_dir %parent_dirA% parent_dirB
	echo parent_dirB = %parent_dirB%
	call::get_dir_name %parent_dirA% parent_folderB
	echo parent_folderB = %parent_folderB%
	echo.
	
	call:get_parent_dir %parent_dirB% parent_dirC
	echo parent_dirC = %parent_dirC%
	call::get_dir_name %parent_dirB% parent_folderC
	echo parent_folderC = %parent_folderC%
	echo.
goto:eof

:: get_current_dir
:::get_current_dir
::    set %1=%cd%
::goto:eof

:: get_parent_dir
:get_parent_dir
	::echo get_parent_dir_input = %1
	for %%x in ("%1..\") do set parent_dir=%%~dpx
	set "%2=%parent_dir%"
goto:eof

:: get_dir_name
:get_dir_name
    for %%a in ("%1..\") do for %%b in ("%%~dpa\.") do set "dir_name=%%~nxb"
	set "%2=%dir_name%"
goto:eof










:: "%CMAKE_EXE%" "-DDKCMAKE_DIR=%DKCMAKE_DIR%" -P "%DKCMAKE_DIR%/dev/Test.cmake"
