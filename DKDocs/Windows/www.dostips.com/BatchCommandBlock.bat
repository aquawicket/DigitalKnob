@ECHO OFF

for /l %%a IN (4,-1,0) do (
    echo.%%a: First  command in block
    echo.   Second command in block
)
echo.
if exist "c:\windows" (
    echo.The c:\windows directory exist.
    set "IsWin=YES"
) ELSE (
    echo.The c:\windows directory doesn’t exist.
    set "IsWin=NO"
)
echo.Is this a windows pc?  %IsWin%