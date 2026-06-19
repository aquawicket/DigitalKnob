@echo off
if not defined returnVar call :loadMacro&exit /b
if "%~1" neq ":returnDisabled" exit /b %2
setlocal enableDelayedExpansion
set "rtn=!%2!"
set "rtn=!rtn:%%=%%3!"
set "rtn=!rtn:""n=%%~L!"
set "rtn=!rtn:""r=%%4!"
set "rtn=!rtn:""q=%%~5!"
for /f "tokens=1-4" %%3 in (^"%% !CR! """") do (
  endlocal
  set "%2=%rtn:~1%"
  exit /b %%X
)


:loadMacro
if "!" equ "" (
  >2 echo ERROR: Delayed expansion must be off when loading the returnVar macro.
  exit /b 1
)
set LF=^


set ^"\n=^^^%LF%%LF%^%LF%%LF%^^"
for /F "usebackq delims= " %%C in (`copy /z "%~f0" nul`) do set "CR=%%C"

set ^"returnVar=for %%# in (1 2) do if %%#==2 (setlocal enableDelayedExpansion%\n%
for /f "tokens=1-4" %%1 in ("!returnVar.args!") do (%\n%
  set "rtn=x!%%2!"%\n%
  set /a "err=!errorlevel!, local=1"%\n%
  for %%A in ("%%~3" "%%~4") do if %%A neq "" set /a "%%~A"%\n%
  set /a "local+=1"%\n%
  for /f %%R in ("!CR!!CR!") do for %%L in ("!LF!") do for %%X in (!err!) do (%\n%
    set ^"rtn=!rtn:"=""q!"%\n%
    set "rtn=!rtn:%%R=""r!"%\n%
    set "rtn=!rtn:%%~L=""n!"%\n%
    set "rtnDis=!rtn!"%\n%
    set "rtn=!rtn:^=^^!"%\n%
    set "path="%\n%
    set "pathExt=;"%\n%
    call set "rtn=%%rtn:^!=""c^!%%"%\n%
    set "rtn=!rtn:""c=^!"%\n%
    for /f "delims=" %%D in (""!rtnDis!"") do for /f "delims=" %%E in (""!rtn!"") do (%\n%
      for /l %%n in (1 1 !local!) do endlocal%\n%
      if "!"=="" (%\n%
        set "%%1=%%~E" !%\n%
        set "%%1=!%%1:""n=%%~L!"%\n%
        set "%%1=!%%1:""r=%%R!"%\n%
        set ^"%%1=!%%1:""q="!"%\n%
        set "%%1=!%%1:~1!"%\n%
        if "%%X" equ "0" (call ) else if "%%X" equ "1" (call) else call "%~f0" :exitErr %%X%\n%
      ) else (%\n%
        set "%%1=%%~D"%\n%
        call "%~f0" :returnDisabled %%1%\n%
      )%\n%
    )%\n%
  )%\n%
)) else set returnVar.args="

exit /b 0