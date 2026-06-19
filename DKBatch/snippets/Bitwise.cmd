rem https://stackoverflow.com/a/439082

::##################################
::#			Bitwise Chart
::#
::#		DEC		HEX			BINARY
::# 	1		0x0001          1
::# 	2		0x0002         10
::#		3		0x0003		   11
::# 	4		0x0004		  100
::#		5		0x0005		  101
::#		6		0x0006		  110
::#		7		0x0007		  111
::# 	8		0x0008		 1000
::#		9		0x0009		 1001
::#		10		0x000A		 1010
::#		11		0x000B		 1011
::#		12		0x000C		 1100
::#		13		0x000D		 1101
::#		14		0x000E		 1110
::#		15		0x000F		 1111
::# 	16		0x0010		10000
::#		17		0x0011		10001
::#		18		0x0012		10010
::#		19		0x0013		10011
::#		20		0x0014		10100
::#		21		0x0015		10101
::#		22		0x0016		10110
::#		23		0x0017		10111
::#		24		0x0018		11000
::#		25		0x0019		11001
::#		26		0x001A		11010
::#		27		0x001B		11011
::#		28		0x001C		11100
::#		29		0x001D		11101
::#		30		0x001E		11110
::#		31		0x001F		11111
::# 	32		0x0020	   100000
			
::# 	64		0x0040
::# 	128		0x0080
::# 	256		0x0100
::# 	512		0x0200



@echo off
setlocal EnableDelayedExpansion


:enter_decimal
echo Please enter a number between 1 and 15:
echo.


::### Decimal Input ###
set "dec="
set /P dec=Type number:
if not defined dec goto enter_decimal

::###### Decimal to Bitwise #############
set /A A 	= "(%dec% & 1) / 1"
set /A B 	= "(%dec% & 2) / 2"
set /A C 	= "(%dec% & 4) / 4"
set /A D 	= "(%dec% & 8) / 8"
set /A E	= "(%dec% & 16) / 16"
set /A F	= "(%dec% & 32) / 32"
set "bit=ABCDEF"
if %A% neq 1 (set "bit=%bit:A= %")
if %B% neq 1 (set "bit=%bit:B= %")
if %C% neq 1 (set "bit=%bit:C= %")
if %D% neq 1 (set "bit=%bit:D= %")
if %E% neq 1 (set "bit=%bit:E= %")
if %F% neq 1 (set "bit=%bit:F= %")
::########################################

::###### Decimal to Hexadecimal ######
set /a Z=%dec%
set map=0123456789ABCDEF
set H=
:Hexloop
set /a Y=!Z! %%16 & set /a Z /=16 
set H=!map:~%Y%,1!!H!
if !Z! gtr 0 goto :Hexloop
if %dec% lss 16 (set H=0%H%)
set "hex=0x00%H%"
::#####################################


::###### Bitwise to Binary ######
set bin=%F%%E%%D%%C%%B%%A%
::##############################


::###### Binary to Decimal ###############
::# https://stackoverflow.com/a/30697239
set _bin_-%F%%E%%D%%C%%B%%A%
Set _dec_=0
for /L %%i in (1,1,32) do if defined _bin_ (
   set /A "_dec_=(_dec_<<1)|!_bin_:~0,1!"
   set "_bin_=!_bin_:~1!"
)
Echo %_dec_%
::########################################


echo     Decimal =       %dec%
echo Hexadecimal =   %hex%
echo      Binary =   %bin%
echo     Bitwise =   %bit%


goto:enter_decimal
echo Done
pause
:end