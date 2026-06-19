@echo off 
setlocal enableDelayedExpansion
for %%v in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist "%%v:\\" set "drives=!drives! %%v:"

echo drives = %drives%
pause