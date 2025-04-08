if(NOT DK_VBS = 1) then
	executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()
	'ForceConsole()
end if

'##################################################################################
'# dk_color()
'#
'public function dk_color()
	'set ESC="																' escape character	BAD: Uncopyable character
	'for /f %%A in ('echo prompt $E^| cmd') do (set ESC=%%A)					' escape character	BAD: cryptic
	'for /f %%A in ('forfiles /c "%COMSPEC% /c echo 0x1B"') do (set ESC=%%A)	' escape character	BAD: Very slow
	'for /l %%A in (27,1,1) do (cmd /c exit %%A & (set ESC=!^=ExitCodeAscii!)) ' escape character	GOOD: Converts DECIMAL to ASCII

	'for /l %%A in (0,1,126)	do (cmd /c exit %%A & set /a "C%%A=!^=ExitCodeAscii!" & echo C%%A = !C%%A! >> ascii.txt)

	'############ C0 control codes #############
	NUL=""						' Null - Does nothing. The code of blank paper tape, and also used for padding to slow transmission
	SOH=""						' Start of Heading - First character of the heading of a message
	STX=""						' Start of Text - Terminates the header and starts the message text
	ETX=""						' End of Text - Ends the message text, starts a footer up to the next TC character
	EOT=""						' End of Transmission - Ends the transmission of one or more messages. May place terminals on standby.
	EQN=""						' Enquiry - Trigger a response at the receiving end, to see if it is still present.
	ACK=""						' Acknowledge - Indication of successful receipt of a message.
	BEL=""						' Bell, Alert	- Call for attention from an operator.
	BS=""						' Backspace - Move one position leftwards. Next character may overprint or replace the character that was there.
	'HT=""						' Character Tabulation, Horizontal Tabulation	- Move right to the next tab stop.
	'LF="	"					' Line Feed - Move down to the same position on the next line some devices also moved to the left column.
	VT=""						' Line Tabulation, Vertical Tabulation - Move down to the next vertical tab stop.
	FF=""						' Form Feed - Move down to the top of the next page.
	'CR=""						' Carriage Return - Move to column zero while staying on the same line.
	SO=""						' Shift Out - Switch to an alternative character set.
	SI=""						' Shift In - Return to regular character set after SO.
	DLE=""						' Data Link Escape - Cause a number of contiguously following characters to be interpreted in some different way
	DC1=""						' Device Control One - Turn on DC1 and DC2 or off DC3 and DC4 devices.
	DC2=""						' Device Control Two
	DC3=""						' Device Control Three
	DC4=""						' Device Control Four
	NAK=""						' Negative Acknowledge - Negative response to a sender, such as a detected error.
	SYN=""						' Synchronous Idle - Sent in synchronous transmission systems when no other character is being transmitted.
	ETB=""						' End of Transmission Block - End of a transmission block of data when data are divided into such blocks.
	CAN=""						' Cancel - Indicates that the data preceding it are in error or are to be disregarded.
	EM=""						' End of medium - Indicates on paper or magnetic tapes that the end of the usable tape had been reached.
	'SUB=""						' Substitute -Replaces a character that was found to be invalid or in error. Should be ignored.
	ESC=""						' Escape - Alters the meaning of a limited number of following bytes.
	FS=""						' File Separator - Can be used as delimiters to mark fields of data structures. 
	GS=""						' Group Separator
	RS=""						' Record Separator
	US=""						' Unit Separator - US is the lowest level
	SP=" " 						' Space - Move right one character position.
	DEL=""						' Delete - Should be ignored. Used to delete characters on punched tape by punching out all the holes.

	'############ C1 control codes #############
	PAD=ESC+"@"					' Padding Character
	HOP=ESC+"A"					' High Octet Preset
	BPH=ESC+"B"					' Break Permitted Here
	NBH=ESC+"C"					' No Break Here
	IND=ESC+"D"					' Index
	NEL=ESC+"E"					' Next Line
	SSA=ESC+"F"					' Start of Selected Area
	ESA=ESC+"G"					' End of Selected Area
	HTS=ESC+"H"					' Horizontal Tabulation Set
	HTJ=ESC+"I"					' Horizontal Tabulation With Justification
	VTS=ESC+"J"					' Vertical Tabulation Set
	PLD=ESC+"K"					' Partial Line Down
	PLU=ESC+"L"					' Partial Line Up
	RI=ESC+"M"					' Reverse Index
	SS2=ESC+"N"					' Single Shift Two
	SS3=ESC+"O"					' Single Shift Three
	DCS=ESC+"P"					' Device Control String
	PU1=ESC+"Q"					' Private Use 1
	PU2=ESC+"R"					' Private Use 2
	STS=ESC+"S"					' Set Transmit State
	CCH=ESC+"T"					' Cancel character
	MW=ESC+"U"					' Message Waiting
	SPA=ESC+"V"					' Start of Protected Area
	EPA=ESC+"W"					' End of Protected Area
	SOS=ESC+"X"					' Start of String
	SGC=ESC+"Y"					' Single Graphic Character Introducer
	SCI=ESC+"Z"					' Single Character Introducer
	CSI=ESC+"["					' Control Sequence Introducer
	ST=ESC+"\"					' String Terminator
	OSC=ESC+"]"					' Operating System Command
	PM=ESC+"^^"					' Privacy Message
	APC=ESC+"_"					' Application Program Command

	DECSC=ESC+"7"					' Save Cursor Position in Memory**
	DECSR=ESC+"8"					' Restore Cursor Position from Memory**

