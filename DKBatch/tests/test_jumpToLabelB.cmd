@echo off
echo This is never seen


:main
	echo.
	echo This is test_jumpToLabelB :main
	pause
goto:eof

:method1
	echo.
	echo This is test_jumpToLabelB :method1
goto:eof

:method2
	echo.
	echo This is test_jumpToLabelB :method2
goto:eof

:method3
	echo.
	echo This is test_jumpToLabelB :method3
goto:eof

:method4
	echo.
	echo This is test_jumpToLabelB :method4
goto:eof