@echo off
echo "test_callStackB entry"


:test_callStackB
	echo test_callStackB %*
::<:dk_popStackReturn <nul call dk_popStack
::	echo returned from dk_popStack & pause
	call:func1
	echo returned from func1
	::call:func1 & (
	::    (goto) 2>nul && (goto) 2>nul && (goto) 2>nul
    ::	call echo 0 = %%~0
	::	echo returned from func1
	::)
goto:eof

:func1
	echo func1 %*
	call:func2
	echo returned from func2
	::call:func2 & (
	::	(goto) 2>nul
	::	call echo 0 = %%~0
	::	echo returned from func2
	::)
goto:eof

:func2
	echo func2 %*
	call:func3
	echo returned from func3
	::call:func3 123 & (
	::	(goto) 2>nul
	::	call echo 0 = %%~0
	::	echo returned from func3
	::)
goto:eof

:func3
	echo func3 %*
	call:func4
	echo returned from func4
	::call:func4 blue & (
	::	(goto) 2>nul
	::	call echo 0 = %%~0
	::	echo returned from func4
	::)
goto:eof

:func4
	echo func4 %*
	call:func5 orange
	echo returned from func5
goto:eof

:func5
	echo func5 %*
<:dk_popStackReturn <nul call dk_popStack
goto:eof
