%dkbatch%

call TestReturn4
echo TestReturn4 = %TestReturn4%

set %0=test3

::%DKEND% & call return %0 %0
%DKEND%
