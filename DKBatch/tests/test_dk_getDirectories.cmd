@echo off

::###### DK_Init ######
call ../functions/DK.cmd

:main
	call dk_getDirectories "C:\Windows" Directories
	call dk_printArray Directories
	pause
goto:eof
