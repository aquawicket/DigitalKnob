//#!/bin/sh
//[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

//##################################################################################
//# dk_color(on/off)
//#
//#	Enable / Disable console text and background coloring
//#
//#   on/off:  Default ON
//#
//#   https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
//#   https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
//#   https://en.wikipedia.org/wiki/ANSI_escape_code
//#
dk_color = function() {
	/*
	dk_debugFunc 0 1
	
	var USE_COLOR = 1
	if [ ${#} -gt 0 ]; then
		if [ ${1-} -eq 0 ]; then
			dk_call dk_unset USE_COLOR
		fi
	fi
	
	if [ -n ${USE_COLOR-} ]; then
	#if dk_call dk_defined USE_COLOR; then
	*/
		var ESC = "\x1b"    		 	// escape character
		
		// Attributes on
		this.clr = ESC+"[0m"   			// Default						- Returns all attributes to the default state prior to modification
		this.bold = ESC+"[1m"			// Bold/Bright 					- Applies brightness/intensity flag to foreground color
		this.dim = ESC+"[2m"			// Dim
		this.italic = ESC+"[3m"			// Italic
		this.underline = ESC+"[4m"		// Underline       				- Adds underline
		this.blink = ESC+"[5m"			// Blink
		this.fblink = ESC+"[6m"			// Rapid Blink
		this.negative = ESC+"[7m"   	// Negative	    				- Swaps foreground and background colors
		this.invisible = ESC+"[8m"		// Invisible
		this.strike = ESC+"[9m"			// Strike Through
		
		// Attributes off
		//this.20m = ESC+"[20m"			// 20
		//this.21m = ESC+"[21m"			// 21
		this.nobold = ESC+"[22m"		// No bold/bright				- Removes brightness/intensity flag from foreground color
		this.noitalic = ESC+"[23m"		// No Italic
		this.nounderline = ESC+"[24m"	// No underline					- Removes underline
		this.noblink = ESC+"[25m"		// No Blink
		//this.26m = ESC+"[26m"			// 26
		this.nonegative = ESC+"[27m"  	// Positive(No negative)		- Returns foreground/background to normal
		this.visible = ESC+"[28m"		// Visible(No invisible)
		this.nostrike = ESC+"[29m"		// No Strike Through
		
		// Foreground Colors
		this.black = ESC+"[30m"			// Foreground Black				- Applies non-bold/bright black to foreground
		this.red = ESC+"[31m"			// Foreground Red				- Applies non-bold/bright red to foreground
		this.green = ESC+"[32m"			// Foreground Green				- Applies non-bold/bright green to foreground
		this.yellow = ESC+"[33m"		// Foreground Yellow			- Applies non-bold/bright yellow to foreground
		this.blue = ESC+"[34m"			// Foreground Blue				- Applies non-bold/bright blue to foreground
		this.magenta = ESC+"[35m"		// Foreground Magenta			- Applies non-bold/bright magenta to foreground
		this.cyan = ESC+"[36m"			// Foreground Cyan				- Applies non-bold/bright cyan to foreground
		this.white = ESC+"[37m"			// Foreground White				- Applies non-bold/bright white to foreground
		this.extended = ESC+"[38m"		// Foreground Extended			- Applies extended color value to the foreground
		//this.default = ESC+"[39m"		// Foreground Default			- Applies only the foreground portion of the defaults
		
		// Background Colors
		this.bg_black = ESC+"[40m"		// Background Black				- Applies non-bold/bright black to background
		this.bg_red = ESC+"[41m"		// Background Red				- Applies non-bold/bright red to background
		this.bg_green = ESC+"[42m"		// Background Green				- Applies non-bold/bright green to background
		this.bg_yellow = ESC+"[43m"		// Background Yellow			- Applies non-bold/bright yellow to background
		this.bg_blue = ESC+"[44m"		// Background Blue				- Applies non-bold/bright blue to background
		this.bg_magenta = ESC+"[45m"	// Background Magenta			- Applies non-bold/bright magenta to background
		this.bg_cyan = ESC+"[46m"		// Background Cyan				- Applies non-bold/bright cyan to background
		this.bg_white = ESC+"[47m"		// Background White				- Applies non-bold/bright white to background
		this.bg_extended = ESC+"[48m"	// Background Extended			- Applies extended color value to the background
		this.bg_default = ESC+"[49m"	// Background Default			- Applies only the background portion of the defaults
		
		// Foreground Colors (light)
		this.lblack = ESC+"[90m"		// Bright Foreground Black		- Applies bold/bright black to foreground
		this.lred = ESC+"[91m"			// Bright Foreground Red		- Applies bold/bright red to foreground
		this.lgreen = ESC+"[92m"		// Bright Foreground Green		- Applies bold/bright green to foreground
		this.lyellow = ESC+"[93m"		// Bright Foreground Yellow		- Applies bold/bright yellow to foreground
		this.lblue = ESC+"[94m"			// Bright Foreground Blue		- Applies bold/bright blue to foreground
		this.lmagenta = ESC+"[95m"		// Bright Foreground Magenta	- Applies bold/bright magenta to foreground
		this.lcyan = ESC+"[96m"			// Bright Foreground Cyan		- Applies bold/bright cyan to foreground
		this.lwhite = ESC+"[97m"		// Bright Foreground White		- Applies bold/bright white to foreground

		// Background Colors (light)
		this.bg_lblack = ESC+"[100m"	// Bright Background Black		- Applies bold/bright black to background
		this.bg_lred = ESC+"[101m"		// Bright Background Red		- Applies bold/bright red to background
		this.bg_lgreen = ESC+"[102m"	// Bright Background Green		- Applies bold/bright green to background
		this.bg_lyellow = ESC+"[103m"	// Bright Background Yellow		- Applies bold/bright yellow to background
		this.bg_lblue = ESC+"[104m"		// Bright Background Blue		- Applies bold/bright blue to background
		this.bg_lmagenta = ESC+"[105m"	// Bright Background Magenta	- Applies bold/bright magenta to background
		this.bg_lcyan = ESC+"[106m"		// Bright Background Cyan		- Applies bold/bright cyan to background
		this.bg_lwhite = ESC+"[107m"	// Bright Background White		- Applies bold/bright white to background
		
		// Foreground RGB Colors
		this.RGB = ESC+"[38;2;"			// ${RGB}50;100;150m        	= ${ESC}[38;2;50;100;150m
		
		// Background RGB Colors
		this.bg_RGB = ESC+"[48;2;"		// ${bg_RGB}150;100;50m     	= ${ESC}[38;2;150;100;50m
		
		console.log(blue+"C"+green+"O"+red+"L"+magenta+"O"+cyan+"R"+blue+" O"+green+"N"+clr)
	/*
	else
		//dk_call dk_unset ESC
		//dk_call dk_unset clr
		
		// Attributes on
		dk_call dk_unset bold
		dk_call dk_unset dim
		dk_call dk_unset italic
		dk_call dk_unset underline
		dk_call dk_unset blink
		dk_call dk_unset fblink
		dk_call dk_unset negative
		dk_call dk_unset invisible
		dk_call dk_unset strike
		
		// Attributes off
		dk_call dk_unset nobold
		dk_call dk_unset noitalic
		dk_call dk_unset nounderline
		dk_call dk_unset noblink
		dk_call dk_unset nonegative
		dk_call dk_unset visible
		dk_call dk_unset nostrike
		
		// Foreground Colors
		dk_call dk_unset black
		dk_call dk_unset red
		dk_call dk_unset green
		dk_call dk_unset yellow
		dk_call dk_unset blue
		dk_call dk_unset magenta
		dk_call dk_unset cyan
		dk_call dk_unset white
		
		// Background Colors
		dk_call dk_unset bg_black
		dk_call dk_unset bg_red
		dk_call dk_unset bg_green
		dk_call dk_unset bg_yellow
		dk_call dk_unset bg_blue
		dk_call dk_unset bg_magenta
		dk_call dk_unset bg_cyan
		dk_call dk_unset bg_white
		
		// Foreground Colors (Bright)
		dk_call dk_unset lblack
		dk_call dk_unset lred
		dk_call dk_unset lgreen
		dk_call dk_unset lyellow
		dk_call dk_unset lblue
		dk_call dk_unset lmagenta
		dk_call dk_unset lcyan
		dk_call dk_unset lwhite
		
		// Background Colors (Bright)
		dk_call dk_unset bg_lblack
		dk_call dk_unset bg_lred
		dk_call dk_unset bg_lgreen
		dk_call dk_unset bg_lyellow
		dk_call dk_unset bg_lblue
		dk_call dk_unset bg_lmagenta
		dk_call dk_unset bg_lcyan
		dk_call dk_unset bg_lwhite
		
		dk_call dk_unset RGB
		dk_call dk_unset bg_RGB
	
		console.log(clr+" COLOR OFF"
	fi
	*/
}
//dk_call dk_color 1
dk_color();






//### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function() {
	//dk_debugFunc 0
	
	console.log("");
	console.log("");
	
	console.log(black+bg_lblack+"           Styles             "+clr);
	console.log("clr       "+clr+" default "+clr);
	console.log("bold       "+bold+" bold "+clr);
	console.log("dim        "+dim+" dim "+clr);
	console.log("italic     "+italic+" italic "+clr);
	console.log("underline  "+underline+" underline "+clr);
	console.log("blink      "+blink+" blink "+clr);
	console.log("fblink     "+fblink+" fblink "+clr);
	console.log("negative   "+negative+" negative "+clr);
	console.log("invisible  "+invisible+" invisible "+clr);
	console.log("strike     "+strike+" strike "+clr);
	console.log("");
	console.log("");

	console.log(black+bg_lblack+"      Foreground Colors       "+clr);
	console.log("black        "+black+bg_lblack+" black "+clr);
	console.log("red          "+red+" red "+clr);
	console.log("green        "+green+" green "+clr);
	console.log("yellow       "+yellow+" yellow "+clr);
	console.log("blue         "+blue+" blue "+clr);
	console.log("magenta      "+magenta+" magenta "+clr);
	console.log("cyan         "+cyan+" cyan "+clr);
	console.log("white        "+white+" white "+clr);
	console.log("");
	console.log("");

	console.log(black+bg_lblack+"      Background Colors       "+clr);
	console.log("bg_black     "+bg_black+"   bg_black   "+clr);
	console.log("bg_red       "+bg_red+black+"   bg_red      "+clr);
	console.log("bg_green     "+bg_green+black+"   bg_green    "+clr);
	console.log("bg_yellow    "+bg_yellow+black+"   bg_yellow   "+clr);
	console.log("bg_blue      "+bg_blue+black+"   bg_blue     "+clr);
	console.log("bg_magenta   "+bg_magenta+black+"   bg_magenta  "+clr);
	console.log("bg_cyan      "+bg_cyan+black+"   bg_cyan     "+clr);
	console.log("bg_white     "+bg_white+black+"   bg_white    "+clr);
	console.log("");
	console.log("");
	
	console.log(black+bg_lblack+"  Foreground Colors  bright   "+clr);
	console.log("lblack        "+lblack+" lblack "+clr);
	console.log("lred          "+lred+" lred "+clr);
	console.log("lgreen        "+lgreen+" lgreen "+clr);
	console.log("lyellow       "+lyellow+" lyellow "+clr);
	console.log("lblue         "+lblue+" lblue "+clr);
	console.log("lmagenta      "+lmagenta+" lmagenta "+clr);
	console.log("lcyan         "+lcyan+" lcyan "+clr);
	console.log("lwhite        "+lwhite+" lwhite "+clr);
	console.log("");
	console.log("");
	
	console.log(black+bg_lblack+"  Background Colors  bright   "+clr);
	console.log("bg_lblack     "+bg_lblack+black+"  bg_lblack   "+clr);
	console.log("bg_lred       "+bg_lred+black+"  bg_lred     "+clr);
	console.log("bg_lgreen     "+bg_lgreen+black+"  bg_lgreen   "+clr);
	console.log("bg_lyellow    "+bg_lyellow+black+"  bg_lyellow  "+clr);
	console.log("bg_lblue      "+bg_lblue+black+"  bg_lblue    "+clr);
	console.log("bg_lmagenta   "+bg_lmagenta+black+"  bg_lmagenta "+clr);
	console.log("bg_lcyan      "+bg_lcyan+black+"  bg_lcyan    "+clr);
	console.log("bg_lwhite     "+bg_lwhite+black+"  bg_lwhite   "+clr);
	console.log("");
	console.log("");
	
	console.log(black+bg_lblack+"    RGB Foreground Colors     "+clr);
	console.log(RGB+"255;10;10m    RGB test (255;0;10);    "+clr);
	console.log(RGB+"10;255;10m    RGB test (0;255;10);    "+clr);
	console.log(RGB+"0;0;255m    RGB test (0;0;255);     "+clr);
	console.log(RGB+"0;0;250m    RGB test (0;0;250);     "+clr);
	console.log(RGB+"0;0;245m    RGB test (0;0;245);     "+clr);
	console.log(RGB+"0;0;240m    RGB test (0;0;240);     "+clr);
	console.log(RGB+"0;0;235m    RGB test (0;0;235);     "+clr);
	console.log(RGB+"0;0;230m    RGB test (0;0;230);     "+clr);
	console.log(RGB+"0;0;225m    RGB test (0;0;225);     "+clr);
	console.log(RGB+"0;0;220m    RGB test (0;0;220);     "+clr);
	console.log(RGB+"0;0;215m    RGB test (0;0;215);     "+clr);
	console.log(RGB+"0;0;210m    RGB test (0;0;210);     "+clr);
	console.log(RGB+"0;0;205m    RGB test (0;0;205);     "+clr);
	console.log(RGB+"0;0;200m    RGB test (0;0;200);     "+clr);
	console.log(RGB+"0;0;195m    RGB test (0;0;195);     "+clr);
	console.log(RGB+"0;0;190m    RGB test (0;0;190);     "+clr);
	console.log(RGB+"0;0;185m    RGB test (0;0;185);     "+clr);
	console.log(RGB+"0;0;180m    RGB test (0;0;180);     "+clr);
	console.log(RGB+"0;0;175m    RGB test (0;0;175);     "+clr);
	console.log(RGB+"0;0;170m    RGB test (0;0;170);     "+clr);
	console.log(RGB+"0;0;165m    RGB test (0;0;165);     "+clr);
	console.log(RGB+"0;0;160m    RGB test (0;0;160);     "+clr);
	console.log(RGB+"0;0;155m    RGB test (0;0;155);     "+clr);
	console.log(RGB+"0;0;150m    RGB test (0;0;150);     "+clr);
	console.log(RGB+"0;0;145m    RGB test (0;0;145);     "+clr);
	console.log(RGB+"0;0;140m    RGB test (0;0;140);     "+clr);
	console.log(RGB+"0;0;135m    RGB test (0;0;135);     "+clr);
	console.log(RGB+"0;0;130m    RGB test (0;0;130);     "+clr);
	console.log(RGB+"0;0;125m    RGB test (0;0;125);     "+clr);
	console.log(RGB+"0;0;120m    RGB test (0;0;120);     "+clr);
	console.log(RGB+"0;0;115m    RGB test (0;0;115);     "+clr);
	console.log(RGB+"0;0;110m    RGB test (0;0;110);     "+clr);
	console.log(RGB+"0;0;105m    RGB test (0;0;105);     "+clr);
	console.log(RGB+"0;0;100m    RGB test (0;0;100);     "+clr);
	console.log(RGB+"0;0;95m    RGB test (0;0;95);      "+clr);
	console.log(RGB+"0;0;90m    RGB test (0;0;90);      "+clr);
	console.log(RGB+"0;0;85m    RGB test (0;0;85);      "+clr);
	console.log(RGB+"0;0;80m    RGB test (0;0;80);      "+clr);
	console.log(RGB+"0;0;75m    RGB test (0;0;75);      "+clr);
	console.log(RGB+"0;0;70m    RGB test (0;0;70);      "+clr);
	console.log(RGB+"0;0;65m    RGB test (0;0;65);      "+clr);
	console.log(RGB+"0;0;60m    RGB test (0;0;60);      "+clr);
	console.log(RGB+"0;0;55m    RGB test (0;0;55);      "+clr);
	console.log(RGB+"0;0;50m    RGB test (0;0;50);      "+clr);
	console.log(RGB+"0;0;45m    RGB test (0;0;45);      "+clr);
	console.log(RGB+"0;0;40m    RGB test (0;0;40);      "+clr);
	console.log(RGB+"0;0;35m    RGB test (0;0;35);      "+clr);
	console.log(RGB+"0;0;30m    RGB test (0;0;30);      "+clr);
	console.log(RGB+"0;0;25m    RGB test (0;0;25);      "+clr);
	console.log(RGB+"0;0;20m    RGB test (0;0;20);      "+clr);
	console.log(RGB+"0;0;15m    RGB test (0;0;15);      "+clr);
	console.log(RGB+"0;0;10m    RGB test (0;0;10);      "+clr);
	console.log(RGB+"0;0;5m    RGB test (0;0;5);       "+clr);
	console.log(RGB+"0;0;0m    RGB test (0;0;0);       "+clr);
	console.log("");
	console.log("");
	console.log(black+bg_lblack+"    RGB Background Colors     "+clr);
	console.log(bg_RGB+"255;10;10m    bg_RGB test (255;0;10);    "+clr);
	console.log(bg_RGB+"10;255;10m    bg_RGB test (0;255;10);    "+clr);
	console.log(bg_RGB+"0;0;255m    bg_RGB test (0;0;255);     "+clr);
	console.log(bg_RGB+"0;0;250m    bg_RGB test (0;0;250);     "+clr);
	console.log(bg_RGB+"0;0;245m    bg_RGB test (0;0;245);     "+clr);
	console.log(bg_RGB+"0;0;240m    bg_RGB test (0;0;240);     "+clr);
	console.log(bg_RGB+"0;0;235m    bg_RGB test (0;0;235);     "+clr);
	console.log(bg_RGB+"0;0;230m    bg_RGB test (0;0;230);     "+clr);
	console.log(bg_RGB+"0;0;225m    bg_RGB test (0;0;225);     "+clr);
	console.log(bg_RGB+"0;0;220m    bg_RGB test (0;0;220);     "+clr);
	console.log(bg_RGB+"0;0;215m    bg_RGB test (0;0;215);     "+clr);
	console.log(bg_RGB+"0;0;210m    bg_RGB test (0;0;210);     "+clr);
	console.log(bg_RGB+"0;0;205m    bg_RGB test (0;0;205);     "+clr);
	console.log(bg_RGB+"0;0;200m    bg_RGB test (0;0;200);     "+clr);
	console.log(bg_RGB+"0;0;195m    bg_RGB test (0;0;195);     "+clr);
	console.log(bg_RGB+"0;0;190m    bg_RGB test (0;0;190);     "+clr);
	console.log(bg_RGB+"0;0;185m    bg_RGB test (0;0;185);     "+clr);
	console.log(bg_RGB+"0;0;180m    bg_RGB test (0;0;180);     "+clr);
	console.log(bg_RGB+"0;0;175m    bg_RGB test (0;0;175);     "+clr);
	console.log(bg_RGB+"0;0;170m    bg_RGB test (0;0;170);     "+clr);
	console.log(bg_RGB+"0;0;165m    bg_RGB test (0;0;165);     "+clr);
	console.log(bg_RGB+"0;0;160m    bg_RGB test (0;0;160);     "+clr);
	console.log(bg_RGB+"0;0;155m    bg_RGB test (0;0;155);     "+clr);
	console.log(bg_RGB+"0;0;150m    bg_RGB test (0;0;150);     "+clr);
	console.log(bg_RGB+"0;0;145m    bg_RGB test (0;0;145);     "+clr);
	console.log(bg_RGB+"0;0;140m    bg_RGB test (0;0;140);     "+clr);
	console.log(bg_RGB+"0;0;135m    bg_RGB test (0;0;135);     "+clr);
	console.log(bg_RGB+"0;0;130m    bg_RGB test (0;0;130);     "+clr);
	console.log(bg_RGB+"0;0;125m    bg_RGB test (0;0;125);     "+clr);
	console.log(bg_RGB+"0;0;120m    bg_RGB test (0;0;120);     "+clr);
	console.log(bg_RGB+"0;0;115m    bg_RGB test (0;0;115);     "+clr);
	console.log(bg_RGB+"0;0;110m    bg_RGB test (0;0;110);     "+clr);
	console.log(bg_RGB+"0;0;105m    bg_RGB test (0;0;105);     "+clr);
	console.log(bg_RGB+"0;0;100m    bg_RGB test (0;0;100);     "+clr);
	console.log(bg_RGB+"0;0;95m    bg_RGB test (0;0;95);      "+clr);
	console.log(bg_RGB+"0;0;90m    bg_RGB test (0;0;90);      "+clr);
	console.log(bg_RGB+"0;0;85m    bg_RGB test (0;0;85);      "+clr);
	console.log(bg_RGB+"0;0;80m    bg_RGB test (0;0;80);      "+clr);
	console.log(bg_RGB+"0;0;75m    bg_RGB test (0;0;75);      "+clr);
	console.log(bg_RGB+"0;0;70m    bg_RGB test (0;0;70);      "+clr);
	console.log(bg_RGB+"0;0;65m    bg_RGB test (0;0;65);      "+clr);
	console.log(bg_RGB+"0;0;60m    bg_RGB test (0;0;60);      "+clr);
	console.log(bg_RGB+"0;0;55m    bg_RGB test (0;0;55);      "+clr);
	console.log(bg_RGB+"0;0;50m    bg_RGB test (0;0;50);      "+clr);
	console.log(bg_RGB+"0;0;45m    bg_RGB test (0;0;45);      "+clr);
	console.log(bg_RGB+"0;0;40m    bg_RGB test (0;0;40);      "+clr);
	console.log(bg_RGB+"0;0;35m    bg_RGB test (0;0;35);      "+clr);
	console.log(bg_RGB+"0;0;30m    bg_RGB test (0;0;30);      "+clr);
	console.log(bg_RGB+"0;0;25m    bg_RGB test (0;0;25);      "+clr);
	console.log(bg_RGB+"0;0;20m    bg_RGB test (0;0;20);      "+clr);
	console.log(bg_RGB+"0;0;15m    bg_RGB test (0;0;15);      "+clr);
	console.log(bg_RGB+"0;0;10m    bg_RGB test (0;0;10);      "+clr);
	console.log(bg_RGB+"0;0;5m    bg_RGB test (0;0;5);       "+clr);
	console.log(bg_RGB+"0;0;0m    bg_RGB test (0;0;0);       "+clr);
	console.log("");
	console.log("");
	console.log(black+bg_lblack+"         Combinations         "+clr);
	console.log(negative+"                            "+negative+"   inverse foreground <-> background   "+clr);
	console.log(bg_yellow+red+"                     "+bg_yellow+red+"   yellow backgroud / red foreground   "+clr);
	console.log(bg_yellow+red+negative+"          "+bg_yellow+red+negative+"        yellow / red inversed          "+clr);
	console.log(bg_red+".."+bg_green+".."+bg_blue+"     "+bg_red+"    nested   "+bg_green+"    colors    "+bg_blue+"    text    "+clr);
	console.log("");
	console.log("");
	console.log(black+bg_lblack+"        ASCII Color Art       "+clr);
	console.log("");
	console.log(bg_blue+" * * * * * * * * * "+bg_red+"                                  "+clr);
	console.log(bg_blue+"  * * * * * * * *  "+bg_white+"                                  "+clr);
	console.log(bg_blue+" * * * * * * * * * "+bg_red+"                                  "+clr); 
	console.log(bg_blue+"  * * * * * * * *  "+bg_white+"                                  "+clr);
	console.log(bg_blue+" * * * * * * * * * "+bg_red+"                                  "+clr);
	console.log(bg_blue+"  * * * * * * * *  "+bg_white+"                                  "+clr);
	console.log(bg_blue+" * * * * * * * * * "+bg_red+"                                  "+clr);
	console.log(bg_white+"                                                     "+clr);
	console.log(bg_red+"                                                     "+clr);
	console.log(bg_white+"                                                     "+clr);
	console.log(bg_red+"                                                     "+clr);
	console.log(bg_white+"                                                     "+clr);
	console.log(bg_red+"                                                     "+clr);
	console.log("");
	console.log("");
}
