@rem shebang

rem ############################################################################
rem # MACRO dk_endlocal()
rem #
:dk_endlocal
set "globals=globals"
setlocal DisableDelayedExpansion
set LF=^


set ^"\n=^^^%LF%%LF%^%LF%%LF%^^"

set ^"endlocal=for %%# in (1 2) do if %%#==2 (                                              %\n%
   setlocal EnableDelayedExpansion                                                       %\n%
   set "varName_count=0"                                                                    %\n%
   for %%C in (!args!) do set "varName[!varName_count!]=%%~C" ^& set /a varName_count+=1   %\n%
   set "retContent=1!LF!"                                                                   %\n%
   for /L %%n in (0 1 !varName_count!) do (                                                %\n%
      for /F "delims=" %%C in ("!varName[%%n]!") DO (                                      %\n%
         set "content=!%%C!"                                                                %\n%
         set "retContent=!retContent!"set !varName[%%n]!=!content!"!LF!"                    %\n%
         if defined content (                                                              %\n%
         set ^"content_EDE=!content:"=""q!"                                                 %\n%
         set "content_EDE=!content_EDE:^=^^!"                                               %\n%
         call set "content_EDE=%%content_EDE:^!=""e^!%%"                                   %\n%
         set "content_EDE=!content_EDE:""e=^!"                                              %\n%
         set ^"content_EDE=!content_EDE:""q="!"                                             %\n%
         ) ELSE set "content_EDE="                                                         %\n%
         set "retContent=!retContent!set "!varName[%%n]!=!content_EDE!"!LF!"                %\n%
      )                                                                                     %\n%
   )                                                                                        %\n%
   for /F "delims=" %%V in ("!retContent!") DO (                                           %\n%
      if "%%V"=="1" (                                                                       %\n%
         endlocal                                                                          %\n%
         endlocal                                                                          %\n%
      ) ELSE (                                                                             %\n%
         if "!"=="" (                                                                       %\n%
            if %%V==%%~V (                                                                  %\n%
               %%V !                                                                        %\n%
            )                                                                               %\n%
         ) ELSE IF not %%V==%%~V (                                                        %\n%
            %%~V                                                                            %\n%
         )                                                                                  %\n%
      )                                                                                     %\n%
   )                                                                                        %\n%
 ) else set args="
 
rem ################ DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################




rem  endlocal & set endlocal=%endlocal%

rem set ^"setGlobal=for %%# in (1 2) do if %%#==2 (%\n%
rem     setlocal DisableDelayedExpansion%\n%
rem     echo ############################################%\n%
rem     call echo argv = %%argv%% %\n%
rem     for /F "tokens=1,2 delims=" %%G in ('call echo "%%argv%%"') do endlocal ^& (%\n%
rem       echo G = %%~G%\n%
rem       echo E = %%~E%\n%
rem       )%\n%
rem ) else set argv="

rem echo endlocal = %endlocal%

rem :endlocal_END
rem exit /b %erorlevel%
exit /b

:setGlobal
setlocal DisableDelayedExpansion
echo 2 = %~2
  set %~1=%~2
  set "globals=%globals% %~1"
  
if not defined globals (set globals=globals) 
if not defined endlocal (call :dk_endlocal)
%endlocal% globals %~1
exit /b !errorlevel!

:ReplaceEqual
  set str=%1.%2
exit /b !errorlevel!

rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal EnableDelayedExpansion
  echo.
  echo ### ENTER %~0 ###
  echo function = %~0
  echo globals = %globals%
  echo main = %main%
  echo funcA = %funcA%
  echo funcB = %funcB%

  setlocal DisableDelayedExpansion
  set "main=main !"
  set "globals=%globals% main"
  %endlocal% %globals%

    
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
  echo ### EXIT %~0 ###
  echo.  

%endlocal% %globals%
  pause
exit /b %errorlevel%


:funcA
setlocal EnableDelayedExpansion
echo.
echo ### ENTER %~0 ###
  
  echo function = %~0
  echo globals = !globals!
  echo main = !main!
  echo funcA = !funcA!
  echo funcB = !funcB!
  
  
  setlocal DisableDelayedExpansion
  set "funcA=funcA !"
  set "globals=%globals% funcA"
  %endlocal% %globals%
  
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
exit /b %errorlevel%


