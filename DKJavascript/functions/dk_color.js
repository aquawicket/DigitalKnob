//###### DKINIT ######
//var js = document.createElement("script");
//js.type = "text/javascript";
//js.src = "dk_echo.js";
//document.body.appendChild(js);

const dk_echo = function dk_echo(message){ console.log(message) }

//if(!$DKINIT){ . $PWD/DK.ps1 }
//if(!$dk_color){ $dk_color = 1 } else{ return }

//##################################################################################
// dk_color(on/off)
//
//	Enable / Disable console text and background coloring
//
//   on/off:  Default ON
//
//   https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
//   https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
//
const dk_color = function dk_color (){
	//dk_debugFunc
	//if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }

		window.USE_COLOR = 1
	//if(Test-Path variable:args){
	//	if(!($args)){
	//		dk_unset USE_COLOR 
	//	}
	//}
	
	if(USE_COLOR){
		window.ESC = "\x1b" 					// escape character
		
		// Attributes on
		window.clr = "\x1b[0m"   			// Default						- Returns all attributes to the default state prior to modification
		window.bold = "\x1b[1m"				// Bold/Bright 					- Applies brightness/intensity flag to foreground color
		window.dim = "\x1b[2m"				// Dim
		window.italic = "\x1b[3m"			// Italic
		window.underline = "\x1b[4m"			// Underline       				- Adds underline
		window.blink = "\x1b[5m"				// Blink
		window.fblink = "\x1b[6m"			// Rapid Blink
		window.negative = "\x1b[7m"   		// Negative	    				- Swaps foreground and background colors
		window.invisible = "\x1b[8m"			// Invisible
		window.strike = "\x1b[9m"			// Strike Through
		
		// Attributes off
		//window.20m = "\x1b[20m"			// 20
		//window.21m = "\x1b[21m"			// 21
		window.nobold = "\x1b[22m"			// No bold/bright				- Removes brightness/intensity flag from foreground color
		window.noitalic = "\x1b[23m"			// No Italic
		window.nounderline = "\x1b[24m"		// No underline					- Removes underline
		window.noblink = "\x1b[25m"			// No Blink
		//window.26m = "\x1b[26m"			// 26
		window.nonegative = "\x1b[27m"  		// Positive(No negative)		- Returns foreground/background to normal
		window.visible = "\x1b[28m"			// Visible(No invisible)
		window.nostrike = "\x1b[29m"			// No Strike Through
		
		// Foreground Colors
		window.black = "\x1b[30m"			// Foreground Black				- Applies non-bold/bright black to foreground
		window.red = "\x1b[31m"				// Foreground Red				- Applies non-bold/bright red to foreground
		window.green = "\x1b[32m"			// Foreground Green				- Applies non-bold/bright green to foreground
		window.yellow = "\x1b[33m"			// Foreground Yellow			- Applies non-bold/bright yellow to foreground
		window.blue = "\x1b[34m"				// Foreground Blue				- Applies non-bold/bright blue to foreground
		window.magenta = "\x1b[35m"			// Foreground Magenta			- Applies non-bold/bright magenta to foreground
		window.cyan = "\x1b[36m"				// Foreground Cyan				- Applies non-bold/bright cyan to foreground
		window.white = "\x1b[37m"			// Foreground White				- Applies non-bold/bright white to foreground
		window.extended = "\x1b[38m"			// Foreground Extended			- Applies extended color value to the foreground
		//window.default = "\x1b[39m"			// Foreground Default			- Applies only the foreground portion of the defaults
		
		// Background Colors
		window.bg_black = "\x1b[40m"			// Background Black				- Applies non-bold/bright black to background
		window.bg_red = "\x1b[41m"			// Background Red				- Applies non-bold/bright red to background
		window.bg_green = "\x1b[42m"			// Background Green				- Applies non-bold/bright green to background
		window.bg_yellow = "\x1b[43m"		// Background Yellow			- Applies non-bold/bright yellow to background
		window.bg_blue = "\x1b[44m"			// Background Blue				- Applies non-bold/bright blue to background
		window.bg_magenta = "\x1b[45m"		// Background Magenta			- Applies non-bold/bright magenta to background
		window.bg_cyan = "\x1b[46m"			// Background Cyan				- Applies non-bold/bright cyan to background
		window.bg_white = "\x1b[47m"			// Background White				- Applies non-bold/bright white to background
		window.bg_extended = "\x1b[48m"		// Background Extended			- Applies extended color value to the background
		window.bg_default = "\x1b[49m"		// Background Default			- Applies only the background portion of the defaults
		
		// Foreground Colors (light)
		window.lblack = "\x1b[90m"			// Bright Foreground Black		- Applies bold/bright black to foreground
		window.lred = "\x1b[91m"				// Bright Foreground Red		- Applies bold/bright red to foreground
		window.lgreen = "\x1b[92m"			// Bright Foreground Green		- Applies bold/bright green to foreground
		window.lyellow = "\x1b[93m"			// Bright Foreground Yellow		- Applies bold/bright yellow to foreground
		window.lblue = "\x1b[94m"			// Bright Foreground Blue		- Applies bold/bright blue to foreground
		window.lmagenta = "\x1b[95m"			// Bright Foreground Magenta	- Applies bold/bright magenta to foreground
		window.lcyan = "\x1b[96m"			// Bright Foreground Cyan		- Applies bold/bright cyan to foreground
		window.lwhite = "\x1b[97m"			// Bright Foreground White		- Applies bold/bright white to foreground

		// Background Colors (light)
		window.bg_lblack = "\x1b[100m"		// Bright Background Black		- Applies bold/bright black to background
		window.bg_lred = "\x1b[101m"			// Bright Background Red		- Applies bold/bright red to background
		window.bg_lgreen = "\x1b[102m"		// Bright Background Green		- Applies bold/bright green to background
		window.bg_lyellow = "\x1b[103m"		// Bright Background Yellow		- Applies bold/bright yellow to background
		window.bg_lblue = "\x1b[104m"		// Bright Background Blue		- Applies bold/bright blue to background
		window.bg_lmagenta = "\x1b[105m"		// Bright Background Magenta	- Applies bold/bright magenta to background
		window.bg_lcyan = "\x1b[106m"		// Bright Background Cyan		- Applies bold/bright cyan to background
		window.bg_lwhite = "\x1b[107m"		// Bright Background White		- Applies bold/bright white to background
		
		// Foreground RGB Colors
		window.RGB = "\x1b[38;2;"			// RGB+50;100;150m        	 = \x1b[38;2;50;100;150m
		
		// Background RGB Colors
		window.bg_RGB = "\x1b[48;2;"			// bg_RGB+150;100;50m      	= \x1b[38;2;150;100;50m
		
		
		dk_echo(blue+"C"+green+"O"+red+"L"+magenta+"O"+cyan+"R"+blue+" O"+green+"N"+clr)
	}
	else {
		//dk_unset ESC
		//dk_unset clr
		
		// Styles
//		dk_unset bold
//		dk_unset nobold
//		dk_unset underline
//		dk_unset nounderline
//		dk_unset negative
//		dk_unset nonegative
		
		// Foreground Colors
//		dk_unset black
//		dk_unset red
//		dk_unset green
//		dk_unset yellow
//		dk_unset blue
//		dk_unset magenta
//		dk_unset cyan
//		dk_unset white
		
		// Background Colors
//		dk_unset bg_black
//		dk_unset bg_red
//		dk_unset bg_green
//		dk_unset bg_yellow
//		dk_unset bg_blue
//		dk_unset bg_magenta
//		dk_unset bg_cyan
//		dk_unset bg_white
		
		// Foreground Colors (Bright)
//		dk_unset lblack
//		dk_unset lred
//		dk_unset lgreen
//		dk_unset lyellow
//		dk_unset lblue
//		dk_unset lmagenta
//		dk_unset lcyan
//		dk_unset lwhite
		
		// Background Colors (Bright)
//		dk_unset bg_lblack
//		dk_unset bg_lred
//		dk_unset bg_lgreen
//		dk_unset bg_lyellow
//		dk_unset bg_lblue
//		dk_unset bg_lmagenta
//		dk_unset bg_lcyan
//		dk_unset bg_lwhite
		
//		dk_unset RGB
//		dk_unset bg_RGB
	
		dk_echo(clr+" COLOR OFF")
	}
}
dk_color(1)





