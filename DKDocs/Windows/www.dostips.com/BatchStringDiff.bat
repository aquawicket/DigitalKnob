@ECHO OFF
REM See also https://en.wikipedia.org/wiki/Longest_common_subsequence_problem

set "x= XMJYAUZU"
set "y= MZJAWXU"

echo.String1=%x%
echo.String2=%y%

call:strUBound x
call:strUBound y
call:removeArr ar


SETLOCAL ENABLEDELAYEDEXPANSION
for /l %%I in (0,1,%x.len%) do set "ar[%%I][0]=0"
for /l %%J in (1,1,%y.len%) do set "ar[0][%%J]=0"
for /l %%I in (1,1,%x.len%) do (
    for /l %%J in (1,1,%y.len%) do (
        set /a "Ii=%%I-1"
        set /a "Jj=%%J-1"
        if "!x:~%%I,1!"=="!y:~%%J,1!" (
            call set /a "ar[%%I][%%J]=ar[!Ii!][!Jj!]+1"
        ) ELSE (
            call:max ar[%%I][%%J] ar[%%I][!Jj!] ar[!Ii!][%%J]
)   )   )

call:printDiff %x.len% %y.len% ar "%x%" "%y%"
call:dumpArr2 ar %x.len% %y.len%
pause
GOTO:EOF


:printDiff i, j, C[0..m,0..n], X[1..m], Y[1..n]
SETLOCAL ENABLEDELAYEDEXPANSION
set "I=%~1"
set "J=%~2"
set "ar=%~3"
set "x=%~4"
set "y=%~5"
set /a "Ii=I-1"
set /a "Jj=J-1"
set "else1=Y"
if %I% GTR 0 if %J% GTR 0 if "!x:~%I%,1!"=="!y:~%J%,1!" (
    set "else1="
    call:printDiff %Ii% %Jj% ar "%x%" "%y%" 
    echo.= !x:~%I%,1!
)
if defined else1 (
    set "else2=Y"
    if %J% GTR 0 (
        set "or1="
        if %I%==0 set "or1=Y"
        if !%ar%[%I%][%Jj%]! GEQ !%ar%[%Ii%][%J%]! set "or1=Y"
        if defined or1 (
            set "else2="
            call:printDiff %I% %Jj% ar "%x%" "%y%"
            echo.+ !y:~%J%,1!
        )
    )
    if defined else2 (
        if %I% GTR 0 (
            set "or1="
            if %J%==0 set "or1=Y"
            if !%ar%[%I%][%Jj%]! LSS !%ar%[%Ii%][%J%]! set "or1=Y"
            if defined or1 (
                call:printDiff %Ii% %J% ar "%x%" "%y%"
                echo.- !x:~%I%,1!
            )
        )
    )
)
GOTO:EOF


:max retval refval1 refval2
SETLOCAL
set /a "a=%~2"
set /a "b=%~3"
if %a% LSS %b% set /a "a=b"
(ENDLOCAL & IF "%~1" NEQ "" (SET %~1=%a%) ELSE ECHO.%a%)
GOTO:EOF


:strUBound refval -- returns the number of characters in a string
for /f "delims=:" %%A in ('"(call echo.%%%~1%%&echo.)|findstr /o "$""') do set /a "%~1.len=%%A-4"
GOTO:EOF


:removeArr arr -- remove an array
::             -- arr [in]  - array name
:$source https://www.dostips.com
for /f "delims==" %%a in ('"set %~1[ 2>NUL"') do set "%%a="
EXIT /b


:dumpArr2 arr i j -- dump array content, two dimensional
::                -- arr [in] - array name
::                -- i   [in] - size of first dimension
::                -- j   [in] - size of second dimension
:$source https://www.dostips.com
SETLOCAL
for /l %%I in (0,1,%2) do (
    set "ln="
    for /l %%J in (0,1,%3) do (
        call set "v=    %%%~1[%%I][%%J]%%"
        call set "ln=%%ln%%%%v:~-1%%"
    )
    call echo.%%ln%%
)
EXIT /b
