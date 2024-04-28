@echo off

::####################################################################
::# test_dk_showFileLine.cmd
::#
::#
::###### DK_Init ######
call "../functions/DK.cmd"

call dk_showFileLine "../../README.md" "How to build"

call dk_exit