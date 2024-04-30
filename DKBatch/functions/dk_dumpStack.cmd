@echo off
call dk_includeGuard
call DK

::https://stackoverflow.com/a/11576816

set "func=%~0"
for /F "delims=\" %%X in ("%func:*\=%") do set "func=%%X"
if ":" == "%func:~0,1%" ( goto %func% )

if not defined frame (set /a frame=0)

:dk_dumpStack
(	
	setlocal DisableDelayedExpansion
	if %frame% NEQ 0 (goto) 2>nul & (goto) 2>nul
    
	echo #################################################
	set /a "frame=%frame%"
	set "_returnVar=%~1"

	
	call set "caller[%frame%]=%%~0"
	call set "caller[%frame%].fullpath=%%~f0"
	call set "caller[%frame%].directory=%%~dp0"
	call set "caller[%frame%].filename=%%~nx0"
	call set "caller[%frame%].func=%%~n0"
	call set "caller[%frame%].args=%%*"

	call set "caller=%%~0"
	call set "caller.fullpath=%%~f0"
	call set "caller.directory=%%~dp0"
	call set "caller.filename=%%~nx0"
	call set "caller.func=%%~n0"
	call set "DKTEST_caller=:DKTEST_%%~n0"
	call set "caller.args=%%*"
	
	echo caller                         = %caller%
	echo caller.fullpath                = %caller.fullpath%
	echo caller.directory               = %caller.directory%
	echo caller.filename                = %caller.filename%
	echo caller.func                    = %caller.func%
	echo DKTEST_caller                  = %DKTEST_caller%
	echo caller.args                    = %caller.args%
	call set _caller=%%caller[%frame%].fullpath:*%%~f0=%%
	echo _caller                        = %_caller%
	
	
	call echo caller[%frame%]           = %%caller[%frame%]%%
	call echo caller[%frame%].fullpath  = %%caller[%frame%].fullpath%%
	call echo caller[%frame%].directory = %%caller[%frame%].directory%%
	call echo caller[%frame%].filename  = %%caller[%frame%].filename%%
	call echo caller[%frame%].func      = %%caller[%frame%].func%%
	call echo caller[%frame%].args      = %%caller[%frame%].args%%
	
	
	echo "%caller%" = "%DKTEST_caller%"
	if "%caller%"=="%DKTEST_caller%" (echo THEY ARE EQUAL!)
	
	if "%caller%"=="" (
		echo CALLER IS EMPTY
		setlocal DisableDelayedExpansion
		set /a frame+=1
		call "%~d0\:dk_dumpStack\..%~pnx0" %*
	) else if "%caller%" NEQ "%DKTEST_caller%" (
		echo CALLER NEQ DKTEST AND CALLER NEQ CALLERFUNC
		setlocal DisableDelayedExpansion
		set /a frame+=1
		call "%~d0\:dk_dumpStack\..%~pnx0" %*
	) else (
		echo LEAVING
		if defined _caller (
			set "caller[%frame%].type=batch"
			call "%~d0\:call_return\..%~pnx0" %*
		) else (
			set "caller[%frame%].type=cmd-line"
			cmd /c "call "%~d0\:call_return\..%~pnx0" %*"
		)
		endlocal
	)
)
goto:eof

:::dk_dumpStackB
::	setlocal DisableDelayedExpansion
::	
::	set "runner=(goto) 2>nul"
::	set "runner=%runner% & call echo frame = %%~0"
::	set "runner=%runner% & call echo self = %~0"
::	set "runner=%runner% & call set frame=%%~0"	
::	set "runner=%runner% & (if [%frame%]==[%%~0] (call ) else (call))"
::	set "runner=%runner% && (call %~d0\:call_return\..%~pnx0)"
::	set "runner=%runner% || (if [%frame%] NEQ [] (call ))"
::	set "runner=%runner% && (set frames=%frames% %frame%)"
::
::	set "runner=%runner% && %runner% && %runner% && %runner% && %runner% && %runner% && %runner% && echo frames = %frames%"
::	
::	echo "runner = %runner%"
::	%runner%
::	::%thingie% && %thingie% && %thingie% && %thingie% && %thingie% && %thingie% && %thingie% & call "%~d0\:call_return\..%~pnx0"
::goto:eof



:call_return
	call :dk_dumpStackReturn
goto:eof

:dk_dumpStackReturn
	endlocal
	
	%caller[1].fullpath% %caller[1].args%
goto:eof





:DKTEST ########################################################################
	call :DKTEST_main
goto:eof

:DKTEST_main
	call :DKTEST_dk_dumpStack
goto:eof

:DKTEST_dk_dumpStack
	echo :DKTEST  %*
	call:func1
	
	echo caller[0] = %caller[0]%
	echo caller[1] = %caller[1]%
	echo caller[2] = %caller[2]%
	echo caller[3] = %caller[3]%
	echo caller[4] = %caller[4]%
	echo caller[5] = %caller[5]%
	echo caller[6] = %caller[6]%
	echo caller[7] = %caller[7]%
	echo returned from :DKTEST 
	
	call dk_exit
goto:eof

:func1
	echo :func1 %*
	call:func2
	echo returned from func2
	::call:func2 & (
	::	(goto) 2>nul
	::	call echo 0 = %%~0
	::	echo returned from func2
	::)
goto:eof

:func2
	echo :func2 %*
	call:func3
	echo returned from func3
	::call:func3 123 & (
	::	(goto) 2>nul
	::	call echo 0 = %%~0
	::	echo returned from func3
	::)
goto:eof

:func3
	echo :func3 %*
	call:func4
	echo returned from func4
	::call:func4 blue & (
	::	(goto) 2>nul
	::	call echo 0 = %%~0
	::	echo returned from func4
	::)
goto:eof

:func4
	echo :func4 %*
	call:func5 orange
	echo returned from func5
goto:eof

:func5
	echo :func5 %*
<:dk_dumpStackReturn <nul call dk_dumpStack
	echo returned from dk_dumpStack dumpstack_caller
goto:eof
