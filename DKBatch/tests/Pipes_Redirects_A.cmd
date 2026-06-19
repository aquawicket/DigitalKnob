:: https://www.tutorialspoint.com/batch_script/batch_script_files_pipes.htm

@echo off
echo.
echo ### Pipes_Redirects_A.cmd %* ###

set "data=abc 123"
echo %data% | call Pipes_Redirects_B.cmd arg1 arg2


	
echo.
pause



