@echo off

::####################################################################
::# test_dk_error.cmd
::#
::#
::###### DK_Init ######
call "../functions/DK.cmd"

call dk_debugFunc

call dk_debug test putting a function on the stack

echo.
call dk_stacktrace
echo.

call dk_exit