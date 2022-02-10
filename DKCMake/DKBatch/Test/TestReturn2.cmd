%dkbatch%

echo got %1, adding 2 and sending to TestReturn3
set /A "var=%1+2"

call TestReturn3 %var%

echo TestReturn3 gave me back %TestReturn3%.
echo I'm gonna subtract 10 and pass it down to TestReturn.

set /A var=%TestReturn3%-10
set %0=%var%


%DKEND%
