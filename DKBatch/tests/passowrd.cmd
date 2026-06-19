@echo off
setlocal

call :ReadPassword pass="Enter password: "
setlocal EnableDelayedExpansion
echo Password read: "!pass!"
goto :EOF


:ReadPassword var="prompt"

rem Read a password
rem Antonio Perez Ayala

rem Initialize variables
setlocal EnableDelayedExpansion
rem Get a CarriageReturn (ASCII 13) character
for /F %%a in ('copy /Z "%~F0" NUL') do set "CR=%%a"
rem Get a BackSpace (ASCII 8) character
for /F %%a in ('echo prompt $H ^| cmd') do set "BS=%%a"

rem Show the prompt and start reading
set /P "=%~2" < NUL
set "input="
set i=0

rem Get the localized xcopy prompt
set "msg="
for /F "delims=" %%a in ('echo.^|xcopy /W "%~F0" "%~F0" 2^>NUL') do if not defined msg set "msg=%%a"

:nextKey
   set "key="
   for /F "delims=" %%a in ('xcopy /W "%~F0" "%~F0" 2^>NUL') do if not defined key set "key=%%a"

   rem Remove the localized xcopy prompt from the beginning of the string
   set key=!key:%msg%=!
   rem If the key is a question mark, it'll have been lost in the set "key=%%a" above
   if not defined key set "key=^!"

   rem If key is CR: terminate input
   if "!key:~-1!" equ "!CR!" goto endRead

   rem If key is BS: delete last char, if any
   set "key=!key:~-1!"
   if "!key!" equ "!BS!" (
      if %i% gtr 0 (
         set /P "=!BS! !BS!" < NUL
         set "input=!input:~0,-1!"
         set /A i-=1
      )
      goto nextKey
   )

   rem Else: show and accept the key
   set /P "=*" < NUL
   set "input=!input!!key!"
   set /A i+=1

goto nextKey

:endRead
echo/
endlocal & set "password=%input%"
echo password = %password%
pause
exit /B