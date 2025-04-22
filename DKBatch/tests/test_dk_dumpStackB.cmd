@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


echo "test_dk_dumpStackB entry"


:test_dk_dumpStackB
	echo :test_dumpStackB %*
::<:dk_popStackReturn <nul call dk_popStack
::	echo returned from dk_popStack & pause
	call:func1
	echo returned from func1
	::call:func1 & (
	::    (goto) 2>nul && (goto) 2>nul && (goto) 2>nul
    ::	call echo 0 = %%~0
	::	echo returned from func1
	::)
%endfunction%

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
