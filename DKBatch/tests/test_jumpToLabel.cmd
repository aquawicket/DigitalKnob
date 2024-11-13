@echo off

:: when running a batch file without using call, it will jump into the last :label called if it exists in the file.

:main
	
	:: This method call a :label, that runs the batch file. It will return to here after
	call :method1
	echo returned from test_jumpToLabelB :method1

	
	:: This method allows us to place all code inline
	call :method2 & goto endMethod2
	:method2
	test_jumpToLabelB
	:endMethod2
	echo returned from test_jumpToLabelB :method2

	
	:: This method also allows us to place all code inline
<:method3 <nul call :method3 & goto endMethod3
test_jumpToLabelB
<:endMethod3
	echo returned from test_jumpToLabelB :method3


	pause
%endfunction%


:method1
	test_jumpToLabelB
%endfunction%