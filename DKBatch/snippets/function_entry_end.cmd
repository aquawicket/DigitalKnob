@echo off

set "function=main"
call:%%_main_%%


pause
goto:eof




:%%_main_%%
	echo in main

	echo leaving main
:%endfunction%

pause