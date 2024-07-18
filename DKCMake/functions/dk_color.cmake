include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_color(on/off)
#
#	Enable / Disable console text and background coloring
#
#   on/off:  Default ON
#
#   https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
#   https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
#
function(dk_color)
	dk_debugFunc(${ARGV})
	
	set(USE_COLOR 1)
	if(DEFINED ARGV0)
		if(NOT ${ARGV0})
			dk_unset(USE_COLOR)
		endif()
	endif()
	
	if(USE_COLOR)
		string(ASCII 27 ESC)
		set(ESC         "${ESC}" 		CACHE INTERNAL "")   	# escape character
		
		# Attributes on
		set(clr 		"${ESC}[0m" 	CACHE INTERNAL "")		# Default					- Returns all attributes to the default state prior to modification
		set(bold 		"${ESC}[1m" 	CACHE INTERNAL "")		# Bold/Bright 				- Applies brightness/intensity flag to foreground color
		set(dim			"${ESC}[2m"		CACHE INTERNAL "")		# Dim
		set(italic		"${ESC}[3m"		CACHE INTERNAL "")		# Italic
		set(underline 	"${ESC}[4m" 	CACHE INTERNAL "")		# Underline       			- Adds underline
		set(blink		"${ESC}[5m"		CACHE INTERNAL "")		# Blink
		set(fblink		"${ESC}[6m"		CACHE INTERNAL "")		# Rapid Blink
		set(negative 	"${ESC}[7m" 	CACHE INTERNAL "")  	# Negative	    			- Swaps foreground and background colors
		set(invisible	"${ESC}[8m"		CACHE INTERNAL "")		# Invisible
		set(strike		"${ESC}[9m"		CACHE INTERNAL "")		# Strike Through
		
		# Attributes off
		#set(20m		"${ESC}[20m"	CACHE INTERNAL "")		# 20
		#set(21m		"${ESC}[21m"	CACHE INTERNAL "")		# 21
		set(nobold 		"${ESC}[22m" 	CACHE INTERNAL "")		# No bold/bright			- Removes brightness/intensity flag from foreground color
		set(noitalic	"${ESC}[23m"	CACHE INTERNAL "")		# No italic
		set(nounderline "${ESC}[24m"	CACHE INTERNAL "")		# No underline				- Removes underline
		set(noblink		"${ESC}[25m"	CACHE INTERNAL "")		# No blink
		#set(26m		"${ESC}[26m"	CACHE INTERNAL "")		# 26
		set(nonegative 	"${ESC}[27m" 	CACHE INTERNAL "")  	# Positive(No negative)		- Returns foreground/background to normal
		set(visible		"${ESC}[28m"	CACHE INTERNAL "")		# Visible
		set(nostrike	"${ESC}[29m"	CACHE INTERNAL "")		# No Strike Through
		
		# Foreground Colors
		set(black 		"${ESC}[30m" 	CACHE INTERNAL "")		# Foreground Black			- Applies non-bold/bright black to foreground
		set(red 		"${ESC}[31m" 	CACHE INTERNAL "")		# Foreground Red			- Applies non-bold/bright red to foreground
		set(green		"${ESC}[32m" 	CACHE INTERNAL "")		# Foreground Green			- Applies non-bold/bright green to foreground
		set(yellow 		"${ESC}[33m" 	CACHE INTERNAL "")		# Foreground Yellow			- Applies non-bold/bright yellow to foreground
		set(blue 		"${ESC}[34m" 	CACHE INTERNAL "")		# Foreground Blue			- Applies non-bold/bright blue to foreground
		set(magenta 	"${ESC}[35m" 	CACHE INTERNAL "")		# Foreground Magenta		- Applies non-bold/bright magenta to foreground
		set(cyan 		"${ESC}[36m" 	CACHE INTERNAL "")		# Foreground Cyan			- Applies non-bold/bright cyan to foreground
		set(white 		"${ESC}[37m" 	CACHE INTERNAL "")		# Foreground White			- Applies non-bold/bright white to foreground
		set(extended 	"${ESC}[38m" 	CACHE INTERNAL "")		# Foreground Extended		- Applies extended color value to the foreground
		set(default 	"${ESC}[39m" 	CACHE INTERNAL "")		# Foreground Default		- Applies only the foreground portion of the defaults
		
		# Background Colors
		set(bg_black 	"${ESC}[40m" 	CACHE INTERNAL "")		# Background Black			- Applies non-bold/bright black to background
		set(bg_red 		"${ESC}[41m" 	CACHE INTERNAL "")		# Background Red			- Applies non-bold/bright red to background
		set(bg_green 	"${ESC}[42m" 	CACHE INTERNAL "")		# Background Green			- Applies non-bold/bright green to background
		set(bg_yellow 	"${ESC}[43m" 	CACHE INTERNAL "")		# Background Yellow			- Applies non-bold/bright yellow to background
		set(bg_blue 	"${ESC}[44m" 	CACHE INTERNAL "")		# Background Blue			- Applies non-bold/bright blue to background
		set(bg_magenta 	"${ESC}[45m" 	CACHE INTERNAL "")		# Background Magenta		- Applies non-bold/bright magenta to background
		set(bg_cyan 	"${ESC}[46m" 	CACHE INTERNAL "")		# Background Cyan			- Applies non-bold/bright cyan to background
		set(bg_white 	"${ESC}[47m" 	CACHE INTERNAL "")		# Background White			- Applies non-bold/bright white to background
		set(bg_extended "${ESC}[48m" 	CACHE INTERNAL "")		# Background Extended		- Applies extended color value to the background
		set(bg_default 	"${ESC}[49m" 	CACHE INTERNAL "")		# Background Default		- Applies only the background portion of the defaults
		
		# Foreground Colors (light)
		set(lblack 		"${ESC}[90m" 	CACHE INTERNAL "")		# Bright Foreground Black	- Applies bold/bright black to foreground
		set(lred 		"${ESC}[91m" 	CACHE INTERNAL "")		# Bright Foreground Red		- Applies bold/bright red to foreground
		set(lgreen 		"${ESC}[92m" 	CACHE INTERNAL "")		# Bright Foreground Green	- Applies bold/bright green to foreground
		set(lyellow 	"${ESC}[93m" 	CACHE INTERNAL "")		# Bright Foreground Yellow	- Applies bold/bright yellow to foreground
		set(lblue 		"${ESC}[94m" 	CACHE INTERNAL "")		# Bright Foreground Blue	- Applies bold/bright blue to foreground
		set(lmagenta 	"${ESC}[95m" 	CACHE INTERNAL "")		# Bright Foreground Magenta	- Applies bold/bright magenta to foreground
		set(lcyan 		"${ESC}[96m" 	CACHE INTERNAL "")		# Bright Foreground Cyan	- Applies bold/bright cyan to foreground
		set(lwhite 		"${ESC}[97m" 	CACHE INTERNAL "")		# Bright Foreground White	- Applies bold/bright white to foreground

		# Background Colors (light)
		set(bg_lblack 	"${ESC}[100m" 	CACHE INTERNAL "")		# Bright Background Black	- Applies bold/bright black to background
		set(bg_lred 	"${ESC}[101m"	CACHE INTERNAL "")		# Bright Background Red		- Applies bold/bright red to background
		set(bg_lgreen 	"${ESC}[102m"	CACHE INTERNAL "")		# Bright Background Green	- Applies bold/bright green to background
		set(bg_lyellow 	"${ESC}[103m" 	CACHE INTERNAL "")		# Bright Background Yellow	- Applies bold/bright yellow to background
		set(bg_lblue 	"${ESC}[104m" 	CACHE INTERNAL "")		# Bright Background Blue	- Applies bold/bright blue to background
		set(bg_lmagenta "${ESC}[105m" 	CACHE INTERNAL "")		# Bright Background Magenta	- Applies bold/bright magenta to background
		set(bg_lcyan 	"${ESC}[106m" 	CACHE INTERNAL "")		# Bright Background Cyan	- Applies bold/bright cyan to background
		set(bg_lwhite 	"${ESC}[107m" 	CACHE INTERNAL "")		# Bright Background White	- Applies bold/bright white to background
		
		# Foreground RGB Colors
		set(RGB 		"${ESC}[38;2;" 	CACHE INTERNAL "")		# ${RGB}50;100;150m         = ${ESC}[38;2;50;100;150m
		
		# Background RGB Colors
		set(bg_RGB 		"${ESC}[48;2;"	CACHE INTERNAL "")		# ${bg_RGB}150;100;50m      = ${ESC}[38;2;150;100;50m
		
		
		dk_echo("${blue}C${green}O${red}L${magenta}O${cyan}R ${blue}O${green}N${clr}")
	else()
		#dk_unset(ESC CACHE)
		#dk_unset(clr CACHE)
		
		# Attributes on
		dk_unset(bold CACHE)
		dk_unset(dim CACHE)
		dk_unset(italic CACHE)
		dk_unset(underline CACHE)
		dk_unset(blink CACHE)
		dk_unset(fblink CACHE)
		dk_unset(negative CACHE)
		dk_unset(invisible CACHE)
		dk_unset(strike CACHE)
		
		# Attributes off
		dk_unset(nobold CACHE)
		dk_unset(noitalic CACHE)
		dk_unset(nounderline CACHE)
		dk_unset(noblink CACHE)
		dk_unset(nonegative CACHE)
		dk_unset(novisible CACHE)
		dk_unset(nostrike CACHE)
		
		# Foreground Colors
		dk_unset(black CACHE)
		dk_unset(red CACHE)
		dk_unset(green CACHE)
		dk_unset(yellow CACHE)
		dk_unset(blue CACHE)
		dk_unset(magenta CACHE)
		dk_unset(cyan CACHE)
		dk_unset(white CACHE)
		
		# Background Colors
		dk_unset(bg_black CACHE)
		dk_unset(bg_red CACHE)
		dk_unset(bg_green CACHE)
		dk_unset(bg_yellow CACHE)
		dk_unset(bg_blue CACHE)
		dk_unset(bg_magenta CACHE)
		dk_unset(bg_cyan CACHE)
		dk_unset(bg_white CACHE)
		
		# Foreground Colors (Bright)
		dk_unset(lblack CACHE)
		dk_unset(lred CACHE)
		dk_unset(lgreen CACHE)
		dk_unset(lyellow CACHE)
		dk_unset(lblue CACHE)
		dk_unset(lmagenta CACHE)
		dk_unset(lcyan CACHE)
		dk_unset(lwhite CACHE)
		
		# Background Colors (Bright)
		dk_unset(bg_lblack CACHE)
		dk_unset(bg_lred CACHE)
		dk_unset(bg_lgreen CACHE)
		dk_unset(bg_lyellow CACHE)
		dk_unset(bg_lblue CACHE)
		dk_unset(bg_lmagenta CACHE)
		dk_unset(bg_lcyan CACHE)
		dk_unset(bg_lwhite CACHE)
		
		dk_unset(RGB CACHE)
		dk_unset(bg_RGB CACHE)
	
		dk_echo("${clr} COLOR OFF")
	endif()
