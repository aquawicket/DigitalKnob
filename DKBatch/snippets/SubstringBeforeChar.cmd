@echo off

set "string=GetTheStringBeforeZthisCharacter
for /f "tokens=1 delims=Z" %%a in ("%string%") do (set "string=%%a")
echo string before Z = %string% 

pause