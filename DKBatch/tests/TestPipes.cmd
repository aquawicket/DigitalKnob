@echo off
setlocal
if /i "%~1"=="/WorkerPipe" goto :/WorkerPipe
if /i "%~1"=="/ReadPipe" goto :/ReadPipe
if /i "%~1"=="/WritePipe" goto :/WritePipe
if /i "%~1"=="/PipeToSelf" goto :/PipeToSelf
cmd /d /c @"%~f0%" /ReadPipe
cmd /d /c @"%~f0%" /WritePipe
cmd /d /c @"%~f0%" /PipeToSelf
pause
exit /b


:: Access pipe by the parent cmd process
:: This can be done only with explicit external processes
:: So CMD commands must be wrapped by cmd /c

:: Process1 | Process2
:: At the time of creating left hand process, the state of cmd handles are as follows
:: &0=Unaltered
:: &1=Pipe Output
:: &2=Unaltered
:: &3=Pipe Input
:: &4=UNDEFINED
:: &5=Original value of &1

:: The left hand process will be created in suspended state
:: It inherit it standard handles (&0 &1 &2) from CMD

:: After creating left hand process in suspended state,
:: The hanldes will be restored to their original value,
:: Or remain redirected if permanent redirection was applied when creating left hand process
:: this can affect the handles which the right hand process inherits.
:: Then the right hand process will be created in suspended state

:: At the time of creating righ hand process, the state of cmd handles are as follows
:: &0=Pipe Input
:: &1=Unaltered
:: &2=Unaltered
:: &3=UNDEFINED
:: &4=Original value of &0

:: The right hand process will be created in suspended state
:: It inherit it standard handles (&0 &1 &2) from CMD

:: CMD itself closes the handles to the both sides of the pipes which have been inherited by its childs.
:: Then both processes will be resumed


:: Examples

:: <Reading from pipe>

:/ReadPipe
echo ---------------------------
echo Read from pipe demo
echo ---------------------------

setlocal EnableDelayedExpansion
set "LF="

:: Permanently redirect stdin to pipe input
cmd /d /u /c "echo.&echo." 0>&3 4>&0 | break

:: Now reading from pipe
pause>nul
pause>nul
set /p "LF="

echo LF test:
echo First Line!LF!Second Line

:: Restore stdin
break 0>&4 3>&0
pause
echo findstr test:

:: The file handles &3 and &4 are now pointing to original stdin &0

cmd /d /c start /b cmd /d /c type "%~f0" 0>&5 6>&0 | break
findstr "^::"
break 0>&6 5>&0
pause
endlocal
exit /b
:: </Reading from pipe>



:: <Writing to pipe>

:/WritePipe

echo ---------------------------
echo Write to pipe demo
echo ---------------------------

:: Because permanent redirecton of stdout (&1) the right hand pipe will inherit the pipe output handle in its process
:: This creates a loop to itself so another stdout must be explicitly specified for it
:: But the risk of dead lock remains. if some program holds stdin until the other side is signaled. (findstr for example)
:: Because it has inherited the handle to read pipe too.

cmd /c "break" 5>&1 4>&5 | cmd /c start /b cmd /c "%~f0" /WorkerPipe 1>&4


timeout /t 1 /nobreak >nul
echo echo Comming directly from parent process (The pipe initiator)
timeout /t 1 /nobreak >nul
echo echo waiting for 5 seconds...
timeout /t 1 /nobreak >nul
echo cmd /c ping -n 6 127.0.0.1 ^>nul
timeout /t 1 /nobreak >nul
echo exit

ping -n 6 127.0.0.1

exit /b
:: </Writing to pipe>


exit /b
:/WorkerPipe
setlocal EnableDelayedExpansion
echo Worker Thread listening for commands from pipe
for /L %%A in (0,0,1) do (
    echo,
    echo Waiting for command...
    set /p "cmd="
    echo Recieved command: !cmd!
    echo Executing...
    !cmd!
)


:: <Pipe to self>

:/PipeToSelf

echo ---------------------------
echo Pipe to self demo
echo ---------------------------

cmd /d /c break 0>&3 4>&0 5>&1 7>&5 | break

set "MyEcho=echo This will be saved in to the variable 'MyVar' just by echoing it!"

echo executing: %MyEcho% >&7
%MyEcho%
set /p "MyVar="
set MyVar >&7
exit /b

:: </Pipe to self>