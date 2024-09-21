@echo off
echo This is never seen


:main
	echo:
	echo This is test_jumpToLabelB :main
	pause
%endfunction%

:method1
	echo:
	echo This is test_jumpToLabelB :method1
%endfunction%

:method2
	echo:
	echo This is test_jumpToLabelB :method2
%endfunction%

:method3
	echo:
	echo This is test_jumpToLabelB :method3
%endfunction%

:method4
	echo:
	echo This is test_jumpToLabelB :method4
%endfunction%