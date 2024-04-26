@echo off

::####################################################################
::# test_cmake_dk_pause.cmd
::#
::#
::###### DK_Init ######
call ../functions/DK.cmd

call dk_cmakeEval "dk_pause()"

::call dk_pause