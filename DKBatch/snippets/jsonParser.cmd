rem Read file "package.json" into variable string, removing line breaks.
rem https://gist.github.com/navono/992727c277bf3478a06540963f48f7e9

set string=
for /f "delims=" %%x in (package.json) do set "string=!string!%%x"

rem Remove quotes
set string=%string:"=%
rem Remove braces
set "string=%string:~2,-2%"
rem Change colon+space by equal-sign
set "string=%string:: ==%"
rem Separate parts at comma into individual assignments
set "%string:, =" & set "%"

echo %version%