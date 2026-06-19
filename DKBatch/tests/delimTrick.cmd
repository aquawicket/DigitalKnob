@echo off
setlocal EnableDelayedExpansion

set "str=abc_123_def_456_ghi_789_jkl"
echo fullString =     %str%

set i=1
set "str!i!=%str:_=" & set /A i+=1 & set "str!i!=%"
set str

set "first=%str:_=" & rem."%"
echo first =          %first%



set "tail=%str:*_=%"
echo from1stToEnd  =      %tail%

set "string1=%str:_=" & set "last=%
echo last  =                                  %last%



echo "%string1%"
echo "%string2%"
echo "%string3%"

pause