#pragma once
#ifndef dk_color_hpp
#define dk_color_hpp

#include "DK.hpp"


// https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797

//Sequences				Hexadecimal   Unicode   Decimal    Octal    Ctrl-Key:
const std::string ESC   = "\x1B";//   \u001b      27       \033       ^[        - sequence starting with ESC (\x1B)
const std::string CSI   = "\x9B";//                                             - Control Sequence Introducer: sequence starting with ESC [ or CSI (\x9B)
const std::string DCS   = "\x90";//                                             - Device Control String: sequence starting with ESC P or DCS (\x90)
const std::string OSC   = "\x9D";//                                             - Operating System Command: sequence starting with ESC ] or OSC (\x9D)



const std::string ANSI0   = ESC+"[0m";       const std::string& clr         = ANSI0;    // Default                   - Returns all attributes to the default state prior to modification
const std::string ANSI1   = ESC+"[1m";       const std::string& bold        = ANSI1;    // Bold/Bright               - Applies brightness/intensity flag to foreground color
const std::string ANSI2   = ESC+"[2m";       const std::string& dim         = ANSI2;    // Dim
const std::string ANSI3   = ESC+"[3m";       const std::string& italic      = ANSI3;    // Italic
const std::string ANSI4   = ESC+"[4m";       const std::string& underline   = ANSI4;    // Underline                 - Adds underline
const std::string ANSI5   = ESC+"[5m";       const std::string& blink       = ANSI5;    // Blink
const std::string ANSI6   = ESC+"[6m";       const std::string& fblink      = ANSI6;    // Rapid Blink
const std::string ANSI7   = ESC+"[7m";       const std::string& negative    = ANSI7;    // Negative                  - Swaps foreground and background colors
const std::string ANSI8   = ESC+"[8m";       const std::string& invisible   = ANSI8;    // Invisible
const std::string ANSI9   = ESC+"[9m";       const std::string& strike      = ANSI9;    // Strike Through
const std::string ANSI10  = ESC+"[10m";//    const std::string& ???         = ANSI10;   // UNKNOWN
const std::string ANSI11  = ESC+"[11m";//    const std::string& ???         = ANSI11;   // UNKNOWN 
const std::string ANSI12  = ESC+"[12m";//    const std::string& ???         = ANSI12;   // UNKNOWN
const std::string ANSI13  = ESC+"[13m";//    const std::string& ???         = ANSI13;   // UNKNOWN
const std::string ANSI14  = ESC+"[14m";//    const std::string& ???         = ANSI14;   // UNKNOWN
const std::string ANSI15  = ESC+"[15m";//    const std::string& ???         = ANSI15;   // UNKNOWN
const std::string ANSI16  = ESC+"[16m";//    const std::string& ???         = ANSI16;   // UNKNOWN
const std::string ANSI17  = ESC+"[17m";//    const std::string& ???         = ANSI17;   // UNKNOWN
const std::string ANSI18  = ESC+"[18m";//    const std::string& ???         = ANSI18;   // UNKNOWN
const std::string ANSI19  = ESC+"[19m";//    const std::string& ???         = ANSI19;   // UNKNOWN
const std::string ANSI20  = ESC+"[20m";//    const std::string& ???         = ANSI20;   // UNKNOWN
const std::string ANSI21  = ESC+"[21m";//    const std::string& ???         = ANSI21;   // UNKNOWN
const std::string ANSI22  = ESC+"[22m";      const std::string& nobold      = ANSI22;   // No bold/bright            - Removes brightness/intensity flag from foreground color
const std::string ANSI23  = ESC+"[23m";      const std::string& noitalic    = ANSI23;   // No Italic
const std::string ANSI24  = ESC+"[24m";      const std::string& nounderline = ANSI24;   // No underline              - Removes underline
const std::string ANSI25  = ESC+"[25m";      const std::string& noblink     = ANSI25;   // No Blink
const std::string ANSI26  = ESC+"[26m";//    const std::string& ???         = ANSI26;   // UNKNOWN
const std::string ANSI27  = ESC+"[27m";      const std::string& nonegative  = ANSI27;   // Positive(No negative)     - Returns foreground/background to normal
const std::string ANSI28  = ESC+"[28m";      const std::string& visible     = ANSI28;   // Visible(No invisible)
const std::string ANSI29  = ESC+"[29m";      const std::string& nostrike    = ANSI29;   // No Strike Through
const std::string ANSI30  = ESC+"[30m";      const std::string& black       = ANSI30;   // Foreground Black          - Applies non-bold/bright black to foreground
const std::string ANSI31  = ESC+"[31m";      const std::string& red         = ANSI31;   // Foreground Red            - Applies non-bold/bright red to foreground
const std::string ANSI32  = ESC+"[32m";      const std::string& green       = ANSI32;   // Foreground Green          - Applies non-bold/bright green to foreground
const std::string ANSI33  = ESC+"[33m";      const std::string& yellow      = ANSI33;   // Foreground Yellow         - Applies non-bold/bright yellow to foreground
const std::string ANSI34  = ESC+"[34m";      const std::string& blue        = ANSI34;   // Foreground Blue           - Applies non-bold/bright blue to foreground
const std::string ANSI35  = ESC+"[35m";      const std::string& magenta     = ANSI35;   // Foreground Magenta        - Applies non-bold/bright magenta to foreground
const std::string ANSI36  = ESC+"[36m";      const std::string& cyan        = ANSI36;   // Foreground Cyan           - Applies non-bold/bright cyan to foreground
const std::string ANSI37  = ESC+"[37m";      const std::string& white       = ANSI37;   // Foreground White          - Applies non-bold/bright white to foreground
const std::string ANSI38  = ESC+"[38;2;";    const std::string& RGB         = ANSI38;   // Foreground EXTENDED       - Applies extended colors to forecround      RGB+"50;100;150m"
const std::string ANSI39  = ESC+"[39m";      const std::string& default_    = ANSI39;   // Foreground Default        - Applies only the foreground portion of the defaults
const std::string ANSI40  = ESC+"[40m";      const std::string& bg_black    = ANSI40;   // Background Black          - Applies non-bold/bright black to background
const std::string ANSI41  = ESC+"[41m";      const std::string& bg_red      = ANSI41;   // Background Red            - Applies non-bold/bright red to background
const std::string ANSI42  = ESC+"[42m";      const std::string& bg_green    = ANSI42;   // Background Green          - Applies non-bold/bright green to background
const std::string ANSI43  = ESC+"[43m";      const std::string& bg_yellow   = ANSI43;   // Background Yellow         - Applies non-bold/bright yellow to background
const std::string ANSI44  = ESC+"[44m";      const std::string& bg_blue     = ANSI44;   // Background Blue           - Applies non-bold/bright blue to background
const std::string ANSI45  = ESC+"[45m";      const std::string& bg_magenta  = ANSI45;   // Background Magenta        - Applies non-bold/bright magenta to background
const std::string ANSI46  = ESC+"[46m";      const std::string& bg_cyan     = ANSI46;   // Background Cyan           - Applies non-bold/bright cyan to background
const std::string ANSI47  = ESC+"[47m";      const std::string& bg_white    = ANSI47;   // Background White          - Applies non-bold/bright white to background
const std::string ANSI48  = ESC+"[48;2;";    const std::string& bg_RGB      = ANSI48;   // Background EXTENDED       - Applies exteneded colors to background    bg_RGB+"150;100;50m"
const std::string ANSI49  = ESC+"[49m";      const std::string& bg_default  = ANSI49;   // Background Default        - Applies only the background portion of the defaults
const std::string ANSI50  = ESC+"[50m";//    const std::string& ???         = ANSI50;   // UNKNOWN
const std::string ANSI51  = ESC+"[51m";//    const std::string& ???         = ANSI51;   // UNKNOWN
const std::string ANSI52  = ESC+"[52m";//    const std::string& ???         = ANSI52;   // UNKNOWN
const std::string ANSI53  = ESC+"[53m";//    const std::string& ???         = ANSI53;   // UNKNOWN
const std::string ANSI54  = ESC+"[54m";//    const std::string& ???         = ANSI54;   // UNKNOWN
const std::string ANSI55  = ESC+"[55m";//    const std::string& ???         = ANSI55;   // UNKNOWN
const std::string ANSI56  = ESC+"[56m";//    const std::string& ???         = ANSI56;   // UNKNOWN
const std::string ANSI57  = ESC+"[57m";//    const std::string& ???         = ANSI57;   // UNKNOWN
const std::string ANSI58  = ESC+"[58m";//    const std::string& ???         = ANSI58;   // UNKNOWN
const std::string ANSI59  = ESC+"[59m";//    const std::string& ???         = ANSI59;   // UNKNOWN
const std::string ANSI60  = ESC+"[60m";//    const std::string& ???         = ANSI60;   // UNKNOWN
const std::string ANSI61  = ESC+"[61m";//    const std::string& ???         = ANSI61;   // UNKNOWN
const std::string ANSI62  = ESC+"[62m";//    const std::string& ???         = ANSI62;   // UNKNOWN
const std::string ANSI63  = ESC+"[63m";//    const std::string& ???         = ANSI63;   // UNKNOWN
const std::string ANSI64  = ESC+"[64m";//    const std::string& ???         = ANSI64;   // UNKNOWN
const std::string ANSI65  = ESC+"[65m";//    const std::string& ???         = ANSI65;   // UNKNOWN
const std::string ANSI66  = ESC+"[66m";//    const std::string& ???         = ANSI66;   // UNKNOWN
const std::string ANSI67  = ESC+"[67m";//    const std::string& ???         = ANSI67;   // UNKNOWN
const std::string ANSI68  = ESC+"[68m";//    const std::string& ???         = ANSI68;   // UNKNOWN
const std::string ANSI69  = ESC+"[69m";//    const std::string& ???         = ANSI69;   // UNKNOWN
const std::string ANSI70  = ESC+"[70m";//    const std::string& ???         = ANSI70;   // UNKNOWN
const std::string ANSI71  = ESC+"[71m";//    const std::string& ???         = ANSI71;   // UNKNOWN
const std::string ANSI72  = ESC+"[72m";//    const std::string& ???         = ANSI72;   // UNKNOWN
const std::string ANSI73  = ESC+"[73m";//    const std::string& ???         = ANSI73;   // UNKNOWN
const std::string ANSI74  = ESC+"[74m";//    const std::string& ???         = ANSI74;   // UNKNOWN
const std::string ANSI75  = ESC+"[75m";//    const std::string& ???         = ANSI75;   // UNKNOWN
const std::string ANSI76  = ESC+"[76m";//    const std::string& ???         = ANSI76;   // UNKNOWN
const std::string ANSI77  = ESC+"[77m";//    const std::string& ???         = ANSI77;   // UNKNOWN
const std::string ANSI78  = ESC+"[78m";//    const std::string& ???         = ANSI78;   // UNKNOWN
const std::string ANSI79  = ESC+"[79m";//    const std::string& ???         = ANSI79;   // UNKNOWN
const std::string ANSI80  = ESC+"[80m";//    const std::string& ???         = ANSI80;   // UNKNOWN
const std::string ANSI81  = ESC+"[81m";//    const std::string& ???         = ANSI81;   // UNKNOWN
const std::string ANSI82  = ESC+"[82m";//    const std::string& ???         = ANSI82;   // UNKNOWN
const std::string ANSI83  = ESC+"[83m";//    const std::string& ???         = ANSI83;   // UNKNOWN
const std::string ANSI84  = ESC+"[84m";//    const std::string& ???         = ANSI84;   // UNKNOWN
const std::string ANSI85  = ESC+"[85m";//    const std::string& ???         = ANSI85;   // UNKNOWN
const std::string ANSI86  = ESC+"[86m";//    const std::string& ???         = ANSI86;   // UNKNOWN
const std::string ANSI87  = ESC+"[87m";//    const std::string& ???         = ANSI87;   // UNKNOWN
const std::string ANSI88  = ESC+"[88m";//    const std::string& ???         = ANSI88;   // UNKNOWN
const std::string ANSI89  = ESC+"[89m";//    const std::string& ???         = ANSI89;   // UNKNOWN
const std::string ANSI90  = ESC+"[90m";      const std::string& lblack      = ANSI90;   // Bright Foreground Black   - Applies bold/bright black to foreground
const std::string ANSI91  = ESC+"[91m";      const std::string& lred        = ANSI91;   // Bright Foreground Red     - Applies bold/bright red to foreground
const std::string ANSI92  = ESC+"[92m";      const std::string& lgreen      = ANSI92;   // Bright Foreground Green   - Applies bold/bright green to foreground
const std::string ANSI93  = ESC+"[93m";      const std::string& lyellow     = ANSI93;   // Bright Foreground Yellow  - Applies bold/bright yellow to foreground
const std::string ANSI94  = ESC+"[94m";      const std::string& lblue       = ANSI94;   // Bright Foreground Blue    - Applies bold/bright blue to foreground
const std::string ANSI95  = ESC+"[95m";      const std::string& lmagenta    = ANSI95;   // Bright Foreground Magenta - Applies bold/bright magenta to foreground
const std::string ANSI96  = ESC+"[96m";      const std::string& lcyan       = ANSI96;   // Bright Foreground Cyan    - Applies bold/bright cyan to foreground
const std::string ANSI97  = ESC+"[97m";      const std::string& lwhite      = ANSI97;   // Bright Foreground White   - Applies bold/bright white to foreground
const std::string ANSI98  = ESC+"[98m";//    const std::string& ???         = ANSI98;   // UNKNOWN
const std::string ANSI99  = ESC+"[99m";//    const std::string& ???         = ANSI99;   // UNKNOWN
const std::string ANSI100 = ESC+"[100m";     const std::string& bg_lblack   = ANSI100;  // Bright Background Black   - Applies bold/bright black to background
const std::string ANSI101 = ESC+"[101m";     const std::string& bg_lred     = ANSI101;  // Bright Background Red     - Applies bold/bright red to background
const std::string ANSI102 = ESC+"[102m";     const std::string& bg_lgreen   = ANSI102;  // Bright Background Green   - Applies bold/bright green to background
const std::string ANSI103 = ESC+"[103m";     const std::string& bg_lyellow  = ANSI103;  // Bright Background Yellow  - Applies bold/bright yellow to background
const std::string ANSI104 = ESC+"[104m";     const std::string& bg_lblue    = ANSI104;  // Bright Background Blue    - Applies bold/bright blue to background
const std::string ANSI105 = ESC+"[105m";     const std::string& bg_lmagenta = ANSI105;  // Bright Background Magenta - Applies bold/bright magenta to background
const std::string ANSI106 = ESC+"[106m";     const std::string& bg_lcyan    = ANSI106;  // Bright Background Cyan    - Applies bold/bright cyan to background
const std::string ANSI107 = ESC+"[107m";     const std::string& bg_lwhite   = ANSI107;  // Bright Background White   - Applies bold/bright white to background
const std::string ANSI108 = ESC+"[108m";//   const std::string& ???         = ANSI108;  // UNKNOWN
const std::string ANSI109 = ESC+"[109m";//   const std::string& ???         = ANSI109;  // UNKNOWN
const std::string ANSI110 = ESC+"[110m";//   const std::string& ???         = ANSI110;  // UNKNOWN
const std::string ANSI111 = ESC+"[111m";//   const std::string& ???         = ANSI111;  // UNKNOWN
const std::string ANSI112 = ESC+"[112m";//   const std::string& ???         = ANSI112;  // UNKNOWN
const std::string ANSI113 = ESC+"[113m";//   const std::string& ???         = ANSI113;  // UNKNOWN
const std::string ANSI114 = ESC+"[114m";//   const std::string& ???         = ANSI114;  // UNKNOWN
const std::string ANSI115 = ESC+"[115m";//   const std::string& ???         = ANSI115;  // UNKNOWN
const std::string ANSI116 = ESC+"[116m";//   const std::string& ???         = ANSI116;  // UNKNOWN
const std::string ANSI117 = ESC+"[117m";//   const std::string& ???         = ANSI117;  // UNKNOWN
const std::string ANSI118 = ESC+"[118m";//   const std::string& ???         = ANSI118;  // UNKNOWN
const std::string ANSI119 = ESC+"[119m";//   const std::string& ???         = ANSI119;  // UNKNOWN
const std::string ANSI120 = ESC+"[120m";//   const std::string& ???         = ANSI120;  // UNKNOWN
const std::string ANSI121 = ESC+"[121m";//   const std::string& ???         = ANSI121;  // UNKNOWN
const std::string ANSI122 = ESC+"[122m";//   const std::string& ???         = ANSI122;  // UNKNOWN
const std::string ANSI123 = ESC+"[123m";//   const std::string& ???         = ANSI123;  // UNKNOWN
const std::string ANSI124 = ESC+"[124m";//   const std::string& ???         = ANSI124;  // UNKNOWN




//################################################################################
//# dk_color()
//#
void dk_color(){
	//dk_echo(blue+"C"+green+"O"+red+"L"+magenta+"O"+cyan+"R"+blue+"O"+green+"N"+clr);
    return;
};


#endif //dk_color_hpp