@echo off

::###### Load Function files ######
call ../functions/DK.cmd


:: dk_cmakeEval(<cmake_commands;.;.;> <return_variables;.;.;.> <-DVARS;.;.;>)
call dk_cmakeEval "dk_todo('test dk_todo message');dk_info('...next line...')"


call dk_pause