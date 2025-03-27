<?php
header('Access-Control-Allow-Origin: *');
include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/DK.php");

//$ESC="\033";
##################################################################################
# dk_color(on/off)
#
# Enable / Disable console text and background coloring
#
#		on/off:		Default ON
#
#		https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
#		https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
#		https://learn.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences
#
//function dk_color(){
	#dk_debugFunc 0
//	echo "###### ".__FUNCTION__."(".implode(";", func_get_args()).") ######\n";

/*
	$USE_COLOR = 0;
	if(isset($argv[0])){
		$USE_COLOR = $argv[0];
	}
	
	if($USE_COLOR != 1){
		//return 0;
	}
*/
	// escape character	BAD: Uncopyable character

		//############ C0 control codes #############
		$NUL="\000";		// Null - Does nothing. The code of blank paper tape, and also used for padding to slow transmission
		$SOH="\001";		// Start of Heading - First character of the heading of a message
		$STX="\002";		// Start of Text - Terminates the header and starts the message text
		$ETX="\003";		// End of Text - Ends the message text, starts a footer (up to the next TC character)
		$EOT="\004";		// End of Transmission - Ends the transmission of one or more messages. May place terminals on standby.
		$EQN="\005";		// Enquiry - Trigger a response at the receiving end, to see if it is still present.
		$ACK="\006";		// Acknowledge - Indication of successful receipt of a message.
		$BEL="\007";		// Bell, Alert	- Call for attention from an operator.
		 $BS="\010";		// Backspace - Move one position leftwards. Next character may overprint or replace the character that was there.
		 $HT="\011";		// Character Tabulation, Horizontal Tabulation	- Move right to the next tab stop.
		 $LF="\012";		// Line Feed - Move down to the same position on the next line (some devices also moved to the left column).
		 $VT="\013";		// Line Tabulation, Vertical Tabulation - Move down to the next vertical tab stop.
		 $FF="\014";		// Form Feed - Move down to the top of the next page.
		 $CR="\015";		// Carriage Return - Move to column zero while staying on the same line.
		 $SO="\016";		// Shift Out - Switch to an alternative character set.
		 $SI="\017";		// Shift In - Return to regular character set after SO.
		$DLE="\020";		// Data Link Escape - Cause a number of contiguously following characters to be interpreted in some different way
		$DC1="\021";		// Device Control One - Turn on (DC1 and DC2) or off (DC3 and DC4) devices.
		$DC2="\022";		// Device Control Two
		$DC3="\023";		// Device Control Three
		$DC4="\024";		// Device Control Four
		$NAK="\025";		// Negative Acknowledge - Negative response to a sender, such as a detected error.
		$SYN="\026";		// Synchronous Idle - Sent in synchronous transmission systems when no other character is being transmitted.
		$ETB="\027";		// End of Transmission Block - End of a transmission block of data when data are divided into such blocks.
		$CAN="\030";		// Cancel - Indicates that the data preceding it are in error or are to be disregarded.
		 $EM="\031";		// End of medium - Indicates on paper or magnetic tapes that the end of the usable tape had been reached.
		$SUB="\032";		// Substitute -Replaces a character that was found to be invalid or in error. Should be ignored.
		$ESC="\033";		// Escape - Alters the meaning of a limited number of following bytes.
		 $FS="\034";		// File Separator - Can be used as delimiters to mark fields of data structures. 
		 $GS="\035";		// Group Separator
		 $RS="\036";		// Record Separator
		 $US="\037";		// Unit Separator - US is the lowest level
		 $SP="\040";		// Space - Move right one character position.
		$DEL="\177";		// Delete - Should be ignored. Used to delete characters on punched tape by punching out all the holes.
		
		//############ C1 control codes #############
		$PAD="${ESC}@";					// Padding Character
		$HOP="${ESC}A";					// High Octet Preset
		$BPH="${ESC}B";					// Break Permitted Here
		$NBH="${ESC}C";					// No Break Here
		$IND="${ESC}D";					// Index
		$NEL="${ESC}E";					// Next Line
		$SSA="${ESC}F";					// Start of Selected Area
		$ESA="${ESC}G";					// End of Selected Area
		$HTS="${ESC}H";					// Horizontal Tabulation Set
		$HTJ="${ESC}I";					// Horizontal Tabulation With Justification
		$VTS="${ESC}J";					// Vertical Tabulation Set
		$PLD="${ESC}K";					// Partial Line Down
		$PLU="${ESC}L";					// Partial Line Up
	     $RI="${ESC}M";					// Reverse Index
		$SS2="${ESC}N";					// Single Shift Two
		$SS3="${ESC}O";					// Single Shift Three
		$DCS="${ESC}P";					// Device Control String
		$PU1="${ESC}Q";					// Private Use 1
		$PU2="${ESC}R";					// Private Use 2
		$STS="${ESC}S";					// Set Transmit State
		$CCH="${ESC}T";					// Cancel character
		 $MW="${ESC}U";					// Message Waiting
		$SPA="${ESC}V";					// Start of Protected Area
		$EPA="${ESC}W";					// End of Protected Area
		$SOS="${ESC}X";					// Start of String
		$SGC="${ESC}Y";					// Single Graphic Character Introducer
		$SCI="${ESC}Z";					// Single Character Introducer
		$CSI="${ESC}[";					// Control Sequence Introducer
		$ST="${ESC}\\";					// String Terminator
		$OSC="${ESC}]";					// Operating System Command
		$PM="${ESC}^^";					// Privacy Message
		$APC="${ESC}_";					// Application Program Command

		$DECSC="${ESC}7";					// Save Cursor Position in Memory**
		$DECSR="${ESC}8";					// Restore Cursor Position from Memory**

		$DECSCUSR0="${ESC}0${SP}q";			// User Shape
		$DECSCUSR1="${ESC}1${SP}q";			// Blinking Block
		$DECSCUSR2="${ESC}2${SP}q";			// Steady Block
		$DECSCUSR3="${ESC}3${SP}q";			// Blinking Underline
		$DECSCUSR4="${ESC}4${SP}q";			// Steady Underline
		$DECSCUSR5="${ESC}5${SP}q";			// Blinking Bar
		$DECSCUSR6="${ESC}6${SP}q";			// Steady Bar

		//############ CSI Commands #############
		$CCU="${CSI}A";					// Cursor Up 1 - Moves the cursor 1 cell in the given direction. If the cursor is already at the edge of the screen, this has no effect.
		//$CCU="${CSI}<n>A";			// Cursor Up -	Moves the cursor n (default 1) cells in the given direction. If the cursor is already at the edge of the screen, this has no effect.
		$CUD="${CSI}B";					// Cursor Down 1
		//$CCU="${CSI}<n>B";			// Cursor Down
		$CUF="${CSI}C";					// Cursor Forward 1
		//$CCU="${CSI}<n>C";			// Cursor Forward
		$CUB="${CSI}D";					// Cursor Back 1
		//$CCU="${CSI}<n>D";				// Cursor Back
		$CNL="${CSI}E";					// Cursor Next Line 1 - Moves cursor to beginning of the line 1 line down. (not ANSI.SYS)
		//$CCU="${CSI}<n>E";				// Cursor Next Line - Moves cursor to beginning of the line n (default 1);" lines down. (not ANSI.SYS)
		$CPL="${CSI}F";					// Cursor Previous Line 1 - Moves cursor to beginning of the line 1 line up. (not ANSI.SYS)
		//$CCU="${CSI}<n>F";				// Cursor Previous Line - Moves cursor to beginning of the line n (default 1);" lines up. (not ANSI.SYS)
		$CHA="${CSI}G";					// Cursor Horizontal Absolute 1 - Moves the cursor to column 1. (not ANSI.SYS)
		//$CCU="${CSI}<n>G";				// Cursor Horizontal Absolute - Moves the cursor to column n (default 1). (not ANSI.SYS)
		//$CUP="${CSI}<n>;<m>H;";			// Cursor Position	- Cursor moves to <x>; <y> coordinate within the viewport, where <x> is the column of the <y> line
		//$HVP="${CSI}<y>;<x>f;";			// Horizontal Vertical Position - Cursor moves to <x>; <y> coordinate within the viewport, where <x> is the column of the <y> line
		$ANSISYSSC="${CSI}s";				// Save Cursor – **With no parameters, performs a save cursor operation like DECSC
		$ANSISYSRC="${CSI}u";				// Restore Cursor - **With no parameters, performs a restore cursor operation like DECRC

		//CSI n J	ED						// Erase in Display - Clears part of the screen. If n is 0 (or missing;, clear from cursor to end of screen. If n is 1, clear from cursor to beginning of the screen. If n is 2, clear entire screen (and moves cursor to upper left on DOS ANSI.SYS). If n is 3, clear entire screen and delete all lines saved in the scrollback buffer.
		//CSI n K	EL						// Erase in Line - Erases part of the line. If n is 0 (or missing), clear from cursor to the end of the line. If n is 1, clear from cursor to beginning of the line. If n is 2, clear entire line. Cursor position does not change.
		//CSI n S	SU						// Scroll Up - Scroll whole page up by n (default 1) lines. New lines are added at the bottom. (not ANSI.SYS)
		//CSI n T	SD						// Scroll Down	- Scroll whole page down by n (default 1) lines. New lines are added at the top. (not ANSI.SYS)
		//CSI n ; m f	HVP					// Horizontal Vertical Position - Same as CUP, but counts as a format effector function (like CR or LF) rather than an editor function (like CUD or CNL).
		//CSI n m	SGR						// Select Graphic Rendition - Sets colors and style of the characters following this code
		//CSI 5i							// AUX Port On	- Enable aux serial port usually for local serial printer
		//CSI 4i							// AUX Port Off - Disable aux serial port usually for local serial printer
		//CSI 6n	DSR						// Device Status Report - Reports the cursor position (CPR) by transmitting ESC[n;mR, where n is the row and m is the column.
		$ATT160="${CSI}?12";				// Text Cursor Blink
		$DECTCEM="${CSI}?25";				// Text Cursor Show/Hide
	
		//(SU="${CSI}<n>S";					// Scroll Up - Scroll text up by <n>. Also known as pan down, new lines fill in from the bottom of the screen
		//(SD="${CSI}<n>T";					// Scroll Down - Scroll down by <n>. Also known as pan up, new lines fill in from the top of the screen

		$DEC="${ESC}(0";					// Enables DEC Line Drawing Mode
		$ASCII="${ESC}(B";				// Enables ASCII Mode (Default)

		//# Cursor
		$cursor_blink_on="${ATT160}h";		// Text Cursor Enable Blinking
		$cursor_blink_off="${ATT160}l";	// Text Cursor Disable Blinking
		$cursor_show="${DECTCEM}h";		// Text Cursor Enable Mode Show
		$cursor_hide="${DECTCEM}l";		// Text Cursor Enable Mode Hide

		//# Attributes on
		$clr="${CSI}0m";					// Default					Reset all modes (styles and colors;
		$bright="${CSI}1m";				// Bright					Applies brightness flag to foreground color
		$dim="${CSI}2m";					// Dim						Applies dim flag to foreground color
		$italic="${CSI}3m";				// Italic
		$underline="${CSI}4m";				// Underline
		$blink="${CSI}5m";					// Blink
		$fblink="${CSI}6m";				// Rapid Blink
		$negative="${CSI}7m";				// Negative				Swaps foreground and background colors
		$invisible="${CSI}8m";				// Invisible
		$strike="${CSI}9m";				// Strike Through

		//# Attributes off
		//$20m="${CSI}20m";				// 20
		//$21m="${CSI}21m";				// 21
		$nodim="${CSI}22m";				// No Dim					Removes brightness/intensity flag from foreground color
		$nobright="${CSI}22m";				// No Bright				Removes brightness/intensity flag from foreground color
		$noitalic="${CSI}23m";				// No Italic
		$nounderline="${CSI}24m";			// No Underline
		$noblink="${CSI}25m";				// No Blink
		//$26m="${CSI}26m";				// 26
		$nonegative="${CSI}27m";			// No Negative				Returns foreground/background to normal
		$visible="${CSI}28m";				// No Invisible
		$nostrike="${CSI}29m";				// No Strike Through

		//# Foreground Colors
		$black="${CSI}30m";				// Foreground Black			Applies non-dim/bright black to foreground
		$red="${CSI}31m";					// Foreground Red				Applies non-dim/bright red to foreground
		$green="${CSI}32m";				// Foreground Green			Applies non-dim/bright green to foreground
		$yellow="${CSI}33m";				// Foreground Yellow			Applies non-dim/bright yellow to foreground
		$blue="${CSI}34m";					// Foreground Blue				Applies non-dim/bright blue to foreground
		$magenta="${CSI}35m";				// Foreground Magenta			Applies non-dim/bright magenta to foreground
		$cyan="${CSI}36m";					// Foreground Cyan				Applies non-dim/bright cyan to foreground
		$white="${CSI}37m";				// Foreground White			Applies non-dim/bright white to foreground
		$extended="${CSI}38m";				// Foreground Extended			Applies extended color value to the foreground
		$fg_clr="${CSI}39m";				// Foreground Default			Applies only the foreground portion of the defaults

		//# Background Colors
		$bg_black="${CSI}40m";				// Background Black			Applies non-dim/bright black to background
		$bg_red="${CSI}41m";				// Background Red				Applies non-dim/bright red to background
		$bg_green="${CSI}42m";				// Background Green			Applies non-dim/bright green to background
		$bg_yellow="${CSI}43m";			// Background Yellow			Applies non-dim/bright yellow to background
		$bg_blue="${CSI}44m";				// Background Blue				Applies non-dim/bright blue to background
		$bg_magenta="${CSI}45m";			// Background Magenta			Applies non-dim/bright magenta to background
		$bg_cyan="${CSI}46m";				// Background Cyan				Applies non-dim/bright cyan to background
		$bg_white="${CSI}47m";				// Background White			Applies non-dim/bright white to background
		$bg_extended="${CSI}48m";			// Background Extended			Applies extended color value to the background
		$bg_clr="${CSI}49m";	 			// Background Default			Applies only the background portion of the defaults

		//# Foreground Colors (light)
		$lblack="${CSI}90m";				// Bright Foreground Black		Applies bright black to foreground
		$lred="${CSI}91m";					// Bright Foreground Red		Applies bright red to foreground
		$lgreen="${CSI}92m";				// Bright Foreground Green		Applies bright green to foreground
		$lyellow="${CSI}93m";				// Bright Foreground Yellow	Applies bright yellow to foreground
		$lblue="${CSI}94m";				// Bright Foreground Blue		Applies bright blue to foreground
		$lmagenta="${CSI}95m";				// Bright Foreground Magenta	Applies bright magenta to foreground
		$lcyan="${CSI}96m";				// Bright Foreground Cyan		Applies bright cyan to foreground
		$lwhite="${CSI}97m";				// Bright Foreground White		Applies bright white to foreground

		//# Background Colors (light)
		$bg_lblack="${CSI}100m";			// Bright Background Black		Applies bright black to background
		$bg_lred="${CSI}101m";				// Bright Background Red		Applies bright red to background
		$bg_lgreen="${CSI}102m";			// Bright Background Green		Applies bright green to background
		$bg_lyellow="${CSI}103m";			// Bright Background Yellow	Applies bright yellow to background
		$bg_lblue="${CSI}104m";			// Bright Background Blue		Applies bright blue to background
		$bg_lmagenta="${CSI}105m";			// Bright Background Magenta	Applies bright magenta to background
		$bg_lcyan="${CSI}106m";			// Bright Background Cyan		Applies bright cyan to background
		$bg_lwhite="${CSI}107m";			// Bright Background White		Applies bright white to background

		//# Foreground RGB Colors
		$RGB="${CSI}38;2;";				// ${RGB}50;100;150m			"${CSI}38;2;50;100;150m";

		//# Background RGB Colors
		$bg_RGB="${CSI}48;2;";				// ${bg_RGB}150;100;50m			"${CSI}38;2;150;100;50m

		echo("${blue}C${green}O${red}L${magenta}O${cyan}R ${blue}O${green}N${clr}\n");
