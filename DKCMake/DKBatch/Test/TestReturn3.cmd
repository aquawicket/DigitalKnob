%dkbatch%

echo I got %1, i'm adding 9 and send to TestReturn 4
set /A var=%1+9


call TestReturn4 %var%


echo ok, TestReturn4 returned %TestReturn4% to me.
echo I'm gonna subtract 2 and return it to TestReturn2. 

set /A %0=%TestReturn4%-2  
  
%DKEND% 
