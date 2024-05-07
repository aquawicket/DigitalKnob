@echo off
echo This is never seen


:main
	echo This is test_jumpToLabelB :main
	pause
goto:eof

:method1
	echo This is test_jumpToLabelB :method1
goto:eof

:method2
	echo This is test_jumpToLabelB :method2
goto:eof