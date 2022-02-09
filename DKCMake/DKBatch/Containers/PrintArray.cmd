::%DKBATCH%

set "arry=%~1"
set /A "n=0"
:loop1 
if defined %arry%[%n%] ( 
   echo !%arry%[%n%]!
   set /A n+=1
   goto :loop1 
)
echo %arry% length = %n%