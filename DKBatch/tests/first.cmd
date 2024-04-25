@echo off
set caller=empty
echo This is %~0

::for /L %%n in (1 1 3) do (
::    echo(
::    echo #1 before calling, n=%%n
::    call second %%n
::)

call dkdebugfunc

echo Back to %~0
pause