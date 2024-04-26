@echo off

::####################################################################
::# test_cmake_dk_warning.cmd
::#
::#
::###### DK_Init ######
call ../functions/DK.cmd

call dk_cmakeEval "dk_warning('test dk_warning message');dk_info('...next line...')"

call dk_pause