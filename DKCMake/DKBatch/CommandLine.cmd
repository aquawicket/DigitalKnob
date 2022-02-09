%DKBATCH%

:enter_command
echo Enter a command:
set /p command=

call ListToArray "%command%" command_arry length
call PrintArray command_arry
call DeleteArray command_arry
set "length="


:::::::::::::::::::::::::
set "command="
goto :enter_command
:end
%DKEND%