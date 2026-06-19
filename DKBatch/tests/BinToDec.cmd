@Echo off
setlocal EnableDelayedExpansion

Color 0e
Title Binary to Decimal

:Start
Set /p Bin=Binary Number?
Set Dec=0
for /L %%i in (1,1,32) do if defined Bin (
   set /A "Dec=(Dec<<1)|!Bin:~0,1!"
   set "Bin=!Bin:~1!"
)
Echo %Dec%
Pause
Goto Start