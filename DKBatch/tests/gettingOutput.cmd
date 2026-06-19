@echo off
setlocal


::for /f "tokens=3,4 delims=, " %%A in (
::  'powershell -command "&{$H=get-host;$H.ui.rawui;}"^|findstr /b WindowSize'
::) do set /a windowWidth=%%A, windowHeight=%%B

mode con
for /f "tokens=1,2,3,4,5,6,7,8,9 delims=, " %%G in (
  'mode con^|findstr /C:Columns:'
) do (
	set token1=%%G 
	set token2=%%H
	set token3=%%I
	set token4=%%J
	set token5=%%K
	set token6=%%L
	set token7=%%M
	set token8=%%N
	set token9=%%O
)

echo:token1 = %token1%
echo:token2 = %token2%
echo:token3 = %token3%
echo:token4 = %token4%
echo:token5 = %token5%
echo:token6 = %token6%
echo:token7 = %token7%
echo:token8 = %token8%
echo:token9 = %token9%
pause