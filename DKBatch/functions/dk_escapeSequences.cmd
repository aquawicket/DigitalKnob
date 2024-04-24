:: dk_includeGuard()

:: https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
:: call dk_verbose "%0(%*)"

set ASCII_length=0
:: ASCII control characters (character code 0-31)
::      			SYMBOL	DEC		OCT		HEX		HTML	Description
call:ASCII_ADD		NUL		0		000		0x00	#00		"Null character"
call:ASCII_ADD		SOH		1		001		0x01	#01		"Start of Heading"
call:ASCII_ADD		STX		2		002		0x02	#02		"Start of Text"
call:ASCII_ADD		ETX		3		003		0x03	#03		"End of Text"
call:ASCII_ADD		EOT		4		004		0x04	#04		"End of Transmission"
call:ASCII_ADD		ENQ		5		005		0x05	#05		"Enquiry"
call:ASCII_ADD		ACK		6		006		0x06	#06		"Acknowledge"
call:ASCII_ADD		BEL		7		007		0x07	#07		"Bell, Alert"
call:ASCII_ADD		BS		8		010		0x08	#08		"Backspace"
call:ASCII_ADD		HT		9		011		0x09	#09		"Horizontal Tab"
call:ASCII_ADD		LF		10		012		0x0a	#10		"Line Feed"
call:ASCII_ADD		VT		11		013		0x0b	#11		"Vertical Tabulation"
call:ASCII_ADD		FF		12		014		0x0c	#12		"Form Feed"
call:ASCII_ADD		CR		13		015		0x0d	#13		"Carriage Return"
call:ASCII_ADD		SO		14		016		0x0e	#14		"Shift Out"
call:ASCII_ADD		SI		15		017		0x0f	#15		"Shift In"
call:ASCII_ADD		DLE		16		020		0x10	#16		"Data Link Escape"
call:ASCII_ADD		DC1		17		021		0x11	#17		"Device Control One (XON)"
call:ASCII_ADD		DC2		18		022		0x12	#18		"Device Control Two"
call:ASCII_ADD		DC3		19		023		0x13	#19		"Device Control Three (XOFF)"
call:ASCII_ADD		DC4		20		024		0x14	#20		"Device Control Four"
call:ASCII_ADD		NAK		21		025		0x15	#21		"Negative Acknowledge"
call:ASCII_ADD		SYN		22		026		0x16	#22		"Synchronous Idle"
call:ASCII_ADD		ETB		23		027		0x17	#23		"End of Transmission Block"
call:ASCII_ADD		CAN		24		030		0x18	#24		"Cancel"
call:ASCII_ADD		EM		25		031		0x19	#25		"End of medium"
call:ASCII_ADD		SUB		26		032		0x1a	#26		"Substitute"
call:ASCII_ADD		ESC		27		033		0x1b	#27		"Escape"
call:ASCII_ADD		ZZZ		28		034		0x1c	#28		"File Separator"
call:ASCII_ADD		ZZZ		29		035		0x1d	#29		"Group Separator"
call:ASCII_ADD		ZZZ		30		036		0x1e	#30		"Record Separator"
call:ASCII_ADD		ZZZ		31		037		0x1f	#31		"Unit Separator"


:::ASCII_length_Loop
::if defined ASCII[%ASCII_length%] (
::	set /a ASCII_length+=1
::	GOTO :ASCII_length_Loop
::)
echo.
echo		SYMBOL	DEC	OCT	HEX	HTML	Description
for /L %%i IN (0,1,%ASCII_length%) DO (
	call:ASCII_SHOW %%i	
)
echo.



call dk_hexToVariable NUL 0x00
::call dk_hexToVariable SOH 0x01
::call dk_hexToVariable STX 0x02
::call dk_hexToVariable ETX 0x03
::call dk_hexToVariable EOT 0x04
::call dk_hexToVariable ENQ 0x05
::call dk_hexToVariable ACK 0x06
call dk_hexToVariable BEL 0x07
::call dk_hexToVariable BS  0x08
call dk_hexToVariable TAB 0x09
::call dk_hexToVariable LF  0x0a
::call dk_hexToVariable VT  0x0b
::call dk_hexToVariable FF  0x0c
::call dk_hexToVariable CR  0x0d
::call dk_hexToVariable SO  0x0e
::call dk_hexToVariable SI  0x0f
::call dk_hexToVariable DLE 0x10
::call dk_hexToVariable DC1 0x11
::call dk_hexToVariable DC2 0x12
::call dk_hexToVariable DC3 0x13
::call dk_hexToVariable DC4 0x14
::call dk_hexToVariable NAK 0x15
::call dk_hexToVariable SYN 0x16
::call dk_hexToVariable ETB 0x17
::call dk_hexToVariable CAN 0x18
::call dk_hexToVariable EM  0x19
::call dk_hexToVariable SUB 0x1a
call dk_hexToVariable ESC 0x1b
::call dk_hexToVariable FS  0x1c
::call dk_hexToVariable GS  0x1d
::call dk_hexToVariable RS  0x1e
::call dk_hexToVariable US  0x1f

