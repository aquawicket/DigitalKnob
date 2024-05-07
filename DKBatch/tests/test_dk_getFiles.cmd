@echo off

::###### DK_Init ######
call ../functions/DK.cmd

:main
	call dk_getFiles "C:\Windows" files
	call dk_printArray files
	pause
goto:eof
