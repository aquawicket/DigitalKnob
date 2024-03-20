@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit ) :: keep window open

:main
	call get_current_dir current_dir
	echo current_dir = %current_dir%

	call get_directories %current_dir% directory_list
	echo directory_list = %directory_list%
goto:eof
