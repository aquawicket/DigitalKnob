
@echo off
%dkbatch%

   
mode 78,45 & color 07

::: This can be put in a seperate bat file
::call colors.bat
if /i "%1" equ "--legacy" for /f "tokens=4,5 delims=. " %%i in ('ver') do for %%k in (6.3 6.2 6.1 6.0 5.2 5.1 5.0) do if "%%j.%%k" equ "%%k" if exist "ansicon.exe" ansicon -p
set `r=[0m&set `b=[1m&set `u=[4m&set `i=[7m&set fg`black-=[30m&set fg`red-=[31m&set fg`green-=[32m&set fg`yellow-=[33m&set fg`blue-=[34m&set fg`magenta-=[35m&set fg`cyan-=[36m&set fg`white-=[37m&set fg`black=[90m&set fg`red=[91m&set fg`green=[92m&set fg`yellow=[93m&set fg`blue=[94m&set fg`magenta=[95m&set fg`cyan=[96m&set fg`white=[97m&set bg`black-=[40m&set bg`red-=[41m&set bg`green-=[42m&set bg`yellow-=[43m&set bg`blue-=[44m&set bg`magenta-=[45m&set bg`cyan-=[46m&set bg`white-=[47m&set bg`black=[100m&set bg`red=[101m&set bg`green=[102m&set bg`yellow=[103m&set bg`blue=[104m&set bg`magenta=[105m&set bg`cyan=[106m&set bg`white=[107m
::::::::::::::::::::

cls
echo.
echo  %`u%%fg`white%Dark foreground%`r%                   %`u%%fg`white%Styles%`r%
echo.
echo  ^| %fg`black-%Hello World!%`r% ^| %%fg`black-%%      ^| %`r%Normal text ^(reset^)%`r% ^| %%`r%%
echo  ^| %fg`red-%Hello World!%`r% ^| %%fg`red-%%        ^| %`b%Bold text%`r%           ^| %%`b%%
echo  ^| %fg`green-%Hello World!%`r% ^| %%fg`green-%%      ^| %`u%Underline text%`r%      ^| %%`u%%
echo  ^| %fg`yellow-%Hello World!%`r% ^| %%fg`yellow-%%     ^| %`i%Inverse text%`r%        ^| %%`i%%
echo  ^| %fg`blue-%Hello World!%`r% ^| %%fg`blue-%%
echo  ^| %fg`magenta-%Hello World!%`r% ^| %%fg`magenta-%%
echo  ^| %fg`cyan-%Hello World!%`r% ^| %%fg`cyan-%%
echo  ^| %fg`white-%Hello World!%`r% ^| %%fg`white-%%
echo.
echo  %`u%%fg`white%Light foreground%`r%                  %`u%%fg`white%Usage%`r% 
echo.                                                   
echo  ^| %fg`black%Hello World!%`r% ^| %%fg`black%%       Before using %`b%cl%`r% plugin, add '%fg`black%call cl.bat%`r%'
echo  ^| %fg`red%Hello World!%`r% ^| %%fg`red%%         to your code. It will save colors to
echo  ^| %fg`green%Hello World!%`r% ^| %%fg`green%%       variables. After that, you can now use it.
echo  ^| %fg`yellow%Hello World!%`r% ^| %%fg`yellow%%      First, select color you want to use and
echo  ^| %fg`blue%Hello World!%`r% ^| %%fg`blue%%        close the string with '%fg`black%%%`r%%%`r%' ^(reset^).
echo  ^| %fg`magenta%Hello World!%`r% ^| %%fg`magenta%%
echo  ^| %fg`cyan%Hello World!%`r% ^| %%fg`cyan%%        %`u%%fg`white%Example%`r% %fg`black%%%fg`cyan-%%%fg`cyan-%Text%`r%%fg`black%%%`r%%%`r%
echo  ^| %fg`white%Hello World!%`r% ^| %%fg`white%%
echo                                         %fg`black%fg%`r% foreground
echo  %`u%%fg`white%Dark background%`r%                      %fg`black%cyan%`r% color
echo                                          %fg`black%-%`r% darker color
echo  ^| %bg`black-%Hello World!%`r% ^| %%bg`black-%%
echo  ^| %bg`red-%Hello World!%`r% ^| %%bg`red-%%        %`u%%fg`white%Compatibility%`r% 
echo  ^| %bg`green-%Hello World!%`r% ^| %%bg`green-%%
echo  ^| %bg`yellow-%Hello World!%`r% ^| %%bg`yellow-%%     If you are running Windows older than 10,
echo  ^| %bg`blue-%Hello World!%`r% ^| %%bg`blue-%%       %`b%cl%`r% will automatically set it to legacy
echo  ^| %bg`magenta-%Hello World!%`r% ^| %%bg`magenta-%%    mode. If not: '%fg`black%call cl.bat --legacy%`r%'.
echo  ^| %bg`cyan-%Hello World!%`r% ^| %%bg`cyan-%%
echo  ^| %bg`white-%Hello World!%`r% ^| %%bg`white-%%
echo.
echo  %`u%%fg`white%Light background%`r%                  %`u%%fg`white%Author%`r%
echo.
echo  ^| %bg`black%Hello World!%`r% ^| %%bg`black-%%      hXR16F.ar@gmail.com %fg`black%^(E-mail^)%`r%
echo  ^| %bg`red%Hello World!%`r% ^| %%bg`red-%%        hXR16F#1796 %fg`black%^(Discord^)%`r%
echo  ^| %bg`green%Hello World!%`r% ^| %%bg`green-%%
echo  ^| %bg`yellow%Hello World!%`r% ^| %%bg`yellow-%%     %fg`black%github.com/%`r%%fg`white-%hXR16F%`r%
echo  ^| %bg`blue%Hello World!%`r% ^| %%bg`blue-%%       %fg`black%instagram.com/%`r%%fg`white-%hxr16f.ar%`r%
echo  ^| %bg`magenta%Hello World!%`r% ^| %%bg`magenta-%%
echo  ^| %bg`cyan%Hello World!%`r% ^| %%bg`cyan-%%
echo  ^| %bg`white%Hello World!%`r% ^| %%bg`white-%%
for /l %%i in (0,0,1) do pause >nul 
 
%DKEND% 
