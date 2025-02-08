#pragma once
#ifndef dk_color_hpp
#define dk_color_hpp

#include "DK.hpp"


// https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
// https://en.wikipedia.org/wiki/C0_and_C1_control_codes

//############ C0 control codes #############
//    Sequences		Hexadecimal   Unicode   Decimal    Octal    Ctrl-Key:
const std::string NUL	= "\x00";	// Null - Does nothing. The code of blank paper tape, and also used for padding to slow transmission
const std::string SOH	= "\x01";	// Start of Heading - First character of the heading of a message
const std::string STX	= "\x02";	// Start of Text - Terminates the header and starts the message text
const std::string ETX	= "\x03";	// End of Text - Ends the message text, starts a footer (up to the next TC character)
const std::string EOT	= "\x04";	// End of Transmission - Ends the transmission of one or more messages. May place terminals on standby.
const std::string EQN	= "\x05";	// Enquiry - Trigger a response at the receiving end, to see if it is still present.
const std::string ACK	= "\x06";	// Acknowledge - Indication of successful receipt of a message.
const std::string BEL	= "\x07";	// Bell, Alert	- Call for attention from an operator.
const std::string BS	= "\x08";	// Backspace - Move one position leftwards. Next character may overprint or replace the character that was there.
const std::string HT	= "\x09";	// Character Tabulation, Horizontal Tabulation	- Move right to the next tab stop.
const std::string LF	= "\x0A";	// Line Feed - Move down to the same position on the next line (some devices also moved to the left column).
const std::string VT	= "\x0B";	// Line Tabulation, Vertical Tabulation - Move down to the next vertical tab stop.
const std::string FF	= "\x0C";	// Form Feed - Move down to the top of the next page.
const std::string CR	= "\x0D";	// Carriage Return - Move to column zero while staying on the same line.
const std::string SO	= "\x0E";	// Shift Out - Switch to an alternative character set.
const std::string SI	= "\x0F";	// Shift In - Return to regular character set after SO.
const std::string DLE	= "\x10";	// Data Link Escape - Cause a number of contiguously following characters to be interpreted in some different way
const std::string DC1	= "\x11";	// Device Control One - Turn on (DC1 and DC2) or off (DC3 and DC4) devices.
const std::string DC2	= "\x12";	// Device Control Two
const std::string DC3	= "\x13";	// Device Control Three
const std::string DC4	= "\x14";	// Device Control Four
const std::string NAK	= "\x15";	// Negative Acknowledge - Negative response to a sender, such as a detected error.
const std::string SYN	= "\x16";	// Synchronous Idle - Sent in synchronous transmission systems when no other character is being transmitted.
const std::string ETB	= "\x17";	// End of Transmission Block - End of a transmission block of data when data are divided into such blocks.
const std::string CAN	= "\x18";	// Cancel - Indicates that the data preceding it are in error or are to be disregarded.
const std::string EM	= "\x19";	// End of medium - Indicates on paper or magnetic tapes that the end of the usable tape had been reached.
const std::string SUB	= "\x1A";	// Substitute -Replaces a character that was found to be invalid or in error. Should be ignored.
const std::string ESC	= "\x1B";	//   \u001b      27       \033       ^[ 		// Escape - Alters the meaning of a limited number of following bytes.
const std::string FS	= "\x1C";	// File Separator - Can be used as delimiters to mark fields of data structures. 
const std::string GS	= "\x1D";	// Group Separator
const std::string RS	= "\x1E";	// Record Separator
const std::string US	= "\x1F";	// Unit Separator - US is the lowest level
const std::string SP	= "\x20";	// Space - Move right one character position.
const std::string DEL	= "\x7F";	// Delete - Should be ignored. Used to delete characters on punched tape by punching out all the holes.