const DKTEST = function DKTEST (){ //####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### 
	//dk_debugFunc
	
	dk_echo("")
	dk_echo(black+bg_lblack+"         Styles     "+clr)
	dk_echo("clr         "+clr+"default      "+clr)
	dk_echo("bold        "+bold+"bold            "+clr)
	dk_echo("underline   "+underline+"underline  "+clr)
	dk_echo("negative    "+negative+"negative    "+clr)
	dk_echo("")
	dk_echo(black+bg_lblack+"      Foreground Colors      "+clr)
	dk_echo("black       "+black+" black         "+clr)
	dk_echo("red         "+red+" red             "+clr)
	dk_echo("green       "+green+" green         "+clr)
	dk_echo("yellow      "+yellow+" yellow       "+clr)
	dk_echo("blue        "+blue+" blue           "+clr)
	dk_echo("magenta     "+magenta+" magenta     "+clr)
	dk_echo("cyan        "+cyan+" cyan           "+clr)
	dk_echo("white       "+white+" white "+clr)
	dk_echo("")
	dk_echo(black+bg_lblack+"      Background Colors      "+clr)
	dk_echo("bg_black    "+bg_black+" bg_black "+clr)
	dk_echo("bg_red      "+bg_red+" bg_red "+clr)
	dk_echo("bg_green    "+bg_green+" bg_green "+clr)
	dk_echo("bg_yellow   "+bg_yellow+" bg_yellow "+clr)
	dk_echo("bg_blue     "+bg_blue+" bg_blue "+clr)
	dk_echo("bg_magenta  "+bg_magenta+" bg_magenta "+clr)
	dk_echo("bg_cyan     "+bg_cyan+" bg_cyan "+clr)
	dk_echo("bg_white    "+bg_white+" bg_white "+clr)
	dk_echo("")
	dk_echo(black+bg_lblack+" Foreground Colors  bright  "+clr)
	dk_echo("lblack      "+lblack+" lblack "+clr)
	dk_echo("lred        "+lred+" lred "+clr)
	dk_echo("lgreen      "+lgreen+" lgreen "+clr)
	dk_echo("lyellow     "+lyellow+" lyellow "+clr)
	dk_echo("lblue       "+lblue+" lblue "+clr)
	dk_echo("lmagenta    "+lmagenta+" lmagenta "+clr)
	dk_echo("lcyan       "+lcyan+" lcyan "+clr)
	dk_echo("lwhite      "+lwhite+" lwhite "+clr)
	dk_echo("")
	dk_echo(black+bg_lblack+" Background Colors  bright  "+clr)
	dk_echo("bg_lblack   "+bg_lblack+" bg_lblack "+clr)
	dk_echo("bg_lred     "+bg_lred+" bg_lred "+clr)
	dk_echo("bg_lgreen   "+bg_lgreen+" bg_lgreen "+clr)
	dk_echo("bg_lyellow  "+bg_lyellow+" bg_lyellow "+clr)
	dk_echo("bg_lblue    "+bg_lblue+" bg_lblue "+clr)
	dk_echo("bg_lmagenta "+bg_lmagenta+" bg_lmagenta "+clr)
	dk_echo("bg_lcyan    "+bg_lcyan+" bg_lcyan "+clr)
	dk_echo("bg_lwhite   "+bg_lwhite+" bg_lwhite "+clr)
	dk_echo("")
	//dk_echo(RGB+255;10;10m+"    RGB test (255;0;10)    "+clr)
	//dk_echo(RGB+10;255;10m+"    RGB test (0;255;10)    "+clr)
	//dk_echo(RGB+0;0;255m+"    RGB test (0;0;255)     "+clr)
	//dk_echo(RGB+0;0;250m+"    RGB test (0;0;250)     "+clr)
	//dk_echo(RGB+0;0;245m+"    RGB test (0;0;245)     "+clr)
	//dk_echo(RGB+0;0;240m+"    RGB test (0;0;240)     "+clr)
	//dk_echo(RGB+0;0;235m+"    RGB test (0;0;235)     "+clr)
	//dk_echo(RGB+0;0;230m+"    RGB test (0;0;230)     "+clr)
	//dk_echo(RGB+0;0;225m+"    RGB test (0;0;225)     "+clr)
	//dk_echo(RGB+0;0;220m+"    RGB test (0;0;220)     "+clr)
	//dk_echo(RGB+0;0;215m+"    RGB test (0;0;215)     "+clr)
	//dk_echo(RGB+0;0;210m+"    RGB test (0;0;210)     "+clr)
	//dk_echo(RGB+0;0;205m+"    RGB test (0;0;205)     "+clr)
	//dk_echo(RGB+0;0;200m+"    RGB test (0;0;200)     "+clr)
	//dk_echo(RGB+0;0;195m+"    RGB test (0;0;195)     "+clr)
	//dk_echo(RGB+0;0;190m+"    RGB test (0;0;190)     "+clr)
	//dk_echo(RGB+0;0;185m+"    RGB test (0;0;185)     "+clr)
	//dk_echo(RGB+0;0;180m+"    RGB test (0;0;180)     "+clr)
	//dk_echo(RGB+0;0;175m+"    RGB test (0;0;175)     "+clr)
	//dk_echo(RGB+0;0;170m+"    RGB test (0;0;170)     "+clr)
	//dk_echo(RGB+0;0;165m+"    RGB test (0;0;165)     "+clr)
	//dk_echo(RGB+0;0;160m+"    RGB test (0;0;160)     "+clr)
	//dk_echo(RGB+0;0;155m+"    RGB test (0;0;155)     "+clr)
	//dk_echo(RGB+0;0;150m+"    RGB test (0;0;150)     "+clr)
	//dk_echo(RGB+0;0;145m+"    RGB test (0;0;145)     "+clr)
	//dk_echo(RGB+0;0;140m+"    RGB test (0;0;140)     "+clr)
	//dk_echo(RGB+0;0;135m+"    RGB test (0;0;135)     "+clr)
	//dk_echo(RGB+0;0;130m+"    RGB test (0;0;130)     "+clr)
	//dk_echo(RGB+0;0;125m+"    RGB test (0;0;125)     "+clr)
	//dk_echo(RGB+0;0;120m+"    RGB test (0;0;120)     "+clr)
	//dk_echo(RGB+0;0;115m+"    RGB test (0;0;115)     "+clr)
	//dk_echo(RGB+0;0;110m+"    RGB test (0;0;110)     "+clr)
	//dk_echo(RGB+0;0;105m+"    RGB test (0;0;105)     "+clr)
	//dk_echo(RGB+0;0;100m+"    RGB test (0;0;100)     "+clr)
	//dk_echo(RGB+0;0;95m+"    RGB test (0;0;95)      "+clr)
	//dk_echo(RGB+0;0;90m+"    RGB test (0;0;90)      "+clr)
	//dk_echo(RGB+0;0;85m+"    RGB test (0;0;85)      "+clr)
	//dk_echo(RGB+0;0;80m+"    RGB test (0;0;80)      "+clr)
	//dk_echo(RGB+0;0;75m+"    RGB test (0;0;75)      "+clr)
	//dk_echo(RGB+0;0;70m+"    RGB test (0;0;70)      "+clr)
	//dk_echo(RGB+0;0;65m+"    RGB test (0;0;65)      "+clr)
	//dk_echo(RGB+0;0;60m+"    RGB test (0;0;60)      "+clr)
	//dk_echo(RGB+0;0;55m+"    RGB test (0;0;55)      "+clr)
	//dk_echo(RGB+0;0;50m+"    RGB test (0;0;50)      "+clr)
	//dk_echo(RGB+0;0;45m+"    RGB test (0;0;45)      "+clr)
	//dk_echo(RGB+0;0;40m+"    RGB test (0;0;40)      "+clr)
	//dk_echo(RGB+0;0;35m+"    RGB test (0;0;35)      "+clr)
	//dk_echo(RGB+0;0;30m+"    RGB test (0;0;30)      "+clr)
	//dk_echo(RGB+0;0;25m+"    RGB test (0;0;25)      "+clr)
	//dk_echo(RGB+0;0;20m+"    RGB test (0;0;20)      "+clr)
	//dk_echo(RGB+0;0;15m+"    RGB test (0;0;15)      "+clr)
	//dk_echo(RGB+0;0;10m+"    RGB test (0;0;10)      "+clr)
	//dk_echo(RGB+0;0;5m+"    RGB test (0;0;5)       "+clr)
	//dk_echo(RGB+0;0;0m+"    RGB test (0;0;0)       "+clr)
	dk_echo("")
	dk_echo(black+bg_lblack+"        Combinations         "+clr)
	dk_echo(negative+"                             "+negative+"   inverse foreground <-> background   "+clr)
	dk_echo(bg_yellow+"`"+red+"                     "+bg_yellow+red+"   yellow backgroud / red foreground   "+clr)
	dk_echo(bg_yellow+"`"+red+"`"+negative+"           "+bg_yellow+red+negative+"        yellow / red inversed          "+clr)
	dk_echo(bg_red+"..`"+bg_green+"..`"+bg_blue+"     "+bg_red+"    nested   "+bg_green+"    colors    "+bg_blue+"    text    "+clr)
	dk_echo("")
	dk_echo("")
	dk_echo(bg_blue+" * * * * * * * * * "+bg_red+"                                  "+clr)
	dk_echo(bg_blue+"  * * * * * * * *  "+bg_white+"                                  "+clr)
	dk_echo(bg_blue+" * * * * * * * * * "+bg_red+"                                  "+clr) 
	dk_echo(bg_blue+"  * * * * * * * *  "+bg_white+"                                  "+clr)
	dk_echo(bg_blue+" * * * * * * * * * "+bg_red+"                                  "+clr)
	dk_echo(bg_blue+"  * * * * * * * *  "+bg_white+"                                  "+clr)
	dk_echo(bg_blue+" * * * * * * * * * "+bg_red+"                                  "+clr)
	dk_echo(bg_white+"                                                     "+clr)
	dk_echo(bg_red+"                                                     "+clr)
	dk_echo(bg_white+"                                                     "+clr)
	dk_echo(bg_red+"                                                     "+clr)
	dk_echo(bg_white+"                                                     "+clr)
	dk_echo(bg_red+"                                                     "+clr)
}
DKTEST()