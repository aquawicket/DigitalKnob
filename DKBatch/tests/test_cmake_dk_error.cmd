@echo off

::####################################################################
::# test_cmake_dk_error.cmd
::#
::#
::###### DK_Init ######
call ../functions/DK.cmd

call dk_cmakeEval "dk_error('test dk_error message');dk_info('...next line...')"

call dk_pause