//############ C1 control codes #############
const std::string PAD	= "\x80";	// Padding Character
const std::string HOP	= "\x81";	// High Octet Preset
const std::string BPH	= "\x82";	// Break Permitted Here
const std::string NBH	= "\x83";	// No Break Here
const std::string IND	= "\x84";	// Index
const std::string NEL	= "\x85";	// Next Line
const std::string SSA	= "\x86";	// Start of Selected Area
const std::string ESA	= "\x87";	// End of Selected Area
const std::string HTS	= "\x88";	// Horizontal Tabulation Set
const std::string HTJ	= "\x89";	// Horizontal Tabulation With Justification
const std::string VTS	= "\x8A";	// Vertical Tabulation Set
const std::string PLD	= "\x8B";	// Partial Line Down
const std::string PLU	= "\x8C";	// Partial Line Up
const std::string RI	= "\x8D";	// Reverse Index
const std::string SS2	= "\x8E";	// Single Shift Two
const std::string SS3	= "\x8F";	// Single Shift Three
const std::string DCS	= "\x90";	// Device Control String
const std::string PU1	= "\x91";	// Private Use 1
const std::string PU2	= "\x92";	// Private Use 2
const std::string STS	= "\x93";	// Set Transmit State
const std::string CCH	= "\x94";	// Cancel character
const std::string MW	= "\x95";	// Message Waiting
const std::string SPA	= "\x96";	// Start of Protected Area
const std::string EPA	= "\x97";	// End of Protected Area
const std::string SOS	= "\x98";	// Start of String
const std::string SGC	= "\x99";	// Single Graphic Character Introducer
const std::string SCI	= "\x9A";	// Single Character Introducer
const std::string CSI	= "\x9B";	// Control Sequence Introducer
const std::string ST	= "\x9C";	// String Terminator
const std::string OSC 	= "\x9D";	// Operating System Command
const std::string PM	= "\x9E";	// Privacy Message
const std::string APC	= "\x9F";	// Application Program Command

