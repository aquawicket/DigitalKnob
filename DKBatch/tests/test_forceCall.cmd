@echo off

:main
	call test_forceCallB
	pause
	
	test_forceCallB & pause
%endfunction%
