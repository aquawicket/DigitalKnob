@echo off

::###### Load Function files ######
call "../functions/DK.cmd" %0 %*
::call dk_keep_console_open %0 %*
::call dk_color
::call dk_echo

echo "This is a normal echo commmand"
call dk_echo "This is a dk_echo line"
call dk_echo "%cyan% This is dk_echo with color %clr%"
pause