@ECHO OFF
if "%~1"=="/?" (
    echo.Sorts text by handling first number in line as number not text
    echo.
    echo.%~n0 [n]
    echo.
    echo.  n     Specifies the character number, n, to
    echo.        begin each comparison.  3 indicates that
    echo.        each comparison should begin at the 3rd
    echo.        character in each line.  Lines with fewer
    echo.        than n characters collate before other lines.
    echo.        By default comparisons start at the first
    echo.        character in each line.
    echo.
    echo.Description:
    echo.        'abc10def3' is bigger than 'abc9def4' because
    echo.        first number in first string is 10
    echo.        first number in second string is 9
    echo.        whereas normal text compare returns 
    echo.        'abc10def3' smaller than 'abc9def4'
    echo.
    echo.Example:
    echo.        To sort a directory pipe the output of the dir
    echo.        command into %~n0 like this:
    echo.           dir /b^|%~n0
    echo.
    echo.Source: https://www.dostips.com
    goto:EOF
)
if "%~1" NEQ "~" (
    for /f "tokens=1,* delims=," %%a in ('"%~f0 ~ %*|sort"') do echo.%%b
    goto:EOF
)
SETLOCAL ENABLEDELAYEDEXPANSION
set /a n=%~2+0
for /f "tokens=1,* delims=]" %%A in ('"find /n /v """') do (
    set f=,%%B
    (
        set f0=!f:~0,%n%!
        set f0=!f0:~1!
        rem call call set f=,%%%%f:*%%f0%%=%%%%    
        set f=,!f:~%n%!
    )
    for /f "delims=1234567890" %%b in ("!f!") do (
        set f1=%%b
        set f1=!f1:~1!
        call set f=0%%f:*%%b=%%
    )
    for /f "delims=abcdefghijklmnopqrstuwwxyzABCDEFGHIJKLMNOPQRSTUWWXYZ~`@#$*_-+=:;',.?/\ " %%b in ("!f!") do (
        set f2=00000000000000000000%%b
        set f2=!f2:~-20!
        call set f=%%f:*%%b=%%
    )
    echo.!f1!!f2!!f!,%%B
    rem echo.-!f0!*!f1!*!f2!*!f!*%%a>&2
)