::call dk_decimalToVariable NUL 0
::call dk_decimalToVariable SOH 1
::call dk_decimalToVariable STX 2
::call dk_decimalToVariable ETX 3
::call dk_decimalToVariable EOT 4
::call dk_decimalToVariable ENQ 5
::call dk_decimalToVariable ACK 6
::call dk_decimalToVariable BEL 7 
::call dk_decimalToVariable BS  8
::call dk_decimalToVariable TAB 9
::call dk_decimalToVariable LF  10
::call dk_decimalToVariable VT  11
::call dk_decimalToVariable FF  12
::call dk_decimalToVariable CR  13
::call dk_decimalToVariable SO  14
::call dk_decimalToVariable SI  15
::call dk_decimalToVariable DLE 16
::call dk_decimalToVariable DC1 17
::call dk_decimalToVariable DC2 18
::call dk_decimalToVariable DC3 19
::call dk_decimalToVariable DC4 20
::call dk_decimalToVariable NAK 21
::call dk_decimalToVariable SYN 22
::call dk_decimalToVariable ETB 23
::call dk_decimalToVariable CAN 24
::call dk_decimalToVariable EM  25
::call dk_decimalToVariable SUB 26
::call dk_decimalToVariable ESC 27
::call dk_decimalToVariable FS  28
::call dk_decimalToVariable GS  29
::call dk_decimalToVariable RS  30
::call dk_decimalToVariable US  31




set "clear=%ESC%[2J"

:: attributes
set "clr=%ESC%[0m"
set "bold=%ESC%[1m"
set "underline=%ESC%[4m"
set "blink=%ESC%[5m"
set "inverse=%ESC%[7m"
set "invisible=%ESC%[8m"
	
:: Foreground Colors
set "black=%ESC%[30m"
set "red=%ESC%[31m"
set "green=%ESC%[32m"
set "yellow=%ESC%[33m"
set "blue=%ESC%[34m"
set "magenta=%ESC%[35m"
set "cyan=%ESC%[36m"
set "white=%ESC%[37m"

:: Background Colors
set "bg_black=%ESC%[40m"
set "bg_red=%ESC%[41m"
set "bg_green=%ESC%[42m"
set "bg_yellow=%ESC%[43m"
set "bg_blue=%ESC%[44m"
set "bg_magenta=%ESC%[45m"
set "bg_cyan=%ESC%[46m"
set "bg_white=%ESC%[47m"

:: Foreground Colors (Bright)
set "Black=%ESC%[90m"
set "Red=%ESC%[91m"
set "Green=%ESC%[92m"
set "Yellow=%ESC%[93m"
set "Blue=%ESC%[94m"
set "Magenta=%ESC%[95m"
set "Cyan=%ESC%[96m"
set "White=%ESC%[97m"

:: Background Colors (Bright)
set "BG_Black=%ESC%[100m"
set "BG_Red=%ESC%[101m"
set "BG_Green=%ESC%[102m"
set "BG_Yellow=%ESC%[103m"
set "BG_Blue=%ESC%[104m"
set "BG_Magenta=%ESC%[105m"
set "BG_Cyan=%ESC%[106m"
set "BG_White=%ESC%[107m"
goto:eof

:ASCII_ADD
	::echo ASCII_ADD (%*
	::echo %~1	%~2		%~3		%~4		%~5		%~6
	set ID=%~2
	set ASCII[%ID%].SYMBOL=%~1
	set ASCII[%ID%].DEC=%~2
	set ASCII[%ID%].OCT=%~3
	set ASCII[%ID%].HEX=%~4
	set ASCII[%ID%].HTML=%~5
	set ASCII[%ID%].INFO=%6
	
	set /a ASCII_length+=1
goto:eof

:ASCII_SHOW
	set ID=%~1
	call echo %%ASCII[%ID%].DEC%%	%%ASCII[%ID%].SYMBOL%%	%%ASCII[%ID%].DEC%%	%%ASCII[%ID%].OCT%%	%%ASCII[%ID%].HEX%%	%%ASCII[%ID%].HTML%%	%%ASCII[%ID%].INFO%%
goto:eof