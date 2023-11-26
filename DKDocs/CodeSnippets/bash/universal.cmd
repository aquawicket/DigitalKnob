:<<"::UNIX"
@ECHO OFF
GOTO :WINDOWS


::UNIX
echo "This universal script is running on Unix"
exit $?


:WINDOWS
ECHO This universal script is running on Windows
