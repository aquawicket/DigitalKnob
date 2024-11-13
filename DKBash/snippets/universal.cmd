:<<"::UNIX"
@ECHO OFF
GOTO windows


::UNIX
echo "This universal script is running on Unix"
exit $?


:windows
ECHO This universal script is running on Windows
pause
