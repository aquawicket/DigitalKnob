@REM....&SETLOCAL ENABLEEXTENSIONS&SETLOCAL DISABLEDELAYEDEXPANSION
@REM....&set /p s=FileSearch, type '-' to refresh lookup list: ||GOTO:EOF
@REM....&if .%s% NEQ .- echo.&findstr %s% "%~f0"&PAUSE&GOTO:EOF
@REM....&findstr /b /c:"@REM....&" "%~f0">"%~f0.txt"
@REM....&dir /s/b c:\ 1>>"%~f0.txt"&move /Y "%~f0.txt" "%~f0"
@REM....&GOTO:EOF