/*
		goto USE_COLOR_endif
		:USE_COLOR_else
		//dk_unset ESC
		//dk_unset clr

		//# Attributes on
		dk_unset bright
		dk_unset dim
		dk_unset italic
		dk_unset underline
		dk_unset blink
		dk_unset fblink
		dk_unset negative
		dk_unset invisible
		dk_unset strike

		//# Attributes off
		dk_unset nobright
		dk_unset noitalic
		dk_unset nounderline
		dk_unset noblink
		dk_unset nonegative
		dk_unset visible
		dk_unset nostrike

		//# Foreground Colors
		dk_unset black
		dk_unset red
		dk_unset green
		dk_unset yellow
		dk_unset blue
		dk_unset magenta
		dk_unset cyan
		dk_unset white
		dk_unset extended
		//dk_unset fg_clr

		//# Background Colors
		dk_unset bg_black
		dk_unset bg_red
		dk_unset bg_green
		dk_unset bg_yellow
		dk_unset bg_blue
		dk_unset bg_magenta
		dk_unset bg_cyan
		dk_unset bg_white
		dk_unset bg_extended
		//dk_unset bg_clr

		//# Foreground Colors (bright)
		dk_unset lblack
		dk_unset lred
		dk_unset lgreen
		dk_unset lyellow
		dk_unset lblue
		dk_unset lmagenta
		dk_unset lcyan
		dk_unset lwhite

		//# Background Colors (bright)
		dk_unset bg_lblack
		dk_unset bg_lred
		dk_unset bg_lgreen
		dk_unset bg_lyellow
		dk_unset bg_lblue
		dk_unset bg_lmagenta
		dk_unset bg_lcyan
		dk_unset bg_lwhite

		dk_unset RGB
		dk_unset bg_RGB

		dk_echo "${clr} COLOR OFF"
	:USE_COLOR_endif
	*/
