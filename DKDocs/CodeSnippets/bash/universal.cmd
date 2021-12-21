:<<"::CMDLITERAL"
@ECHO OFF
GOTO :CMDSCRIPT
::CMDLITERAL

echo "I can write free-form ${SHELL} now!"
if :; then
  echo "This makes conditional constructs so much easier because"
  echo "they can now span multiple lines."
fi
exit $?

:CMDSCRIPT
ECHO Welcome to %COMSPEC%