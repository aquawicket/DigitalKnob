@echo off
setlocal DisableDelayedExpansion
REM *** Thread redirector 
for /F "tokens=3 delims=:" %%F in ("%~0") do goto %%F

REM *** Clear params.tmp
break > params.tmp

start "" /b cmd /k @"%~d0\:StayAlive:\..\%~pnx0" "params.tmp"



setlocal EnableDelayedExpansion

:: Detect available handles without displaying error messages
:: Continue only if there is at least 3(2) unused handles. (One is used by stderr redirection)
call :enumIO
:: One of the handles was used by redirection of stderr
:: So we only need 2 additional free handles to continue.
if %freeSlots% LSS 2 (
    echo Not enough IO Slots.
    exit /b
)

:: First , do the permanent redirection of stderr. We don't have to know the backup handle.
:: The order of redirection is critical: stderr ---> freeSlots ---> usedSlots
set "stderr_permanent=break 2>nul"
for /L %%A in (%freeSlots%,-1,1) do set "stderr_permanent=!stderr_permanent! !freeIO[%%A]!>&2"
for /L %%A in (%usedSlots%,-1,1) do set "stderr_permanent=!stderr_permanent! !usedIO[%%A]!>&2"
%stderr_permanent%

echo One of the 'usedIO's is occupied by redirection of stderr
echo If there is more than one, then we don't which, And no need to know
echo Only CMD knows, This is the part that enables us to prevent the error message
echo This reminds me of Quantum uncertainty principle :)
echo,
set freeIO[
set usedIO[
set stderr_permanent


:: Next do a permanent redirection of stdout and stdin by known free handles.
(
    endlocal & endlocal %= To preserve prompt value after fatal error =%
    prompt #
    echo on >params.tmp 0>nul %freeIO[1]%>&1 %freeIO[2]%>&1
)
()%*

REM Unreachable

:enumIO
for /F "delims==" %%A in ('"(set freeIO[ & set usedIO[)2>nul"') do set "%%A=" // for displaying purposes

set /a "freeSlots=usedSlots=0"
2>nul (
    for /L %%A in (3,1,8) do call :nextIO 9 %%A
)
:: If non of the handles 4 to 8 are free then there are three possibilities for handle 9
:: 1. It is occupied before us, then we MAY have one free handle which is occupied by redirection of 9
:: 2. It is occupied by redirection of stderr, then we have no free handles
:: 3. It is free, then have only one free handle which is handle 9
:: either way we don't have the required free handles (2 handles)
if %freeSlots% NEQ 0 2>nul call :nextIO 1 9
if %freeSlots% NEQ 0 2>nul (
    set /a "highUsed=usedIO[%usedSlots%]"
    if "!highUsed!"=="9" (
        set /a "highFree=freeIO[%freeSlots%], highUsed=highFree+1"
        for /F "delims==" %%A in ('"(set freeIO[ & set usedIO[)2>nul"') do set "%%A=" // for displaying purposes
        set /a "freeSlots=usedSlots=0"
        for /L %%A in (3,1,!highFree!) do call :nextIO !highFree! %%A
        for /L %%A in (!highUsed!,1,9) do (
            set /a "usedSlots+=1"
            set "usedIO[!usedSlots!]=%%A"
        )
    )
)
exit /b
:nextIO
break %1>&%2 && (
    set /a "usedSlots+=1"
    set "usedIO[!usedSlots!]=%2"
    (call,)
) || (
    set /a "freeSlots+=1"
    set "freeIO[!freeSlots!]=%2"
)
exit /b


REM *** Second thread to fetch and show the parameters
:StayAlive

:__WaitForParams
if %~z1 EQU 0 (
    goto :__WaitForParams
)
REM *** Show the result
findstr /n "^" %1
echo,