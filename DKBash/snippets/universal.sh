:<<"::UNIX"
@ECHO OFF
GOTO :WINDOWS


::UNIX
echo "This universal script is running on Unix"
read -p "Press any key to continue ..."
exit $?


:WINDOWS
ECHO This universal script is running on Windows
pause
exit