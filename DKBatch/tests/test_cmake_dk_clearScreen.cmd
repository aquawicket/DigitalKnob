@echo off

::####################################################################
::# test_cmake_dk_clearScreen.cmd
::#
::#
::###### DK_Init ######
call ../functions/DK.cmd

call dk_cmakeEval "dk_clearScreen()"

call dk_pause