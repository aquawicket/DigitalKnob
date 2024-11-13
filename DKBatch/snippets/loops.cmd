@echo off


echo:
echo loop
::###### loop ######
set /a "count=0"
:loop
if %count% lss 10 (
	
	echo %count%
	
	set /a "count+=1" & goto loop
)





set "while=if not defined n set /a n=0"
set "endwhile=set /a "n+=1" & goto while"



echo:
echo while loop
::###### While loop ######
:while
%while% 
if %n% lss 10 (
	
	echo %n%

%endwhile%)




::https://stackoverflow.com/a/54817193/688352

:: Infinate loop
::for /L %%L in (0,0,1) do @(
::echo. Counter always 0, See "%%L" = "0" - Waiting a split second&ping -n 1 127.0.0.1>nul )



:: ###### infinate count loop ######
:: Note:   the speed of this is dependant on the size of your screen buffer in cmd or windows terminal.
:: if you have a screen buffer of 1000 in cmd, you will see the speed of console writes increase x10 once the buffer is full.
echo:
echo infinate count loop
for /L %%L in (0,1,2147483648) do @(
	echo.%%L
)



:: ###### until 10 ######
echo:
echo loop until 10
for /F %%A IN ('
  CMD /C "for /L %%L IN (0,1,2147483648) do @( echo.%%L & IF /I %%L EQU 10 ( exit /b  ) )"
') do @(
  echo %%~A
)


::###### better until 10 ######
echo:
echo loop until 10 best
for /F %%A IN ('CMD /C "for /L %%L IN (0,1,10000000) do @( echo.%%L & IF /I %%L EQU 10 ( exit /b  ) )" ') do @(echo %%~A)




pause









