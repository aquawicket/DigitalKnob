@echo off

(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)

setlocal enableDelayedExpansion

if "!DE!" equ "" echo Delayed Expansion ON
if "!DE!" neq "" echo Delayed Expansion OFF

set $first=^&call:first
set $middle=^&call:middle
set $last=^&call:last

:main
	echo --------------------------
	echo %$first:!$middle!=!$last!%

	goto:main
goto:eof


:first
	echo ###%0###
goto:eof

:middle
	echo ###%0###
goto:eof

:last
	echo ###%0###
goto:eof
  




