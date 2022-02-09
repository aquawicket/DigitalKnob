%DKBATCH%

:enter_command
echo Enter a command:
set /p command=

call ListToArray "%command%" command_arry length

echo command_arry[0] = %command_arry[0]%
echo command_arry[1] = %command_arry[1]%
echo command_arry[2] = %command_arry[2]%
echo command_arry[3] = %command_arry[3]%
echo command_arry length = %length%

::call PrintArray %command_arry%

:::::::::::::::::::::::::
goto :enter_command
:end
%DKEND%