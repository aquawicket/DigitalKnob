@ECHO OFF

echo.
echo.1:
echo.   ...finding 'ERROR' in logfile.log
find "ERROR" logfile.log>NUL && (
    echo.   yes, "ERROR" in logfile
)

echo.
echo.2:
echo.   ...finding 'ERROR' in logfile.log
find "ERROR" logfile.log>NUL || (
    echo.   no "ERROR" in logfile
)

echo.
echo.3:
set "v=old_value"
set /p "v=   ...enter a value or just hit ENTER: " && (
    echo.   The user entered a value, the variable v changed.
) || (
    echo.   The user just hit Enter, the variable v remains unchanged.
)
echo.   v is now: %v%