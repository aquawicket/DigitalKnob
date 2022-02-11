%dkbatch%

echo I'm TestReturn. 
echo I'm sending 11 to TestReturn2

call TestReturn2 11

echo The final number I got back from TestReturn2 is %TestReturn2%.
set /A var=%TestReturn2%-11
echo That's %var% more than the 11 we started with. Our work here is done.  
  
%DKEND% 
