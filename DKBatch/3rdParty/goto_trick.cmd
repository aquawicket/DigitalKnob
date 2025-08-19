@echo off
setlocal enableDelayedExpansion
set "var=Parent Value"
(
  call :test
  echo This and the following line are NOT executed
  goto:eof
)
:break
echo How did I get here^^!^^!^^!^^!
pause

:test
setlocal disableDelayedExpansion
set "var=Child Value"
(goto) 2>nul & echo var=!var! & goto :break
echo This line is NOT executed

:break
echo This line is NOT executed

