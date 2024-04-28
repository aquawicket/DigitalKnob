@echo off

::####################################################################
::# test_dk_error.cmd
::#
::#
::###### DK_Init ######
call "../functions/DK.cmd"

call dk_debugFunc

echo "calling dk_error from test_dk_error.cmd"
call dk_error "test dk_error message"
echo "...next line..."

call dk_exit
