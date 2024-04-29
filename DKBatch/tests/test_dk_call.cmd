@echo off

::###### Load Function files ######
call ../functions/DK.cmd

call dk_call dk_info "test message using dk_call"

call dk_exit