@echo off

::####################################################################
::# test_bell.cmd
::#
::#
::###### DK_Init ######
call "../functions/DK.cmd"

call dk_hexToVariable BEL 0x07
call dk_echo %BEL%
call dk_echo "If you heard a bell type sound, this is working."

call dk_pause
