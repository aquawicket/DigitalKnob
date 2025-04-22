@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::##################################################################################
::# dk_color(on/off)
::#
::# Enable / Disable console text and background coloring
::#
::#		on/off:		Default ON
::#
::#		https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
::#		https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
::#		https://learn.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences
::#
:dk_color
::setlocal
	%dk_call% dk_debugFunc 0 1

	(set USE_COLOR=1)
	if defined %1 if %1 equ 0 (set USE_COLOR=)


	:USE_COLOR_if
	if not defined USE_COLOR goto USE_COLOR_else

		::(set ESC="																&:: escape character	BAD: Uncopyable character
		::for /f %%A in ('echo prompt $E^| cmd') do (set ESC=%%A)					&:: escape character	BAD: cryptic
		::for /f %%A in ('forfiles /c "%COMSPEC% /c echo 0x1B"') do (set ESC=%%A)	&:: escape character	BAD: Very slow
		::for /l %%A in (27,1,1) do (cmd /c exit %%A & (set ESC=!^=ExitCodeAscii!)) &:: escape character	GOOD: Converts DECIMAL to ASCII

		::for /l %%A in (0,1,126)	do (cmd /c exit %%A & set /a "C%%A=!^=ExitCodeAscii!" & echo C%%A = !C%%A! >> ascii.txt)

		::############ C0 control codes #############
		(set NUL=)							&:: Null - Does nothing. The code of blank paper tape, and also used for padding to slow transmission
		(set SOH=)							&:: Start of Heading - First character of the heading of a message
		(set STX=)							&:: Start of Text - Terminates the header and starts the message text
		(set ETX=)							&:: End of Text - Ends the message text, starts a footer (up to the next TC character)
		(set EOT=)							&:: End of Transmission - Ends the transmission of one or more messages. May place terminals on standby.
		(set EQN=)							&:: Enquiry - Trigger a response at the receiving end, to see if it is still present.
		(set ACK=)							&:: Acknowledge - Indication of successful receipt of a message.
		(set BEL=)							&:: Bell, Alert	- Call for attention from an operator.
		(set BS=)							&:: Backspace - Move one position leftwards. Next character may overprint or replace the character that was there.
		(set HT=	)						&:: Character Tabulation, Horizontal Tabulation	- Move right to the next tab stop.
		(set LF=^
%= This creates a Line Feed - DO NOT ALTER =%
)											&:: Line Feed - Move down to the same position on the next line (some devices also moved to the left column).
		(set VT=)							&:: Line Tabulation, Vertical Tabulation - Move down to the next vertical tab stop.
		(set FF=)							&:: Form Feed - Move down to the top of the next page.
		for /f %%a in ('copy /Z "%~dpf0" nul') do (set CR=%%a)	 &:: Carriage Return - Move to column zero while staying on the same line.
		(set SO=)							&:: Shift Out - Switch to an alternative character set.
		(set SI=)							&:: Shift In - Return to regular character set after SO.
		(set DLE=)							&:: Data Link Escape - Cause a number of contiguously following characters to be interpreted in some different way
		(set DC1=)							&:: Device Control One - Turn on (DC1 and DC2) or off (DC3 and DC4) devices.
		(set DC2=)							&:: Device Control Two
		(set DC3=)							&:: Device Control Three
		(set DC4=)							&:: Device Control Four
		(set NAK=)							&:: Negative Acknowledge - Negative response to a sender, such as a detected error.
		(set SYN=)							&:: Synchronous Idle - Sent in synchronous transmission systems when no other character is being transmitted.
		(set ETB=)							&:: End of Transmission Block - End of a transmission block of data when data are divided into such blocks.
		(set CAN=)							&:: Cancel - Indicates that the data preceding it are in error or are to be disregarded.
		(set EM=)							&:: End of medium - Indicates on paper or magnetic tapes that the end of the usable tape had been reached.
		(set SUB=)							&:: Substitute -Replaces a character that was found to be invalid or in error. Should be ignored.
		(set ESC=)							&:: Escape - Alters the meaning of a limited number of following bytes.
		(set FS=)							&:: File Separator - Can be used as delimiters to mark fields of data structures. 
		(set GS=)							&:: Group Separator
		(set RS=)							&:: Record Separator
		(set US=)							&:: Unit Separator - US is the lowest level
		(set SP= )							&:: Space - Move right one character position.
		(set DEL=)							&:: Delete - Should be ignored. Used to delete characters on punched tape by punching out all the holes.

		::############ C1 control codes #############
		(set PAD=%ESC%@)					&:: Padding Character
		(set HOP=%ESC%A)					&:: High Octet Preset
		(set BPH=%ESC%B)					&:: Break Permitted Here
		(set NBH=%ESC%C)					&:: No Break Here
		(set IND=%ESC%D)					&:: Index
		(set NEL=%ESC%E)					&:: Next Line
		(set SSA=%ESC%F)					&:: Start of Selected Area
		(set ESA=%ESC%G)					&:: End of Selected Area
		(set HTS=%ESC%H)					&:: Horizontal Tabulation Set
		(set HTJ=%ESC%I)					&:: Horizontal Tabulation With Justification
		(set VTS=%ESC%J)					&:: Vertical Tabulation Set
		(set PLD=%ESC%K)					&:: Partial Line Down
		(set PLU=%ESC%L)					&:: Partial Line Up
		(set RI=%ESC%M)						&:: Reverse Index
		(set SS2=%ESC%N)					&:: Single Shift Two
		(set SS3=%ESC%O)					&:: Single Shift Three
		(set DCS=%ESC%P)					&:: Device Control String
		(set PU1=%ESC%Q)					&:: Private Use 1
		(set PU2=%ESC%R)					&:: Private Use 2
		(set STS=%ESC%S)					&:: Set Transmit State
		(set CCH=%ESC%T)					&:: Cancel character
		(set MW=%ESC%U)						&:: Message Waiting
		(set SPA=%ESC%V)					&:: Start of Protected Area
		(set EPA=%ESC%W)					&:: End of Protected Area
		(set SOS=%ESC%X)					&:: Start of String
		(set SGC=%ESC%Y)					&:: Single Graphic Character Introducer
		(set SCI=%ESC%Z)					&:: Single Character Introducer
		(set CSI=%ESC%[)					&:: Control Sequence Introducer
		(set ST=%ESC%\)						&:: String Terminator
		(set OSC=%ESC%])					&:: Operating System Command
		(set PM=%ESC%^^)					&:: Privacy Message
		(set APC=%ESC%_)					&:: Application Program Command

		(set DECSC=%ESC%7)					&:: Save Cursor Position in Memory**
		(set DECSR=%ESC%8)					&:: Restore Cursor Position from Memory**

		(set DECSCUSR0=%ESC%0%SP%q)			&:: User Shape
		(set DECSCUSR1=%ESC%1%SP%q)			&:: Blinking Block
		(set DECSCUSR2=%ESC%2%SP%q)			&:: Steady Block
		(set DECSCUSR3=%ESC%3%SP%q)			&:: Blinking Underline
		(set DECSCUSR4=%ESC%4%SP%q)			&:: Steady Underline
		(set DECSCUSR5=%ESC%5%SP%q)			&:: Blinking Bar
		(set DECSCUSR6=%ESC%6%SP%q)			&:: Steady Bar

		::############ CSI Commands #############
		(set CCU=%CSI%A)					&:: Cursor Up 1 - Moves the cursor 1 cell in the given direction. If the cursor is already at the edge of the screen, this has no effect.
		::(set CCU=%CSI%<n>A)				&:: Cursor Up -	Moves the cursor n (default 1) cells in the given direction. If the cursor is already at the edge of the screen, this has no effect.
		(set CUD=%CSI%B)					&:: Cursor Down 1
		::(set CCU=%CSI%<n>B)				&:: Cursor Down
		(set CUF=%CSI%C)					&:: Cursor Forward 1
		::(set CCU=%CSI%<n>C)				&:: Cursor Forward
		(set CUB=%CSI%D)					&:: Cursor Back 1
		::(set CCU=%CSI%<n>D)				&:: Cursor Back
		(set CNL=%CSI%E)					&:: Cursor Next Line 1 - Moves cursor to beginning of the line 1 line down. (not ANSI.SYS)
		::(set CCU=%CSI%<n>E)				&:: Cursor Next Line - Moves cursor to beginning of the line n (default 1) lines down. (not ANSI.SYS)
		(set CPL=%CSI%F)					&:: Cursor Previous Line 1 - Moves cursor to beginning of the line 1 line up. (not ANSI.SYS)
		::(set CCU=%CSI%<n>F)				&:: Cursor Previous Line - Moves cursor to beginning of the line n (default 1) lines up. (not ANSI.SYS)
		(set CHA=%CSI%G)					&:: Cursor Horizontal Absolute 1 - Moves the cursor to column 1. (not ANSI.SYS)
		::(set CCU=%CSI%<n>G)				&:: Cursor Horizontal Absolute - Moves the cursor to column n (default 1). (not ANSI.SYS)
		::(set CUP=%CSI%<n>;<m>H)			&:: Cursor Position	- Cursor moves to <x>; <y> coordinate within the viewport, where <x> is the column of the <y> line
		::(set HVP=%CSI%<y>;<x>f)			&:: Horizontal Vertical Position - Cursor moves to <x>; <y> coordinate within the viewport, where <x> is the column of the <y> line
		(set ANSISYSSC=%CSI%s)				&:: Save Cursor – **With no parameters, performs a save cursor operation like DECSC
		(set ANSISYSRC=%CSI%u)				&:: Restore Cursor - **With no parameters, performs a restore cursor operation like DECRC

		::CSI n J	ED						&:: Erase in Display - Clears part of the screen. If n is 0 (or missing), clear from cursor to end of screen. If n is 1, clear from cursor to beginning of the screen. If n is 2, clear entire screen (and moves cursor to upper left on DOS ANSI.SYS). If n is 3, clear entire screen and delete all lines saved in the scrollback buffer.
		::CSI n K	EL						&:: Erase in Line - Erases part of the line. If n is 0 (or missing), clear from cursor to the end of the line. If n is 1, clear from cursor to beginning of the line. If n is 2, clear entire line. Cursor position does not change.
		::CSI n S	SU						&:: Scroll Up - Scroll whole page up by n (default 1) lines. New lines are added at the bottom. (not ANSI.SYS)
		::CSI n T	SD						&:: Scroll Down	- Scroll whole page down by n (default 1) lines. New lines are added at the top. (not ANSI.SYS)
		::CSI n ; m f	HVP					&:: Horizontal Vertical Position - Same as CUP, but counts as a format effector function (like CR or LF) rather than an editor function (like CUD or CNL).
		::CSI n m	SGR						&:: Select Graphic Rendition - Sets colors and style of the characters following this code
		::CSI 5i							&:: AUX Port On	- Enable aux serial port usually for local serial printer
		::CSI 4i							&:: AUX Port Off - Disable aux serial port usually for local serial printer
		::CSI 6n	DSR						&:: Device Status Report - Reports the cursor position (CPR) by transmitting ESC[n;mR, where n is the row and m is the column.
		(set ATT160=%CSI%?12)				&:: Text Cursor Blink
		(set DECTCEM=%CSI%?25)				&:: Text Cursor Show/Hide
	
		::(SU=%CSI%<n>S)					&:: Scroll Up - Scroll text up by <n>. Also known as pan down, new lines fill in from the bottom of the screen
		::(SD=%CSI%<n>T)					&:: Scroll Down - Scroll down by <n>. Also known as pan up, new lines fill in from the top of the screen

		(set "DEC=%ESC%(0")					&:: Enables DEC Line Drawing Mode
		(set "ASCII=%ESC%(B")				&:: Enables ASCII Mode (Default)

		::# Cursor
		(set cursor_blink_on=%ATT160%h)		&:: Text Cursor Enable Blinking
		(set cursor_blink_off=%ATT160%l)	&:: Text Cursor Disable Blinking
		(set cursor_show=%DECTCEM%h)		&:: Text Cursor Enable Mode Show
		(set cursor_hide=%DECTCEM%l)		&:: Text Cursor Enable Mode Hide

		::# Attributes on
		(set clr=%CSI%0m)					&:: Default					Reset all modes (styles and colors)
		(set bright=%CSI%1m)				&:: Bright					Applies brightness flag to foreground color
		(set dim=%CSI%2m)					&:: Dim						Applies dim flag to foreground color
		(set italic=%CSI%3m)				&:: Italic
		(set underline=%CSI%4m)				&:: Underline
		(set blink=%CSI%5m)					&:: Blink
		(set fblink=%CSI%6m)				&:: Rapid Blink
		(set negative=%CSI%7m)				&:: Negative				Swaps foreground and background colors
		(set invisible=%CSI%8m)				&:: Invisible
		(set strike=%CSI%9m)				&:: Strike Through

		::# Attributes off
		::(set 20m=%CSI%20m)				&:: 20
		::(set 21m=%CSI%21m)				&:: 21
		(set nodim=%CSI%22m)				&:: No Dim					Removes brightness/intensity flag from foreground color
		(set nobright=%CSI%22m)				&:: No Bright				Removes brightness/intensity flag from foreground color
		(set noitalic=%CSI%23m)				&:: No Italic
		(set nounderline=%CSI%24m)			&:: No Underline
		(set noblink=%CSI%25m)				&:: No Blink
		::(set 26m=%CSI%26m)				&:: 26
		(set nonegative=%CSI%27m)			&:: No Negative				Returns foreground/background to normal
		(set visible=%CSI%28m)				&:: No Invisible
		(set nostrike=%CSI%29m)				&:: No Strike Through

		::# Foreground Colors
		(set black=%CSI%30m)				&:: Foreground Black			Applies non-dim/bright black to foreground
		(set red=%CSI%31m)					&:: Foreground Red				Applies non-dim/bright red to foreground
		(set green=%CSI%32m)				&:: Foreground Green			Applies non-dim/bright green to foreground
		(set yellow=%CSI%33m)				&:: Foreground Yellow			Applies non-dim/bright yellow to foreground
		(set blue=%CSI%34m)					&:: Foreground Blue				Applies non-dim/bright blue to foreground
		(set magenta=%CSI%35m)				&:: Foreground Magenta			Applies non-dim/bright magenta to foreground
		(set cyan=%CSI%36m)					&:: Foreground Cyan				Applies non-dim/bright cyan to foreground
		(set white=%CSI%37m)				&:: Foreground White			Applies non-dim/bright white to foreground
		(set extended=%CSI%38m)				&:: Foreground Extended			Applies extended color value to the foreground
		(set fg_clr=%CSI%39m)				&:: Foreground Default			Applies only the foreground portion of the defaults

		::# Background Colors
		(set bg_black=%CSI%40m)				&:: Background Black			Applies non-dim/bright black to background
		(set bg_red=%CSI%41m)				&:: Background Red				Applies non-dim/bright red to background
		(set bg_green=%CSI%42m)				&:: Background Green			Applies non-dim/bright green to background
		(set bg_yellow=%CSI%43m)			&:: Background Yellow			Applies non-dim/bright yellow to background
		(set bg_blue=%CSI%44m)				&:: Background Blue				Applies non-dim/bright blue to background
		(set bg_magenta=%CSI%45m)			&:: Background Magenta			Applies non-dim/bright magenta to background
		(set bg_cyan=%CSI%46m)				&:: Background Cyan				Applies non-dim/bright cyan to background
		(set bg_white=%CSI%47m)				&:: Background White			Applies non-dim/bright white to background
		(set bg_extended=%CSI%48m)			&:: Background Extended			Applies extended color value to the background
		(set bg_clr=%CSI%49m)	 			&:: Background Default			Applies only the background portion of the defaults

		::# Foreground Colors (light)
		(set lblack=%CSI%90m)				&:: Bright Foreground Black		Applies bright black to foreground
		(set lred=%CSI%91m)					&:: Bright Foreground Red		Applies bright red to foreground
		(set lgreen=%CSI%92m)				&:: Bright Foreground Green		Applies bright green to foreground
		(set lyellow=%CSI%93m)				&:: Bright Foreground Yellow	Applies bright yellow to foreground
		(set lblue=%CSI%94m)				&:: Bright Foreground Blue		Applies bright blue to foreground
		(set lmagenta=%CSI%95m)				&:: Bright Foreground Magenta	Applies bright magenta to foreground
		(set lcyan=%CSI%96m)				&:: Bright Foreground Cyan		Applies bright cyan to foreground
		(set lwhite=%CSI%97m)				&:: Bright Foreground White		Applies bright white to foreground

		::# Background Colors (light)
		(set bg_lblack=%CSI%100m)			&:: Bright Background Black		Applies bright black to background
		(set bg_lred=%CSI%101m)				&:: Bright Background Red		Applies bright red to background
		(set bg_lgreen=%CSI%102m)			&:: Bright Background Green		Applies bright green to background
		(set bg_lyellow=%CSI%103m)			&:: Bright Background Yellow	Applies bright yellow to background
		(set bg_lblue=%CSI%104m)			&:: Bright Background Blue		Applies bright blue to background
		(set bg_lmagenta=%CSI%105m)			&:: Bright Background Magenta	Applies bright magenta to background
		(set bg_lcyan=%CSI%106m)			&:: Bright Background Cyan		Applies bright cyan to background
		(set bg_lwhite=%CSI%107m)			&:: Bright Background White		Applies bright white to background

		::# Foreground RGB Colors
		(set RGB=%CSI%38;2;)				&:: %RGB%50;100;150m			%CSI%38;2;50;100;150m

		::# Background RGB Colors
		(set bg_RGB=%CSI%48;2;)				&:: %bg_RGB%150;100;50m			%CSI%38;2;150;100;50m

		%dk_call% dk_echo "%blue%C%green%O%red%L%magenta%O%cyan%R %blue%O%green%N%clr%"
	goto USE_COLOR_endif	
	:USE_COLOR_else
		::%dk_call% dk_unset ESC
		::%dk_call% dk_unset clr

		::# Attributes on
		%dk_call% dk_unset bright
		%dk_call% dk_unset dim
		%dk_call% dk_unset italic
		%dk_call% dk_unset underline
		%dk_call% dk_unset blink
		%dk_call% dk_unset fblink
		%dk_call% dk_unset negative
		%dk_call% dk_unset invisible
		%dk_call% dk_unset strike

		::# Attributes off
		%dk_call% dk_unset nobright
		%dk_call% dk_unset noitalic
		%dk_call% dk_unset nounderline
		%dk_call% dk_unset noblink
		%dk_call% dk_unset nonegative
		%dk_call% dk_unset visible
		%dk_call% dk_unset nostrike

		::# Foreground Colors
		%dk_call% dk_unset black
		%dk_call% dk_unset red
		%dk_call% dk_unset green
		%dk_call% dk_unset yellow
		%dk_call% dk_unset blue
		%dk_call% dk_unset magenta
		%dk_call% dk_unset cyan
		%dk_call% dk_unset white
		%dk_call% dk_unset extended
		::%dk_call% dk_unset fg_clr

		::# Background Colors
		%dk_call% dk_unset bg_black
		%dk_call% dk_unset bg_red
		%dk_call% dk_unset bg_green
		%dk_call% dk_unset bg_yellow
		%dk_call% dk_unset bg_blue
		%dk_call% dk_unset bg_magenta
		%dk_call% dk_unset bg_cyan
		%dk_call% dk_unset bg_white
		%dk_call% dk_unset bg_extended
		::%dk_call% dk_unset bg_clr

		::# Foreground Colors (bright)
		%dk_call% dk_unset lblack
		%dk_call% dk_unset lred
		%dk_call% dk_unset lgreen
		%dk_call% dk_unset lyellow
		%dk_call% dk_unset lblue
		%dk_call% dk_unset lmagenta
		%dk_call% dk_unset lcyan
		%dk_call% dk_unset lwhite

		::# Background Colors (bright)
		%dk_call% dk_unset bg_lblack
		%dk_call% dk_unset bg_lred
		%dk_call% dk_unset bg_lgreen
		%dk_call% dk_unset bg_lyellow
		%dk_call% dk_unset bg_lblue
		%dk_call% dk_unset bg_lmagenta
		%dk_call% dk_unset bg_lcyan
		%dk_call% dk_unset bg_lwhite

		%dk_call% dk_unset RGB
		%dk_call% dk_unset bg_RGB

		dk_echo "%clr% COLOR OFF"
	:USE_COLOR_endif
%endfunction%
%dk_call% dk_color 1



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	echo:
	echo %black% %bg_lblack%                 CSI codes              %clr%
	echo CSI0m       %CSI%0m    CSI0m    %clr%
	echo CSI1m       %CSI%1m    CSI1m    %clr%
	echo CSI2m       %CSI%2m    CSI2m    %clr%
	echo CSI3m       %CSI%3m    CSI3m    %clr%
	echo CSI4m       %CSI%4m    CSI4m    %clr%
	echo CSI5m       %CSI%5m    CSI5m    %clr%
	echo CSI6m       %CSI%6m    CSI6m    %clr%
	echo CSI7m       %CSI%7m    CSI7m    %clr%
	echo CSI8m       %CSI%8m    CSI8m    %clr%
	echo CSI9m       %CSI%9m    CSI9m    %clr%
	echo CSI10m      %CSI%10m    CSI10m    %clr%
	echo CSI11m      %CSI%11m    CSI11m    %clr%
	echo CSI12m      %CSI%12m    CSI12m    %clr%
	echo CSI13m      %CSI%13m    CSI13m    %clr%
	echo CSI14m      %CSI%14m    CSI14m    %clr%
	echo CSI15m      %CSI%15m    CSI15m    %clr%
	echo CSI16m      %CSI%16m    CSI16m    %clr%
	echo CSI17m      %CSI%17m    CSI17m    %clr%
	echo CSI18m      %CSI%18m    CSI18m    %clr%
	echo CSI19m      %CSI%19m    CSI19m    %clr%
	echo CSI20m      %CSI%20m    CSI20m    %clr%
	echo CSI21m      %CSI%21m    CSI21m    %clr%
	echo CSI22m      %CSI%22m    CSI22m    %clr%
	echo CSI23m      %CSI%23m    CSI23m    %clr%
	echo CSI24m      %CSI%24m    CSI24m    %clr%
	echo CSI25m      %CSI%25m    CSI25m    %clr%
	echo CSI26m      %CSI%26m    CSI26m    %clr%
	echo CSI27m      %CSI%27m    CSI27m    %clr%
	echo CSI28m      %CSI%28m    CSI28m    %clr%
	echo CSI29m      %CSI%29m    CSI29m    %clr%
	echo CSI30m      %CSI%30m    CSI30m    %clr%
	echo CSI31m      %CSI%31m    CSI31m    %clr%
	echo CSI32m      %CSI%32m    CSI32m    %clr%
	echo CSI33m      %CSI%33m    CSI33m    %clr%
	echo CSI34m      %CSI%34m    CSI34m    %clr%
	echo CSI35m      %CSI%35m    CSI35m    %clr%
	echo CSI36m      %CSI%36m    CSI36m    %clr%
	echo CSI37m      %CSI%37m    CSI37m    %clr%
	echo CSI38m      %CSI%38m    CSI38m    %clr%
	echo CSI39m      %CSI%39m    CSI39m    %clr%
	echo CSI40m      %CSI%40m    CSI40m    %clr%
	echo CSI41m      %CSI%41m    CSI41m    %clr%
	echo CSI42m      %CSI%42m    CSI42m    %clr%
	echo CSI43m      %CSI%43m    CSI43m    %clr%
	echo CSI44m      %CSI%44m    CSI44m    %clr%
	echo CSI45m      %CSI%45m    CSI45m    %clr%
	echo CSI46m      %CSI%46m    CSI46m    %clr%
	echo CSI47m      %CSI%47m    CSI47m    %clr%
	echo CSI48m      %CSI%48m    CSI48m    %clr%
	echo CSI49m      %CSI%49m    CSI49m    %clr%
	echo CSI50m      %CSI%50m    CSI50m    %clr%
	echo CSI51m      %CSI%51m    CSI51m    %clr%
	echo CSI52m      %CSI%52m    CSI52m    %clr%
	echo CSI53m      %CSI%53m    CSI53m    %clr%
	echo CSI54m      %CSI%54m    CSI54m    %clr%
	echo CSI55m      %CSI%55m    CSI55m    %clr%
	echo CSI56m      %CSI%56m    CSI56m    %clr%
	echo CSI57m      %CSI%57m    CSI57m    %clr%
	echo CSI58m      %CSI%58m    CSI58m    %clr%
	echo CSI59m      %CSI%59m    CSI59m    %clr%
	echo CSI60m      %CSI%60m    CSI60m    %clr%
	echo CSI61m      %CSI%61m    CSI61m    %clr%
	echo CSI62m      %CSI%62m    CSI62m    %clr%
	echo CSI63m      %CSI%63m    CSI63m    %clr%
	echo CSI64m      %CSI%64m    CSI64m    %clr%
	echo CSI65m      %CSI%65m    CSI65m    %clr%
	echo CSI66m      %CSI%66m    CSI66m    %clr%
	echo CSI67m      %CSI%67m    CSI67m    %clr%
	echo CSI68m      %CSI%68m    CSI68m    %clr%
	echo CSI69m      %CSI%69m    CSI69m    %clr%
	echo CSI70m      %CSI%70m    CSI70m    %clr%
	echo CSI71m      %CSI%71m    CSI71m    %clr%
	echo CSI72m      %CSI%72m    CSI72m    %clr%
	echo CSI73m      %CSI%73m    CSI73m    %clr%
	echo CSI74m      %CSI%74m    CSI74m    %clr%
	echo CSI75m      %CSI%75m    CSI75m    %clr%
	echo CSI76m      %CSI%76m    CSI76m    %clr%
	echo CSI77m      %CSI%77m    CSI77m    %clr%
	echo CSI78m      %CSI%78m    CSI78m    %clr%
	echo CSI79m      %CSI%79m    CSI79m    %clr%
	echo CSI80m      %CSI%80m    CSI80m    %clr%
	echo CSI81m      %CSI%81m    CSI81m    %clr%
	echo CSI82m      %CSI%82m    CSI82m    %clr%
	echo CSI83m      %CSI%83m    CSI83m    %clr%
	echo CSI84m      %CSI%84m    CSI84m    %clr%
	echo CSI85m      %CSI%85m    CSI85m    %clr%
	echo CSI86m      %CSI%86m    CSI86m    %clr%
	echo CSI87m      %CSI%87m    CSI87m    %clr%
	echo CSI88m      %CSI%88m    CSI88m    %clr%
	echo CSI89m      %CSI%89m    CSI89m    %clr%
	echo CSI90m      %CSI%90m    CSI90m    %clr%
	echo CSI91m      %CSI%91m    CSI91m    %clr%
	echo CSI92m      %CSI%92m    CSI92m    %clr%
	echo CSI93m      %CSI%93m    CSI93m    %clr%
	echo CSI94m      %CSI%94m    CSI94m    %clr%
	echo CSI95m      %CSI%95m    CSI95m    %clr%
	echo CSI96m      %CSI%96m    CSI96m    %clr%
	echo CSI97m      %CSI%97m    CSI97m    %clr%
	echo CSI98m      %CSI%98m    CSI98m    %clr%
	echo CSI99m      %CSI%99m    CSI99m    %clr%
	echo CSI100m     %CSI%100m    CSI100m    %clr%
	echo CSI101m     %CSI%101m    CSI101m    %clr%
	echo CSI102m     %CSI%102m    CSI102m    %clr%
	echo CSI103m     %CSI%103m    CSI103m    %clr%
	echo CSI104m     %CSI%104m    CSI104m    %clr%
	echo CSI105m     %CSI%105m    CSI105m    %clr%
	echo CSI106m     %CSI%106m    CSI106m    %clr%
	echo CSI107m     %CSI%107m    CSI107m    %clr%
	echo CSI108m     %CSI%108m    CSI108m    %clr%
	echo CSI109m     %CSI%109m    CSI109m    %clr%
	echo CSI110m     %CSI%110m    CSI110m    %clr%
	echo CSI111m     %CSI%111m    CSI111m    %clr%
	echo CSI112m     %CSI%112m    CSI112m    %clr%
	echo CSI113m     %CSI%113m    CSI113m    %clr%
	echo CSI114m     %CSI%114m    CSI114m    %clr%
	echo CSI115m     %CSI%115m    CSI115m    %clr%
	echo CSI116m     %CSI%116m    CSI116m    %clr%
	echo CSI117m     %CSI%117m    CSI117m    %clr%
	echo CSI118m     %CSI%118m    CSI118m    %clr%
	echo CSI119m     %CSI%119m    CSI119m    %clr%
	echo CSI120m     %CSI%120m    CSI120m    %clr%
	echo CSI121m     %CSI%121m    CSI121m    %clr%
	echo CSI122m     %CSI%122m    CSI122m    %clr%
	echo CSI123m     %CSI%123m    CSI123m    %clr%
	echo CSI124m     %CSI%124m    CSI124m    %clr%
	echo CSI125m     %CSI%125m    CSI125m    %clr%
	echo CSI126m     %CSI%126m    CSI126m    %clr%
	echo CSI127m     %CSI%127m    CSI127m    %clr%

	echo CSI?12h     %CSI%?12h    CSI?12h
	echo CSI?12l     %CSI%?12l    CSI?12l

	echo:
	echo %black% %bg_lblack%                  Styles                %clr%
	echo   clr                %clr%  default  %clr%
	echo   bright             %bright%  bright  %clr%
	echo   nobright           %nobright%  nobright  %clr%
	echo   dim                %dim%  dim  %clr%
	echo   nodim              %nodim%  nodim  %clr%
	echo   italic             %italic%  italic  %clr%
	echo   noitalic           %noitalic%  noitalic  %clr%
	echo   underline          %underline%  underline  %clr%
	echo   nounderline        %nounderline%  nounderline  %clr%
	echo   blink              %blink%  blink  %clr%
	echo   noblink            %noblink%  noblink  %clr%
	echo   fblink             %fblink%  fblink  %clr%
	echo   nofblink           %nofblink%  nofblink  %clr%
	echo   negative           %negative%  negative  %clr%
	echo   nonegative         %nonegative%  nonegative  %clr%
	echo   invisible          %invisible%  invisible  %clr%
	echo   noinvisible        %noinvisible%  noinvisible  %clr%
	echo   strike             %strike%  strike  %clr%
	echo   nostrike           %nostrike%  nostrike  %clr%
	echo %clr%
	echo:
	echo:
	echo %black% %bg_lblack%           Style Combinations           %clr%
	echo   bright,italic      %bright%  %italic% bright,italic    %clr%
	echo   bright,underline   %bright%  %underline% bright,underline    %clr%
	echo   bright,negative    %bright%  %negative% bright,negative    %clr%
	echo   bright,strike      %bright%  %strike% bright,strike    %clr%
	echo:
	echo:
	echo %black% %bg_lblack%           Color Combinations           %clr%
	echo   dim black          %dim%%black% dim black %clr%
	echo   black              %black% black %clr%
	echo   bright black       %bright%%black% bright black %clr%
	echo   dim red            %dim%%red% dim red %clr%
	echo   red                %red% red %clr%
	echo   bright red         %bright%%red% bright red %clr%
	echo   dim green          %dim%%green% dim green %clr%
	echo   green              %green% green %clr%
	echo   bright green       %bright%%green% bright green %clr%
	echo   dim yellow         %dim%%yellow% dim yellow %clr%
	echo   yellow             %yellow% yellow %clr%
	echo   bright yellow      %bright%%yellow% bright yellow %clr%
	echo   dim blue           %dim%%blue% dim blue %clr%
	echo   blue               %blue% blue %clr%
	echo   bright blue        %bright%%blue% bright blue %clr%
	echo   dim magenta        %dim%%magenta% dim magenta %clr%
	echo   magenta            %magenta% magenta %clr%
	echo   bright magenta     %bright%%magenta% bright magenta %clr%
	echo   dim cyan           %dim%%cyan% dim cyan %clr%
	echo   cyan               %cyan% cyan %clr%
	echo   bright cyan        %bright%%cyan% bright cyan %clr%
	echo   dim white          %dim%%white% dim white %clr%
	echo   white              %white% white %clr%
	echo   bright white       %bright%%white% bright white %clr%
	echo:
	echo:
	echo %black% %bg_lblack%            Foreground Colors           %clr%
	echo   black              %black% black %fg_clr%
	echo   red                %red% red %fg_clr%
	echo   green              %green% green %fg_clr%
	echo   yellow             %yellow% yellow %fg_clr%
	echo   blue               %blue% blue %fg_clr%
	echo   magenta            %magenta% magenta %fg_clr%
	echo   cyan               %cyan% cyan %fg_clr%
	echo   white              %white% white %fg_clr%
	echo:
	echo:
	echo %black% %bg_lblack%            Background Colors           %clr%
	echo   bg_black    %bg_black% bg_black   %bg_clr%
	echo   bg_red      %bg_red% bg_red   %bg_clr%
	echo   bg_green    %bg_green% bg_green   %bg_clr%
	echo   bg_yellow   %bg_yellow% bg_yellow   %bg_clr%
	echo   bg_blue     %bg_blue% bg_blue   %bg_clr%
	echo   bg_magenta  %bg_magenta% bg_magenta   %bg_clr%
	echo   bg_cyan     %bg_cyan% bg_cyan   %bg_clr%
	echo   bg_white    %bg_white% bg_white   %bg_clr%
	echo:
	echo:
	echo %black% %bg_lblack%       Foreground Colors    bright      %clr%
	echo   lblack      %lblack% lblack %clr%
	echo   lred        %lred% lred %clr%
	echo   lgreen      %lgreen% lgreen %clr%
	echo   lyellow     %lyellow% lyellow %clr%
	echo   lblue       %lblue% lblue %clr%
	echo   lmagenta    %lmagenta% lmagenta %clr%
	echo   lcyan       %lcyan% lcyan %clr%
	echo   lwhite      %lwhite% lwhite %clr%
	echo:
	echo:
	echo %black% %bg_lblack%       Background Colors - bright       %clr%
	echo   bg_lblack      %bg_lblack%%black%   bg_lblack    %clr%
	echo   bg_lred        %bg_lred%%black%     bg_lred    %clr%
	echo   bg_lgreen      %bg_lgreen%%black%   bg_lgreen    %clr%
	echo   bg_lyellow     %bg_lyellow%%black%  bg_lyellow    %clr%
	echo   bg_lblue       %bg_lblue%%black%    bg_lblue    %clr%
	echo   bg_lmagenta    %bg_lmagenta%%black% bg_lmagenta    %clr%
	echo   bg_lcyan       %bg_lcyan%%black%    bg_lcyan    %clr%
	echo   bg_lwhite      %bg_lwhite%%black%   bg_lwhite    %clr%
	echo:
	echo:
	echo %black% %bg_lblack%         RGB Foreground Colors          %clr%
	echo   %RGB%255;10;10m      RGB255;0;10m     %clr%
	echo   %RGB%10;255;10m      RGB 0;255;10    %clr%
	echo   %RGB%0;0;255m      RGB 0;0;255    %clr%
	echo   %RGB%0;0;250m      RGB 0;0;250    %clr%
	echo   %RGB%0;0;245m      RGB 0;0;245    %clr%
	echo   %RGB%0;0;240m      RGB 0;0;240    %clr%
	echo   %RGB%0;0;235m      RGB 0;0;235    %clr%
	echo   %RGB%0;0;230m      RGB 0;0;230    %clr%
	echo   %RGB%0;0;225m      RGB 0;0;225    %clr%
	echo   %RGB%0;0;220m      RGB 0;0;220    %clr%
	echo   %RGB%0;0;215m      RGB 0;0;215    %clr%
	echo   %RGB%0;0;210m      RGB 0;0;210    %clr%
	echo   %RGB%0;0;205m      RGB 0;0;205    %clr%
	echo   %RGB%0;0;200m      RGB 0;0;200    %clr%
	echo   %RGB%0;0;195m      RGB 0;0;195    %clr%
	echo   %RGB%0;0;190m      RGB 0;0;190    %clr%
	echo   %RGB%0;0;185m      RGB 0;0;185    %clr%
	echo   %RGB%0;0;180m      RGB 0;0;180    %clr%
	echo   %RGB%0;0;175m      RGB 0;0;175    %clr%
	echo   %RGB%0;0;170m      RGB 0;0;170    %clr%
	echo   %RGB%0;0;165m      RGB 0;0;165    %clr%
	echo   %RGB%0;0;160m      RGB 0;0;160    %clr%
	echo   %RGB%0;0;155m      RGB 0;0;155    %clr%
	echo   %RGB%0;0;150m      RGB 0;0;150    %clr%
	echo   %RGB%0;0;145m      RGB 0;0;145    %clr%
	echo   %RGB%0;0;140m      RGB 0;0;140    %clr%
	echo   %RGB%0;0;135m      RGB 0;0;135    %clr%
	echo   %RGB%0;0;130m      RGB 0;0;130    %clr%
	echo   %RGB%0;0;125m      RGB 0;0;125    %clr%
	echo   %RGB%0;0;120m      RGB 0;0;120    %clr%
	echo   %RGB%0;0;115m      RGB 0;0;115    %clr%
	echo   %RGB%0;0;110m      RGB 0;0;110    %clr%
	echo   %RGB%0;0;105m      RGB 0;0;105    %clr%
	echo   %RGB%0;0;100m      RGB 0;0;100    %clr%
	echo   %RGB%0;0;95m      RGB 0;0;95     %clr%
	echo   %RGB%0;0;90m      RGB 0;0;90     %clr%
	echo   %RGB%0;0;85m      RGB 0;0;85     %clr%
	echo   %RGB%0;0;80m      RGB 0;0;80     %clr%
	echo   %RGB%0;0;75m      RGB 0;0;75     %clr%
	echo   %RGB%0;0;70m      RGB 0;0;70     %clr%
	echo   %RGB%0;0;65m      RGB 0;0;65     %clr%
	echo   %RGB%0;0;60m      RGB 0;0;60     %clr%
	echo   %RGB%0;0;55m      RGB 0;0;55     %clr%
	echo   %RGB%0;0;50m      RGB 0;0;50     %clr%
	echo   %RGB%0;0;45m      RGB 0;0;45     %clr%
	echo   %RGB%0;0;40m      RGB 0;0;40     %clr%
	echo   %RGB%0;0;35m      RGB 0;0;35     %clr%
	echo   %RGB%0;0;30m      RGB 0;0;30     %clr%
	echo   %RGB%0;0;25m      RGB 0;0;25     %clr%
	echo   %RGB%0;0;20m      RGB 0;0;20     %clr%
	echo   %RGB%0;0;15m      RGB 0;0;15     %clr%
	echo   %RGB%0;0;10m      RGB 0;0;10     %clr%
	echo   %RGB%0;0;5m      RGB 0;0;5      %clr%
	echo   %RGB%0;0;0m      RGB 0;0;0      %clr%
	echo:
	echo:
	echo %black% %bg_lblack%          RGB Background Colors         %clr%
	echo   %bg_RGB%255;10;10m      bg_RGB 255;0;10    %clr%
	echo   %bg_RGB%10;255;10m      bg_RGB 0;255;10    %clr%
	echo   %bg_RGB%0;0;255m      bg_RGB 0;0;255     %clr%
	echo   %bg_RGB%0;0;250m      bg_RGB 0;0;250     %clr%
	echo   %bg_RGB%0;0;245m      bg_RGB 0;0;245     %clr%
	echo   %bg_RGB%0;0;240m      bg_RGB 0;0;240     %clr%
	echo   %bg_RGB%0;0;235m      bg_RGB 0;0;235     %clr%
	echo   %bg_RGB%0;0;230m      bg_RGB 0;0;230     %clr%
	echo   %bg_RGB%0;0;225m      bg_RGB 0;0;225     %clr%
	echo   %bg_RGB%0;0;220m      bg_RGB 0;0;220     %clr%
	echo   %bg_RGB%0;0;215m      bg_RGB 0;0;215     %clr%
	echo   %bg_RGB%0;0;210m      bg_RGB 0;0;210     %clr%
	echo   %bg_RGB%0;0;205m      bg_RGB 0;0;205     %clr%
	echo   %bg_RGB%0;0;200m      bg_RGB 0;0;200     %clr%
	echo   %bg_RGB%0;0;195m      bg_RGB 0;0;195     %clr%
	echo   %bg_RGB%0;0;190m      bg_RGB 0;0;190     %clr%
	echo   %bg_RGB%0;0;185m      bg_RGB 0;0;185     %clr%
	echo   %bg_RGB%0;0;180m      bg_RGB 0;0;180     %clr%
	echo   %bg_RGB%0;0;175m      bg_RGB 0;0;175     %clr%
	echo   %bg_RGB%0;0;170m      bg_RGB 0;0;170     %clr%
	echo   %bg_RGB%0;0;165m      bg_RGB 0;0;165     %clr%
	echo   %bg_RGB%0;0;160m      bg_RGB 0;0;160     %clr%
	echo   %bg_RGB%0;0;155m      bg_RGB 0;0;155     %clr%
	echo   %bg_RGB%0;0;150m      bg_RGB 0;0;150     %clr%
	echo   %bg_RGB%0;0;145m      bg_RGB 0;0;145     %clr%
	echo   %bg_RGB%0;0;140m      bg_RGB 0;0;140     %clr%
	echo   %bg_RGB%0;0;135m      bg_RGB 0;0;135     %clr%
	echo   %bg_RGB%0;0;130m      bg_RGB 0;0;130     %clr%
	echo   %bg_RGB%0;0;125m      bg_RGB 0;0;125     %clr%
	echo   %bg_RGB%0;0;120m      bg_RGB 0;0;120     %clr%
	echo   %bg_RGB%0;0;115m      bg_RGB 0;0;115     %clr%
	echo   %bg_RGB%0;0;110m      bg_RGB 0;0;110     %clr%
	echo   %bg_RGB%0;0;105m      bg_RGB 0;0;105     %clr%
	echo   %bg_RGB%0;0;100m      bg_RGB 0;0;100     %clr%
	echo   %bg_RGB%0;0;95m      bg_RGB 0;0;95      %clr%
	echo   %bg_RGB%0;0;90m      bg_RGB 0;0;90      %clr%
	echo   %bg_RGB%0;0;85m      bg_RGB 0;0;85      %clr%
	echo   %bg_RGB%0;0;80m      bg_RGB 0;0;80      %clr%
	echo   %bg_RGB%0;0;75m      bg_RGB 0;0;75      %clr%
	echo   %bg_RGB%0;0;70m      bg_RGB 0;0;70      %clr%
	echo   %bg_RGB%0;0;65m      bg_RGB 0;0;65      %clr%
	echo   %bg_RGB%0;0;60m      bg_RGB 0;0;60      %clr%
	echo   %bg_RGB%0;0;55m      bg_RGB 0;0;55      %clr%
	echo   %bg_RGB%0;0;50m      bg_RGB 0;0;50      %clr%
	echo   %bg_RGB%0;0;45m      bg_RGB 0;0;45      %clr%
	echo   %bg_RGB%0;0;40m      bg_RGB 0;0;40      %clr%
	echo   %bg_RGB%0;0;35m      bg_RGB 0;0;35      %clr%
	echo   %bg_RGB%0;0;30m      bg_RGB 0;0;30      %clr%
	echo   %bg_RGB%0;0;25m      bg_RGB 0;0;25      %clr%
	echo   %bg_RGB%0;0;20m      bg_RGB 0;0;20      %clr%
	echo   %bg_RGB%0;0;15m      bg_RGB 0;0;15      %clr%
	echo   %bg_RGB%0;0;10m      bg_RGB 0;0;10      %clr%
	echo   %bg_RGB%0;0;5m      bg_RGB 0;0;5       %clr%
	echo   %bg_RGB%0;0;0m      bg_RGB 0;0;0       %clr%
	echo: 
	echo:
	echo %black% %bg_lblack%              Combinations              %clr%
	echo  negative                  %negative%       inverse foreground / background        %clr%
	echo  bg_yellow,red             %bg_yellow%%red%      yellow backgroud / red foreground       %clr%
	echo  bg_yellow,red,negative    %bg_yellow%%red%%negative%             yellow / red inversed            %clr%
	echo  bg_red,bg_green,bg_blue   %bg_red%     nested     %bg_green%     colors     %bg_blue%     text     %clr%
	echo:
	echo:
	echo %black% %bg_lblack%             ASCII Color Art            %clr%
	echo:
	echo   %bg_blue% * * * * * * * * * %bg_red%                                %clr%
	echo   %bg_blue%  * * * * * * * *  %bg_white%                                %clr%
	echo   %bg_blue% * * * * * * * * * %bg_red%                                %clr% 
	echo   %bg_blue%  * * * * * * * *  %bg_white%                                %clr%
	echo   %bg_blue% * * * * * * * * * %bg_red%                                %clr%
	echo   %bg_blue%  * * * * * * * *  %bg_white%                                %clr%
	echo   %bg_blue% * * * * * * * * * %bg_red%                                %clr%
	echo   %bg_white%                                                   %clr%
	echo   %bg_red%                                                   %clr%
	echo   %bg_white%                                                   %clr%
	echo   %bg_red%                                                   %clr%
	echo   %bg_white%                                                   %clr%
	echo   %bg_red%                                                   %clr%
	echo:
	echo:
	echo %black% %bg_lblack%               ASCII Mode               %clr%
	echo %ASCII% a b c d e f g h i j k l m n o p q r s t u v w x y z
	echo:
	echo:
	echo %black% %bg_lblack%                DEC Mode                %clr%
	echo %DEC% a b c d e f g h i j k l m n o p q r s t u v w x y z
	echo %ASCII%
	echo:
	echo:
%endfunction%


