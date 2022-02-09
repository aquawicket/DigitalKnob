::%DKBATCH%
set "REQUIRED_1=if [%1]==[] echo [91m	%~n0(%*): argument 1 is invalid [0m & goto :EOF"
set "REQUIRED_2=if [%2]==[] echo [91m	%~n0(%*): argument 2 is invalid [0m & goto :EOF"
set "REQUIRED_3=if [%3]==[] echo [91m	%~n0(%*): argument 3 is invalid [0m & goto :EOF"

%REQUIRED_1%
%REQUIRED_2%
%REQUIRED_3%

set /A array_length=0
endlocal & (for %%a in (%~1) do (
    set "%2[!array_length!]=%%a"
	set /A array_length+=1
	set "%3=!array_length!"
))