@echo off

::####################################################################
::# test_dk_debug.cmd
::#
::#
::###### DK_Init ######
call "../functions/DK.cmd"

call dk_debug "test dk_debug message"
call dk_info "...next line..."

call dk_pause