@echo off

::####################################################################
::# test_dk_dumpStack.cmd
::#
::#
::###### DK_Init ######
::

:main
	echo :main
	
	call "../functions/DK.cmd"
	
	call test_dk_dumpStackB
	echo returned from test_dk_dumpStackB
	
	echo caller[0] = %caller[0]%
	echo caller[1] = %caller[1]%
	echo caller[2] = %caller[2]%
	echo caller[3] = %caller[3]%
	echo caller[4] = %caller[4]%
	echo caller[5] = %caller[5]%
	echo caller[6] = %caller[6]%
	echo caller[7] = %caller[7]%
	pause
goto:eof
