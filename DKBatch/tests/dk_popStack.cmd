::https://stackoverflow.com/a/11576816

set "func=%~0"
for /F "delims=\" %%X in ("%func:*\=%") do set "func=%%X"
if ":" == "%func:~0,1%" ( goto %func% )

:dk_popStack
	setlocal DisableDelayedExpansion
	
	set "runner=(goto) 2>nul"
	set "runner=%runner% & call echo frame = %%~0"
	set "runner=%runner% & call echo self = %~0"
	set "runner=%runner% & call set frame=%%~0"	
	set "runner=%runner% & (if [%frame%]==[%%~0] (call ) else (call))"
	set "runner=%runner% && (call %~d0\:call_return\..%~pnx0)"
	set "runner=%runner% || (if [%frame%] NEQ [] (call ))"
	set "runner=%runner% && (set frames=%frames% %frame%)"

	set "runner=%runner% && %runner% && %runner% && %runner% && %runner% && %runner% && %runner% && echo frames = %frames%"
	
	echo "runner = %runner%"
	%runner%
	::%thingie% && %thingie% && %thingie% && %thingie% && %thingie% && %thingie% && %thingie% & call "%~d0\:call_return\..%~pnx0"
goto:eof



:call_return
	echo :call_return
	call :dk_popStackReturn
goto:eof

:dk_popStackReturn
	echo :dk_popStackReturn
	endlocal
	test_callStackB
goto:oef