@echo off

::####################################################################
::# test_cmake_dk_debug.cmd
::#
::#
::###### DK_Init ######
call ../functions/DK.cmd

call dk_cmakeEval "dk_debug('test dk_debug message');dk_info('...next line...')"

call dk_pause