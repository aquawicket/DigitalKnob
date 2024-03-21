@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit ) :: keep window open

:main
	call get_current_dir current_dir
	echo current_dir = %current_dir%

	call get_files %current_dir% file_list
	echo file_list = %file_list%
	
	call ListToArray "%file_list%" file_arry length
	call PrintArray %file_arry%
goto:eof
