%dkbatch%

echo got %1, adding 4 more.
echo I'm gonna return it to TestRetrun3

set /A "var=%1+4"
::set /A "%0=%1+4"
set "%0=%var%"


%DKEND%
