:: https://stackoverflow.com/a/18869970
:: Read lines of a file into an array and echo them back
@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

set "file=ServiceList.txt"
set /A i=0

for /F "usebackq delims=" %%a in ("%file%") do (
set /A i+=1
::call echo %%i%%
call set array[%%i%%]=%%a
call set n=%%i%%
)

for /L %%i in (1,1,%n%) do call echo %%array[%%i]%%