'	DECSCUSR0=ESC+"0"+SP+"q"		' User Shape
'	DECSCUSR1=ESC+"1%SP%q			' Blinking Block
'	DECSCUSR2=ESC+"2%SP%q			' Steady Block
'	DECSCUSR3=ESC+"3%SP%q			' Blinking Underline
'	DECSCUSR4=ESC+"4%SP%q			' Steady Underline
'	DECSCUSR5=ESC+"5%SP%q			' Blinking Bar
'	DECSCUSR6=ESC+"6%SP%q			' Steady Bar

	'############ CSI Commands #############
	CCU=CSI+"A"					' Cursor Up 1 - Moves the cursor 1 cell in the given direction. If the cursor is already at the edge of the screen, this has no effect.
	'CCU=CSI+"<n>A				' Cursor Up -	Moves the cursor n default 1 cells in the given direction. If the cursor is already at the edge of the screen, this has no effect.
	CUD=CSI+"B"					' Cursor Down 1
	'CCU=CSI+"<n>B				' Cursor Down
	CUF=CSI+"C"					' Cursor Forward 1
	'CCU=CSI+"<n>C				' Cursor Forward
	CUB=CSI+"D"					' Cursor Back 1
	'CCU=CSI+"<n>D				' Cursor Back
	CNL=CSI+"E"					' Cursor Next Line 1 - Moves cursor to beginning of the line 1 line down. not ANSI.SYS
	'CCU=CSI+"<n>E				' Cursor Next Line - Moves cursor to beginning of the line n default 1 lines down. not ANSI.SYS
	CPL=CSI+"F"					' Cursor Previous Line 1 - Moves cursor to beginning of the line 1 line up. not ANSI.SYS
	'CCU=CSI+"<n>F				' Cursor Previous Line - Moves cursor to beginning of the line n default 1 lines up. not ANSI.SYS
	CHA=CSI+"G"					' Cursor Horizontal Absolute 1 - Moves the cursor to column 1. not ANSI.SYS
	'CCU=CSI+"<n>G				' Cursor Horizontal Absolute - Moves the cursor to column n default 1. not ANSI.SYS
	'CUP=CSI+"<n>;<m>H			' Cursor Position	- Cursor moves to <x>; <y> coordinate within the viewport, where <x> is the column of the <y> line
	'HVP=CSI+"<y>;<x>f			' Horizontal Vertical Position - Cursor moves to <x>; <y> coordinate within the viewport, where <x> is the column of the <y> line
	ANSISYSSC=CSI+"s"				' Save Cursor – **With no parameters, performs a save cursor operation like DECSC
	ANSISYSRC=CSI+"u"				' Restore Cursor - **With no parameters, performs a restore cursor operation like DECRC

	'CSI n J	ED						' Erase in Display - Clears part of the screen. If n is 0 or missing, clear from cursor to end of screen. If n is 1, clear from cursor to beginning of the screen. If n is 2, clear entire screen and moves cursor to upper left on DOS ANSI.SYS. If n is 3, clear entire screen and delete all lines saved in the scrollback buffer.
	'CSI n K	EL						' Erase in Line - Erases part of the line. If n is 0 or missing, clear from cursor to the end of the line. If n is 1, clear from cursor to beginning of the line. If n is 2, clear entire line. Cursor position does not change.
	'CSI n S	SU						' Scroll Up - Scroll whole page up by n default 1 lines. New lines are added at the bottom. not ANSI.SYS
	'CSI n T	SD						' Scroll Down	- Scroll whole page down by n default 1 lines. New lines are added at the top. not ANSI.SYS
	'CSI n ; m f	HVP					' Horizontal Vertical Position - Same as CUP, but counts as a format effector function like CR or LF rather than an editor function like CUD or CNL.
	'CSI n m	SGR						' Select Graphic Rendition - Sets colors and style of the characters following this code
	'CSI 5i							' AUX Port On	- Enable aux serial port usually for local serial printer
	'CSI 4i							' AUX Port Off - Disable aux serial port usually for local serial printer
	'CSI 6n	DSR						' Device Status Report - Reports the cursor position CPR by transmitting ESC[n;mR, where n is the row and m is the column.
	ATT160=CSI+"?12"				' Text Cursor Blink
	DECTCEM=CSI+"?25"				' Text Cursor Show/Hide

'	SU=CSI+"<n>S"					' Scroll Up - Scroll text up by <n>. Also known as pan down, new lines fill in from the bottom of the screen
'	SD=CSI+"<n>T"					' Scroll Down - Scroll down by <n>. Also known as pan up, new lines fill in from the top of the screen

	DEC=ESC+"0"						' Enables DEC Line Drawing Mode
	ASCII=ESC+"B"					' Enables ASCII Mode Default

	'# Cursor
	cursor_blink_on=ATT160+"h"		' Text Cursor Enable Blinking
	cursor_blink_off=ATT160+"l"		' Text Cursor Disable Blinking
	cursor_show=DECTCEM+"h"			' Text Cursor Enable Mode Show
	cursor_hide=DECTCEM+"l"			' Text Cursor Enable Mode Hide

	'# Attributes on
	clr=CSI+"0m"					' Default					Reall modes styles and colors
	bright=CSI+"1m"					' Bright					Applies brightness flag to foreground color
	dark=CSI+"2m"					' Dim						Applies dark flag to foreground color
	italic=CSI+"3m"					' Italic
	underline=CSI+"4m"				' Underline
	blink=CSI+"5m"					' Blink
	fblink=CSI+"6m"					' Rapid Blink
	negative=CSI+"7m"				' Negative				Swaps foreground and background colors
	invisible=CSI+"8m"				' Invisible
	strike=CSI+"9m"					' Strike Through

	'# Attributes off
	'20m=CSI+"20m"					' 20
	'21m=CSI+"21m"					' 21
	nodark=CSI+"22m"					' No Dim					Removes brightness/intensity flag from foreground color
	nobright=CSI+"22m"				' No Bright				Removes brightness/intensity flag from foreground color
	noitalic=CSI+"23m"				' No Italic
	nounderline=CSI+"24m"			' No Underline
	noblink=CSI+"25m"				' No Blink
	'26m=CSI+"26m"					' 26
	nonegative=CSI+"27m"			' No Negative				Returns foreground/background to normal
	visible=CSI+"28m"				' No Invisible
	nostrike=CSI+"29m"				' No Strike Through

	'# Foreground Colors
	black=CSI+"30m"					' Foreground Black			Applies non-dark/bright black to foreground
	red=CSI+"31m"					' Foreground Red			Applies non-dark/bright red to foreground
	green=CSI+"32m"					' Foreground Green			Applies non-dark/bright green to foreground
	yellow=CSI+"33m"				' Foreground Yellow			Applies non-dark/bright yellow to foreground
	blue=CSI+"34m"					' Foreground Blue			Applies non-dark/bright blue to foreground
	magenta=CSI+"35m"				' Foreground Magenta		Applies non-dark/bright magenta to foreground
	cyan=CSI+"36m"					' Foreground Cyan			Applies non-dark/bright cyan to foreground
	white=CSI+"37m"					' Foreground White			Applies non-dark/bright white to foreground
	extended=CSI+"38m"				' Foreground Extended		Applies extended color value to the foreground
	fg_clr=CSI+"39m"				' Foreground Default		Applies only the foreground portion of the defaults

	'# Background Colors
	bg_black=CSI+"40m"				' Background Black			Applies non-dark/bright black to background
	bg_red=CSI+"41m"				' Background Red			Applies non-dark/bright red to background
	bg_green=CSI+"42m"				' Background Green			Applies non-dark/bright green to background
	bg_yellow=CSI+"43m"				' Background Yellow			Applies non-dark/bright yellow to background
	bg_blue=CSI+"44m"				' Background Blue			Applies non-dark/bright blue to background
	bg_magenta=CSI+"45m"			' Background Magenta		Applies non-dark/bright magenta to background
	bg_cyan=CSI+"46m"				' Background Cyan			Applies non-dark/bright cyan to background
	bg_white=CSI+"47m"				' Background White			Applies non-dark/bright white to background
	bg_extended=CSI+"48m"			' Background Extended		Applies extended color value to the background
	bg_clr=CSI+"49m"	 			' Background Default		Applies only the background portion of the defaults

	'# Foreground Colors light
	lblack=CSI+"90m"				' Bright Foreground Black		Applies bright black to foreground
	lred=CSI+"91m"					' Bright Foreground Red			Applies bright red to foreground
	lgreen=CSI+"92m"				' Bright Foreground Green		Applies bright green to foreground
	lyellow=CSI+"93m"				' Bright Foreground Yellow		Applies bright yellow to foreground
	lblue=CSI+"94m"					' Bright Foreground Blue		Applies bright blue to foreground
	lmagenta=CSI+"95m"				' Bright Foreground Magenta		Applies bright magenta to foreground
	lcyan=CSI+"96m"					' Bright Foreground Cyan		Applies bright cyan to foreground
	lwhite=CSI+"97m"				' Bright Foreground White		Applies bright white to foreground

	'# Background Colors light
	bg_lblack=CSI+"100m"			' Bright Background Black		Applies bright black to background
	bg_lred=CSI+"101m"				' Bright Background Red			Applies bright red to background
	bg_lgreen=CSI+"102m"			' Bright Background Green		Applies bright green to background
	bg_lyellow=CSI+"103m"			' Bright Background Yellow		Applies bright yellow to background
	bg_lblue=CSI+"104m"				' Bright Background Blue		Applies bright blue to background
	bg_lmagenta=CSI+"105m"			' Bright Background Magenta		Applies bright magenta to background
	bg_lcyan=CSI+"106m"				' Bright Background Cyan		Applies bright cyan to background
	bg_lwhite=CSI+"107m"			' Bright Background White		Applies bright white to background

	' ######### FIXME: ; characters must be specially handled in vbs script ############
	'# Foreground RGB Colors
	'RGB=CSI+"38;2"+chr(59)					' %RGB%50;100;150m				%CSI%38;2;50;100;150m

	'# Background RGB Colors
	'bg_RGB=CSI+"48;2;"				' %bg_RGB%150;100;50m			%CSI%38;2;150;100;50m

	dk_echo(blue+"C"+green+"O"+red+"L"+magenta+"O"+cyan+"R "+blue+"O"+green+"N"+clr)

'end function
'dk_color()











'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(ENV("DKSCRIPT_PATH") = WScript.ScriptFullName) then
public function DKTEST()	

	dk_echo("")
	dk_echo(black+bg_lblack+"                 CSI codes              "+clr)
	dk_echo("    CSI0m              "+CSI+"0m    CSI0m    "+clr)
	dk_echo("    CSI1m              "+CSI+"1m    CSI1m    "+clr)
	dk_echo("    CSI2m              "+CSI+"2m    CSI2m    "+clr)
	dk_echo("    CSI3m              "+CSI+"3m    CSI3m    "+clr)
	dk_echo("    CSI4m              "+CSI+"4m    CSI4m    "+clr)
	dk_echo("    CSI5m              "+CSI+"5m    CSI5m    "+clr)
	dk_echo("    CSI6m              "+CSI+"6m    CSI6m    "+clr)
	dk_echo("    CSI7m              "+CSI+"7m    CSI7m    "+clr)
	dk_echo("    CSI8m              "+CSI+"8m    CSI8m    "+clr)
	dk_echo("    CSI9m              "+CSI+"9m    CSI9m    "+clr)
	dk_echo("    CSI10m             "+CSI+"10m    CSI10m    "+clr)
	dk_echo("    CSI11m             "+CSI+"11m    CSI11m    "+clr)
	dk_echo("    CSI12m             "+CSI+"12m    CSI12m    "+clr)
	dk_echo("    CSI13m             "+CSI+"13m    CSI13m    "+clr)
	dk_echo("    CSI14m             "+CSI+"14m    CSI14m    "+clr)
	dk_echo("    CSI15m             "+CSI+"15m    CSI15m    "+clr)
	dk_echo("    CSI16m             "+CSI+"16m    CSI16m    "+clr)
	dk_echo("    CSI17m             "+CSI+"17m    CSI17m    "+clr)
	dk_echo("    CSI18m             "+CSI+"18m    CSI18m    "+clr)
	dk_echo("    CSI19m             "+CSI+"19m    CSI19m    "+clr)
	dk_echo("    CSI20m             "+CSI+"20m    CSI20m    "+clr)
	dk_echo("    CSI21m             "+CSI+"21m    CSI21m    "+clr)
	dk_echo("    CSI22m             "+CSI+"22m    CSI22m    "+clr)
	dk_echo("    CSI23m             "+CSI+"23m    CSI23m    "+clr)
	dk_echo("    CSI24m             "+CSI+"24m    CSI24m    "+clr)
	dk_echo("    CSI25m             "+CSI+"25m    CSI25m    "+clr)
	dk_echo("    CSI26m             "+CSI+"26m    CSI26m    "+clr)
	dk_echo("    CSI27m             "+CSI+"27m    CSI27m    "+clr)
	dk_echo("    CSI28m             "+CSI+"28m    CSI28m    "+clr)
	dk_echo("    CSI29m             "+CSI+"29m    CSI29m    "+clr)
	dk_echo("    CSI30m             "+CSI+"30m    CSI30m    "+clr)
	dk_echo("    CSI31m             "+CSI+"31m    CSI31m    "+clr)
	dk_echo("    CSI32m             "+CSI+"32m    CSI32m    "+clr)
	dk_echo("    CSI33m             "+CSI+"33m    CSI33m    "+clr)
	dk_echo("    CSI34m             "+CSI+"34m    CSI34m    "+clr)
	dk_echo("    CSI35m             "+CSI+"35m    CSI35m    "+clr)
	dk_echo("    CSI36m             "+CSI+"36m    CSI36m    "+clr)
	dk_echo("    CSI37m             "+CSI+"37m    CSI37m    "+clr)
	dk_echo("    CSI38m             "+CSI+"38m    CSI38m    "+clr)
	dk_echo("    CSI39m             "+CSI+"39m    CSI39m    "+clr)
	dk_echo("    CSI40m             "+CSI+"40m    CSI40m    "+clr)
	dk_echo("    CSI41m             "+CSI+"41m    CSI41m    "+clr)
	dk_echo("    CSI42m             "+CSI+"42m    CSI42m    "+clr)
	dk_echo("    CSI43m             "+CSI+"43m    CSI43m    "+clr)
	dk_echo("    CSI44m             "+CSI+"44m    CSI44m    "+clr)
	dk_echo("    CSI45m             "+CSI+"45m    CSI45m    "+clr)
	dk_echo("    CSI46m             "+CSI+"46m    CSI46m    "+clr)
	dk_echo("    CSI47m             "+CSI+"47m    CSI47m    "+clr)
	dk_echo("    CSI48m             "+CSI+"48m    CSI48m    "+clr)
	dk_echo("    CSI49m             "+CSI+"49m    CSI49m    "+clr)
	dk_echo("    CSI50m             "+CSI+"50m    CSI50m    "+clr)
	dk_echo("    CSI51m             "+CSI+"51m    CSI51m    "+clr)
	dk_echo("    CSI52m             "+CSI+"52m    CSI52m    "+clr)
	dk_echo("    CSI53m             "+CSI+"53m    CSI53m    "+clr)
	dk_echo("    CSI54m             "+CSI+"54m    CSI54m    "+clr)
	dk_echo("    CSI55m             "+CSI+"55m    CSI55m    "+clr)
	dk_echo("    CSI56m             "+CSI+"56m    CSI56m    "+clr)
	dk_echo("    CSI57m             "+CSI+"57m    CSI57m    "+clr)
	dk_echo("    CSI58m             "+CSI+"58m    CSI58m    "+clr)
	dk_echo("    CSI59m             "+CSI+"59m    CSI59m    "+clr)
	dk_echo("    CSI60m             "+CSI+"60m    CSI60m    "+clr)
	dk_echo("    CSI61m             "+CSI+"61m    CSI61m    "+clr)
	dk_echo("    CSI62m             "+CSI+"62m    CSI62m    "+clr)
	dk_echo("    CSI63m             "+CSI+"63m    CSI63m    "+clr)
	dk_echo("    CSI64m             "+CSI+"64m    CSI64m    "+clr)
	dk_echo("    CSI65m             "+CSI+"65m    CSI65m    "+clr)
	dk_echo("    CSI66m             "+CSI+"66m    CSI66m    "+clr)
	dk_echo("    CSI67m             "+CSI+"67m    CSI67m    "+clr)
	dk_echo("    CSI68m             "+CSI+"68m    CSI68m    "+clr)
	dk_echo("    CSI69m             "+CSI+"69m    CSI69m    "+clr)
	dk_echo("    CSI70m             "+CSI+"70m    CSI70m    "+clr)
	dk_echo("    CSI71m             "+CSI+"71m    CSI71m    "+clr)
	dk_echo("    CSI72m             "+CSI+"72m    CSI72m    "+clr)
	dk_echo("    CSI73m             "+CSI+"73m    CSI73m    "+clr)
	dk_echo("    CSI74m             "+CSI+"74m    CSI74m    "+clr)
	dk_echo("    CSI75m             "+CSI+"75m    CSI75m    "+clr)
	dk_echo("    CSI76m             "+CSI+"76m    CSI76m    "+clr)
	dk_echo("    CSI77m             "+CSI+"77m    CSI77m    "+clr)
	dk_echo("    CSI78m             "+CSI+"78m    CSI78m    "+clr)
	dk_echo("    CSI79m             "+CSI+"79m    CSI79m    "+clr)
	dk_echo("    CSI80m             "+CSI+"80m    CSI80m    "+clr)
	dk_echo("    CSI81m             "+CSI+"81m    CSI81m    "+clr)
	dk_echo("    CSI82m             "+CSI+"82m    CSI82m    "+clr)
	dk_echo("    CSI83m             "+CSI+"83m    CSI83m    "+clr)
	dk_echo("    CSI84m             "+CSI+"84m    CSI84m    "+clr)
	dk_echo("    CSI85m             "+CSI+"85m    CSI85m    "+clr)
	dk_echo("    CSI86m             "+CSI+"86m    CSI86m    "+clr)
	dk_echo("    CSI87m             "+CSI+"87m    CSI87m    "+clr)
	dk_echo("    CSI88m             "+CSI+"88m    CSI88m    "+clr)
	dk_echo("    CSI89m             "+CSI+"89m    CSI89m    "+clr)
	dk_echo("    CSI90m             "+CSI+"90m    CSI90m    "+clr)
	dk_echo("    CSI91m             "+CSI+"91m    CSI91m    "+clr)
	dk_echo("    CSI92m             "+CSI+"92m    CSI92m    "+clr)
	dk_echo("    CSI93m             "+CSI+"93m    CSI93m    "+clr)
	dk_echo("    CSI94m             "+CSI+"94m    CSI94m    "+clr)
	dk_echo("    CSI95m             "+CSI+"95m    CSI95m    "+clr)
	dk_echo("    CSI96m             "+CSI+"96m    CSI96m    "+clr)
	dk_echo("    CSI97m             "+CSI+"97m    CSI97m    "+clr)
	dk_echo("    CSI98m             "+CSI+"98m    CSI98m    "+clr)
	dk_echo("    CSI99m             "+CSI+"99m    CSI99m    "+clr)
	dk_echo("    CSI100m            "+CSI+"100m    CSI100m    "+clr)
	dk_echo("    CSI101m            "+CSI+"101m    CSI101m    "+clr)
	dk_echo("    CSI102m            "+CSI+"102m    CSI102m    "+clr)
	dk_echo("    CSI103m            "+CSI+"103m    CSI103m    "+clr)
	dk_echo("    CSI104m            "+CSI+"104m    CSI104m    "+clr)
	dk_echo("    CSI105m            "+CSI+"105m    CSI105m    "+clr)
	dk_echo("    CSI106m            "+CSI+"106m    CSI106m    "+clr)
	dk_echo("    CSI107m            "+CSI+"107m    CSI107m    "+clr)
	dk_echo("    CSI108m            "+CSI+"108m    CSI108m    "+clr)
	dk_echo("    CSI109m            "+CSI+"109m    CSI109m    "+clr)
	dk_echo("    CSI110m            "+CSI+"110m    CSI110m    "+clr)
	dk_echo("    CSI111m            "+CSI+"111m    CSI111m    "+clr)
	dk_echo("    CSI112m            "+CSI+"112m    CSI112m    "+clr)
	dk_echo("    CSI113m            "+CSI+"113m    CSI113m    "+clr)
	dk_echo("    CSI114m            "+CSI+"114m    CSI114m    "+clr)
	dk_echo("    CSI115m            "+CSI+"115m    CSI115m    "+clr)
	dk_echo("    CSI116m            "+CSI+"116m    CSI116m    "+clr)
	dk_echo("    CSI117m            "+CSI+"117m    CSI117m    "+clr)
	dk_echo("    CSI118m            "+CSI+"118m    CSI118m    "+clr)
	dk_echo("    CSI119m            "+CSI+"119m    CSI119m    "+clr)
	dk_echo("    CSI120m            "+CSI+"120m    CSI120m    "+clr)
	dk_echo("    CSI121m            "+CSI+"121m    CSI121m    "+clr)
	dk_echo("    CSI122m            "+CSI+"122m    CSI122m    "+clr)
	dk_echo("    CSI123m            "+CSI+"123m    CSI123m    "+clr)
	dk_echo("    CSI124m            "+CSI+"124m    CSI124m    "+clr)
	dk_echo("    CSI125m            "+CSI+"125m    CSI125m    "+clr)
	dk_echo("    CSI126m            "+CSI+"126m    CSI126m    "+clr)
	dk_echo("    CSI127m            "+CSI+"127m    CSI127m    "+clr)
	dk_echo("    CSI?12h            "+CSI+"?12h    CSI?12h    "+clr)
	dk_echo("    CSI?12l            "+CSI+"?12l    CSI?12l    "+clr)
	dk_echo("")
	dk_echo(black+bg_lblack+"                  Styles                "+clr)
	dk_echo("    clr                "+clr+"  default  "+clr)
	dk_echo("    bright             "+bright+"  bright  "+clr)
	dk_echo("    nobright           "+nobright+"  nobright  "+clr)
	dk_echo("    dark               "+dark+"  dark  "+clr)
	dk_echo("    nodark             "+nodark+"  nodark  "+clr)
	dk_echo("    italic             "+italic+"  italic  "+clr)
	dk_echo("    noitalic           "+noitalic+"  noitalic  "+clr)
	dk_echo("    underline          "+underline+"  underline  "+clr)
	dk_echo("    nounderline        "+nounderline+"  nounderline  "+clr)
	dk_echo("    blink              "+blink+"  blink  "+clr)
	dk_echo("    noblink            "+noblink+"  noblink  "+clr)
	dk_echo("    fblink             "+fblink+"  fblink  "+clr)
	dk_echo("    nofblink           "+nofblink+"  nofblink  "+clr)
	dk_echo("    negative           "+negative+"  negative  "+clr)
	dk_echo("    nonegative         "+nonegative+"  nonegative  "+clr)
	dk_echo("    invisible          "+invisible+"  invisible  "+clr)
	dk_echo("    noinvisible        "+noinvisible+"  noinvisible  "+clr)
	dk_echo("    strike             "+strike+"  strike  "+clr)
	dk_echo("    nostrike           "+nostrike+"  nostrike  "+clr)
	dk_echo("")
	dk_echo("")
	dk_echo(black+bg_lblack+"           Style Combinations           "+clr)
	dk_echo("    bright,italic      "+bright+"  "+italic+" bright,italic    "+clr)
	dk_echo("    bright,underline   "+bright+"  "+underline+" bright,underline    "+clr)
	dk_echo("    bright,negative    "+bright+"  "+negative+" bright,negative    "+clr)
	dk_echo("    bright,strike      "+bright+"  "+strike+" bright,strike    "+clr)
	dk_echo("")
	dk_echo("")
	dk_echo(black+" "+bg_lblack+"           Color Combinations           "+clr)
	dk_echo("    dark black          "+dark+black+" dark black "+clr)
	dk_echo("    black              "+black+" black "+clr)
	dk_echo("    bright black       "+bright+black+" bright black "+clr)
	dk_echo("    dark red            "+dark+red+" dark red "+clr)
	dk_echo("    red                "+red+" red "+clr)
	dk_echo("    bright red         "+bright+red+" bright red "+clr)
	dk_echo("    dark green          "+dark+""+green+" dark green "+clr)
	dk_echo("    green              "+green+" green "+clr)
	dk_echo("    bright green       "+bright+""+green+" bright green "+clr)
	dk_echo("    dark yellow         "+dark+""+yellow+" dark yellow "+clr)
	dk_echo("    yellow             "+yellow+" yellow "+clr)
	dk_echo("    bright yellow      "+bright+""+yellow+" bright yellow "+clr)
	dk_echo("    dark blue           "+dark+""+blue+" dark blue "+clr)
	dk_echo("    blue               "+blue+" blue "+clr)
	dk_echo("    bright blue        "+bright+""+blue+" bright blue "+clr)
	dk_echo("    dark magenta        "+dark+""+magenta+" dark magenta "+clr)
	dk_echo("    magenta            "+magenta+" magenta "+clr)
	dk_echo("    bright magenta     "+bright+""+magenta+" bright magenta "+clr)
	dk_echo("    dark cyan           "+dark+""+cyan+" dark cyan "+clr)
	dk_echo("    cyan               "+cyan+" cyan "+clr)
	dk_echo("    bright cyan        "+bright+""+cyan+" bright cyan "+clr)
	dk_echo("    dark white          "+dark+""+white+" dark white "+clr)
	dk_echo("    white              "+white+" white "+clr)
	dk_echo("    bright white       "+bright+""+white+" bright white "+clr)
	dk_echo("")
	dk_echo("")
	dk_echo(black+" "+bg_lblack+"            Foreground Colors           "+clr)
	dk_echo("    black              "+black+" black "+fg_clr)
	dk_echo("    red                "+red+" red "+fg_clr)
	dk_echo("    green              "+green+" green "+fg_clr)
	dk_echo("    yellow             "+yellow+" yellow "+fg_clr)
	dk_echo("    blue               "+blue+" blue "+fg_clr)
	dk_echo("    magenta            "+magenta+" magenta "+fg_clr)
	dk_echo("    cyan               "+cyan+" cyan "+fg_clr)
	dk_echo("    white              "+white+" white "+fg_clr)
	dk_echo("")
	dk_echo("")
	dk_echo(black+" "+bg_lblack+"            Background Colors           "+clr)
	dk_echo("    bg_black           "+bg_black+" bg_black   "+bg_clr)
	dk_echo("    bg_red             "+bg_red+" bg_red   "+bg_clr)
	dk_echo("    bg_green           "+bg_green+" bg_green   "+bg_clr)
	dk_echo("    bg_yellow          "+bg_yellow+" bg_yellow   "+bg_clr)
	dk_echo("    bg_blue            "+bg_blue+" bg_blue   "+bg_clr)
	dk_echo("    bg_magenta         "+bg_magenta+" bg_magenta   "+bg_clr)
	dk_echo("    bg_cyan            "+bg_cyan+" bg_cyan   "+bg_clr)
	dk_echo("    bg_white           "+bg_white+" bg_white   "+bg_clr)
	dk_echo("")
	dk_echo("")
	dk_echo(black+" "+bg_lblack+"       Foreground Colors    bright      "+clr)
	dk_echo("    lblack             "+lblack+" lblack "+clr)
	dk_echo("    lred               "+lred+" lred "+clr)
	dk_echo("    lgreen             "+lgreen+" lgreen "+clr)
	dk_echo("    lyellow            "+lyellow+" lyellow "+clr)
	dk_echo("    lblue              "+lblue+" lblue "+clr)
	dk_echo("    lmagenta           "+lmagenta+" lmagenta "+clr)
	dk_echo("    lcyan              "+lcyan+" lcyan "+clr)
	dk_echo("    lwhite             "+lwhite+" lwhite "+clr)
	dk_echo("")
	dk_echo("")
	dk_echo(black+" "+bg_lblack+"       Background Colors - bright       "+clr)
	dk_echo("    bg_lblack          "+bg_lblack+black+"   bg_lblack    "+clr)
	dk_echo("    bg_lred            "+bg_lred+""+black+"     bg_lred    "+clr)
	dk_echo("    bg_lgreen          "+bg_lgreen+""+black+"   bg_lgreen    "+clr)
	dk_echo("    bg_lyellow         "+bg_lyellow+""+black+"  bg_lyellow    "+clr)
	dk_echo("    bg_lblue           "+bg_lblue+""+black+"    bg_lblue    "+clr)
	dk_echo("    bg_lmagenta        "+bg_lmagenta+""+black+" bg_lmagenta    "+clr)
	dk_echo("    bg_lcyan           "+bg_lcyan+""+black+"    bg_lcyan    "+clr)
	dk_echo("    bg_lwhite          "+bg_lwhite+""+black+"   bg_lwhite    "+clr)
	dk_echo("")
	dk_echo("")
	dk_echo(black+" "+bg_lblack+"         RGB Foreground Colors          "+clr)
	
' ######### FIXME: ; characters must be specially handled in vbs script ############
'	dk_echo("    "+RGB+"255;10;10m      RGB255;0;10m     "+clr)
'	dk_echo("    "+RGB+"10;255;10m      RGB 0;255;10    "+clr)
'	dk_echo("    "+RGB+"0;0;255m      RGB 0;0;255    "+clr)
'	dk_echo("    "+RGB+"0;0;250m      RGB 0;0;250    "+clr)
'	dk_echo("    "+RGB+"0;0;245m      RGB 0;0;245    "+clr)
'	dk_echo("    "+RGB+"0;0;240m      RGB 0;0;240    "+clr)
'	dk_echo("    "+RGB+"0;0;235m      RGB 0;0;235    "+clr)
'	dk_echo("    "+RGB+"0;0;230m      RGB 0;0;230    "+clr)
'	dk_echo("    "+RGB+"0;0;225m      RGB 0;0;225    "+clr)
'	dk_echo("    "+RGB+"0;0;220m      RGB 0;0;220    "+clr)
'	dk_echo("    "+RGB+"0;0;215m      RGB 0;0;215    "+clr)
'	dk_echo("    "+RGB+"0;0;210m      RGB 0;0;210    "+clr)
'	dk_echo("    "+RGB+"0;0;205m      RGB 0;0;205    "+clr)
'	dk_echo("    "+RGB+"0;0;200m      RGB 0;0;200    "+clr)
'	dk_echo("    "+RGB+"0;0;195m      RGB 0;0;195    "+clr)
'	dk_echo("    "+RGB+"0;0;190m      RGB 0;0;190    "+clr)
'	dk_echo("    "+RGB+"0;0;185m      RGB 0;0;185    "+clr)
'	dk_echo("    "+RGB+"0;0;180m      RGB 0;0;180    "+clr)
'	dk_echo("    "+RGB+"0;0;175m      RGB 0;0;175    "+clr)
'	dk_echo("    "+RGB+"0;0;170m      RGB 0;0;170    "+clr)
'	dk_echo("    "+RGB+"0;0;165m      RGB 0;0;165    "+clr)
'	dk_echo("    "+RGB+"0;0;160m      RGB 0;0;160    "+clr)
'	dk_echo("    "+RGB+"0;0;155m      RGB 0;0;155    "+clr)
'	dk_echo("    "+RGB+"0;0;150m      RGB 0;0;150    "+clr)
'	dk_echo("    "+RGB+"0;0;145m      RGB 0;0;145    "+clr)
'	dk_echo("    "+RGB+"0;0;140m      RGB 0;0;140    "+clr)
'	dk_echo("    "+RGB+"0;0;135m      RGB 0;0;135    "+clr)
'	dk_echo("    "+RGB+"0;0;130m      RGB 0;0;130    "+clr)
'	dk_echo("    "+RGB+"0;0;125m      RGB 0;0;125    "+clr)
'	dk_echo("    "+RGB+"0;0;120m      RGB 0;0;120    "+clr)
'	dk_echo("    "+RGB+"0;0;115m      RGB 0;0;115    "+clr)
'	dk_echo("    "+RGB+"0;0;110m      RGB 0;0;110    "+clr)
'	dk_echo("    "+RGB+"0;0;105m      RGB 0;0;105    "+clr)
'	dk_echo("    "+RGB+"0;0;100m      RGB 0;0;100    "+clr)
'	dk_echo("    "+RGB+"0;0;95m      RGB 0;0;95     "+clr)
'	dk_echo("    "+RGB+"0;0;90m      RGB 0;0;90     "+clr)
'	dk_echo("    "+RGB+"0;0;85m      RGB 0;0;85     "+clr)
'	dk_echo("    "+RGB+"0;0;80m      RGB 0;0;80     "+clr)
'	dk_echo("    "+RGB+"0;0;75m      RGB 0;0;75     "+clr)
'	dk_echo("    "+RGB+"0;0;70m      RGB 0;0;70     "+clr)
'	dk_echo("    "+RGB+"0;0;65m      RGB 0;0;65     "+clr)
'	dk_echo("    "+RGB+"0;0;60m      RGB 0;0;60     "+clr)
'	dk_echo("    "+RGB+"0;0;55m      RGB 0;0;55     "+clr)
'	dk_echo("    "+RGB+"0;0;50m      RGB 0;0;50     "+clr)
'	dk_echo("    "+RGB+"0;0;45m      RGB 0;0;45     "+clr)
'	dk_echo("    "+RGB+"0;0;40m      RGB 0;0;40     "+clr)
'	dk_echo("    "+RGB+"0;0;35m      RGB 0;0;35     "+clr)
'	dk_echo("    "+RGB+"0;0;30m      RGB 0;0;30     "+clr)
'	dk_echo("    "+RGB+"0;0;25m      RGB 0;0;25     "+clr)
'	dk_echo("    "+RGB+"0;0;20m      RGB 0;0;20     "+clr)
'	dk_echo("    "+RGB+"0;0;15m      RGB 0;0;15     "+clr)
'	dk_echo("    "+RGB+"0;0;10m      RGB 0;0;10     "+clr)
'	dk_echo("    "+RGB+"0;0;5m      RGB 0;0;5      "+clr)
'	dk_echo("    "+RGB+"0;0;0m      RGB 0;0;0      "+clr)
	dk_echo("")
	dk_echo("")
	dk_echo(black+" "+bg_lblack+"          RGB Background Colors         "+clr)
' ######### FIXME: ; characters must be specially handled in vbs script ############
'	dk_echo("    "+bg_RGB+"255;10;10m      bg_RGB 255;0;10    "+clr)
'	dk_echo("    "+bg_RGB+"10;255;10m      bg_RGB 0;255;10    "+clr)
'	dk_echo("    "+bg_RGB+"0;0;255m      bg_RGB 0;0;255     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;250m      bg_RGB 0;0;250     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;245m      bg_RGB 0;0;245     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;240m      bg_RGB 0;0;240     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;235m      bg_RGB 0;0;235     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;230m      bg_RGB 0;0;230     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;225m      bg_RGB 0;0;225     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;220m      bg_RGB 0;0;220     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;215m      bg_RGB 0;0;215     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;210m      bg_RGB 0;0;210     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;205m      bg_RGB 0;0;205     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;200m      bg_RGB 0;0;200     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;195m      bg_RGB 0;0;195     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;190m      bg_RGB 0;0;190     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;185m      bg_RGB 0;0;185     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;180m      bg_RGB 0;0;180     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;175m      bg_RGB 0;0;175     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;170m      bg_RGB 0;0;170     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;165m      bg_RGB 0;0;165     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;160m      bg_RGB 0;0;160     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;155m      bg_RGB 0;0;155     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;150m      bg_RGB 0;0;150     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;145m      bg_RGB 0;0;145     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;140m      bg_RGB 0;0;140     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;135m      bg_RGB 0;0;135     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;130m      bg_RGB 0;0;130     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;125m      bg_RGB 0;0;125     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;120m      bg_RGB 0;0;120     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;115m      bg_RGB 0;0;115     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;110m      bg_RGB 0;0;110     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;105m      bg_RGB 0;0;105     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;100m      bg_RGB 0;0;100     "+clr)
'	dk_echo("    "+bg_RGB+"0;0;95m      bg_RGB 0;0;95      "+clr)
'	dk_echo("    "+bg_RGB+"0;0;90m      bg_RGB 0;0;90      "+clr)
'	dk_echo("    "+bg_RGB+"0;0;85m      bg_RGB 0;0;85      "+clr)
'	dk_echo("    "+bg_RGB+"0;0;80m      bg_RGB 0;0;80      "+clr)
'	dk_echo("    "+bg_RGB+"0;0;75m      bg_RGB 0;0;75      "+clr)
'	dk_echo("    "+bg_RGB+"0;0;70m      bg_RGB 0;0;70      "+clr)
'	dk_echo("    "+bg_RGB+"0;0;65m      bg_RGB 0;0;65      "+clr)
'	dk_echo("    "+bg_RGB+"0;0;60m      bg_RGB 0;0;60      "+clr)
'	dk_echo("    "+bg_RGB+"0;0;55m      bg_RGB 0;0;55      "+clr)
'	dk_echo("    "+bg_RGB+"0;0;50m      bg_RGB 0;0;50      "+clr)
'	dk_echo("    "+bg_RGB+"0;0;45m      bg_RGB 0;0;45      "+clr)
'	dk_echo("    "+bg_RGB+"0;0;40m      bg_RGB 0;0;40      "+clr)
'	dk_echo("    "+bg_RGB+"0;0;35m      bg_RGB 0;0;35      "+clr)
'	dk_echo("    "+bg_RGB+"0;0;30m      bg_RGB 0;0;30      "+clr)
'	dk_echo("    "+bg_RGB+"0;0;25m      bg_RGB 0;0;25      "+clr)
'	dk_echo("    "+bg_RGB+"0;0;20m      bg_RGB 0;0;20      "+clr)
'	dk_echo("    "+bg_RGB+"0;0;15m      bg_RGB 0;0;15      "+clr)
'	dk_echo("    "+bg_RGB+"0;0;10m      bg_RGB 0;0;10      "+clr)
'	dk_echo("    "+bg_RGB+"0;0;5m      bg_RGB 0;0;5       "+clr)
'	dk_echo("    "+bg_RGB+"0;0;0m      bg_RGB 0;0;0       "+clr)
	dk_echo("") 
	dk_echo("")
	dk_echo(black+" "+bg_lblack+"              Combinations              "+clr)
	dk_echo("negative                  "+negative+"       inverse foreground / background        "+clr)
	dk_echo("bg_yellow,red             "+bg_yellow+red+"      yellow backgroud / red foreground       "+clr)
	dk_echo("bg_yellow,red,negative    "+bg_yellow+red+negative+"             yellow / red inversed            "+clr)
	dk_echo("bg_red,bg_green,bg_blue   "+bg_red+"     nested     "+bg_green+"     colors     "+bg_blue+"     text     "+clr)
	dk_echo("")
	dk_echo("")
	dk_echo(black+" "+bg_lblack+"             ASCII Color Art            "+clr)
	dk_echo("")
	dk_echo("    "+bg_blue+" * * * * * * * * * "+bg_red+"                                "+clr)
	dk_echo("    "+bg_blue+"  * * * * * * * *  "+bg_white+"                                "+clr)
	dk_echo("    "+bg_blue+" * * * * * * * * * "+bg_red+"                                "+clr) 
	dk_echo("    "+bg_blue+"  * * * * * * * *  "+bg_white+"                                "+clr)
	dk_echo("    "+bg_blue+" * * * * * * * * * "+bg_red+"                                "+clr)
	dk_echo("    "+bg_blue+"  * * * * * * * *  "+bg_white+"                                "+clr)
	dk_echo("    "+bg_blue+" * * * * * * * * * "+bg_red+"                                "+clr)
	dk_echo("    "+bg_white+"                                                   "+clr)
	dk_echo("    "+bg_red+"                                                   "+clr)
	dk_echo("    "+bg_white+"                                                   "+clr)
	dk_echo("    "+bg_red+"                                                   "+clr)
	dk_echo("    "+bg_white+"                                                   "+clr)
	dk_echo("    "+bg_red+"                                                   "+clr)
	dk_echo("")
	dk_echo("")
	dk_echo(black+" "+bg_lblack+"               ASCII Mode               "+clr)
	dk_echo(ASCII+" a b c d e f g h i j k l m n o p q r s t u v w x y z")
	dk_echo("")
	dk_echo("")
	dk_echo(black+" "+bg_lblack+"                DEC Mode                "+clr)
	dk_echo(DEC+" a b c d e f g h i j k l m n o p q r s t u v w x y z")
	dk_echo(ASCII+"")
	dk_echo("")
	dk_echo("")

end function	
end if