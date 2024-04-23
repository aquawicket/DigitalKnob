@echo off

::###### Load Function files ######
call ../functions/DK.cmd


:: dk_cmakeEval(<cmake_commands;.;.;> <return_variables;.;.;.> <-DVARS;.;.;>)
call dk_cmakeEval "dk_clearScreen()"


call dk_pause