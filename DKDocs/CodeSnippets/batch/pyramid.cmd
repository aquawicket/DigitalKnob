@echo off
%dkbatch%

@echo off
setlocal EnableDelayedExpansion
set /p "layers=How many layers? "
set "space=[0m "

echo. & echo Pyramid 1 & echo ---------
for /l %%i in (1,1,%layers%) do (
	for /l %%j in (1,1,%%i) do (
		<nul set /p =*
	)
	echo.
)

echo. & echo Pyramid 2 & echo ---------
for /l %%i in (1,1,%layers%) do (
	for /l %%j in (%%i,1,%layers%) do (
		<nul set /p =*
	)
	echo.
)

echo. & echo Pyramid 3 & echo ---------
for /l %%i in (1,1,%layers%) do (
	set /a a=%%i * 2 - 1
	set /a b=%layers% - %%i
	for /l %%j in (!b!,-1,1) do (
		<nul set /p =%space%
	)
	for /l %%j in (1,1,!a!) do (
		<nul set /p =*
	)
	echo.
)

echo. & echo Pyramid 4 & echo ---------
for /l %%i in (1,1,%layers%) do (
	set /a a=%%i - 1
	set /a b=%%i * 2 - 1
	set /a c=%layers% * 2 - 1
	for /l %%j in (!a!,-1,1) do (
		<nul set /p =%space%
	)
	for /l %%j in (!b!,1,!c!) do (
		<nul set /p =*
	)
	echo.
)
