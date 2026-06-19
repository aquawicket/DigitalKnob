@echo off
setlocal EnableDelayedExpansion

set "str=1.0.2.25"
set "vars=Major Minor Revision Subrev"

set "p=%%"
set "v=%vars: =" & set "s=!str:*.=!" & call set "!v!=!p!str:.!s!=!p!" & set "str=!s!" & set "v=%" & set "!v!=!s!"

echo Major: %Major%, Minor: %Minor%, Revision: %Revision%, Subrev: %Subrev%

pause