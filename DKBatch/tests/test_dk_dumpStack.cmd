@echo off

::####################################################################
::# test_dk_dumpStack.cmd
::#
::#
::###### DK_Init ######
::

:func1
	echo :func1 %*
	call:func2
	echo returned from func2
	::call:func2 & (
	::	(goto) 2>nul
	::	call echo 0 = %%~0
	::	echo returned from func2
	::)
%endfunction%

:func2
	echo :func2 %*
	call:func3
	echo returned from func3
	::call:func3 123 & (
	::	(goto) 2>nul
	::	call echo 0 = %%~0
	::	echo returned from func3
	::)
%endfunction%

:func3
	echo :func3 %*
	call:func4
	echo returned from func4
	::call:func4 blue & (
	::	(goto) 2>nul
	::	call echo 0 = %%~0
	::	echo returned from func4
	::)
%endfunction%

:func4
	echo :func4 %*
	call:func5 orange
	echo returned from func5
%endfunction%

:func5
	echo :func5 %*
<:dk_dumpStackReturn <nul call dk_dumpStack
	echo returned from dk_dumpStack
%endfunction%
