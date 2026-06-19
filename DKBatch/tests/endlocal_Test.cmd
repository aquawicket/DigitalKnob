@echo off
setlocal DisableDelayedExpansion
set LF=^


set ^"\n=^^^%LF%%LF%^%LF%%LF%^^"
%=   I use EDE for EnableDelayeExpansion and DDE for DisableDelayedExpansion =%
set ^"endlocal=for %%# in (1 2) do if %%#==2 (%\n%
   setlocal EnableDelayedExpansion%\n%
 %=       Take all variable names into the varName array       =%%\n%
   set varName_count=0%\n%
   for %%C in (!args!) do set "varName[!varName_count!]=%%~C" ^& set /a varName_count+=1%\n%
 %= Build one variable with a list of set statements for each variable delimited by newlines =%%\n%
 %= The lists looks like --> set result1=myContent\n"set result1=myContent1"\nset result2=content2\nset result2=content2\n     =%%\n%
 %= Each result exists two times, the first for the case returning to DDE, the second for EDE =%%\n%
 %= The correct line will be detected by the (missing) enclosing quotes  =%%\n%
   set "retContent=1!LF!"%\n%
   for /L %%n in (0 1 !varName_count!) do (%\n%
      for /F "delims=" %%C in ("!varName[%%n]!") DO (%\n%
         set "content=!%%C!"%\n%
         set "retContent=!retContent!"set !varName[%%n]!=!content!"!LF!"%\n%
         if defined content (%\n%
 %=      This complex block is only for replacing '!' with '^!'      =%%\n%
 %=    First replacing   '"'->'""q'   '^'->'^^' =%%\n%
         set ^"content_EDE=!content:"=""q!"%\n%
         set "content_EDE=!content_EDE:^=^^!"%\n%
 %= Now it's poosible to use CALL SET and replace '!'->'""e!' =%%\n%
         call set "content_EDE=%%content_EDE:^!=""e^!%%"%\n%
         %= Now it's possible to replace '""e' to '^', this is effectivly '!' -> '^!'  =%%\n%
         set "content_EDE=!content_EDE:""e=^!"%\n%
         %= Now restore the quotes  =%%\n%
         set ^"content_EDE=!content_EDE:""q="!"%\n%
         ) ELSE set "content_EDE="%\n%
         set "retContent=!retContent!set "!varName[%%n]!=!content_EDE!"!LF!"%\n%
      )%\n%
   )%\n%
 %= Now return all variables from retContent over the barrier =%%\n%
   for /F "delims=" %%V in ("!retContent!") DO (%\n%
 %= Only the first line can contain a single 1 =%%\n%
      if "%%V"=="1" (%\n%
 %= We need to call endlocal twice, as there is one more setlocal in the macro itself =%%\n%
         endlocal%\n%
         endlocal%\n%
      ) ELSE (%\n%
 %= This is true in EDE             =%%\n%
         if "!"=="" (%\n%
            if %%V==%%~V (%\n%
               %%V !%\n%
            )%\n%
         ) ELSE IF not %%V==%%~V (%\n%
            %%~V%\n%
         )%\n%
      )%\n%
   )%\n%
 ) else set args="


set ^"setGlobal=for %%# in (1 2) do if %%#==2 (%\n%
    setlocal DisableDelayedExpansion%\n%
    echo ############################################%\n%
    call echo argv = %%argv%% %\n%
    for /F "tokens=1,2 delims=" %%G in ('call echo "%%argv%%"') do endlocal ^& (%\n%
      echo G = %%~G%\n%
      echo E = %%~E%\n%
      )%\n%
) else set argv="


set "dk=call :command"
set "globals=globals"
call :main
exit /b %errorlevel%

:main
setlocal DisableDelayedExpansion
echo.
echo ### ENTER %~0 ###
  echo function = %~0
  echo globals = %globals%
  echo main = %main%
  echo funcA = %funcA%
  echo funcB = %funcB%
  rem                     "!""#$%%&'()*+,-./:;<=>?@[\]^_`{|}~"
  call :setGlobal main  "!  #$   '()*+,-./:; = ?@[\]^_`{ }~"
  rem %setGlobal% "main=main !"
    
  echo function = %~0
  echo globals = %globals%
  echo main = %main%
  echo funcA = %funcA%
  echo funcB = %funcB%
  
  call :funcA
  
  echo function = %~0
  echo globals = %globals%
  echo main = %main%
  echo funcA = %funcA%
  echo funcB = %funcB%
  
  pause
  
echo ### EXIT %~0 ###
echo.  
%endlocal% %globals%
exit /b !errorlevel!


:funcA
setlocal EnableDelayedExpansion
echo.
echo ### ENTER %~0 ###
  
  echo function = %~0
  echo globals = !globals!
  echo main = !main!
  echo funcA = !funcA!
  echo funcB = !funcB!
  
  rem %setGlobal% funcA "funcA !"
  
rem  setlocal DisableDelayedExpansion
rem  setlocal DisableDelayedExpansion & 
call :setGlobal funcA "funcA !"
rem  %endlocal% %globals%
  
  call :funcB
  
  echo function = %~0
  echo globals = %globals%
  echo globals = !globals!
  echo main = !main!
  echo funcA = !funcA!
  echo funcB = !funcB!
echo ### EXIT %~0 ###
echo.
%endlocal% %globals%
exit /b !errorlevel!


:funcB
setlocal DisableDelayedExpansion
echo.
echo ### ENTER %~0 ###
  echo function = %~0
  echo globals = %globals%
  echo main = %main%
  echo funcA = %funcA%
  echo funcB = %funcB%
  
  call :setGlobal funcB "funcB !"
  rem %setGlobal% funcB "funcB !"

  
  echo function = %~0
  echo globals = %globals%
  echo main = %main%
  echo funcA = %funcA%
  echo funcB = %funcB%
echo ### EXIT %~0 ###
echo.
%endlocal% %globals%
exit /b !errorlevel!



:setGlobal
setlocal DisableDelayedExpansion
echo 2 = %~2
  set %~1=%~2
  set "globals=%globals% %~1"
%endlocal% globals %~1
exit /b !errorlevel!

:ReplaceEqual
  set str=%1.%2
exit /b