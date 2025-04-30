::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:Line <xReturn> <xUniqueID> [xOffset]
:: Find and return the line number of the unique id adjusted by the optional offset.
:: Returns -1 in the case of an error or the unique id is not found in the file.
:: Note: The unique id cannot contain backslashes and MUST have spaces on each side.
:: Note: Change " %~2 " into " %~2" to only require a space before the unique id.
setlocal
set "xLine=-1"
for /f "usebackq tokens=1 delims=:" %%i in (`findstr /n /c:" %~2 " "%~f0"`) do set /a xLine=%~3 + %%i
endlocal & if "%~1" neq "" (set "%~1=%xLine%")
goto:eof
:: by David Ruhmann