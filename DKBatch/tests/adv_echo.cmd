@echo off

:main
setlocal enableDelayedExpansion



::############### Special Characters ###############
	      ::ALL: "   !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~"
      ::INVALID: "   !"  %                           "
        ::VALID: "     #$ &'()*+,-./:;<=>?@[\]^_`{|}~"

call :printSpecial "      #$ &'()*+,-./:;<=>?@[\]^_`{|}~"

setlocal disableDelayedExpansion
call :printSpecial "    ! #$ &'()*+,-./:;<=>?@[\]^_`{|}~"
endlocal

call :printSpecial ""     "#$ &'()*+,-./:;<=>?@[\]^_`{|}~"

pause

:printSpecial
	echo(
	echo(%*
	set message=%*
	for /f "tokens=1* delims==" %%a in ('set message') do (echo(%%~b)
exit /b 0
