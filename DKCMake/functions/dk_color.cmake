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
			unset(USE_COLOR)
		endif()
	endif()
	
	if(USE_COLOR)
		string(ASCII 27 ESC)
		set(ESC          "${ESC}" 		CACHE INTERNAL "")   	# escape character
		set(clr          "${ESC}[0m" 	CACHE INTERNAL "")   	# reset color
		
		# Styles
		set(clr 		"${ESC}[0m" 	CACHE INTERNAL "")		# Default					- Returns all attributes to the default state prior to modification
		set(bold 		"${ESC}[1m" 	CACHE INTERNAL "")		# Bold/Bright 				- Applies brightness/intensity flag to foreground color
		set(nobold 		"${ESC}[22m" 	CACHE INTERNAL "")		# No bold/bright			- Removes brightness/intensity flag from foreground color
		set(underline 	"${ESC}[4m" 	CACHE INTERNAL "")		# Underline       			- Adds underline
		set(nounderline "${ESC}[24m"	CACHE INTERNAL "")		# No underline				- Removes underline
		set(negative 	"${ESC}[7m" 	CACHE INTERNAL "")  	# Negative	    			- Swaps foreground and background colors
		set(nonegative 	"${ESC}[27m" 	CACHE INTERNAL "")  	# Positive(No negative)		- Returns foreground/background to normal

		# Foreground Colors
		set(black "${ESC}[30m" CACHE INTERNAL "")			# Foreground Black			- Applies non-bold/bright black to foreground
		set(red "${ESC}[31m" CACHE INTERNAL "")				# Foreground Red			- Applies non-bold/bright red to foreground
		set(green "${ESC}[32m" CACHE INTERNAL "")			# Foreground Green			- Applies non-bold/bright green to foreground
		set(yellow "${ESC}[33m" CACHE INTERNAL "")			# Foreground Yellow			- Applies non-bold/bright yellow to foreground
		set(blue "${ESC}[34m" CACHE INTERNAL "")			# Foreground Blue			- Applies non-bold/bright blue to foreground
		set(magenta "${ESC}[35m" CACHE INTERNAL "")			# Foreground Magenta		- Applies non-bold/bright magenta to foreground
		set(cyan "${ESC}[36m" CACHE INTERNAL "")			# Foreground Cyan			- Applies non-bold/bright cyan to foreground
		set(white "${ESC}[37m" CACHE INTERNAL "")			# Foreground White			- Applies non-bold/bright white to foreground
		set(extended "${ESC}[38m" CACHE INTERNAL "")		# Foreground Extended		- Applies extended color value to the foreground
		set(default "${ESC}[39m" CACHE INTERNAL "")			# Foreground Default		- Applies only the foreground portion of the defaults
		
		# Background Colors
		set(bg_black "${ESC}[40m" CACHE INTERNAL "")		# Background Black			- Applies non-bold/bright black to background
		set(bg_red "${ESC}[41m" CACHE INTERNAL "")			# Background Red			- Applies non-bold/bright red to background
		set(bg_green "${ESC}[42m" CACHE INTERNAL "")		# Background Green			- Applies non-bold/bright green to background
		set(bg_yellow "${ESC}[43m" CACHE INTERNAL "")		# Background Yellow			- Applies non-bold/bright yellow to background
		set(bg_blue "${ESC}[44m" CACHE INTERNAL "")			# Background Blue			- Applies non-bold/bright blue to background
		set(bg_magenta "${ESC}[45m" CACHE INTERNAL "")		# Background Magenta		- Applies non-bold/bright magenta to background
		set(bg_cyan "${ESC}[46m" CACHE INTERNAL "")			# Background Cyan			- Applies non-bold/bright cyan to background
		set(bg_white "${ESC}[47m" CACHE INTERNAL "")		# Background White			- Applies non-bold/bright white to background
		set(bg_extended "${ESC}[48m" CACHE INTERNAL "")		# Background Extended		- Applies extended color value to the background
		set(bg_default "${ESC}[49m" CACHE INTERNAL "")		# Background Default		- Applies only the background portion of the defaults
		
		# Foreground Colors (light)
		set(lblack "${ESC}[90m" CACHE INTERNAL "")			# Bright Foreground Black	- Applies bold/bright black to foreground
		set(lred "${ESC}[91m" CACHE INTERNAL "")			# Bright Foreground Red		- Applies bold/bright red to foreground
		set(lgreen "${ESC}[92m" CACHE INTERNAL "")			# Bright Foreground Green	- Applies bold/bright green to foreground
		set(lyellow "${ESC}[93m" CACHE INTERNAL "")			# Bright Foreground Yellow	- Applies bold/bright yellow to foreground
		set(lblue "${ESC}[94m" CACHE INTERNAL "")			# Bright Foreground Blue	- Applies bold/bright blue to foreground
		set(lmagenta "${ESC}[95m" CACHE INTERNAL "")		# Bright Foreground Magenta	- Applies bold/bright magenta to foreground
		set(lcyan "${ESC}[96m" CACHE INTERNAL "")			# Bright Foreground Cyan	- Applies bold/bright cyan to foreground
		set(lwhite "${ESC}[97m" CACHE INTERNAL "")			# Bright Foreground White	- Applies bold/bright white to foreground

		# Background Colors (light)
		set(bg_lblack "${ESC}[100m" CACHE INTERNAL "")		# Bright Background Black	- Applies bold/bright black to background
		set(bg_lred "${ESC}[101m" CACHE INTERNAL "")		# Bright Background Red		- Applies bold/bright red to background
		set(bg_lgreen "${ESC}[102m" CACHE INTERNAL "")		# Bright Background Green	- Applies bold/bright green to background
		set(bg_lyellow "${ESC}[103m" CACHE INTERNAL "")		# Bright Background Yellow	- Applies bold/bright yellow to background
		set(bg_lblue "${ESC}[104m" CACHE INTERNAL "")		# Bright Background Blue	- Applies bold/bright blue to background
		set(bg_lmagenta "${ESC}[105m" CACHE INTERNAL "")	# Bright Background Magenta	- Applies bold/bright magenta to background
		set(bg_lcyan "${ESC}[106m" CACHE INTERNAL "")		# Bright Background Cyan	- Applies bold/bright cyan to background
		set(bg_lwhite "${ESC}[107m" CACHE INTERNAL "")		# Bright Background White	- Applies bold/bright white to background
		
		# Foreground RGB Colors
		set(RGB "${ESC}[38;2;" CACHE INTERNAL "")			# ${RGB}50;100;150m         = ${ESC}[38;2;50;100;150m
		
		# Background RGB Colors
		set(bg_RGB "${ESC}[48;2;")							# ${bg_RGB}150;100;50m      = ${ESC}[38;2;150;100;50m
		
		dk_echo("${blue}C${green}O${red}L${magenta}O${cyan}R ${blue}O${green}N${clr}")
	else()
		#unset(ESC CACHE)
		#unset(clr CACHE)
		
		# Styles
		unset(bold CACHE)
		unset(nobold CACHE)
		unset(underline CACHE)
		unset(nounderline CACHE)
		unset(negative CACHE)
		unset(nonegative CACHE)
		
		# Foreground Colors
		unset(black CACHE)
		unset(red CACHE)
		unset(green CACHE)
		unset(yellow CACHE)
		unset(blue CACHE)
		unset(magenta CACHE)
		unset(cyan CACHE)
		unset(white CACHE)
		
		# Background Colors
		unset(bg_black CACHE)
		unset(bg_red CACHE)
		unset(bg_green CACHE)
		unset(bg_yellow CACHE)
		unset(bg_blue CACHE)
		unset(bg_magenta CACHE)
		unset(bg_cyan CACHE)
		unset(bg_white CACHE)
		
		# Foreground Colors (Bright)
		unset(lblack CACHE)
		unset(lred CACHE)
		unset(lgreen CACHE)
		unset(lyellow CACHE)
		unset(lblue CACHE)
		unset(lmagenta CACHE)
		unset(lcyan CACHE)
		unset(lwhite CACHE)
		
		# Background Colors (Bright)
		unset(bg_lblack CACHE)
		unset(bg_lred CACHE)
		unset(bg_lgreen CACHE)
		unset(bg_lyellow CACHE)
		unset(bg_lblue CACHE)
		unset(bg_lmagenta CACHE)
		unset(bg_lcyan CACHE)
		unset(bg_lwhite CACHE)
		
		unset(RGB CACHE)
		unset(bg_RGB CACHE)
	
		dk_echo("${clr} COLOR OFF")
		
	endif()
endfunction()
dk_color(1)





function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})

	dk_color(1)
	dk_color(0)
	dk_color(1)
	
	dk_echo("")
	dk_echo("${black}${bg_lblack}           Styles            ${clr}")
	dk_echo("\${clr}        ${clr} default ${clr}")
	dk_echo("\${bold}       ${bold} bold ${clr}")
	dk_echo("\${underline}  ${underline} underline ${clr}")
	dk_echo("\${negative}    ${negative} negative ${clr}")
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
	dk_echo("${black}${bg_lblack}        Combinations         ${clr}")
	dk_echo("\${negative}                             ${negative}   inverse foreground <-> background   ${clr}")
	dk_echo("\${bg_yellow}\${red}                     ${bg_yellow}${red}   yellow backgroud / red foreground   ${clr}")
	dk_echo("\${bg_yellow}\${red}\${negative}           ${bg_yellow}${red}${negative}        yellow / red inversed          ${clr}")
	dk_echo("\${bg_red}..\${bg_green}..\${bg_blue}     ${bg_red}    nested   ${bg_green}    colors    ${bg_blue}    text    ${clr}")
	dk_echo("")
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