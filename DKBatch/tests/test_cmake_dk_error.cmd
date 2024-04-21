@echo off

::###### Load Function files ######
call ../functions/DK.cmd


:: dk_cmake_eval(<cmake_commands;.;.;> <return_variables;.;.;.> <-DVARS;.;.;>)
call dk_cmake_eval "dk_error('test dk_error message');dk_info('...next line...')"


call dk_pause