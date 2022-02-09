%DKBATCH%

::%REQUIRED_1%
::%REQUIRED_2%
::%REQUIRED_3%


::set /A array_length=0
endlocal & (for %%a in (%~1) do (
	if not defined array_length set /A array_length=0
	if defined %3 set "%3="
    set "%2[!array_length!]=%%a"
	set /A array_length+=1
	set "%3=!array_length!"
))

%DKEND%