@echo off

::####################################################################
::# test_cmake_dk_todo.cmd
::#
::#
::###### DK_Init ######
call ../functions/DK.cmd

call dk_cmakeEval "dk_todo('test dk_todo message');dk_info('...next line...')"

call dk_pause