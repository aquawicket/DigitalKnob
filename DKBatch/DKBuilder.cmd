@echo off

echo "cls" && cls

::###### Load DK Function files ######
call functions/DK.cmd

::### Load Main Program ###

::#if ! [[ "$@" == "" ]]; then
::#	"$@"
::#fi

dk_build_main "%*"