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

	goto main
%endfunction%


:first
	echo ###%0###
%endfunction%

:middle
	echo ###%0###
%endfunction%

:last
	echo ###%0###
%endfunction%
 




