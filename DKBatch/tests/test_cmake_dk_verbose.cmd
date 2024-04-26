@echo off

::####################################################################
::# test_cmake_dk_verbose.cmd
::#
::#
::###### DK_Init ######
call ../functions/DK.cmd

call dk_cmakeEval "dk_verbose('test dk_verbose message');dk_info('...next line...')"

call dk_pause