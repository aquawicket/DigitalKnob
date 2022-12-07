:<<"::CMDLITERAL"
@ECHO OFF
GOTO :WINDOWS
::CMDLITERAL

echo "This universal script is running on Unix"
if :; then
  echo "This makes conditional constructs so much easier because"
  echo "they can now span multiple lines."
fi
exit $?

:WINDOWS
ECHO This universal script is running on Windows