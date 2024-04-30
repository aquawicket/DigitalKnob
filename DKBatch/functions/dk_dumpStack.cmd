@echo off
::call dk_includeGuard
::call DK

::https://stackoverflow.com/a/11576816

set "func=%~0"
for /F "delims=\" %%X in ("%func:*\=%") do set "func=%%X"
if ":" == "%func:~0,1%" ( goto %func% )

if not defined frame (set /a frame=0)

:dk_dumpStack
(	
	setlocal DisableDelayedExpansion
	if %frame% NEQ 0 (goto) 2>nul
    
	set "frame=%frame%"
	set "_returnVar=%~1"

	call set "caller=%%~0"
	call set "caller.fullpath=%%~f0"
	call set "caller.directory=%%~dp0"
	call set "caller.filename=%%~nx0"
	call set "caller.func=%%~n0"
	call set "caller.args=%%*"
	call set "caller[%frame%]=%%~0"
	call set "caller[%frame%].fullpath=%%~f0"
	call set "caller[%frame%].directory=%%~dp0"
	call set "caller[%frame%].filename=%%~nx0"
	call set "caller[%frame%].func=%%~n0"
	call set "caller[%frame%].args=%%*"
	
	echo caller                         = %caller%
	echo caller.fullpath                = %caller.fullpath%
	echo caller.directory               = %caller.directory%
	echo caller.filename                = %caller.filename%
	echo caller.func                    = %caller.func%
	echo caller.args                    = %caller.args%
	call echo caller[%frame%]           = %%caller[%frame%]%%
	call echo caller[%frame%].fullpath  = %%caller[%frame%].fullpath%%
	call echo caller[%frame%].directory = %%caller[%frame%].directory%%
	call echo caller[%frame%].filename  = %%caller[%frame%].filename%%
	call echo caller[%frame%].func      = %%caller[%frame%].func%%
	call echo caller[%frame%].args      = %%caller[%frame%].args%%
	
	call set _caller=%%caller[%frame%].fullpath:*%%~f0=%%
	echo _caller                        = %_caller%
	
	if "%caller%"=="" (
 		setlocal DisableDelayedExpansion
		(goto) 2>nul
		set /a frame+=1
		call "%~d0\:dk_dumpStack\..%~pnx0" %*
	) else if "%caller%" NEQ "%caller.func%" (
 		setlocal DisableDelayedExpansion
		(goto) 2>nul
		set /a frame+=1
		call "%~d0\:dk_dumpStack\..%~pnx0" %*
	) else if defined _caller (
        set "caller[%frame%].type=batch"
        call "%~d0\:call_return\..%~pnx0" %*
    ) else (
        set "caller[%frame%].type=cmd-line"
        cmd /c "call "%~d0\:call_return\..%~pnx0" %*"
    )
	endlocal
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





:::DKTEST ::#####################################################################################################
::call dk_dumpStack
:::dk_dumpStackReturn 
::call dk_exit