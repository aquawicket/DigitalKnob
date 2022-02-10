%dkbatch%

echo I got %1, i'm adding 9 and send to TestReturn 4
set /A "var=%1+9"

call TestReturn4 %var%
::echo TestReturn4 = %TestReturn4%

echo ok, TestReturn4 returned %TestReturn4% to me.
echo I'm gonna subtract 2 and return it to TestReturn2. 

set /A var=%TestReturn4%-2
set %0=%var%


%DKEND%
