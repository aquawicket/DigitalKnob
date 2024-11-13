#pragma once
#ifndef dk_color_h
#define dk_color_h

#include "DK.h"

// https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797

//Sequences		  Hexadecimal   Unicode   Decimal    Octal    Ctrl-Key:
const char* ESC   = "\x1B";//   \u001b      27       \033       ^[        - sequence starting with ESC (\x1B)
const char* CSI   = "\x9B";//                                             - Control Sequence Introducer: sequence starting with ESC [ or CSI (\x9B)
const char* DCS   = "\x90";//                                             - Device Control String: sequence starting with ESC P or DCS (\x90)
const char* OSC   = "\x9D";//                                             - Operating System Command: sequence starting with ESC ] or OSC (\x9D)

//const char* str(const char *strA, const char *strB){
	//for (;*str;str++);
    //*str++ = c; 
    //*str++ = 0;
//	return "test";
//};
  
const char* ANSI0   = "\x1B[0m";       const char* clr         = "\x1B[0m";    // Default                   - Returns all attributes to the default state prior to modification
const char* ANSI1   = "\x1B[1m";       const char* bold        = "\x1B[1m";    // Bold/Bright               - Applies brightness/intensity flag to foreground color
const char* ANSI2   = "\x1B[2m";       const char* dim         = "\x1B[2m";    // Dim
const char* ANSI3   = "\x1B[3m";       const char* italic      = "\x1B[3m";    // Italic
const char* ANSI4   = "\x1B[4m";       const char* underline   = "\x1B[4m";    // Underline                 - Adds underline
const char* ANSI5   = "\x1B[5m";       const char* blink       = "\x1B[5m";    // Blink
const char* ANSI6   = "\x1B[6m";       const char* fblink      = "\x1B[6m";    // Rapid Blink
const char* ANSI7   = "\x1B[7m";       const char* negative    = "\x1B[7m";    // Negative                  - Swaps foreground and background colors
const char* ANSI8   = "\x1B[8m";       const char* invisible   = "\x1B[8m";    // Invisible
const char* ANSI9   = "\x1B[9m";       const char* strike      = "\x1B[9m";    // Strike Through
const char* ANSI10  = "\x1B[10m";//    const char* ???         = "\x1B[10m";   // UNKNOWN
const char* ANSI11  = "\x1B[11m";//    const char* ???         = "\x1B[11m";   // UNKNOWN 
const char* ANSI12  = "\x1B[12m";//    const char* ???         = "\x1B[12m";   // UNKNOWN
const char* ANSI13  = "\x1B[13m";//    const char* ???         = "\x1B[13m";   // UNKNOWN
const char* ANSI14  = "\x1B[14m";//    const char* ???         = "\x1B[14m";   // UNKNOWN
const char* ANSI15  = "\x1B[15m";//    const char* ???         = "\x1B[15m";   // UNKNOWN
const char* ANSI16  = "\x1B[16m";//    const char* ???         = "\x1B[16m";   // UNKNOWN
const char* ANSI17  = "\x1B[17m";//    const char* ???         = "\x1B[17m";   // UNKNOWN
const char* ANSI18  = "\x1B[18m";//    const char* ???         = "\x1B[18m";   // UNKNOWN
const char* ANSI19  = "\x1B[19m";//    const char* ???         = "\x1B[19m";   // UNKNOWN
const char* ANSI20  = "\x1B[20m";//    const char* ???         = "\x1B[20m";   // UNKNOWN
const char* ANSI21  = "\x1B[21m";//    const char* ???         = "\x1B[21m";   // UNKNOWN
const char* ANSI22  = "\x1B[22m";      const char* nobold      = "\x1B[22m";   // No bold/bright            - Removes brightness/intensity flag from foreground color
const char* ANSI23  = "\x1B[23m";      const char* noitalic    = "\x1B[23m";   // No Italic
const char* ANSI24  = "\x1B[24m";      const char* nounderline = "\x1B[24m";   // No underline              - Removes underline
const char* ANSI25  = "\x1B[25m";      const char* noblink     = "\x1B[25m";   // No Blink
const char* ANSI26  = "\x1B[26m";//    const char* ???         = "\x1B[26m";   // UNKNOWN
const char* ANSI27  = "\x1B[27m";      const char* nonegative  = "\x1B[27m";   // Positive(No negative)     - Returns foreground/background to normal
const char* ANSI28  = "\x1B[28m";      const char* visible     = "\x1B[28m";   // Visible(No invisible)
const char* ANSI29  = "\x1B[29m";      const char* nostrike    = "\x1B[29m";   // No Strike Through
const char* ANSI30  = "\x1B[30m";      const char* black       = "\x1B[30m";   // Foreground Black          - Applies non-bold/bright black to foreground
const char* ANSI31  = "\x1B[31m";      const char* red         = "\x1B[31m";   // Foreground Red            - Applies non-bold/bright red to foreground
const char* ANSI32  = "\x1B[32m";      const char* green       = "\x1B[32m";   // Foreground Green          - Applies non-bold/bright green to foreground
const char* ANSI33  = "\x1B[33m";      const char* yellow      = "\x1B[33m";   // Foreground Yellow         - Applies non-bold/bright yellow to foreground
const char* ANSI34  = "\x1B[34m";      const char* blue        = "\x1B[34m";   // Foreground Blue           - Applies non-bold/bright blue to foreground
const char* ANSI35  = "\x1B[35m";      const char* magenta     = "\x1B[35m";   // Foreground Magenta        - Applies non-bold/bright magenta to foreground
const char* ANSI36  = "\x1B[36m";      const char* cyan        = "\x1B[36m";   // Foreground Cyan           - Applies non-bold/bright cyan to foreground
const char* ANSI37  = "\x1B[37m";      const char* white       = "\x1B[37m";   // Foreground White          - Applies non-bold/bright white to foreground
const char* ANSI38  = "\x1B[38;2;";    const char* RGB         = "\x1B[38;2;"; // Foreground EXTENDED       - Applies extended colors to forecround      RGB+"50;100;150m"
const char* ANSI39  = "\x1B[39m";      const char* default_    = "\x1B[39m";   // Foreground Default        - Applies only the foreground portion of the defaults
const char* ANSI40  = "\x1B[40m";      const char* bg_black    = "\x1B[40m";   // Background Black          - Applies non-bold/bright black to background
const char* ANSI41  = "\x1B[41m";      const char* bg_red      = "\x1B[41m";   // Background Red            - Applies non-bold/bright red to background
const char* ANSI42  = "\x1B[42m";      const char* bg_green    = "\x1B[42m";   // Background Green          - Applies non-bold/bright green to background
const char* ANSI43  = "\x1B[43m";      const char* bg_yellow   = "\x1B[43m";   // Background Yellow         - Applies non-bold/bright yellow to background
const char* ANSI44  = "\x1B[44m";      const char* bg_blue     = "\x1B[44m";   // Background Blue           - Applies non-bold/bright blue to background
const char* ANSI45  = "\x1B[45m";      const char* bg_magenta  = "\x1B[45m";   // Background Magenta        - Applies non-bold/bright magenta to background
const char* ANSI46  = "\x1B[46m";      const char* bg_cyan     = "\x1B[46m";   // Background Cyan           - Applies non-bold/bright cyan to background
const char* ANSI47  = "\x1B[47m";      const char* bg_white    = "\x1B[47m";   // Background White          - Applies non-bold/bright white to background
const char* ANSI48  = "\x1B[48;2;";    const char* bg_RGB      = "\x1B[48m";   // Background EXTENDED       - Applies exteneded colors to background    bg_RGB+"150;100;50m"
const char* ANSI49  = "\x1B[49m";  	   const char* bg_default  = "\x1B[49m";   // Background Default        - Applies only the background portion of the defaults
const char* ANSI50  = "\x1B[50m";//    const char* ???         = "\x1B[50m";   // UNKNOWN
const char* ANSI51  = "\x1B[51m";//    const char* ???         = "\x1B[51m";   // UNKNOWN
const char* ANSI52  = "\x1B[52m";//    const char* ???         = "\x1B[52m";   // UNKNOWN
const char* ANSI53  = "\x1B[53m";//    const char* ???         = "\x1B[53m";   // UNKNOWN
const char* ANSI54  = "\x1B[54m";//    const char* ???         = "\x1B[54m";   // UNKNOWN
const char* ANSI55  = "\x1B[55m";//    const char* ???         = "\x1B[55m";   // UNKNOWN
const char* ANSI56  = "\x1B[56m";//    const char* ???         = "\x1B[56m";   // UNKNOWN
const char* ANSI57  = "\x1B[57m";//    const char* ???         = "\x1B[57m";   // UNKNOWN
const char* ANSI58  = "\x1B[58m";//    const char* ???         = "\x1B[58m";   // UNKNOWN
const char* ANSI59  = "\x1B[59m";//    const char* ???         = "\x1B[59m";   // UNKNOWN
const char* ANSI60  = "\x1B[60m";//    const char* ???         = "\x1B[60m";   // UNKNOWN
const char* ANSI61  = "\x1B[61m";//    const char* ???         = "\x1B[61m";   // UNKNOWN
const char* ANSI62  = "\x1B[62m";//    const char* ???         = "\x1B[62m";   // UNKNOWN
const char* ANSI63  = "\x1B[63m";//    const char* ???         = "\x1B[63m";   // UNKNOWN
const char* ANSI64  = "\x1B[64m";//    const char* ???         = "\x1B[64m";   // UNKNOWN
const char* ANSI65  = "\x1B[65m";//    const char* ???         = "\x1B[65m";   // UNKNOWN
const char* ANSI66  = "\x1B[66m";//    const char* ???         = "\x1B[66m";   // UNKNOWN
const char* ANSI67  = "\x1B[67m";//    const char* ???         = "\x1B[67m";   // UNKNOWN
const char* ANSI68  = "\x1B[68m";//    const char* ???         = "\x1B[68m";   // UNKNOWN
const char* ANSI69  = "\x1B[69m";//    const char* ???         = "\x1B[69m";   // UNKNOWN
const char* ANSI70  = "\x1B[70m";//    const char* ???         = "\x1B[70m";   // UNKNOWN
const char* ANSI71  = "\x1B[71m";//    const char* ???         = "\x1B[71m";   // UNKNOWN
const char* ANSI72  = "\x1B[72m";//    const char* ???         = "\x1B[72m";   // UNKNOWN
const char* ANSI73  = "\x1B[73m";//    const char* ???         = "\x1B[73m";   // UNKNOWN
const char* ANSI74  = "\x1B[74m";//    const char* ???         = "\x1B[74m";   // UNKNOWN
const char* ANSI75  = "\x1B[75m";//    const char* ???         = "\x1B[75m";   // UNKNOWN
const char* ANSI76  = "\x1B[76m";//    const char* ???         = "\x1B[76m";   // UNKNOWN
const char* ANSI77  = "\x1B[77m";//    const char* ???         = "\x1B[77m";   // UNKNOWN
const char* ANSI78  = "\x1B[78m";//    const char* ???         = "\x1B[78m";   // UNKNOWN
const char* ANSI79  = "\x1B[79m";//    const char* ???         = "\x1B[79m";   // UNKNOWN
const char* ANSI80  = "\x1B[80m";//    const char* ???         = "\x1B[80m";   // UNKNOWN
const char* ANSI81  = "\x1B[81m";//    const char* ???         = "\x1B[81m";   // UNKNOWN
const char* ANSI82  = "\x1B[82m";//    const char* ???         = "\x1B[82m";   // UNKNOWN
const char* ANSI83  = "\x1B[83m";//    const char* ???         = "\x1B[83m";   // UNKNOWN
const char* ANSI84  = "\x1B[84m";//    const char* ???         = "\x1B[84m";   // UNKNOWN
const char* ANSI85  = "\x1B[85m";//    const char* ???         = "\x1B[85m";   // UNKNOWN
const char* ANSI86  = "\x1B[86m";//    const char* ???         = "\x1B[86m";   // UNKNOWN
const char* ANSI87  = "\x1B[87m";//    const char* ???         = "\x1B[87m";   // UNKNOWN
const char* ANSI88  = "\x1B[88m";//    const char* ???         = "\x1B[88m";   // UNKNOWN
const char* ANSI89  = "\x1B[89m";//    const char* ???         = "\x1B[89m";   // UNKNOWN
const char* ANSI90  = "\x1B[90m";      const char* lblack      = "\x1B[90m";   // Bright Foreground Black   - Applies bold/bright black to foreground
const char* ANSI91  = "\x1B[91m";      const char* lred        = "\x1B[91m";   // Bright Foreground Red     - Applies bold/bright red to foreground
const char* ANSI92  = "\x1B[92m";      const char* lgreen      = "\x1B[92m";   // Bright Foreground Green   - Applies bold/bright green to foreground
const char* ANSI93  = "\x1B[93m";      const char* lyellow     = "\x1B[93m";   // Bright Foreground Yellow  - Applies bold/bright yellow to foreground
const char* ANSI94  = "\x1B[94m";      const char* lblue       = "\x1B[94m";   // Bright Foreground Blue    - Applies bold/bright blue to foreground
const char* ANSI95  = "\x1B[95m";      const char* lmagenta    = "\x1B[95m";   // Bright Foreground Magenta - Applies bold/bright magenta to foreground
const char* ANSI96  = "\x1B[96m";      const char* lcyan       = "\x1B[96m";   // Bright Foreground Cyan    - Applies bold/bright cyan to foreground
const char* ANSI97  = "\x1B[97m";      const char* lwhite      = "\x1B[97m";   // Bright Foreground White   - Applies bold/bright white to foreground
const char* ANSI98  = "\x1B[98m";//    const char* ???         = "\x1B[98m";   // UNKNOWN
const char* ANSI99  = "\x1B[99m";//    const char* ???         = "\x1B[99m";   // UNKNOWN
const char* ANSI100 = "\x1B[100m";     const char* bg_lblack   = "\x1B[100m";  // Bright Background Black   - Applies bold/bright black to background
const char* ANSI101 = "\x1B[101m";     const char* bg_lred     = "\x1B[101m";  // Bright Background Red     - Applies bold/bright red to background
const char* ANSI102 = "\x1B[102m";     const char* bg_lgreen   = "\x1B[102m";  // Bright Background Green   - Applies bold/bright green to background
const char* ANSI103 = "\x1B[103m";     const char* bg_lyellow  = "\x1B[103m";  // Bright Background Yellow  - Applies bold/bright yellow to background
const char* ANSI104 = "\x1B[104m";     const char* bg_lblue    = "\x1B[104m";  // Bright Background Blue    - Applies bold/bright blue to background
const char* ANSI105 = "\x1B[105m";     const char* bg_lmagenta = "\x1B[105m";  // Bright Background Magenta - Applies bold/bright magenta to background
const char* ANSI106 = "\x1B[106m";     const char* bg_lcyan    = "\x1B[106m";  // Bright Background Cyan    - Applies bold/bright cyan to background
const char* ANSI107 = "\x1B[107m";     const char* bg_lwhite   = "\x1B[107m";  // Bright Background White   - Applies bold/bright white to background
const char* ANSI108 = "\x1B[108m";//   const char* ???         = "\x1B[108m";  // UNKNOWN
const char* ANSI109 = "\x1B[109m";//   const char* ???         = "\x1B[109m";  // UNKNOWN
const char* ANSI110 = "\x1B[110m";//   const char* ???         = "\x1B[111m";  // UNKNOWN
const char* ANSI111 = "\x1B[111m";//   const char* ???         = "\x1B[111m";  // UNKNOWN
const char* ANSI112 = "\x1B[112m";//   const char* ???         = "\x1B[112m";  // UNKNOWN
const char* ANSI113 = "\x1B[113m";//   const char* ???         = "\x1B[113m";  // UNKNOWN
const char* ANSI114 = "\x1B[114m";//   const char* ???         = "\x1B[114m";  // UNKNOWN
const char* ANSI115 = "\x1B[115m";//   const char* ???         = "\x1B[115m";  // UNKNOWN
const char* ANSI116 = "\x1B[116m";//   const char* ???         = "\x1B[116m";  // UNKNOWN
const char* ANSI117 = "\x1B[117m";//   const char* ???         = "\x1B[117m";  // UNKNOWN
const char* ANSI118 = "\x1B[118m";//   const char* ???         = "\x1B[118m";  // UNKNOWN
const char* ANSI119 = "\x1B[119m";//   const char* ???         = "\x1B[119m";  // UNKNOWN
const char* ANSI120 = "\x1B[120m";//   const char* ???         = "\x1B[120m";  // UNKNOWN
const char* ANSI121 = "\x1B[121m";//   const char* ???         = "\x1B[121m";  // UNKNOWN
const char* ANSI122 = "\x1B[122m";//   const char* ???         = "\x1B[122m";  // UNKNOWN
const char* ANSI123 = "\x1B[123m";//   const char* ???         = "\x1B[123m";  // UNKNOWN
const char* ANSI124 = "\x1B[124m";//   const char* ???         = "\x1B[124m";  // UNKNOWN




//################################################################################
//# dk_color()
//#
void dk_color(){
	//dk_echo(blue+"C"+green+"O"+red+"L"+magenta+"O"+cyan+"R"+blue+"O"+green+"N"+clr);
    return;
};


#endif //dk_color_h