@echo off    
call :define_macro

setlocal EnableDelayedExpansion
set var=content

%+@% ver
%+@% ver /?
%+@% echo %var% !var!
::ALL    !""#$%%&'()*+,-./:;<=>?@[\]^_`{|}~
%+@%        #$ &'()*+,-./:;<=>?@[\]^_`{|}~
%+@%        #$%%&'()*+,-./:;<=>?@[\]^_`{|}~
pause
%+@%      ""#$%%&'()*+,-./:;<=>?@[\]^_`{|}~
pause
%+@%     !""#$%%&'()*+,-./:;<=>?@[\]^_`{|}~
::ALL    !""#$%%&'()*+,-./:;<=>?@[\]^_`{|}~
pause
exit /b

:define_macro
(set \n=^^^

)
set ^"+@=for %%# in (1 2) do if %%#==2 (%\n%
    setlocal EnableDelayedExpansion%\n%
	echo(!argv:~2!%\n%
rem for /F "tokens=*" %%a in ("!argv!") do (%\n%
rem        endlocal%\n%
rem        echo(%%~a%\n%
rem        endlocal%\n%
rem   )%\n%
) ELSE setlocal DisableDelayedExpansion ^& set argv=""

exit /b