#pragma once
#ifndef dk_color_hpp
#define dk_color_hpp

#include "DK.hpp"

#define ESC			"\x1B"

// Attributes on
#define clr  		"\x1B[0m"   	// Default					- Returns all attributes to the default state prior to modification
#define bold		"\x1B[1m"		// Bold/Bright 				- Applies brightness/intensity flag to foreground color
#define dim			"\x1B[2m"		// Dim
#define italic		"\x1B[3m"		// Italic
#define underline	"\x1B[4m"		// Underline       			- Adds underline
#define blink		"\x1B[5m"		// Blink
#define fblink		"\x1B[6m"		// Rapid Blink
#define negative	"\x1B[7m"   	// Negative	    			- Swaps foreground and background colors
#define invisible	"\x1B[8m"		// Invisible
#define strike		"\x1B[9m"		// Strike Through
		
// Attributes off
//#define 20m		"\x1B[20m"		// 20
//#define 21m		"\x1B[21m"		// 21
#define nobold		"\x1B[22m"		// No bold/bright			- Removes brightness/intensity flag from foreground color
#define noitalic	"\x1B[23m"		// No Italic
#define nounderline	"\x1B[24m"		// No underline				- Removes underline
#define noblink		"\x1B[25m"		// No Blink
//#define 26m		"\x1B[26m"		// 26
#define nonegative	"\x1B[27m"  	// Positive(No negative)	- Returns foreground/background to normal
#define visible		"\x1B[28m"		// Visible(No invisible)
#define nostrike	"\x1B[29m"		// No Strike Through

// Foreground Colors
#define black		"\x1B[30m"		// Foreground Black			- Applies non-bold/bright black to foreground
#define red			"\x1B[31m"		// Foreground Red			- Applies non-bold/bright red to foreground
#define green		"\x1B[32m"		// Foreground Green			- Applies non-bold/bright green to foreground
#define yellow		"\x1B[33m"		// Foreground Yellow		- Applies non-bold/bright yellow to foreground
#define blue		"\x1B[34m"		// Foreground Blue			- Applies non-bold/bright blue to foreground
#define magenta		"\x1B[35m"		// Foreground Magenta		- Applies non-bold/bright magenta to foreground
#define cyan		"\x1B[36m"		// Foreground Cyan			- Applies non-bold/bright cyan to foreground
#define white		"\x1B[37m"		// Foreground White			- Applies non-bold/bright white to foreground
#define extended	"\x1B[38m"		// Foreground Extended		- Applies extended color value to the foreground
#define default		"\x1B[39m"		// Foreground Default		- Applies only the foreground portion of the defaults

// Background Colors
#define bg_black	"\x1B[40m"		// Background Black			- Applies non-bold/bright black to background
#define bg_red		"\x1B[41m"		// Background Red			- Applies non-bold/bright red to background
#define bg_green	"\x1B[42m"		// Background Green			- Applies non-bold/bright green to background
#define bg_yellow	"\x1B[43m"		// Background Yellow		- Applies non-bold/bright yellow to background
#define bg_blue		"\x1B[44m"		// Background Blue			- Applies non-bold/bright blue to background
#define bg_magenta	"\x1B[45m"		// Background Magenta		- Applies non-bold/bright magenta to background
#define bg_cyan		"\x1B[46m"		// Background Cyan			- Applies non-bold/bright cyan to background
#define bg_white	"\x1B[47m"		// Background White			- Applies non-bold/bright white to background
#define bg_extended	"\x1B[48m"		// Background Extended		- Applies extended color value to the background
#define bg_default	"\x1B[49m"		// Background Default		- Applies only the background portion of the defaults

// Foreground Colors (light)
#define lblack		"\x1B[90m"		// Bright Foreground Black	- Applies bold/bright black to foreground
#define lred		"\x1B[91m"		// Bright Foreground Red	- Applies bold/bright red to foreground
#define lgreen		"\x1B[92m"		// Bright Foreground Green	- Applies bold/bright green to foreground
#define lyellow		"\x1B[93m"		// Bright Foreground Yellow	- Applies bold/bright yellow to foreground
#define lblue		"\x1B[94m"		// Bright Foreground Blue	- Applies bold/bright blue to foreground
#define lmagenta	"\x1B[95m"		// Bright Foreground Magenta- Applies bold/bright magenta to foreground
#define lcyan		"\x1B[96m"		// Bright Foreground Cyan	- Applies bold/bright cyan to foreground
#define lwhite		"\x1B[97m"		// Bright Foreground White	- Applies bold/bright white to foreground

// Background Colors (light)
#define bg_lblack	"\x1B[100m"		// Bright Background Black	- Applies bold/bright black to background
#define bg_lred		"\x1B[101m"		// Bright Background Red	- Applies bold/bright red to background
#define bg_lgreen	"\x1B[102m"		// Bright Background Green	- Applies bold/bright green to background
#define bg_lyellow	"\x1B[103m"		// Bright Background Yellow	- Applies bold/bright yellow to background
#define bg_lblue	"\x1B[104m"		// Bright Background Blue	- Applies bold/bright blue to background
#define bg_lmagenta	"\x1B[105m"		// Bright Background Magenta- Applies bold/bright magenta to background
#define bg_lcyan	"\x1B[106m"		// Bright Background Cyan	- Applies bold/bright cyan to background
#define bg_lwhite	"\x1B[107m"		// Bright Background White	- Applies bold/bright white to background

// Foreground RGB Colors
#define RGB			"\x1B[38;2;"			// ${RGB}50;100;150m   = ${ESC}[38;2;50;100;150m

// Background RGB Colors
#define bg_RGB		"\x1B[48;2;"		// ${bg_RGB}150;100;50m    = ${ESC}[38;2;150;100;50m

//dk_echo "${blue}C${green}O${red}L${magenta}O${cyan}R ${blue}O${green}N${clr}"

//################################################################################
//# dk_color()
//#
void dk_color(){
	return;
};


#endif //dk_color_hpp