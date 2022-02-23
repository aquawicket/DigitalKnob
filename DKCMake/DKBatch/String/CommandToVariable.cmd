%dkbatch%

setlocal ENABLEDELAYEDEXPANSION
set "command=%~1"
echo command = %command%
set count=0
for /F "tokens=* USEBACKQ" %%F IN (%command%) DO (
  SET "command_output_array[!count!]=%%F"
  SET /a count=!count!+1
)

call ArrayToList command_output_array
echo list is %ArrayToList% 

set "%0=%ArrayToList%"

%DKEND% 
