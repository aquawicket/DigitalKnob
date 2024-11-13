@echo off

call:main
goto eof

:main
	::echo before call returnWithoutCallB
	::call returnWithoutCallB
	::echo after call returnWithoutCallB
	
::	echo:
::	echo before returnWithoutCallB
::	returnWithoutCallB &(
::		echo after returnWithoutCallB
::		pause
::	)

	echo before returnWithoutCallB
	call:returnWithoutCallB
%endfunction%

	

:returnWithoutCallB
	:returnWithoutCallB_return & returnWithoutCallB & goto returnWithoutCallB_return & call %~f0
	::returnWithoutCallB_return
	echo after returnWithoutCallB
	pause
%endfunction%
