@echo off
setlocal enableDelayedExpansion
set "var=Parent Value"
(
  call :test
  echo This and the following line are not executed
  exit /b
)
:break
echo How did I get here^^!^^!^^!^^!
pause

:test
setlocal disableDelayedExpansion
set "var=Child Value"
(goto) 2>nul & echo var=!var! & goto :break
echo This line is not executed

:break
echo This line is not executed

