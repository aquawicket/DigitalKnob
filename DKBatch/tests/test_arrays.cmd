@echo off

::###### DK_Init ######
call ../functions/DK.cmd

:: create the file
dir /b /a-d > array.cmd

:main
	call dk_fileToArray array.cmd MyArray
	call dk_arrayLength MyArray MyArrayLength
	::echo MyArrayLength = %MyArrayLength%
	::echo MyArray[0] = %MyArray[0]%
	::echo MyArray[1] = %MyArray[1]%
	::echo MyArray[2] = %MyArray[2]%
	call dk_printArray MyArray
	
	call dk_arrayToString MyArray MyArrayString
	echo MyArrayString = %MyArrayString%
	
	set "MyList=abc;123;four;five;six"
	echo MyList = %MyList%
	call dk_listToArray "%MyList%" MyArrayB
	call dk_arrayLength MyArrayB MyArrayBLength
	::echo MyArrayBLength = %MyArrayBLength%
	::echo MyArrayB[0] = %MyArrayB[0]%
	::echo MyArrayB[1] = %MyArrayB[1]%
	::echo MyArrayB[2] = %MyArrayB[2]%
	call dk_printArray MyArrayB
	
	call dk_deleteArray MyArrayB
	::echo MyArrayB[0] = %MyArrayB[0]%
	::echo MyArrayB[1] = %MyArrayB[1]%
	::echo MyArrayB[2] = %MyArrayB[2]%
	call dk_printArray MyArrayB
	
	pause
goto:eof
