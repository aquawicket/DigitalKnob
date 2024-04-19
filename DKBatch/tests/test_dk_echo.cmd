@echo off

::###### Load Function files ######
call "../functions/DK.cmd"

echo "This is a normal echo commmand"
call dk_echo "This is a dk_echo line"
call dk_echo "%cyan% This is dk_echo with color %clr%"



pause
