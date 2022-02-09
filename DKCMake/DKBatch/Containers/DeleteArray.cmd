%DKBATCH%

set /A "n=0"
:loop1 
if defined %~1[%n%] ( 
   set /A n+=1
   goto :loop1 
)

endlocal & (for /L %%G IN (0,1,!n!) do (
	if not defined count set /A count=0
	set "%1[!count!]="
	set /A count+=1
))

%DKEND%