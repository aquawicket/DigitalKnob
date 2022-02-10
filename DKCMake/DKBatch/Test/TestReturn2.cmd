%dkbatch%

call TestReturn3
echo TestReturn3 = %TestReturn3%

set %0=test2

::%DKEND% & call return %0 %0
%DKEND%