//}
//dk_color();



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function DKTEST() {
	#dk_debugFunc 0
	echo "###### ".__FUNCTION__."(".implode(";", func_get_args()).") ######\n";

	global $ESC;
	global $CSI;
	global $clr;
	global $black;
	global $bg_black;
	global $bg_lblack;
	
	echo("");
echo("${black} ${bg_lblack}                 CSI codes              ${clr}\n");
	echo("CSI0m       ${CSI}0m    CSI0m    ${clr}\n");
	echo("CSI1m       ${CSI}1m    CSI1m    ${clr}\n");
	echo("CSI2m       ${CSI}2m    CSI2m    ${clr}\n");
	echo("CSI3m       ${CSI}3m    CSI3m    ${clr}\n");
	echo("CSI4m       ${CSI}4m    CSI4m    ${clr}\n");
	echo("CSI5m       ${CSI}5m    CSI5m    ${clr}\n");
	echo("CSI6m       ${CSI}6m    CSI6m    ${clr}\n");
	echo("CSI7m       ${CSI}7m    CSI7m    ${clr}\n");
	echo("CSI8m       ${CSI}8m    CSI8m    ${clr}\n");
	echo("CSI9m       ${CSI}9m    CSI9m    ${clr}\n");
	echo("CSI10m      ${CSI}10m    CSI10m    ${clr}\n");
	echo("CSI11m      ${CSI}11m    CSI11m    ${clr}\n");
	echo("CSI12m      ${CSI}12m    CSI12m    ${clr}\n");
	echo("CSI13m      ${CSI}13m    CSI13m    ${clr}\n");
	echo("CSI14m      ${CSI}14m    CSI14m    ${clr}\n");
	echo("CSI15m      ${CSI}15m    CSI15m    ${clr}\n");
	echo("CSI16m      ${CSI}16m    CSI16m    ${clr}\n");
	echo("CSI17m      ${CSI}17m    CSI17m    ${clr}\n");
	echo("CSI18m      ${CSI}18m    CSI18m    ${clr}\n");
	echo("CSI19m      ${CSI}19m    CSI19m    ${clr}\n");
	echo("CSI20m      ${CSI}20m    CSI20m    ${clr}\n");
	echo("CSI21m      ${CSI}21m    CSI21m    ${clr}\n");
	echo("CSI22m      ${CSI}22m    CSI22m    ${clr}\n");
	echo("CSI23m      ${CSI}23m    CSI23m    ${clr}\n");
	echo("CSI24m      ${CSI}24m    CSI24m    ${clr}\n");
	echo("CSI25m      ${CSI}25m    CSI25m    ${clr}\n");
	echo("CSI26m      ${CSI}26m    CSI26m    ${clr}\n");
	echo("CSI27m      ${CSI}27m    CSI27m    ${clr}\n");
	echo("CSI28m      ${CSI}28m    CSI28m    ${clr}\n");
	echo("CSI29m      ${CSI}29m    CSI29m    ${clr}\n");
	echo("CSI30m      ${CSI}30m    CSI30m    ${clr}\n");
	echo("CSI31m      ${CSI}31m    CSI31m    ${clr}\n");
	echo("CSI32m      ${CSI}32m    CSI32m    ${clr}\n");
	echo("CSI33m      ${CSI}33m    CSI33m    ${clr}\n");
	echo("CSI34m      ${CSI}34m    CSI34m    ${clr}\n");
	echo("CSI35m      ${CSI}35m    CSI35m    ${clr}\n");
	echo("CSI36m      ${CSI}36m    CSI36m    ${clr}\n");
	echo("CSI37m      ${CSI}37m    CSI37m    ${clr}\n");
	echo("CSI38m      ${CSI}38m    CSI38m    ${clr}\n");
	echo("CSI39m      ${CSI}39m    CSI39m    ${clr}\n");
	echo("CSI40m      ${CSI}40m    CSI40m    ${clr}\n");
	echo("CSI41m      ${CSI}41m    CSI41m    ${clr}\n");
	echo("CSI42m      ${CSI}42m    CSI42m    ${clr}\n");
	echo("CSI43m      ${CSI}43m    CSI43m    ${clr}\n");
	echo("CSI44m      ${CSI}44m    CSI44m    ${clr}\n");
	echo("CSI45m      ${CSI}45m    CSI45m    ${clr}\n");
	echo("CSI46m      ${CSI}46m    CSI46m    ${clr}\n");
	echo("CSI47m      ${CSI}47m    CSI47m    ${clr}\n");
	echo("CSI48m      ${CSI}48m    CSI48m    ${clr}\n");
	echo("CSI49m      ${CSI}49m    CSI49m    ${clr}\n");
	echo("CSI50m      ${CSI}50m    CSI50m    ${clr}\n");
	echo("CSI51m      ${CSI}51m    CSI51m    ${clr}\n");
	echo("CSI52m      ${CSI}52m    CSI52m    ${clr}\n");
	echo("CSI53m      ${CSI}53m    CSI53m    ${clr}\n");
	echo("CSI54m      ${CSI}54m    CSI54m    ${clr}\n");
	echo("CSI55m      ${CSI}55m    CSI55m    ${clr}\n");
	echo("CSI56m      ${CSI}56m    CSI56m    ${clr}\n");
	echo("CSI57m      ${CSI}57m    CSI57m    ${clr}\n");
	echo("CSI58m      ${CSI}58m    CSI58m    ${clr}\n");
	echo("CSI59m      ${CSI}59m    CSI59m    ${clr}\n");
	echo("CSI60m      ${CSI}60m    CSI60m    ${clr}\n");
	echo("CSI61m      ${CSI}61m    CSI61m    ${clr}\n");
	echo("CSI62m      ${CSI}62m    CSI62m    ${clr}\n");
	echo("CSI63m      ${CSI}63m    CSI63m    ${clr}\n");
	echo("CSI64m      ${CSI}64m    CSI64m    ${clr}\n");
	echo("CSI65m      ${CSI}65m    CSI65m    ${clr}\n");
	echo("CSI66m      ${CSI}66m    CSI66m    ${clr}\n");
	echo("CSI67m      ${CSI}67m    CSI67m    ${clr}\n");
	echo("CSI68m      ${CSI}68m    CSI68m    ${clr}\n");
	echo("CSI69m      ${CSI}69m    CSI69m    ${clr}\n");
	echo("CSI70m      ${CSI}70m    CSI70m    ${clr}\n");
	echo("CSI71m      ${CSI}71m    CSI71m    ${clr}\n");
	echo("CSI72m      ${CSI}72m    CSI72m    ${clr}\n");
	echo("CSI73m      ${CSI}73m    CSI73m    ${clr}\n");
	echo("CSI74m      ${CSI}74m    CSI74m    ${clr}\n");
	echo("CSI75m      ${CSI}75m    CSI75m    ${clr}\n");
	echo("CSI76m      ${CSI}76m    CSI76m    ${clr}\n");
	echo("CSI77m      ${CSI}77m    CSI77m    ${clr}\n");
	echo("CSI78m      ${CSI}78m    CSI78m    ${clr}\n");
	echo("CSI79m      ${CSI}79m    CSI79m    ${clr}\n");
	echo("CSI80m      ${CSI}80m    CSI80m    ${clr}\n");
	echo("CSI81m      ${CSI}81m    CSI81m    ${clr}\n");
	echo("CSI82m      ${CSI}82m    CSI82m    ${clr}\n");
	echo("CSI83m      ${CSI}83m    CSI83m    ${clr}\n");
	echo("CSI84m      ${CSI}84m    CSI84m    ${clr}\n");
	echo("CSI85m      ${CSI}85m    CSI85m    ${clr}\n");
	echo("CSI86m      ${CSI}86m    CSI86m    ${clr}\n");
	echo("CSI87m      ${CSI}87m    CSI87m    ${clr}\n");
	echo("CSI88m      ${CSI}88m    CSI88m    ${clr}\n");
	echo("CSI89m      ${CSI}89m    CSI89m    ${clr}\n");
	echo("CSI90m      ${CSI}90m    CSI90m    ${clr}\n");
	echo("CSI91m      ${CSI}91m    CSI91m    ${clr}\n");
	echo("CSI92m      ${CSI}92m    CSI92m    ${clr}\n");
	echo("CSI93m      ${CSI}93m    CSI93m    ${clr}\n");
	echo("CSI94m      ${CSI}94m    CSI94m    ${clr}\n");
	echo("CSI95m      ${CSI}95m    CSI95m    ${clr}\n");
	echo("CSI96m      ${CSI}96m    CSI96m    ${clr}\n");
	echo("CSI97m      ${CSI}97m    CSI97m    ${clr}\n");
	echo("CSI98m      ${CSI}98m    CSI98m    ${clr}\n");
	echo("CSI99m      ${CSI}99m    CSI99m    ${clr}\n");
	echo("CSI100m     ${CSI}100m    CSI100m    ${clr}\n");
	echo("CSI101m     ${CSI}101m    CSI101m    ${clr}\n");
	echo("CSI102m     ${CSI}102m    CSI102m    ${clr}\n");
	echo("CSI103m     ${CSI}103m    CSI103m    ${clr}\n");
	echo("CSI104m     ${CSI}104m    CSI104m    ${clr}\n");
	echo("CSI105m     ${CSI}105m    CSI105m    ${clr}\n");
	echo("CSI106m     ${CSI}106m    CSI106m    ${clr}\n");
	echo("CSI107m     ${CSI}107m    CSI107m    ${clr}\n");
	echo("CSI108m     ${CSI}108m    CSI108m    ${clr}\n");
	echo("CSI109m     ${CSI}109m    CSI109m    ${clr}\n");
	echo("CSI110m     ${CSI}110m    CSI110m    ${clr}\n");
	echo("CSI111m     ${CSI}111m    CSI111m    ${clr}\n");
	echo("CSI112m     ${CSI}112m    CSI112m    ${clr}\n");
	echo("CSI113m     ${CSI}113m    CSI113m    ${clr}\n");
	echo("CSI114m     ${CSI}114m    CSI114m    ${clr}\n");
	echo("CSI115m     ${CSI}115m    CSI115m    ${clr}\n");
	echo("CSI116m     ${CSI}116m    CSI116m    ${clr}\n");
	echo("CSI117m     ${CSI}117m    CSI117m    ${clr}\n");
	echo("CSI118m     ${CSI}118m    CSI118m    ${clr}\n");
	echo("CSI119m     ${CSI}119m    CSI119m    ${clr}\n");
	echo("CSI120m     ${CSI}120m    CSI120m    ${clr}\n");
	echo("CSI121m     ${CSI}121m    CSI121m    ${clr}\n");
	echo("CSI122m     ${CSI}122m    CSI122m    ${clr}\n");
	echo("CSI123m     ${CSI}123m    CSI123m    ${clr}\n");
	echo("CSI124m     ${CSI}124m    CSI124m    ${clr}\n");
	echo("CSI125m     ${CSI}125m    CSI125m    ${clr}\n");
	echo("CSI126m     ${CSI}126m    CSI126m    ${clr}\n");
	echo("CSI127m     ${CSI}127m    CSI127m    ${clr}\n");

	echo("CSI?12h     ${CSI}?12h    CSI?12h    ${clr}\n");
	echo("CSI?12l     ${CSI}?12l    CSI?12l    ${clr}\n");

	echo("");
	echo("${black} ${bg_lblack}                  Styles                ${clr}\n");
	echo("    clr                ${clr}  default  ${clr}\n");
	echo("    bright             ${bright}  bright  ${clr}\n");
	echo("    nobright           ${nobright}  nobright  ${clr}\n");
	echo("    dim                ${dim}  dim  ${clr}\n");
	echo("    nodim              ${nodim}  nodim  ${clr}\n");
	echo("    italic             ${italic}  italic  ${clr}\n");
	echo("    noitalic           ${noitalic}  noitalic  ${clr}\n");
	echo("    underline          ${underline}  underline  ${clr}\n");
	echo("    nounderline        ${nounderline}  nounderline  ${clr}\n");
	echo("    blink              ${blink}  blink  ${clr}\n");
	echo("    noblink            ${noblink}  noblink  ${clr}\n");
	echo("    fblink             ${fblink}  fblink  ${clr}\n");
	echo("    nofblink           ${nofblink}  nofblink  ${clr}\n");
	echo("    negative           ${negative}  negative  ${clr}\n");
	echo("    nonegative         ${nonegative}  nonegative  ${clr}\n");
	echo("    invisible          ${invisible}  invisible  ${clr}\n");
	echo("    noinvisible        ${noinvisible}  noinvisible  ${clr}\n");
	echo("    strike             ${strike}  strike  ${clr}\n");
	echo("    nostrike           ${nostrike}  nostrike  ${clr}\n");
	echo("");
	echo("");
	echo("${black} ${bg_lblack}           Style Combinations           ${clr}\n");
	echo("    bright,italic      ${bright}  ${italic} bright,italic    ${clr}\n");
	echo("    bright,underline   ${bright}  ${underline} bright,underline    ${clr}\n");
	echo("    bright,negative    ${bright}  ${negative} bright,negative    ${clr}\n");
	echo("    bright,strike      ${bright}  ${strike} bright,strike    ${clr}\n");
	echo("");
	echo("");
	echo("${black} ${bg_lblack}           Color Combinations           ${clr}\n");
	echo("    dim black          ${dim}${black} dim black ${clr}\n");
	echo("    black              ${black} black ${clr}\n");
	echo("    bright black       ${bright}${black} bright black ${clr}\n");
	echo("    dim red            ${dim}${red} dim red ${clr}\n");
	echo("    red                ${red} red ${clr}\n");
	echo("    bright red         ${bright}${red} bright red ${clr}\n");
	echo("    dim green          ${dim}${green} dim green ${clr}\n");
	echo("    green              ${green} green ${clr}\n");
	echo("    bright green       ${bright}${green} bright green ${clr}\n");
	echo("    dim yellow         ${dim}${yellow} dim yellow ${clr}\n");
	echo("    yellow             ${yellow} yellow ${clr}\n");
	echo("    bright yellow      ${bright}${yellow} bright yellow ${clr}\n");
	echo("    dim blue           ${dim}${blue} dim blue ${clr}\n");
	echo("    blue               ${blue} blue ${clr}\n");
	echo("    bright blue        ${bright}${blue} bright blue ${clr}\n");
	echo("    dim magenta        ${dim}${magenta} dim magenta ${clr}\n");
	echo("    magenta            ${magenta} magenta ${clr}\n");
	echo("    bright magenta     ${bright}${magenta} bright magenta ${clr}\n");
	echo("    dim cyan           ${dim}${cyan} dim cyan ${clr}\n");
	echo("    cyan               ${cyan} cyan ${clr}\n");
	echo("    bright cyan        ${bright}${cyan} bright cyan ${clr}\n");
	echo("    dim white          ${dim}${white} dim white ${clr}\n");
	echo("    white              ${white} white ${clr}\n");
	echo("    bright white       ${bright}${white} bright white ${clr}\n");
	echo("");
	echo("");
	echo("${black} ${bg_lblack}            Foreground Colors           ${clr}\n");
	echo("    black              ${black} black ${fg_clr}");
	echo("    red                ${red} red ${fg_clr}");
	echo("    green              ${green} green ${fg_clr}");
	echo("    yellow             ${yellow} yellow ${fg_clr}");
	echo("    blue               ${blue} blue ${fg_clr}");
	echo("    magenta            ${magenta} magenta ${fg_clr}");
	echo("    cyan               ${cyan} cyan ${fg_clr}");
	echo("    white              ${white} white ${fg_clr}");
	echo("");
	echo("");
	echo("${black} ${bg_lblack}            Background Colors           ${clr}\n");
	echo("    bg_black    ${bg_black} bg_black   ${bg_clr}");
	echo("    bg_red      ${bg_red} bg_red   ${bg_clr}");
	echo("    bg_green    ${bg_green} bg_green   ${bg_clr}");
	echo("    bg_yellow   ${bg_yellow} bg_yellow   ${bg_clr}");
	echo("    bg_blue     ${bg_blue} bg_blue   ${bg_clr}");
	echo("    bg_magenta  ${bg_magenta} bg_magenta   ${bg_clr}");
	echo("    bg_cyan     ${bg_cyan} bg_cyan   ${bg_clr}");
	echo("    bg_white    ${bg_white} bg_white   ${bg_clr}");
	echo("");
	echo("");
	echo("${black} ${bg_lblack}       Foreground Colors    bright      ${clr}\n");
	echo("    lblack      ${lblack} lblack ${clr}\n");
	echo("    lred        ${lred} lred ${clr}\n");
	echo("    lgreen      ${lgreen} lgreen ${clr}\n");
	echo("    lyellow     ${lyellow} lyellow ${clr}\n");
	echo("    lblue       ${lblue} lblue ${clr}\n");
	echo("    lmagenta    ${lmagenta} lmagenta ${clr}\n");
	echo("    lcyan       ${lcyan} lcyan ${clr}\n");
	echo("    lwhite      ${lwhite} lwhite ${clr}\n");
	echo("");
	echo("");
	echo("${black} ${bg_lblack}       Background Colors - bright       ${clr}\n");
	echo("    bg_lblack      ${bg_lblack}${black}   bg_lblack    ${clr}\n");
	echo("    bg_lred        ${bg_lred}${black}     bg_lred    ${clr}\n");
	echo("    bg_lgreen      ${bg_lgreen}${black}   bg_lgreen    ${clr}\n");
	echo("    bg_lyellow     ${bg_lyellow}${black}  bg_lyellow    ${clr}\n");
	echo("    bg_lblue       ${bg_lblue}${black}    bg_lblue    ${clr}\n");
	echo("    bg_lmagenta    ${bg_lmagenta}${black} bg_lmagenta    ${clr}\n");
	echo("    bg_lcyan       ${bg_lcyan}${black}    bg_lcyan    ${clr}\n");
	echo("    bg_lwhite      ${bg_lwhite}${black}   bg_lwhite    ${clr}\n");
	echo("");
	echo("");
	echo("${black} ${bg_lblack}         RGB Foreground Colors          ${clr}\n");
	echo("    ${RGB}255;10;10m      RGB255;0;10m     ${clr}\n");
	echo("    ${RGB}10;255;10m      RGB 0;255;10    ${clr}\n");
	echo("    ${RGB}0;0;255m      RGB 0;0;255    ${clr}\n");
	echo("    ${RGB}0;0;250m      RGB 0;0;250    ${clr}\n");
	echo("    ${RGB}0;0;245m      RGB 0;0;245    ${clr}\n");
	echo("    ${RGB}0;0;240m      RGB 0;0;240    ${clr}\n");
	echo("    ${RGB}0;0;235m      RGB 0;0;235    ${clr}\n");
	echo("    ${RGB}0;0;230m      RGB 0;0;230    ${clr}\n");
	echo("    ${RGB}0;0;225m      RGB 0;0;225    ${clr}\n");
	echo("    ${RGB}0;0;220m      RGB 0;0;220    ${clr}\n");
	echo("    ${RGB}0;0;215m      RGB 0;0;215    ${clr}\n");
	echo("    ${RGB}0;0;210m      RGB 0;0;210    ${clr}\n");
	echo("    ${RGB}0;0;205m      RGB 0;0;205    ${clr}\n");
	echo("    ${RGB}0;0;200m      RGB 0;0;200    ${clr}\n");
	echo("    ${RGB}0;0;195m      RGB 0;0;195    ${clr}\n");
	echo("    ${RGB}0;0;190m      RGB 0;0;190    ${clr}\n");
	echo("    ${RGB}0;0;185m      RGB 0;0;185    ${clr}\n");
	echo("    ${RGB}0;0;180m      RGB 0;0;180    ${clr}\n");
	echo("    ${RGB}0;0;175m      RGB 0;0;175    ${clr}\n");
	echo("    ${RGB}0;0;170m      RGB 0;0;170    ${clr}\n");
	echo("    ${RGB}0;0;165m      RGB 0;0;165    ${clr}\n");
	echo("    ${RGB}0;0;160m      RGB 0;0;160    ${clr}\n");
	echo("    ${RGB}0;0;155m      RGB 0;0;155    ${clr}\n");
	echo("    ${RGB}0;0;150m      RGB 0;0;150    ${clr}\n");
	echo("    ${RGB}0;0;145m      RGB 0;0;145    ${clr}\n");
	echo("    ${RGB}0;0;140m      RGB 0;0;140    ${clr}\n");
	echo("    ${RGB}0;0;135m      RGB 0;0;135    ${clr}\n");
	echo("    ${RGB}0;0;130m      RGB 0;0;130    ${clr}\n");
	echo("    ${RGB}0;0;125m      RGB 0;0;125    ${clr}\n");
	echo("    ${RGB}0;0;120m      RGB 0;0;120    ${clr}\n");
	echo("    ${RGB}0;0;115m      RGB 0;0;115    ${clr}\n");
	echo("    ${RGB}0;0;110m      RGB 0;0;110    ${clr}\n");
	echo("    ${RGB}0;0;105m      RGB 0;0;105    ${clr}\n");
	echo("    ${RGB}0;0;100m      RGB 0;0;100    ${clr}\n");
	echo("    ${RGB}0;0;95m      RGB 0;0;95     ${clr}\n");
	echo("    ${RGB}0;0;90m      RGB 0;0;90     ${clr}\n");
	echo("    ${RGB}0;0;85m      RGB 0;0;85     ${clr}\n");
	echo("    ${RGB}0;0;80m      RGB 0;0;80     ${clr}\n");
	echo("    ${RGB}0;0;75m      RGB 0;0;75     ${clr}\n");
	echo("    ${RGB}0;0;70m      RGB 0;0;70     ${clr}\n");
	echo("    ${RGB}0;0;65m      RGB 0;0;65     ${clr}\n");
	echo("    ${RGB}0;0;60m      RGB 0;0;60     ${clr}\n");
	echo("    ${RGB}0;0;55m      RGB 0;0;55     ${clr}\n");
	echo("    ${RGB}0;0;50m      RGB 0;0;50     ${clr}\n");
	echo("    ${RGB}0;0;45m      RGB 0;0;45     ${clr}\n");
	echo("    ${RGB}0;0;40m      RGB 0;0;40     ${clr}\n");
	echo("    ${RGB}0;0;35m      RGB 0;0;35     ${clr}\n");
	echo("    ${RGB}0;0;30m      RGB 0;0;30     ${clr}\n");
	echo("    ${RGB}0;0;25m      RGB 0;0;25     ${clr}\n");
	echo("    ${RGB}0;0;20m      RGB 0;0;20     ${clr}\n");
	echo("    ${RGB}0;0;15m      RGB 0;0;15     ${clr}\n");
	echo("    ${RGB}0;0;10m      RGB 0;0;10     ${clr}\n");
	echo("    ${RGB}0;0;5m      RGB 0;0;5      ${clr}\n");
	echo("    ${RGB}0;0;0m      RGB 0;0;0      ${clr}\n");
	echo("");
	echo("");
	echo("${black} ${bg_lblack}          RGB Background Colors         ${clr}\n");
	echo("    ${bg_RGB}255;10;10m      bg_RGB 255;0;10    ${clr}\n");
	echo("    ${bg_RGB}10;255;10m      bg_RGB 0;255;10    ${clr}\n");
	echo("    ${bg_RGB}0;0;255m      bg_RGB 0;0;255     ${clr}\n");
	echo("    ${bg_RGB}0;0;250m      bg_RGB 0;0;250     ${clr}\n");
	echo("    ${bg_RGB}0;0;245m      bg_RGB 0;0;245     ${clr}\n");
	echo("    ${bg_RGB}0;0;240m      bg_RGB 0;0;240     ${clr}\n");
	echo("    ${bg_RGB}0;0;235m      bg_RGB 0;0;235     ${clr}\n");
	echo("    ${bg_RGB}0;0;230m      bg_RGB 0;0;230     ${clr}\n");
	echo("    ${bg_RGB}0;0;225m      bg_RGB 0;0;225     ${clr}\n");
	echo("    ${bg_RGB}0;0;220m      bg_RGB 0;0;220     ${clr}\n");
	echo("    ${bg_RGB}0;0;215m      bg_RGB 0;0;215     ${clr}\n");
	echo("    ${bg_RGB}0;0;210m      bg_RGB 0;0;210     ${clr}\n");
	echo("    ${bg_RGB}0;0;205m      bg_RGB 0;0;205     ${clr}\n");
	echo("    ${bg_RGB}0;0;200m      bg_RGB 0;0;200     ${clr}\n");
	echo("    ${bg_RGB}0;0;195m      bg_RGB 0;0;195     ${clr}\n");
	echo("    ${bg_RGB}0;0;190m      bg_RGB 0;0;190     ${clr}\n");
	echo("    ${bg_RGB}0;0;185m      bg_RGB 0;0;185     ${clr}\n");
	echo("    ${bg_RGB}0;0;180m      bg_RGB 0;0;180     ${clr}\n");
	echo("    ${bg_RGB}0;0;175m      bg_RGB 0;0;175     ${clr}\n");
	echo("    ${bg_RGB}0;0;170m      bg_RGB 0;0;170     ${clr}\n");
	echo("    ${bg_RGB}0;0;165m      bg_RGB 0;0;165     ${clr}\n");
	echo("    ${bg_RGB}0;0;160m      bg_RGB 0;0;160     ${clr}\n");
	echo("    ${bg_RGB}0;0;155m      bg_RGB 0;0;155     ${clr}\n");
	echo("    ${bg_RGB}0;0;150m      bg_RGB 0;0;150     ${clr}\n");
	echo("    ${bg_RGB}0;0;145m      bg_RGB 0;0;145     ${clr}\n");
	echo("    ${bg_RGB}0;0;140m      bg_RGB 0;0;140     ${clr}\n");
	echo("    ${bg_RGB}0;0;135m      bg_RGB 0;0;135     ${clr}\n");
	echo("    ${bg_RGB}0;0;130m      bg_RGB 0;0;130     ${clr}\n");
	echo("    ${bg_RGB}0;0;125m      bg_RGB 0;0;125     ${clr}\n");
	echo("    ${bg_RGB}0;0;120m      bg_RGB 0;0;120     ${clr}\n");
	echo("    ${bg_RGB}0;0;115m      bg_RGB 0;0;115     ${clr}\n");
	echo("    ${bg_RGB}0;0;110m      bg_RGB 0;0;110     ${clr}\n");
	echo("    ${bg_RGB}0;0;105m      bg_RGB 0;0;105     ${clr}\n");
	echo("    ${bg_RGB}0;0;100m      bg_RGB 0;0;100     ${clr}\n");
	echo("    ${bg_RGB}0;0;95m      bg_RGB 0;0;95      ${clr}\n");
	echo("    ${bg_RGB}0;0;90m      bg_RGB 0;0;90      ${clr}\n");
	echo("    ${bg_RGB}0;0;85m      bg_RGB 0;0;85      ${clr}\n");
	echo("    ${bg_RGB}0;0;80m      bg_RGB 0;0;80      ${clr}\n");
	echo("    ${bg_RGB}0;0;75m      bg_RGB 0;0;75      ${clr}\n");
	echo("    ${bg_RGB}0;0;70m      bg_RGB 0;0;70      ${clr}\n");
	echo("    ${bg_RGB}0;0;65m      bg_RGB 0;0;65      ${clr}\n");
	echo("    ${bg_RGB}0;0;60m      bg_RGB 0;0;60      ${clr}\n");
	echo("    ${bg_RGB}0;0;55m      bg_RGB 0;0;55      ${clr}\n");
	echo("    ${bg_RGB}0;0;50m      bg_RGB 0;0;50      ${clr}\n");
	echo("    ${bg_RGB}0;0;45m      bg_RGB 0;0;45      ${clr}\n");
	echo("    ${bg_RGB}0;0;40m      bg_RGB 0;0;40      ${clr}\n");
	echo("    ${bg_RGB}0;0;35m      bg_RGB 0;0;35      ${clr}\n");
	echo("    ${bg_RGB}0;0;30m      bg_RGB 0;0;30      ${clr}\n");
	echo("    ${bg_RGB}0;0;25m      bg_RGB 0;0;25      ${clr}\n");
	echo("    ${bg_RGB}0;0;20m      bg_RGB 0;0;20      ${clr}\n");
	echo("    ${bg_RGB}0;0;15m      bg_RGB 0;0;15      ${clr}\n");
	echo("    ${bg_RGB}0;0;10m      bg_RGB 0;0;10      ${clr}\n");
	echo("    ${bg_RGB}0;0;5m      bg_RGB 0;0;5       ${clr}\n");
	echo("    ${bg_RGB}0;0;0m      bg_RGB 0;0;0       ${clr}\n");
	echo(""); 
	echo("");
	echo("${black} ${bg_lblack}              Combinations              ${clr}\n");
	echo("negative                  ${negative}       inverse foreground / background        ${clr}\n");
	echo("bg_yellow,red             ${bg_yellow}${red}      yellow backgroud / red foreground       ${clr}\n");
	echo("bg_yellow,red,negative    ${bg_yellow}${red}${negative}             yellow / red inversed            ${clr}\n");
	echo("bg_red,bg_green,bg_blue   ${bg_red}     nested     ${bg_green}     colors     ${bg_blue}     text     ${clr}\n");
	echo("");
	echo("");
	echo("${black} ${bg_lblack}             ASCII Color Art            ${clr}\n");
	echo("");
	echo("    ${bg_blue} * * * * * * * * * ${bg_red}                                ${clr}\n");
	echo("    ${bg_blue}  * * * * * * * *  ${bg_white}                                ${clr}\n");
	echo("    ${bg_blue} * * * * * * * * * ${bg_red}                                ${clr}\n"); 
	echo("    ${bg_blue}  * * * * * * * *  ${bg_white}                                ${clr}\n");
	echo("    ${bg_blue} * * * * * * * * * ${bg_red}                                ${clr}\n");
	echo("    ${bg_blue}  * * * * * * * *  ${bg_white}                                ${clr}\n");
	echo("    ${bg_blue} * * * * * * * * * ${bg_red}                                ${clr}\n");
	echo("    ${bg_white}                                                   ${clr}\n");
	echo("    ${bg_red}                                                   ${clr}\n");
	echo("    ${bg_white}                                                   ${clr}\n");
	echo("    ${bg_red}                                                   ${clr}\n");
	echo("    ${bg_white}                                                   ${clr}\n");
	echo("    ${bg_red}                                                   ${clr}\n");
	echo("");
	echo("");
	echo("${black} ${bg_lblack}               ASCII Mode               ${clr}\n");
	echo("${ASCII} a b c d e f g h i j k l m n o p q r s t u v w x y z\n");
	echo("");
	echo("");
	echo("${black} ${bg_lblack}                DEC Mode                ${clr}\n");
	echo("${DEC} a b c d e f g h i j k l m n o p q r s t u v w x y z\n");
	echo("${ASCII}\n");
	echo("");
	echo("");
}


