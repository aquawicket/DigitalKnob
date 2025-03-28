<?php
//header('Access-Control-Allow-Origin: *');
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
function dk_color(){
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
		$noinvisible="${CSI}28m";				// No Invisible
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
		$RGB="${CSI}38;2;";				// ".$GLOBALS['RGB']."50;100;150m			"${CSI}38;2;50;100;150m";

		//# Background RGB Colors
		$bg_RGB="${CSI}48;2;";				// ".$GLOBALS['bg_RGB']."150;100;50m			"${CSI}38;2;150;100;50m

		echo("".$GLOBALS['blue']."C".$GLOBALS['green']."O".$GLOBALS['red']."L".$GLOBALS['magenta']."O".$GLOBALS['cyan']."R ".$GLOBALS['blue']."O".$GLOBALS['green']."N${clr}\n");
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
}
dk_color();



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function DKTEST() {
	#dk_debugFunc 0
	echo "###### ".__FUNCTION__."(".implode(";", func_get_args()).") ######\n";

	echo("\n");
	echo($GLOBALS['black'].$GLOBALS['bg_lblack']."                 CSI codes              ".$GLOBALS['clr']."\n");
	echo("    CSI0m              ".$GLOBALS['CSI']."0m    CSI0m    ".$GLOBALS['clr']."\n");
	echo("    CSI1m              ".$GLOBALS['CSI']."1m    CSI1m    ".$GLOBALS['clr']."\n");
	echo("    CSI2m              ".$GLOBALS['CSI']."2m    CSI2m    ".$GLOBALS['clr']."\n");
	echo("    CSI3m              ".$GLOBALS['CSI']."3m    CSI3m    ".$GLOBALS['clr']."\n");
	echo("    CSI4m              ".$GLOBALS['CSI']."4m    CSI4m    ".$GLOBALS['clr']."\n");
	echo("    CSI5m              ".$GLOBALS['CSI']."5m    CSI5m    ".$GLOBALS['clr']."\n");
	echo("    CSI6m              ".$GLOBALS['CSI']."6m    CSI6m    ".$GLOBALS['clr']."\n");
	echo("    CSI7m              ".$GLOBALS['CSI']."7m    CSI7m    ".$GLOBALS['clr']."\n");
	echo("    CSI8m              ".$GLOBALS['CSI']."8m    CSI8m    ".$GLOBALS['clr']."\n");
	echo("    CSI9m              ".$GLOBALS['CSI']."9m    CSI9m    ".$GLOBALS['clr']."\n");
	echo("    CSI10m             ".$GLOBALS['CSI']."10m    CSI10m    ".$GLOBALS['clr']."\n");
	echo("    CSI11m             ".$GLOBALS['CSI']."11m    CSI11m    ".$GLOBALS['clr']."\n");
	echo("    CSI12m             ".$GLOBALS['CSI']."12m    CSI12m    ".$GLOBALS['clr']."\n");
	echo("    CSI13m             ".$GLOBALS['CSI']."13m    CSI13m    ".$GLOBALS['clr']."\n");
	echo("    CSI14m             ".$GLOBALS['CSI']."14m    CSI14m    ".$GLOBALS['clr']."\n");
	echo("    CSI15m             ".$GLOBALS['CSI']."15m    CSI15m    ".$GLOBALS['clr']."\n");
	echo("    CSI16m             ".$GLOBALS['CSI']."16m    CSI16m    ".$GLOBALS['clr']."\n");
	echo("    CSI17m             ".$GLOBALS['CSI']."17m    CSI17m    ".$GLOBALS['clr']."\n");
	echo("    CSI18m             ".$GLOBALS['CSI']."18m    CSI18m    ".$GLOBALS['clr']."\n");
	echo("    CSI19m             ".$GLOBALS['CSI']."19m    CSI19m    ".$GLOBALS['clr']."\n");
	echo("    CSI20m             ".$GLOBALS['CSI']."20m    CSI20m    ".$GLOBALS['clr']."\n");
	echo("    CSI21m             ".$GLOBALS['CSI']."21m    CSI21m    ".$GLOBALS['clr']."\n");
	echo("    CSI22m             ".$GLOBALS['CSI']."22m    CSI22m    ".$GLOBALS['clr']."\n");
	echo("    CSI23m             ".$GLOBALS['CSI']."23m    CSI23m    ".$GLOBALS['clr']."\n");
	echo("    CSI24m             ".$GLOBALS['CSI']."24m    CSI24m    ".$GLOBALS['clr']."\n");
	echo("    CSI25m             ".$GLOBALS['CSI']."25m    CSI25m    ".$GLOBALS['clr']."\n");
	echo("    CSI26m             ".$GLOBALS['CSI']."26m    CSI26m    ".$GLOBALS['clr']."\n");
	echo("    CSI27m             ".$GLOBALS['CSI']."27m    CSI27m    ".$GLOBALS['clr']."\n");
	echo("    CSI28m             ".$GLOBALS['CSI']."28m    CSI28m    ".$GLOBALS['clr']."\n");
	echo("    CSI29m             ".$GLOBALS['CSI']."29m    CSI29m    ".$GLOBALS['clr']."\n");
	echo("    CSI30m             ".$GLOBALS['CSI']."30m    CSI30m    ".$GLOBALS['clr']."\n");
	echo("    CSI31m             ".$GLOBALS['CSI']."31m    CSI31m    ".$GLOBALS['clr']."\n");
	echo("    CSI32m             ".$GLOBALS['CSI']."32m    CSI32m    ".$GLOBALS['clr']."\n");
	echo("    CSI33m             ".$GLOBALS['CSI']."33m    CSI33m    ".$GLOBALS['clr']."\n");
	echo("    CSI34m             ".$GLOBALS['CSI']."34m    CSI34m    ".$GLOBALS['clr']."\n");
	echo("    CSI35m             ".$GLOBALS['CSI']."35m    CSI35m    ".$GLOBALS['clr']."\n");
	echo("    CSI36m             ".$GLOBALS['CSI']."36m    CSI36m    ".$GLOBALS['clr']."\n");
	echo("    CSI37m             ".$GLOBALS['CSI']."37m    CSI37m    ".$GLOBALS['clr']."\n");
	echo("    CSI38m             ".$GLOBALS['CSI']."38m    CSI38m    ".$GLOBALS['clr']."\n");
	echo("    CSI39m             ".$GLOBALS['CSI']."39m    CSI39m    ".$GLOBALS['clr']."\n");
	echo("    CSI40m             ".$GLOBALS['CSI']."40m    CSI40m    ".$GLOBALS['clr']."\n");
	echo("    CSI41m             ".$GLOBALS['CSI']."41m    CSI41m    ".$GLOBALS['clr']."\n");
	echo("    CSI42m             ".$GLOBALS['CSI']."42m    CSI42m    ".$GLOBALS['clr']."\n");
	echo("    CSI43m             ".$GLOBALS['CSI']."43m    CSI43m    ".$GLOBALS['clr']."\n");
	echo("    CSI44m             ".$GLOBALS['CSI']."44m    CSI44m    ".$GLOBALS['clr']."\n");
	echo("    CSI45m             ".$GLOBALS['CSI']."45m    CSI45m    ".$GLOBALS['clr']."\n");
	echo("    CSI46m             ".$GLOBALS['CSI']."46m    CSI46m    ".$GLOBALS['clr']."\n");
	echo("    CSI47m             ".$GLOBALS['CSI']."47m    CSI47m    ".$GLOBALS['clr']."\n");
	echo("    CSI48m             ".$GLOBALS['CSI']."48m    CSI48m    ".$GLOBALS['clr']."\n");
	echo("    CSI49m             ".$GLOBALS['CSI']."49m    CSI49m    ".$GLOBALS['clr']."\n");
	echo("    CSI50m             ".$GLOBALS['CSI']."50m    CSI50m    ".$GLOBALS['clr']."\n");
	echo("    CSI51m             ".$GLOBALS['CSI']."51m    CSI51m    ".$GLOBALS['clr']."\n");
	echo("    CSI52m             ".$GLOBALS['CSI']."52m    CSI52m    ".$GLOBALS['clr']."\n");
	echo("    CSI53m             ".$GLOBALS['CSI']."53m    CSI53m    ".$GLOBALS['clr']."\n");
	echo("    CSI54m             ".$GLOBALS['CSI']."54m    CSI54m    ".$GLOBALS['clr']."\n");
	echo("    CSI55m             ".$GLOBALS['CSI']."55m    CSI55m    ".$GLOBALS['clr']."\n");
	echo("    CSI56m             ".$GLOBALS['CSI']."56m    CSI56m    ".$GLOBALS['clr']."\n");
	echo("    CSI57m             ".$GLOBALS['CSI']."57m    CSI57m    ".$GLOBALS['clr']."\n");
	echo("    CSI58m             ".$GLOBALS['CSI']."58m    CSI58m    ".$GLOBALS['clr']."\n");
	echo("    CSI59m             ".$GLOBALS['CSI']."59m    CSI59m    ".$GLOBALS['clr']."\n");
	echo("    CSI60m             ".$GLOBALS['CSI']."60m    CSI60m    ".$GLOBALS['clr']."\n");
	echo("    CSI61m             ".$GLOBALS['CSI']."61m    CSI61m    ".$GLOBALS['clr']."\n");
	echo("    CSI62m             ".$GLOBALS['CSI']."62m    CSI62m    ".$GLOBALS['clr']."\n");
	echo("    CSI63m             ".$GLOBALS['CSI']."63m    CSI63m    ".$GLOBALS['clr']."\n");
	echo("    CSI64m             ".$GLOBALS['CSI']."64m    CSI64m    ".$GLOBALS['clr']."\n");
	echo("    CSI65m             ".$GLOBALS['CSI']."65m    CSI65m    ".$GLOBALS['clr']."\n");
	echo("    CSI66m             ".$GLOBALS['CSI']."66m    CSI66m    ".$GLOBALS['clr']."\n");
	echo("    CSI67m             ".$GLOBALS['CSI']."67m    CSI67m    ".$GLOBALS['clr']."\n");
	echo("    CSI68m             ".$GLOBALS['CSI']."68m    CSI68m    ".$GLOBALS['clr']."\n");
	echo("    CSI69m             ".$GLOBALS['CSI']."69m    CSI69m    ".$GLOBALS['clr']."\n");
	echo("    CSI70m             ".$GLOBALS['CSI']."70m    CSI70m    ".$GLOBALS['clr']."\n");
	echo("    CSI71m             ".$GLOBALS['CSI']."71m    CSI71m    ".$GLOBALS['clr']."\n");
	echo("    CSI72m             ".$GLOBALS['CSI']."72m    CSI72m    ".$GLOBALS['clr']."\n");
	echo("    CSI73m             ".$GLOBALS['CSI']."73m    CSI73m    ".$GLOBALS['clr']."\n");
	echo("    CSI74m             ".$GLOBALS['CSI']."74m    CSI74m    ".$GLOBALS['clr']."\n");
	echo("    CSI75m             ".$GLOBALS['CSI']."75m    CSI75m    ".$GLOBALS['clr']."\n");
	echo("    CSI76m             ".$GLOBALS['CSI']."76m    CSI76m    ".$GLOBALS['clr']."\n");
	echo("    CSI77m             ".$GLOBALS['CSI']."77m    CSI77m    ".$GLOBALS['clr']."\n");
	echo("    CSI78m             ".$GLOBALS['CSI']."78m    CSI78m    ".$GLOBALS['clr']."\n");
	echo("    CSI79m             ".$GLOBALS['CSI']."79m    CSI79m    ".$GLOBALS['clr']."\n");
	echo("    CSI80m             ".$GLOBALS['CSI']."80m    CSI80m    ".$GLOBALS['clr']."\n");
	echo("    CSI81m             ".$GLOBALS['CSI']."81m    CSI81m    ".$GLOBALS['clr']."\n");
	echo("    CSI82m             ".$GLOBALS['CSI']."82m    CSI82m    ".$GLOBALS['clr']."\n");
	echo("    CSI83m             ".$GLOBALS['CSI']."83m    CSI83m    ".$GLOBALS['clr']."\n");
	echo("    CSI84m             ".$GLOBALS['CSI']."84m    CSI84m    ".$GLOBALS['clr']."\n");
	echo("    CSI85m             ".$GLOBALS['CSI']."85m    CSI85m    ".$GLOBALS['clr']."\n");
	echo("    CSI86m             ".$GLOBALS['CSI']."86m    CSI86m    ".$GLOBALS['clr']."\n");
	echo("    CSI87m             ".$GLOBALS['CSI']."87m    CSI87m    ".$GLOBALS['clr']."\n");
	echo("    CSI88m             ".$GLOBALS['CSI']."88m    CSI88m    ".$GLOBALS['clr']."\n");
	echo("    CSI89m             ".$GLOBALS['CSI']."89m    CSI89m    ".$GLOBALS['clr']."\n");
	echo("    CSI90m             ".$GLOBALS['CSI']."90m    CSI90m    ".$GLOBALS['clr']."\n");
	echo("    CSI91m             ".$GLOBALS['CSI']."91m    CSI91m    ".$GLOBALS['clr']."\n");
	echo("    CSI92m             ".$GLOBALS['CSI']."92m    CSI92m    ".$GLOBALS['clr']."\n");
	echo("    CSI93m             ".$GLOBALS['CSI']."93m    CSI93m    ".$GLOBALS['clr']."\n");
	echo("    CSI94m             ".$GLOBALS['CSI']."94m    CSI94m    ".$GLOBALS['clr']."\n");
	echo("    CSI95m             ".$GLOBALS['CSI']."95m    CSI95m    ".$GLOBALS['clr']."\n");
	echo("    CSI96m             ".$GLOBALS['CSI']."96m    CSI96m    ".$GLOBALS['clr']."\n");
	echo("    CSI97m             ".$GLOBALS['CSI']."97m    CSI97m    ".$GLOBALS['clr']."\n");
	echo("    CSI98m             ".$GLOBALS['CSI']."98m    CSI98m    ".$GLOBALS['clr']."\n");
	echo("    CSI99m             ".$GLOBALS['CSI']."99m    CSI99m    ".$GLOBALS['clr']."\n");
	echo("    CSI100m            ".$GLOBALS['CSI']."100m    CSI100m    ".$GLOBALS['clr']."\n");
	echo("    CSI101m            ".$GLOBALS['CSI']."101m    CSI101m    ".$GLOBALS['clr']."\n");
	echo("    CSI102m            ".$GLOBALS['CSI']."102m    CSI102m    ".$GLOBALS['clr']."\n");
	echo("    CSI103m            ".$GLOBALS['CSI']."103m    CSI103m    ".$GLOBALS['clr']."\n");
	echo("    CSI104m            ".$GLOBALS['CSI']."104m    CSI104m    ".$GLOBALS['clr']."\n");
	echo("    CSI105m            ".$GLOBALS['CSI']."105m    CSI105m    ".$GLOBALS['clr']."\n");
	echo("    CSI106m            ".$GLOBALS['CSI']."106m    CSI106m    ".$GLOBALS['clr']."\n");
	echo("    CSI107m            ".$GLOBALS['CSI']."107m    CSI107m    ".$GLOBALS['clr']."\n");
	echo("    CSI108m            ".$GLOBALS['CSI']."108m    CSI108m    ".$GLOBALS['clr']."\n");
	echo("    CSI109m            ".$GLOBALS['CSI']."109m    CSI109m    ".$GLOBALS['clr']."\n");
	echo("    CSI110m            ".$GLOBALS['CSI']."110m    CSI110m    ".$GLOBALS['clr']."\n");
	echo("    CSI111m            ".$GLOBALS['CSI']."111m    CSI111m    ".$GLOBALS['clr']."\n");
	echo("    CSI112m            ".$GLOBALS['CSI']."112m    CSI112m    ".$GLOBALS['clr']."\n");
	echo("    CSI113m            ".$GLOBALS['CSI']."113m    CSI113m    ".$GLOBALS['clr']."\n");
	echo("    CSI114m            ".$GLOBALS['CSI']."114m    CSI114m    ".$GLOBALS['clr']."\n");
	echo("    CSI115m            ".$GLOBALS['CSI']."115m    CSI115m    ".$GLOBALS['clr']."\n");
	echo("    CSI116m            ".$GLOBALS['CSI']."116m    CSI116m    ".$GLOBALS['clr']."\n");
	echo("    CSI117m            ".$GLOBALS['CSI']."117m    CSI117m    ".$GLOBALS['clr']."\n");
	echo("    CSI118m            ".$GLOBALS['CSI']."118m    CSI118m    ".$GLOBALS['clr']."\n");
	echo("    CSI119m            ".$GLOBALS['CSI']."119m    CSI119m    ".$GLOBALS['clr']."\n");
	echo("    CSI120m            ".$GLOBALS['CSI']."120m    CSI120m    ".$GLOBALS['clr']."\n");
	echo("    CSI121m            ".$GLOBALS['CSI']."121m    CSI121m    ".$GLOBALS['clr']."\n");
	echo("    CSI122m            ".$GLOBALS['CSI']."122m    CSI122m    ".$GLOBALS['clr']."\n");
	echo("    CSI123m            ".$GLOBALS['CSI']."123m    CSI123m    ".$GLOBALS['clr']."\n");
	echo("    CSI124m            ".$GLOBALS['CSI']."124m    CSI124m    ".$GLOBALS['clr']."\n");
	echo("    CSI125m            ".$GLOBALS['CSI']."125m    CSI125m    ".$GLOBALS['clr']."\n");
	echo("    CSI126m            ".$GLOBALS['CSI']."126m    CSI126m    ".$GLOBALS['clr']."\n");
	echo("    CSI127m            ".$GLOBALS['CSI']."127m    CSI127m    ".$GLOBALS['clr']."\n");

	echo("    CSI?12h            ".$GLOBALS['CSI']."?12h    CSI?12h    ".$GLOBALS['clr']."\n");
	echo("    CSI?12l            ".$GLOBALS['CSI']."?12l    CSI?12l    ".$GLOBALS['clr']."\n");

	echo("\n");
	echo($GLOBALS['black'].$GLOBALS['bg_lblack']."                  Styles                ".$GLOBALS['clr']."\n");
	echo("    clr                ".$GLOBALS['clr']."  default  ".$GLOBALS['clr']."\n");
	echo("    bright             ".$GLOBALS['bright']."  bright  ".$GLOBALS['clr']."\n");
	echo("    nobright           ".$GLOBALS['nobright']."  nobright  ".$GLOBALS['clr']."\n");
	echo("    dim                ".$GLOBALS['dim']."  dim  ".$GLOBALS['clr']."\n");
	echo("    nodim              ".$GLOBALS['nodim']."  nodim  ".$GLOBALS['clr']."\n");
	echo("    italic             ".$GLOBALS['italic']."  italic  ".$GLOBALS['clr']."\n");
	echo("    noitalic           ".$GLOBALS['noitalic']."  noitalic  ".$GLOBALS['clr']."\n");
	echo("    underline          ".$GLOBALS['underline']."  underline  ".$GLOBALS['clr']."\n");
	echo("    nounderline        ".$GLOBALS['nounderline']."  nounderline  ".$GLOBALS['clr']."\n");
	echo("    blink              ".$GLOBALS['blink']."  blink  ".$GLOBALS['clr']."\n");
	echo("    noblink            ".$GLOBALS['noblink']."  noblink  ".$GLOBALS['clr']."\n");
	echo("    fblink             ".$GLOBALS['fblink']."  fblink  ".$GLOBALS['clr']."\n");
	//echo("    nofblink           ".$GLOBALS['nofblink']."  nofblink  ".$GLOBALS['clr']."\n");
	echo("    negative           ".$GLOBALS['negative']."  negative  ".$GLOBALS['clr']."\n");
	echo("    nonegative         ".$GLOBALS['nonegative']."  nonegative  ".$GLOBALS['clr']."\n");
	echo("    invisible          ".$GLOBALS['invisible']."  invisible  ".$GLOBALS['clr']."\n");
	echo("    noinvisible        ".$GLOBALS['noinvisible']."  noinvisible  ".$GLOBALS['clr']."\n");
	echo("    strike             ".$GLOBALS['strike']."  strike  ".$GLOBALS['clr']."\n");
	echo("    nostrike           ".$GLOBALS['nostrike']."  nostrike  ".$GLOBALS['clr']."\n");
	echo("\n");
	echo("\n");
	echo($GLOBALS['black']." ".$GLOBALS['bg_lblack']."           Style Combinations           ".$GLOBALS['clr']."\n");
	echo("    bright,italic      ".$GLOBALS['bright']."  ".$GLOBALS['italic']." bright,italic    ".$GLOBALS['clr']."\n");
	echo("    bright,underline   ".$GLOBALS['bright']."  ".$GLOBALS['underline']." bright,underline    ".$GLOBALS['clr']."\n");
	echo("    bright,negative    ".$GLOBALS['bright']."  ".$GLOBALS['negative']." bright,negative    ".$GLOBALS['clr']."\n");
	echo("    bright,strike      ".$GLOBALS['bright']."  ".$GLOBALS['strike']." bright,strike    ".$GLOBALS['clr']."\n");
	echo("\n");
	echo("\n");
	echo($GLOBALS['black']." ".$GLOBALS['bg_lblack']."           Color Combinations           ".$GLOBALS['clr']."\n");
	echo("    dim black          ".$GLOBALS['dim'].$GLOBALS['black']." dim black ".$GLOBALS['clr']."\n");
	echo("    black              ".$GLOBALS['black']." black ".$GLOBALS['clr']."\n");
	echo("    bright black       ".$GLOBALS['bright'].$GLOBALS['black']." bright black ".$GLOBALS['clr']."\n");
	echo("    dim red            ".$GLOBALS['dim'].$GLOBALS['red']." dim red ".$GLOBALS['clr']."\n");
	echo("    red                ".$GLOBALS['red']." red ".$GLOBALS['clr']."\n");
	echo("    bright red         ".$GLOBALS['bright'].$GLOBALS['red']." bright red ".$GLOBALS['clr']."\n");
	echo("    dim green          ".$GLOBALS['dim']."".$GLOBALS['green']." dim green ".$GLOBALS['clr']."\n");
	echo("    green              ".$GLOBALS['green']." green ".$GLOBALS['clr']."\n");
	echo("    bright green       ".$GLOBALS['bright']."".$GLOBALS['green']." bright green ".$GLOBALS['clr']."\n");
	echo("    dim yellow         ".$GLOBALS['dim']."".$GLOBALS['yellow']." dim yellow ".$GLOBALS['clr']."\n");
	echo("    yellow             ".$GLOBALS['yellow']." yellow ".$GLOBALS['clr']."\n");
	echo("    bright yellow      ".$GLOBALS['bright']."".$GLOBALS['yellow']." bright yellow ".$GLOBALS['clr']."\n");
	echo("    dim blue           ".$GLOBALS['dim']."".$GLOBALS['blue']." dim blue ".$GLOBALS['clr']."\n");
	echo("    blue               ".$GLOBALS['blue']." blue ".$GLOBALS['clr']."\n");
	echo("    bright blue        ".$GLOBALS['bright']."".$GLOBALS['blue']." bright blue ".$GLOBALS['clr']."\n");
	echo("    dim magenta        ".$GLOBALS['dim']."".$GLOBALS['magenta']." dim magenta ".$GLOBALS['clr']."\n");
	echo("    magenta            ".$GLOBALS['magenta']." magenta ".$GLOBALS['clr']."\n");
	echo("    bright magenta     ".$GLOBALS['bright']."".$GLOBALS['magenta']." bright magenta ".$GLOBALS['clr']."\n");
	echo("    dim cyan           ".$GLOBALS['dim']."".$GLOBALS['cyan']." dim cyan ".$GLOBALS['clr']."\n");
	echo("    cyan               ".$GLOBALS['cyan']." cyan ".$GLOBALS['clr']."\n");
	echo("    bright cyan        ".$GLOBALS['bright']."".$GLOBALS['cyan']." bright cyan ".$GLOBALS['clr']."\n");
	echo("    dim white          ".$GLOBALS['dim']."".$GLOBALS['white']." dim white ".$GLOBALS['clr']."\n");
	echo("    white              ".$GLOBALS['white']." white ".$GLOBALS['clr']."\n");
	echo("    bright white       ".$GLOBALS['bright']."".$GLOBALS['white']." bright white ".$GLOBALS['clr']."\n");
	echo("\n");
	echo("\n");
	echo($GLOBALS['black']." ".$GLOBALS['bg_lblack']."            Foreground Colors           ".$GLOBALS['clr']."\n");
	echo("    black              ".$GLOBALS['black']." black ".$GLOBALS['fg_clr']."\n");
	echo("    red                ".$GLOBALS['red']." red ".$GLOBALS['fg_clr']."\n");
	echo("    green              ".$GLOBALS['green']." green ".$GLOBALS['fg_clr']."\n");
	echo("    yellow             ".$GLOBALS['yellow']." yellow ".$GLOBALS['fg_clr']."\n");
	echo("    blue               ".$GLOBALS['blue']." blue ".$GLOBALS['fg_clr']."\n");
	echo("    magenta            ".$GLOBALS['magenta']." magenta ".$GLOBALS['fg_clr']."\n");
	echo("    cyan               ".$GLOBALS['cyan']." cyan ".$GLOBALS['fg_clr']."\n");
	echo("    white              ".$GLOBALS['white']." white ".$GLOBALS['fg_clr']."\n");
	echo("\n");
	echo("\n");
	echo($GLOBALS['black']." ".$GLOBALS['bg_lblack']."            Background Colors           ".$GLOBALS['clr']."\n");
	echo("    bg_black           ".$GLOBALS['bg_black']." bg_black   ".$GLOBALS['bg_clr']."\n");
	echo("    bg_red             ".$GLOBALS['bg_red']." bg_red   ".$GLOBALS['bg_clr']."\n");
	echo("    bg_green           ".$GLOBALS['bg_green']." bg_green   ".$GLOBALS['bg_clr']."\n");
	echo("    bg_yellow          ".$GLOBALS['bg_yellow']." bg_yellow   ".$GLOBALS['bg_clr']."\n");
	echo("    bg_blue            ".$GLOBALS['bg_blue']." bg_blue   ".$GLOBALS['bg_clr']."\n");
	echo("    bg_magenta         ".$GLOBALS['bg_magenta']." bg_magenta   ".$GLOBALS['bg_clr']."\n");
	echo("    bg_cyan            ".$GLOBALS['bg_cyan']." bg_cyan   ".$GLOBALS['bg_clr']."\n");
	echo("    bg_white           ".$GLOBALS['bg_white']." bg_white   ".$GLOBALS['bg_clr']."\n");
	echo("\n");
	echo("\n");
	echo($GLOBALS['black']." ".$GLOBALS['bg_lblack']."       Foreground Colors    bright      ".$GLOBALS['clr']."\n");
	echo("    lblack             ".$GLOBALS['lblack']." lblack ".$GLOBALS['clr']."\n");
	echo("    lred               ".$GLOBALS['lred']." lred ".$GLOBALS['clr']."\n");
	echo("    lgreen             ".$GLOBALS['lgreen']." lgreen ".$GLOBALS['clr']."\n");
	echo("    lyellow            ".$GLOBALS['lyellow']." lyellow ".$GLOBALS['clr']."\n");
	echo("    lblue              ".$GLOBALS['lblue']." lblue ".$GLOBALS['clr']."\n");
	echo("    lmagenta           ".$GLOBALS['lmagenta']." lmagenta ".$GLOBALS['clr']."\n");
	echo("    lcyan              ".$GLOBALS['lcyan']." lcyan ".$GLOBALS['clr']."\n");
	echo("    lwhite             ".$GLOBALS['lwhite']." lwhite ".$GLOBALS['clr']."\n");
	echo("\n");
	echo("\n");
	echo($GLOBALS['black']." ".$GLOBALS['bg_lblack']."       Background Colors - bright       ".$GLOBALS['clr']."\n");
	echo("    bg_lblack          ".$GLOBALS['bg_lblack'].$GLOBALS['black']."   bg_lblack    ".$GLOBALS['clr']."\n");
	echo("    bg_lred            ".$GLOBALS['bg_lred']."".$GLOBALS['black']."     bg_lred    ".$GLOBALS['clr']."\n");
	echo("    bg_lgreen          ".$GLOBALS['bg_lgreen']."".$GLOBALS['black']."   bg_lgreen    ".$GLOBALS['clr']."\n");
	echo("    bg_lyellow         ".$GLOBALS['bg_lyellow']."".$GLOBALS['black']."  bg_lyellow    ".$GLOBALS['clr']."\n");
	echo("    bg_lblue           ".$GLOBALS['bg_lblue']."".$GLOBALS['black']."    bg_lblue    ".$GLOBALS['clr']."\n");
	echo("    bg_lmagenta        ".$GLOBALS['bg_lmagenta']."".$GLOBALS['black']." bg_lmagenta    ".$GLOBALS['clr']."\n");
	echo("    bg_lcyan           ".$GLOBALS['bg_lcyan']."".$GLOBALS['black']."    bg_lcyan    ".$GLOBALS['clr']."\n");
	echo("    bg_lwhite          ".$GLOBALS['bg_lwhite']."".$GLOBALS['black']."   bg_lwhite    ".$GLOBALS['clr']."\n");
	echo("\n");
	echo("\n");
	echo($GLOBALS['black']." ".$GLOBALS['bg_lblack']."         RGB Foreground Colors          ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."255;10;10m      RGB255;0;10m     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."10;255;10m      RGB 0;255;10    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;255m      RGB 0;0;255    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;250m      RGB 0;0;250    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;245m      RGB 0;0;245    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;240m      RGB 0;0;240    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;235m      RGB 0;0;235    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;230m      RGB 0;0;230    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;225m      RGB 0;0;225    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;220m      RGB 0;0;220    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;215m      RGB 0;0;215    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;210m      RGB 0;0;210    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;205m      RGB 0;0;205    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;200m      RGB 0;0;200    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;195m      RGB 0;0;195    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;190m      RGB 0;0;190    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;185m      RGB 0;0;185    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;180m      RGB 0;0;180    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;175m      RGB 0;0;175    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;170m      RGB 0;0;170    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;165m      RGB 0;0;165    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;160m      RGB 0;0;160    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;155m      RGB 0;0;155    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;150m      RGB 0;0;150    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;145m      RGB 0;0;145    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;140m      RGB 0;0;140    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;135m      RGB 0;0;135    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;130m      RGB 0;0;130    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;125m      RGB 0;0;125    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;120m      RGB 0;0;120    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;115m      RGB 0;0;115    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;110m      RGB 0;0;110    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;105m      RGB 0;0;105    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;100m      RGB 0;0;100    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;95m      RGB 0;0;95     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;90m      RGB 0;0;90     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;85m      RGB 0;0;85     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;80m      RGB 0;0;80     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;75m      RGB 0;0;75     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;70m      RGB 0;0;70     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;65m      RGB 0;0;65     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;60m      RGB 0;0;60     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;55m      RGB 0;0;55     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;50m      RGB 0;0;50     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;45m      RGB 0;0;45     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;40m      RGB 0;0;40     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;35m      RGB 0;0;35     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;30m      RGB 0;0;30     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;25m      RGB 0;0;25     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;20m      RGB 0;0;20     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;15m      RGB 0;0;15     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;10m      RGB 0;0;10     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;5m      RGB 0;0;5      ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['RGB']."0;0;0m      RGB 0;0;0      ".$GLOBALS['clr']."\n");
	echo("\n");
	echo("\n");
	echo($GLOBALS['black']." ".$GLOBALS['bg_lblack']."          RGB Background Colors         ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."255;10;10m      bg_RGB 255;0;10    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."10;255;10m      bg_RGB 0;255;10    ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;255m      bg_RGB 0;0;255     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;250m      bg_RGB 0;0;250     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;245m      bg_RGB 0;0;245     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;240m      bg_RGB 0;0;240     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;235m      bg_RGB 0;0;235     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;230m      bg_RGB 0;0;230     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;225m      bg_RGB 0;0;225     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;220m      bg_RGB 0;0;220     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;215m      bg_RGB 0;0;215     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;210m      bg_RGB 0;0;210     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;205m      bg_RGB 0;0;205     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;200m      bg_RGB 0;0;200     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;195m      bg_RGB 0;0;195     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;190m      bg_RGB 0;0;190     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;185m      bg_RGB 0;0;185     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;180m      bg_RGB 0;0;180     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;175m      bg_RGB 0;0;175     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;170m      bg_RGB 0;0;170     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;165m      bg_RGB 0;0;165     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;160m      bg_RGB 0;0;160     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;155m      bg_RGB 0;0;155     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;150m      bg_RGB 0;0;150     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;145m      bg_RGB 0;0;145     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;140m      bg_RGB 0;0;140     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;135m      bg_RGB 0;0;135     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;130m      bg_RGB 0;0;130     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;125m      bg_RGB 0;0;125     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;120m      bg_RGB 0;0;120     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;115m      bg_RGB 0;0;115     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;110m      bg_RGB 0;0;110     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;105m      bg_RGB 0;0;105     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;100m      bg_RGB 0;0;100     ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;95m      bg_RGB 0;0;95      ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;90m      bg_RGB 0;0;90      ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;85m      bg_RGB 0;0;85      ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;80m      bg_RGB 0;0;80      ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;75m      bg_RGB 0;0;75      ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;70m      bg_RGB 0;0;70      ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;65m      bg_RGB 0;0;65      ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;60m      bg_RGB 0;0;60      ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;55m      bg_RGB 0;0;55      ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;50m      bg_RGB 0;0;50      ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;45m      bg_RGB 0;0;45      ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;40m      bg_RGB 0;0;40      ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;35m      bg_RGB 0;0;35      ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;30m      bg_RGB 0;0;30      ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;25m      bg_RGB 0;0;25      ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;20m      bg_RGB 0;0;20      ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;15m      bg_RGB 0;0;15      ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;10m      bg_RGB 0;0;10      ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;5m      bg_RGB 0;0;5       ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_RGB']."0;0;0m      bg_RGB 0;0;0       ".$GLOBALS['clr']."\n");
	echo("\n"); 
	echo("\n");
	echo($GLOBALS['black']." ".$GLOBALS['bg_lblack']."              Combinations              ".$GLOBALS['clr']."\n");
	echo("negative                  ".$GLOBALS['negative']."       inverse foreground / background        ".$GLOBALS['clr']."\n");
	echo("bg_yellow,red             ".$GLOBALS['bg_yellow'].$GLOBALS['red']."      yellow backgroud / red foreground       ".$GLOBALS['clr']."\n");
	echo("bg_yellow,red,negative    ".$GLOBALS['bg_yellow'].$GLOBALS['red'].$GLOBALS['negative']."             yellow / red inversed            ".$GLOBALS['clr']."\n");
	echo("bg_red,bg_green,bg_blue   ".$GLOBALS['bg_red']."     nested     ".$GLOBALS['bg_green']."     colors     ".$GLOBALS['bg_blue']."     text     ".$GLOBALS['clr']."\n");
	echo("\n");
	echo("\n");
	echo($GLOBALS['black']." ".$GLOBALS['bg_lblack']."             ASCII Color Art            ".$GLOBALS['clr']."\n");
	echo("\n");
	echo("    ".$GLOBALS['bg_blue']." * * * * * * * * * ".$GLOBALS['bg_red']."                                ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_blue']."  * * * * * * * *  ".$GLOBALS['bg_white']."                                ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_blue']." * * * * * * * * * ".$GLOBALS['bg_red']."                                ".$GLOBALS['clr']."\n"); 
	echo("    ".$GLOBALS['bg_blue']."  * * * * * * * *  ".$GLOBALS['bg_white']."                                ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_blue']." * * * * * * * * * ".$GLOBALS['bg_red']."                                ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_blue']."  * * * * * * * *  ".$GLOBALS['bg_white']."                                ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_blue']." * * * * * * * * * ".$GLOBALS['bg_red']."                                ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_white']."                                                   ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_red']."                                                   ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_white']."                                                   ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_red']."                                                   ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_white']."                                                   ".$GLOBALS['clr']."\n");
	echo("    ".$GLOBALS['bg_red']."                                                   ".$GLOBALS['clr']."\n");
	echo("\n");
	echo("\n");
	echo($GLOBALS['black']." ".$GLOBALS['bg_lblack']."               ASCII Mode               ".$GLOBALS['clr']."\n");
	echo($GLOBALS['ASCII']." a b c d e f g h i j k l m n o p q r s t u v w x y z\n");
	echo("\n");
	echo("\n");
	echo($GLOBALS['black']." ".$GLOBALS['bg_lblack']."                DEC Mode                ".$GLOBALS['clr']."\n");
	echo($GLOBALS['DEC']." a b c d e f g h i j k l m n o p q r s t u v w x y z\n");
	echo($GLOBALS['ASCII']."\n");
	echo("\n");
	echo("\n");
}

