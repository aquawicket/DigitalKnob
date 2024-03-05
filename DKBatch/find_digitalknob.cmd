@echo off
setlocal EnableDelayedExpansion
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit ) :: keep window open

:main	
	call:find_dkbranch_dir DIGITALKNOB_DIR DKBRANCH
	echo DIGITALKNOB_DIR = %DIGITALKNOB_DIR%
	echo DKBRANCH = %DKBRANCH%
	set DKBRANCH_DIR=%DIGITALKNOB_DIR%\%DKBRANCH%
	echo DKBRANCH_DIR = %DKBRANCH_DIR%
	
	
goto:eof

:: find_dkbranch_dir
:find_dkbranch_dir
	set current_dir=%~dp0
	:find_dkbranch_dir_loop
		for %%a in ("%current_dir%") do for %%b in ("%%~dpa\.") do set "current_folder=%%~nxb"
		for %%x in ("%current_dir%\..\") do set parent_dir=%%~dpx
		for %%a in ("%parent_dir%") do for %%b in ("%%~dpa\.") do set "parent_folder=%%~nxb"
		set current_dir=%parent_dir%
		if "%parent_folder%" NEQ "digitalknob" goto:find_dkbranch_dir_loop
		set %1=%parent_dir:~0,-1%
		set %2=%current_folder%
goto:eof




:: "%CMAKE_EXE%" "-DDKCMAKE_DIR=%DKCMAKE_DIR%" -P "%DKCMAKE_DIR%/dev/Test.cmake"
