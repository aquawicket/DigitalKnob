@echo off

::####################################################################
::# test_dk_validateCmake.cmd
::#
::#
::###### DK_Init ######
call "../functions/DK.cmd"

call dk_validateCmake

call dk_pause