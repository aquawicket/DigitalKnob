@echo off

goto:test2

(set LF=^
%=Do not remove this line=%
)
set ^"NL=^^^%LF%%LF%^%LF%%LF%^^"

rem #  New Line (enabled variable expansion)
setlocal enabledelayedexpansion
echo delayed%NL%expansion%NL%ON
echo delayed!LF!expansion!LF!ON
pause


rem #  New Line (disabled variable expansion)
setlocal disabledelayedexpansion
echo delayed%NL%expansion%NL%OFF
pause

:test2
setlocal disabledelayedexpansion

set A=###
set !A!=###


echo dde: '%!A!^%'
setlocal enabledelayedexpansion
echo ede: '%!A^!%'
setlocal disabledelayedexpansion
echo dde: '%!A^!%'



rem echo %ok:undefined%
pause