:funcB
setlocal EnableDelayedExpansion
  echo.
  echo ### ENTER %~0 ###
  echo function = %~0
  echo globals = %globals%
  echo main = %main%
  echo funcA = %funcA%
  echo funcB = %funcB%
  
  setlocal DisableDelayedExpansion
  set "funcB=funcB !"
  set "globals=%globals% funcB"
  %endlocal% %globals%
  
  echo function = %~0
  echo globals = %globals%
  echo main = %main%
  echo funcA = %funcA%
  echo funcB = %funcB%
  echo ### EXIT %~0 ###
  echo.
%endlocal% %globals%
exit /b %errorlevel%



rem set ^"\n=^^^%LF%%LF%^%LF%%LF%^^"
rem %=   I use EDE for EnableDelayeExpansion and DDE for DisableDelayedExpansion =%
rem set ^"endlocal=for %%# in (1 2) do if %%#==2 (%\n%
rem    setlocal EnableDelayedExpansion%\n%
rem  %=       Take all variable names into the varName array       =%%\n%
rem    set varName_count=0%\n%
rem    for %%C in (!args!) do set "varName[!varName_count!]=%%~C" ^& set /a varName_count+=1%\n%
rem  %= Build one variable with a list of set statements for each variable delimited by newlines =%%\n%
rem  %= The lists looks like --> set result1=myContent\n"set result1=myContent1"\nset result2=content2\nset result2=content2\n     =%%\n%
rem  %= Each result exists two times, the first for the case returning to DDE, the second for EDE =%%\n%
rem  %= The correct line will be detected by the (missing) enclosing quotes  =%%\n%
rem    set "retContent=1!LF!"%\n%
rem    for /L %%n in (0 1 !varName_count!) do (%\n%
rem       for /F "delims=" %%C in ("!varName[%%n]!") DO (%\n%
rem          set "content=!%%C!"%\n%
rem          set "retContent=!retContent!"set !varName[%%n]!=!content!"!LF!"%\n%
rem          if defined content (%\n%
rem  %=      This complex block is only for replacing '!' with '^!'      =%%\n%
rem  %=    First replacing   '"'->'""q'   '^'->'^^' =%%\n%
rem          set ^"content_EDE=!content:"=""q!"%\n%
rem          set "content_EDE=!content_EDE:^=^^!"%\n%
rem  %= Now it's poosible to use CALL SET and replace '!'->'""e!' =%%\n%
rem          call set "content_EDE=%%content_EDE:^!=""e^!%%"%\n%
rem          %= Now it's possible to replace '""e' to '^', this is effectivly '!' -> '^!'  =%%\n%
rem          set "content_EDE=!content_EDE:""e=^!"%\n%
rem          %= Now restore the quotes  =%%\n%
rem          set ^"content_EDE=!content_EDE:""q="!"%\n%
rem          ) ELSE set "content_EDE="%\n%
rem          set "retContent=!retContent!set "!varName[%%n]!=!content_EDE!"!LF!"%\n%
rem       )%\n%
rem    )%\n%
rem  %= Now return all variables from retContent over the barrier =%%\n%
rem    for /F "delims=" %%V in ("!retContent!") DO (%\n%
rem  %= Only the first line can contain a single 1 =%%\n%
rem       if "%%V"=="1" (%\n%
rem  %= We need to call endlocal twice, as there is one more setlocal in the macro itself =%%\n%
rem          endlocal%\n%
rem          endlocal%\n%
rem       ) ELSE (%\n%
rem  %= This is true in EDE             =%%\n%
rem          if "!"=="" (%\n%
rem             if %%V==%%~V (%\n%
rem                %%V !%\n%
rem             )%\n%
rem          ) ELSE IF not %%V==%%~V (%\n%
rem             %%~V%\n%
rem          )%\n%
rem       )%\n%
rem    )%\n%
rem  ) else set args="