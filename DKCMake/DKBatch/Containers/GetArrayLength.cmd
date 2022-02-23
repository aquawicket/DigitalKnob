%dkbatch%

set "array_name=%~1"
set "array_length=0"
:arrayCountLoop
if defined %array_name%[%array_length%] ( 
   set /a "array_length+=1"
   goto :arrayCountLoop 
)

echo %array_length%
set /a %0=%array_length% 
 
%DKEND% 
