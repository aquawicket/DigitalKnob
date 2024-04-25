@echo off


::###### Load Function files ######
call "../functions/DK.cmd"
call dk_debugFunc

echo "calling dk_error from test_dk_error.cmd"
call dk_error "test dk_error message"
call dk_info "...next line..."

dk_pause
