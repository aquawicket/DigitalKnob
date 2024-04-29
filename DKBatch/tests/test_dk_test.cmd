@echo off

::###### Load Function files ######
call "../functions/DK.cmd"

call dk_test "called from test_dk_test.sh"

call dk_exit