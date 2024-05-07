@echo off

::###### DK_Init ######
call ../functions/DK.cmd

:: create the file
dir /b /a-d > array.cmd

:main
	call dk_fileToArray array.cmd MyArray
	call dk_getArrayLength MyArray MyArrayLength
	echo MyArrayLength = %MyArrayLength%
	echo MyArray[0] = %MyArray[0]%
	echo MyArray[1] = %MyArray[1]%
	echo MyArray[2] = %MyArray[2]%
	pause
goto:eof