//############ CSI Commands #############
const std::string ANSI0   = "\x1B[0m";       const std::string clr         = "\x1B[0m";    // Default                   - Returns all attributes to the default state prior to modification
const std::string ANSI1   = "\x1B[1m";       const std::string bold        = "\x1B[1m";    // Bold/Bright               - Applies brightness/intensity flag to foreground color
const std::string ANSI2   = "\x1B[2m";       const std::string dim         = "\x1B[2m";    // Dim
const std::string ANSI3   = "\x1B[3m";       const std::string italic      = "\x1B[3m";    // Italic
const std::string ANSI4   = "\x1B[4m";       const std::string underline   = "\x1B[4m";    // Underline                 - Adds underline
const std::string ANSI5   = "\x1B[5m";       const std::string blink       = "\x1B[5m";    // Blink
const std::string ANSI6   = "\x1B[6m";       const std::string fblink      = "\x1B[6m";    // Rapid Blink
const std::string ANSI7   = "\x1B[7m";       const std::string negative    = "\x1B[7m";    // Negative                  - Swaps foreground and background colors
const std::string ANSI8   = "\x1B[8m";       const std::string invisible   = "\x1B[8m";    // Invisible
const std::string ANSI9   = "\x1B[9m";       const std::string strike      = "\x1B[9m";    // Strike Through
const std::string ANSI10  = "\x1B[10m";//    const std::string ???         = "\x1B[10m";   // UNKNOWN
const std::string ANSI11  = "\x1B[11m";//    const std::string ???         = "\x1B[11m";   // UNKNOWN 
const std::string ANSI12  = "\x1B[12m";//    const std::string ???         = "\x1B[12m";   // UNKNOWN
const std::string ANSI13  = "\x1B[13m";//    const std::string ???         = "\x1B[13m";   // UNKNOWN
const std::string ANSI14  = "\x1B[14m";//    const std::string ???         = "\x1B[14m";   // UNKNOWN
const std::string ANSI15  = "\x1B[15m";//    const std::string ???         = "\x1B[15m";   // UNKNOWN
const std::string ANSI16  = "\x1B[16m";//    const std::string ???         = "\x1B[16m";   // UNKNOWN
const std::string ANSI17  = "\x1B[17m";//    const std::string ???         = "\x1B[17m";   // UNKNOWN
const std::string ANSI18  = "\x1B[18m";//    const std::string ???         = "\x1B[18m";   // UNKNOWN
const std::string ANSI19  = "\x1B[19m";//    const std::string ???         = "\x1B[19m";   // UNKNOWN
const std::string ANSI20  = "\x1B[20m";//    const std::string ???         = "\x1B[20m";   // UNKNOWN
const std::string ANSI21  = "\x1B[21m";//    const std::string ???         = "\x1B[21m";   // UNKNOWN
const std::string ANSI22  = "\x1B[22m";      const std::string nobold      = "\x1B[22m";   // No bold/bright            - Removes brightness/intensity flag from foreground color
const std::string ANSI23  = "\x1B[23m";      const std::string noitalic    = "\x1B[23m";   // No Italic
const std::string ANSI24  = "\x1B[24m";      const std::string nounderline = "\x1B[24m";   // No underline              - Removes underline
const std::string ANSI25  = "\x1B[25m";      const std::string noblink     = "\x1B[25m";   // No Blink
const std::string ANSI26  = "\x1B[26m";//    const std::string ???         = "\x1B[26m";   // UNKNOWN
const std::string ANSI27  = "\x1B[27m";      const std::string nonegative  = "\x1B[27m";   // Positive(No negative)     - Returns foreground/background to normal
const std::string ANSI28  = "\x1B[28m";      const std::string visible     = "\x1B[28m";   // Visible(No invisible)
const std::string ANSI29  = "\x1B[29m";      const std::string nostrike    = "\x1B[29m";   // No Strike Through
const std::string ANSI30  = "\x1B[30m";      const std::string black       = "\x1B[30m";   // Foreground Black          - Applies non-bold/bright black to foreground
const std::string ANSI31  = "\x1B[31m";      const std::string red         = "\x1B[31m";   // Foreground Red            - Applies non-bold/bright red to foreground
const std::string ANSI32  = "\x1B[32m";      const std::string green       = "\x1B[32m";   // Foreground Green          - Applies non-bold/bright green to foreground
const std::string ANSI33  = "\x1B[33m";      const std::string yellow      = "\x1B[33m";   // Foreground Yellow         - Applies non-bold/bright yellow to foreground
const std::string ANSI34  = "\x1B[34m";      const std::string blue        = "\x1B[34m";   // Foreground Blue           - Applies non-bold/bright blue to foreground
const std::string ANSI35  = "\x1B[35m";      const std::string magenta     = "\x1B[35m";   // Foreground Magenta        - Applies non-bold/bright magenta to foreground
const std::string ANSI36  = "\x1B[36m";      const std::string cyan        = "\x1B[36m";   // Foreground Cyan           - Applies non-bold/bright cyan to foreground
const std::string ANSI37  = "\x1B[37m";      const std::string white       = "\x1B[37m";   // Foreground White          - Applies non-bold/bright white to foreground
const std::string ANSI38  = "\x1B[38;2;";    const std::string RGB         = "\x1B[38;2;"; // Foreground EXTENDED       - Applies extended colors to forecround      RGB+"50;100;150m"
const std::string ANSI39  = "\x1B[39m";      const std::string default_    = "\x1B[39m";   // Foreground Default        - Applies only the foreground portion of the defaults
const std::string ANSI40  = "\x1B[40m";      const std::string bg_black    = "\x1B[40m";   // Background Black          - Applies non-bold/bright black to background
const std::string ANSI41  = "\x1B[41m";      const std::string bg_red      = "\x1B[41m";   // Background Red            - Applies non-bold/bright red to background
const std::string ANSI42  = "\x1B[42m";      const std::string bg_green    = "\x1B[42m";   // Background Green          - Applies non-bold/bright green to background
const std::string ANSI43  = "\x1B[43m";      const std::string bg_yellow   = "\x1B[43m";   // Background Yellow         - Applies non-bold/bright yellow to background
const std::string ANSI44  = "\x1B[44m";      const std::string bg_blue     = "\x1B[44m";   // Background Blue           - Applies non-bold/bright blue to background
const std::string ANSI45  = "\x1B[45m";      const std::string bg_magenta  = "\x1B[45m";   // Background Magenta        - Applies non-bold/bright magenta to background
const std::string ANSI46  = "\x1B[46m";      const std::string bg_cyan     = "\x1B[46m";   // Background Cyan           - Applies non-bold/bright cyan to background
const std::string ANSI47  = "\x1B[47m";      const std::string bg_white    = "\x1B[47m";   // Background White          - Applies non-bold/bright white to background
const std::string ANSI48  = "\x1B[48;2;";    const std::string bg_RGB      = "\x1B[48;2;"; // Background EXTENDED       - Applies exteneded colors to background    bg_RGB+"150;100;50m"
const std::string ANSI49  = "\x1B[49m";  	   const std::string bg_default  = "\x1B[49m";   // Background Default        - Applies only the background portion of the defaults
const std::string ANSI50  = "\x1B[50m";//    const std::string ???         = "\x1B[50m";   // UNKNOWN
const std::string ANSI51  = "\x1B[51m";//    const std::string ???         = "\x1B[51m";   // UNKNOWN
const std::string ANSI52  = "\x1B[52m";//    const std::string ???         = "\x1B[52m";   // UNKNOWN
const std::string ANSI53  = "\x1B[53m";//    const std::string ???         = "\x1B[53m";   // UNKNOWN
const std::string ANSI54  = "\x1B[54m";//    const std::string ???         = "\x1B[54m";   // UNKNOWN
const std::string ANSI55  = "\x1B[55m";//    const std::string ???         = "\x1B[55m";   // UNKNOWN
const std::string ANSI56  = "\x1B[56m";//    const std::string ???         = "\x1B[56m";   // UNKNOWN
const std::string ANSI57  = "\x1B[57m";//    const std::string ???         = "\x1B[57m";   // UNKNOWN
const std::string ANSI58  = "\x1B[58m";//    const std::string ???         = "\x1B[58m";   // UNKNOWN
const std::string ANSI59  = "\x1B[59m";//    const std::string ???         = "\x1B[59m";   // UNKNOWN
const std::string ANSI60  = "\x1B[60m";//    const std::string ???         = "\x1B[60m";   // UNKNOWN
const std::string ANSI61  = "\x1B[61m";//    const std::string ???         = "\x1B[61m";   // UNKNOWN
const std::string ANSI62  = "\x1B[62m";//    const std::string ???         = "\x1B[62m";   // UNKNOWN
const std::string ANSI63  = "\x1B[63m";//    const std::string ???         = "\x1B[63m";   // UNKNOWN
const std::string ANSI64  = "\x1B[64m";//    const std::string ???         = "\x1B[64m";   // UNKNOWN
const std::string ANSI65  = "\x1B[65m";//    const std::string ???         = "\x1B[65m";   // UNKNOWN
const std::string ANSI66  = "\x1B[66m";//    const std::string ???         = "\x1B[66m";   // UNKNOWN
const std::string ANSI67  = "\x1B[67m";//    const std::string ???         = "\x1B[67m";   // UNKNOWN
const std::string ANSI68  = "\x1B[68m";//    const std::string ???         = "\x1B[68m";   // UNKNOWN
const std::string ANSI69  = "\x1B[69m";//    const std::string ???         = "\x1B[69m";   // UNKNOWN
const std::string ANSI70  = "\x1B[70m";//    const std::string ???         = "\x1B[70m";   // UNKNOWN
const std::string ANSI71  = "\x1B[71m";//    const std::string ???         = "\x1B[71m";   // UNKNOWN
const std::string ANSI72  = "\x1B[72m";//    const std::string ???         = "\x1B[72m";   // UNKNOWN
const std::string ANSI73  = "\x1B[73m";//    const std::string ???         = "\x1B[73m";   // UNKNOWN
const std::string ANSI74  = "\x1B[74m";//    const std::string ???         = "\x1B[74m";   // UNKNOWN
const std::string ANSI75  = "\x1B[75m";//    const std::string ???         = "\x1B[75m";   // UNKNOWN
const std::string ANSI76  = "\x1B[76m";//    const std::string ???         = "\x1B[76m";   // UNKNOWN
const std::string ANSI77  = "\x1B[77m";//    const std::string ???         = "\x1B[77m";   // UNKNOWN
const std::string ANSI78  = "\x1B[78m";//    const std::string ???         = "\x1B[78m";   // UNKNOWN
const std::string ANSI79  = "\x1B[79m";//    const std::string ???         = "\x1B[79m";   // UNKNOWN
const std::string ANSI80  = "\x1B[80m";//    const std::string ???         = "\x1B[80m";   // UNKNOWN
const std::string ANSI81  = "\x1B[81m";//    const std::string ???         = "\x1B[81m";   // UNKNOWN
const std::string ANSI82  = "\x1B[82m";//    const std::string ???         = "\x1B[82m";   // UNKNOWN
const std::string ANSI83  = "\x1B[83m";//    const std::string ???         = "\x1B[83m";   // UNKNOWN
const std::string ANSI84  = "\x1B[84m";//    const std::string ???         = "\x1B[84m";   // UNKNOWN
const std::string ANSI85  = "\x1B[85m";//    const std::string ???         = "\x1B[85m";   // UNKNOWN
const std::string ANSI86  = "\x1B[86m";//    const std::string ???         = "\x1B[86m";   // UNKNOWN
const std::string ANSI87  = "\x1B[87m";//    const std::string ???         = "\x1B[87m";   // UNKNOWN
const std::string ANSI88  = "\x1B[88m";//    const std::string ???         = "\x1B[88m";   // UNKNOWN
const std::string ANSI89  = "\x1B[89m";//    const std::string ???         = "\x1B[89m";   // UNKNOWN
const std::string ANSI90  = "\x1B[90m";      const std::string lblack      = "\x1B[90m";   // Bright Foreground Black   - Applies bold/bright black to foreground
const std::string ANSI91  = "\x1B[91m";      const std::string lred        = "\x1B[91m";   // Bright Foreground Red     - Applies bold/bright red to foreground
const std::string ANSI92  = "\x1B[92m";      const std::string lgreen      = "\x1B[92m";   // Bright Foreground Green   - Applies bold/bright green to foreground
const std::string ANSI93  = "\x1B[93m";      const std::string lyellow     = "\x1B[93m";   // Bright Foreground Yellow  - Applies bold/bright yellow to foreground
const std::string ANSI94  = "\x1B[94m";      const std::string lblue       = "\x1B[94m";   // Bright Foreground Blue    - Applies bold/bright blue to foreground
const std::string ANSI95  = "\x1B[95m";      const std::string lmagenta    = "\x1B[95m";   // Bright Foreground Magenta - Applies bold/bright magenta to foreground
const std::string ANSI96  = "\x1B[96m";      const std::string lcyan       = "\x1B[96m";   // Bright Foreground Cyan    - Applies bold/bright cyan to foreground
const std::string ANSI97  = "\x1B[97m";      const std::string lwhite      = "\x1B[97m";   // Bright Foreground White   - Applies bold/bright white to foreground
const std::string ANSI98  = "\x1B[98m";//    const std::string ???         = "\x1B[98m";   // UNKNOWN
const std::string ANSI99  = "\x1B[99m";//    const std::string ???         = "\x1B[99m";   // UNKNOWN
const std::string ANSI100 = "\x1B[100m";     const std::string bg_lblack   = "\x1B[100m";  // Bright Background Black   - Applies bold/bright black to background
const std::string ANSI101 = "\x1B[101m";     const std::string bg_lred     = "\x1B[101m";  // Bright Background Red     - Applies bold/bright red to background
const std::string ANSI102 = "\x1B[102m";     const std::string bg_lgreen   = "\x1B[102m";  // Bright Background Green   - Applies bold/bright green to background
const std::string ANSI103 = "\x1B[103m";     const std::string bg_lyellow  = "\x1B[103m";  // Bright Background Yellow  - Applies bold/bright yellow to background
const std::string ANSI104 = "\x1B[104m";     const std::string bg_lblue    = "\x1B[104m";  // Bright Background Blue    - Applies bold/bright blue to background
const std::string ANSI105 = "\x1B[105m";     const std::string bg_lmagenta = "\x1B[105m";  // Bright Background Magenta - Applies bold/bright magenta to background
const std::string ANSI106 = "\x1B[106m";     const std::string bg_lcyan    = "\x1B[106m";  // Bright Background Cyan    - Applies bold/bright cyan to background
const std::string ANSI107 = "\x1B[107m";     const std::string bg_lwhite   = "\x1B[107m";  // Bright Background White   - Applies bold/bright white to background
const std::string ANSI108 = "\x1B[108m";//   const std::string ???         = "\x1B[108m";  // UNKNOWN
const std::string ANSI109 = "\x1B[109m";//   const std::string ???         = "\x1B[109m";  // UNKNOWN
const std::string ANSI110 = "\x1B[110m";//   const std::string ???         = "\x1B[111m";  // UNKNOWN
const std::string ANSI111 = "\x1B[111m";//   const std::string ???         = "\x1B[111m";  // UNKNOWN
const std::string ANSI112 = "\x1B[112m";//   const std::string ???         = "\x1B[112m";  // UNKNOWN
const std::string ANSI113 = "\x1B[113m";//   const std::string ???         = "\x1B[113m";  // UNKNOWN
const std::string ANSI114 = "\x1B[114m";//   const std::string ???         = "\x1B[114m";  // UNKNOWN
const std::string ANSI115 = "\x1B[115m";//   const std::string ???         = "\x1B[115m";  // UNKNOWN
const std::string ANSI116 = "\x1B[116m";//   const std::string ???         = "\x1B[116m";  // UNKNOWN
const std::string ANSI117 = "\x1B[117m";//   const std::string ???         = "\x1B[117m";  // UNKNOWN
const std::string ANSI118 = "\x1B[118m";//   const std::string ???         = "\x1B[118m";  // UNKNOWN
const std::string ANSI119 = "\x1B[119m";//   const std::string ???         = "\x1B[119m";  // UNKNOWN
const std::string ANSI120 = "\x1B[120m";//   const std::string ???         = "\x1B[120m";  // UNKNOWN
const std::string ANSI121 = "\x1B[121m";//   const std::string ???         = "\x1B[121m";  // UNKNOWN
const std::string ANSI122 = "\x1B[122m";//   const std::string ???         = "\x1B[122m";  // UNKNOWN
const std::string ANSI123 = "\x1B[123m";//   const std::string ???         = "\x1B[123m";  // UNKNOWN
const std::string ANSI124 = "\x1B[124m";//   const std::string ???         = "\x1B[124m";  // UNKNOWN


//const std::string str(const char *strA, const char *strB){
	//for (;*str;str++);
    //*str++ = c; 
    //*str++ = 0;
//	return "test";
//};

//################################################################################
//# dk_color()
//#
void dk_color(){
	//dk_echo(blue+"C"+green+"O"+red+"L"+magenta+"O"+cyan+"R"+blue+"O"+green+"N"+clr);
    return;
};


#endif //dk_color_hpp