endfunction()
dk_color(1)





function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_echo("")
	dk_echo("${black}${bg_lblack}           Styles            ${clr}")
	dk_echo("\${clr}        ${clr} default ${clr}")
	dk_echo("\${bold}       ${bold} bold ${clr}")
	dk_echo("\${dim}        ${dim} dim  ${clr}")
	dk_echo("\${italic}     ${italic} italic  ${clr}")
	dk_echo("\${underline}  ${underline} underline ${clr}")
	dk_echo("\${blink}      ${blink} blink  ${clr}")
	dk_echo("\${fblink}     ${fblink} fblink  ${clr}")
	dk_echo("\${negative}   ${negative} negative ${clr}")
	dk_echo("\${invisible}  ${invisible} invisible ${clr}")
	dk_echo("\${strike}     ${strike} strike ${clr}")
	dk_echo("")
	dk_echo("")
	dk_echo("${black}${bg_lblack}      Foreground Colors      ${clr}")
	dk_echo("\${black}      ${black} black ${clr}")
	dk_echo("\${red}        ${red} red ${clr}")
	dk_echo("\${green}      ${green} green ${clr}")
	dk_echo("\${yellow}     ${yellow} yellow ${clr}")
	dk_echo("\${blue}       ${blue} blue ${clr}")
	dk_echo("\${magenta}    ${magenta} magenta ${clr}")
	dk_echo("\${cyan}       ${cyan} cyan ${clr}")
	dk_echo("\${white}      ${white} white ${clr}")
	dk_echo("")
	dk_echo("")
	dk_echo("${black}${bg_lblack}      Background Colors      ${clr}")
	dk_echo("\${bg_black}   ${bg_black} bg_black ${clr}")
	dk_echo("\${bg_red}     ${bg_red} bg_red ${clr}")
	dk_echo("\${bg_green}   ${bg_green} bg_green ${clr}")
	dk_echo("\${bg_yellow}  ${bg_yellow} bg_yellow ${clr}")
	dk_echo("\${bg_blue}    ${bg_blue} bg_blue ${clr}")
	dk_echo("\${bg_magenta} ${bg_magenta} bg_magenta ${clr}")
	dk_echo("\${bg_cyan}    ${bg_cyan} bg_cyan ${clr}")
	dk_echo("\${bg_white}   ${bg_white} bg_white ${clr}")
	dk_echo("")
	dk_echo("")
	dk_echo("${black}${bg_lblack} Foreground Colors (bright)  ${clr}")
	dk_echo("\${lblack}      ${lblack} lblack ${clr}")
	dk_echo("\${lred}        ${lred} lred ${clr}")
	dk_echo("\${lgreen}      ${lgreen} lgreen ${clr}")
	dk_echo("\${lyellow}     ${lyellow} lyellow ${clr}")
	dk_echo("\${lblue}       ${lblue} lblue ${clr}")
	dk_echo("\${lmagenta}    ${lmagenta} lmagenta ${clr}")
	dk_echo("\${lcyan}       ${lcyan} lcyan ${clr}")
	dk_echo("\${lwhite}      ${lwhite} lwhite ${clr}")
	dk_echo("")
	dk_echo("")
	dk_echo("${black}${bg_lblack} Background Colors (bright)  ${clr}")
	dk_echo("\${bg_lblack}   ${bg_lblack} bg_lblack ${clr}")
	dk_echo("\${bg_lred}     ${bg_lred} bg_lred ${clr}")
	dk_echo("\${bg_lgreen}   ${bg_lgreen} bg_lgreen ${clr}")
	dk_echo("\${bg_lyellow}  ${bg_lyellow} bg_lyellow ${clr}")
	dk_echo("\${bg_lblue}    ${bg_lblue} bg_lblue ${clr}")
	dk_echo("\${bg_lmagenta} ${bg_lmagenta} bg_lmagenta ${clr}")
	dk_echo("\${bg_lcyan}    ${bg_lcyan} bg_lcyan ${clr}")
	dk_echo("\${bg_lwhite}   ${bg_lwhite} bg_lwhite ${clr}")
	dk_echo("")
	dk_echo("")
	dk_echo("${black}${bg_lblack}    RGB Foreground Colors    ${clr}")
	dk_echo("${RGB}255;10;10m    RGB test (255;0;10)    ${clr}")
	dk_echo("${RGB}10;255;10m    RGB test (0;255;10)    ${clr}")
	dk_echo("${RGB}0;0;255m    RGB test (0;0;255)     ${clr}")
	dk_echo("${RGB}0;0;250m    RGB test (0;0;250)     ${clr}")
	dk_echo("${RGB}0;0;245m    RGB test (0;0;245)     ${clr}")
	dk_echo("${RGB}0;0;240m    RGB test (0;0;240)     ${clr}")
	dk_echo("${RGB}0;0;235m    RGB test (0;0;235)     ${clr}")
	dk_echo("${RGB}0;0;230m    RGB test (0;0;230)     ${clr}")
	dk_echo("${RGB}0;0;225m    RGB test (0;0;225)     ${clr}")
	dk_echo("${RGB}0;0;220m    RGB test (0;0;220)     ${clr}")
	dk_echo("${RGB}0;0;215m    RGB test (0;0;215)     ${clr}")
	dk_echo("${RGB}0;0;210m    RGB test (0;0;210)     ${clr}")
	dk_echo("${RGB}0;0;205m    RGB test (0;0;205)     ${clr}")
	dk_echo("${RGB}0;0;200m    RGB test (0;0;200)     ${clr}")
	dk_echo("${RGB}0;0;195m    RGB test (0;0;195)     ${clr}")
	dk_echo("${RGB}0;0;190m    RGB test (0;0;190)     ${clr}")
	dk_echo("${RGB}0;0;185m    RGB test (0;0;185)     ${clr}")
	dk_echo("${RGB}0;0;180m    RGB test (0;0;180)     ${clr}")
	dk_echo("${RGB}0;0;175m    RGB test (0;0;175)     ${clr}")
	dk_echo("${RGB}0;0;170m    RGB test (0;0;170)     ${clr}")
	dk_echo("${RGB}0;0;165m    RGB test (0;0;165)     ${clr}")
	dk_echo("${RGB}0;0;160m    RGB test (0;0;160)     ${clr}")
	dk_echo("${RGB}0;0;155m    RGB test (0;0;155)     ${clr}")
	dk_echo("${RGB}0;0;150m    RGB test (0;0;150)     ${clr}")
	dk_echo("${RGB}0;0;145m    RGB test (0;0;145)     ${clr}")
	dk_echo("${RGB}0;0;140m    RGB test (0;0;140)     ${clr}")
	dk_echo("${RGB}0;0;135m    RGB test (0;0;135)     ${clr}")
	dk_echo("${RGB}0;0;130m    RGB test (0;0;130)     ${clr}")
	dk_echo("${RGB}0;0;125m    RGB test (0;0;125)     ${clr}")
	dk_echo("${RGB}0;0;120m    RGB test (0;0;120)     ${clr}")
	dk_echo("${RGB}0;0;115m    RGB test (0;0;115)     ${clr}")
	dk_echo("${RGB}0;0;110m    RGB test (0;0;110)     ${clr}")
	dk_echo("${RGB}0;0;105m    RGB test (0;0;105)     ${clr}")
	dk_echo("${RGB}0;0;100m    RGB test (0;0;100)     ${clr}")
	dk_echo("${RGB}0;0;95m    RGB test (0;0;95)      ${clr}")
	dk_echo("${RGB}0;0;90m    RGB test (0;0;90)      ${clr}")
	dk_echo("${RGB}0;0;85m    RGB test (0;0;85)      ${clr}")
	dk_echo("${RGB}0;0;80m    RGB test (0;0;80)      ${clr}")
	dk_echo("${RGB}0;0;75m    RGB test (0;0;75)      ${clr}")
	dk_echo("${RGB}0;0;70m    RGB test (0;0;70)      ${clr}")
	dk_echo("${RGB}0;0;65m    RGB test (0;0;65)      ${clr}")
	dk_echo("${RGB}0;0;60m    RGB test (0;0;60)      ${clr}")
	dk_echo("${RGB}0;0;55m    RGB test (0;0;55)      ${clr}")
	dk_echo("${RGB}0;0;50m    RGB test (0;0;50)      ${clr}")
	dk_echo("${RGB}0;0;45m    RGB test (0;0;45)      ${clr}")
	dk_echo("${RGB}0;0;40m    RGB test (0;0;40)      ${clr}")
	dk_echo("${RGB}0;0;35m    RGB test (0;0;35)      ${clr}")
	dk_echo("${RGB}0;0;30m    RGB test (0;0;30)      ${clr}")
	dk_echo("${RGB}0;0;25m    RGB test (0;0;25)      ${clr}")
	dk_echo("${RGB}0;0;20m    RGB test (0;0;20)      ${clr}")
	dk_echo("${RGB}0;0;15m    RGB test (0;0;15)      ${clr}")
	dk_echo("${RGB}0;0;10m    RGB test (0;0;10)      ${clr}")
	dk_echo("${RGB}0;0;5m    RGB test (0;0;5)       ${clr}")
	dk_echo("${RGB}0;0;0m    RGB test (0;0;0)       ${clr}")
	dk_echo("")
	dk_echo("")
	dk_echo("${black}${bg_lblack}    RGB Background Colors     ${clr}")
	dk_echo("${bg_RGB}255;10;10m    bg_RGB test (255;0;10)    ${clr}")
	dk_echo("${bg_RGB}10;255;10m    bg_RGB test (0;255;10)    ${clr}")
	dk_echo("${bg_RGB}0;0;255m    bg_RGB test (0;0;255)     ${clr}")
	dk_echo("${bg_RGB}0;0;250m    bg_RGB test (0;0;250)     ${clr}")
	dk_echo("${bg_RGB}0;0;245m    bg_RGB test (0;0;245)     ${clr}")
	dk_echo("${bg_RGB}0;0;240m    bg_RGB test (0;0;240)     ${clr}")
	dk_echo("${bg_RGB}0;0;235m    bg_RGB test (0;0;235)     ${clr}")
	dk_echo("${bg_RGB}0;0;230m    bg_RGB test (0;0;230)     ${clr}")
	dk_echo("${bg_RGB}0;0;225m    bg_RGB test (0;0;225)     ${clr}")
	dk_echo("${bg_RGB}0;0;220m    bg_RGB test (0;0;220)     ${clr}")
	dk_echo("${bg_RGB}0;0;215m    bg_RGB test (0;0;215)     ${clr}")
	dk_echo("${bg_RGB}0;0;210m    bg_RGB test (0;0;210)     ${clr}")
	dk_echo("${bg_RGB}0;0;205m    bg_RGB test (0;0;205)     ${clr}")
	dk_echo("${bg_RGB}0;0;200m    bg_RGB test (0;0;200)     ${clr}")
	dk_echo("${bg_RGB}0;0;195m    bg_RGB test (0;0;195)     ${clr}")
	dk_echo("${bg_RGB}0;0;190m    bg_RGB test (0;0;190)     ${clr}")
	dk_echo("${bg_RGB}0;0;185m    bg_RGB test (0;0;185)     ${clr}")
	dk_echo("${bg_RGB}0;0;180m    bg_RGB test (0;0;180)     ${clr}")
	dk_echo("${bg_RGB}0;0;175m    bg_RGB test (0;0;175)     ${clr}")
	dk_echo("${bg_RGB}0;0;170m    bg_RGB test (0;0;170)     ${clr}")
	dk_echo("${bg_RGB}0;0;165m    bg_RGB test (0;0;165)     ${clr}")
	dk_echo("${bg_RGB}0;0;160m    bg_RGB test (0;0;160)     ${clr}")
	dk_echo("${bg_RGB}0;0;155m    bg_RGB test (0;0;155)     ${clr}")
	dk_echo("${bg_RGB}0;0;150m    bg_RGB test (0;0;150)     ${clr}")
	dk_echo("${bg_RGB}0;0;145m    bg_RGB test (0;0;145)     ${clr}")
	dk_echo("${bg_RGB}0;0;140m    bg_RGB test (0;0;140)     ${clr}")
	dk_echo("${bg_RGB}0;0;135m    bg_RGB test (0;0;135)     ${clr}")
	dk_echo("${bg_RGB}0;0;130m    bg_RGB test (0;0;130)     ${clr}")
	dk_echo("${bg_RGB}0;0;125m    bg_RGB test (0;0;125)     ${clr}")
	dk_echo("${bg_RGB}0;0;120m    bg_RGB test (0;0;120)     ${clr}")
	dk_echo("${bg_RGB}0;0;115m    bg_RGB test (0;0;115)     ${clr}")
	dk_echo("${bg_RGB}0;0;110m    bg_RGB test (0;0;110)     ${clr}")
	dk_echo("${bg_RGB}0;0;105m    bg_RGB test (0;0;105)     ${clr}")
	dk_echo("${bg_RGB}0;0;100m    bg_RGB test (0;0;100)     ${clr}")
	dk_echo("${bg_RGB}0;0;95m    bg_RGB test (0;0;95)      ${clr}")
	dk_echo("${bg_RGB}0;0;90m    bg_RGB test (0;0;90)      ${clr}")
	dk_echo("${bg_RGB}0;0;85m    bg_RGB test (0;0;85)      ${clr}")
	dk_echo("${bg_RGB}0;0;80m    bg_RGB test (0;0;80)      ${clr}")
	dk_echo("${bg_RGB}0;0;75m    bg_RGB test (0;0;75)      ${clr}")
	dk_echo("${bg_RGB}0;0;70m    bg_RGB test (0;0;70)      ${clr}")
	dk_echo("${bg_RGB}0;0;65m    bg_RGB test (0;0;65)      ${clr}")
	dk_echo("${bg_RGB}0;0;60m    bg_RGB test (0;0;60)      ${clr}")
	dk_echo("${bg_RGB}0;0;55m    bg_RGB test (0;0;55)      ${clr}")
	dk_echo("${bg_RGB}0;0;50m    bg_RGB test (0;0;50)      ${clr}")
	dk_echo("${bg_RGB}0;0;45m    bg_RGB test (0;0;45)      ${clr}")
	dk_echo("${bg_RGB}0;0;40m    bg_RGB test (0;0;40)      ${clr}")
	dk_echo("${bg_RGB}0;0;35m    bg_RGB test (0;0;35)      ${clr}")
	dk_echo("${bg_RGB}0;0;30m    bg_RGB test (0;0;30)      ${clr}")
	dk_echo("${bg_RGB}0;0;25m    bg_RGB test (0;0;25)      ${clr}")
	dk_echo("${bg_RGB}0;0;20m    bg_RGB test (0;0;20)      ${clr}")
	dk_echo("${bg_RGB}0;0;15m    bg_RGB test (0;0;15)      ${clr}")
	dk_echo("${bg_RGB}0;0;10m    bg_RGB test (0;0;10)      ${clr}")
	dk_echo("${bg_RGB}0;0;5m    bg_RGB test (0;0;5)       ${clr}")
	dk_echo("${bg_RGB}0;0;0m    bg_RGB test (0;0;0)       ${clr}")
	dk_echo("")
	dk_echo("")
	dk_echo("${black}${bg_lblack}        Combinations         ${clr}")
	dk_echo("\${negative}                             ${negative}   inverse foreground <-> background   ${clr}")
	dk_echo("\${bg_yellow}\${red}                     ${bg_yellow}${red}   yellow backgroud / red foreground   ${clr}")
	dk_echo("\${bg_yellow}\${red}\${negative}           ${bg_yellow}${red}${negative}        yellow / red inversed          ${clr}")
	dk_echo("\${bg_red}..\${bg_green}..\${bg_blue}     ${bg_red}    nested   ${bg_green}    colors    ${bg_blue}    text    ${clr}")
	dk_echo("")
	dk_echo("")
	dk_echo("${black}${bg_lblack}        ASCII Color Art       ${clr}")
	dk_echo("")
	dk_echo(" ${bg_blue} * * * * * * * * * ${bg_red}                                  ${clr}")
	dk_echo(" ${bg_blue}  * * * * * * * *  ${bg_white}                                  ${clr}")
	dk_echo(" ${bg_blue} * * * * * * * * * ${bg_red}                                  ${clr}") 
	dk_echo(" ${bg_blue}  * * * * * * * *  ${bg_white}                                  ${clr}")
	dk_echo(" ${bg_blue} * * * * * * * * * ${bg_red}                                  ${clr}")
	dk_echo(" ${bg_blue}  * * * * * * * *  ${bg_white}                                  ${clr}")
	dk_echo(" ${bg_blue} * * * * * * * * * ${bg_red}                                  ${clr}")
	dk_echo(" ${bg_white}                                                     ${clr}")
	dk_echo(" ${bg_red}                                                     ${clr}")
	dk_echo(" ${bg_white}                                                     ${clr}")
	dk_echo(" ${bg_red}                                                     ${clr}")
	dk_echo(" ${bg_white}                                                     ${clr}")
	dk_echo(" ${bg_red}                                                     ${clr}")
endfunction()