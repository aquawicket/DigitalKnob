@echo off

set "string=GetTheStringAfterZthisCharacter
set "string=%string:*Z=%"
echo string after Z = %string% 

pause