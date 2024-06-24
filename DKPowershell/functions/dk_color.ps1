if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_color){ $dk_color = 1 } else{ return }

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
function Global:dk_color (){
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	#dk_echo "`$args = $args"
	#dk_echo "`${args} = ${args}"
	#dk_echo "`$args[0] = $args[0]"
	#dk_echo "`${args[0]} = ${args[0]}"

	$global:USE_COLOR = 1
	if(Test-Path variable:args){
		dk_echo "args = $args"
		#if($args -eq "OFF"){ 
		if(!($args)){
			dk_unset USE_COLOR 
		}
	}
	
	if($USE_COLOR){
		$global:ESC = "$([char]27)" # escape character
		$global:clr = "${ESC}[0m"   # reset color
		
		# Styles
		$global:bold = "${ESC}[1m"
		$global:underline = "${ESC}[4m"
		$global:inverse = "${ESC}[7m"

		# Foreground Colors
		$global:black = "${ESC}[30m"
		$global:red = "${ESC}[31m"
		$global:green = "${ESC}[32m"
		$global:yellow = "${ESC}[33m"
		$global:blue = "${ESC}[34m"
		$global:magenta = "${ESC}[35m"
		$global:cyan = "${ESC}[36m" 
		$global:white = "${ESC}[37m"
		
		# Background Colors
		$global:bg_black = "${ESC}[40m"
		$global:bg_red = "${ESC}[41m"
		$global:bg_green = "${ESC}[42m"
		$global:bg_yellow = "${ESC}[43m"
		$global:bg_blue = "${ESC}[44m"
		$global:bg_magenta = "${ESC}[45m"
		$global:bg_cyan = "${ESC}[46m" 
		$global:bg_white = "${ESC}[47m"
		
		# Foreground Colors (Bright)
		$global:BLACK = "${ESC}[90m"
		$global:RED = "${ESC}[91m"
		$global:GREEN = "${ESC}[92m"
		$global:YELLOW = "${ESC}[93m"
		$global:BLUE = "${ESC}[94m"
		$global:MAGENTA = "${ESC}[95m"
		$global:CYAN = "${ESC}[96m"
		$global:WHITE = "${ESC}[97m"
		
		# Background Colors (Bright)
		$global:BG_BLACK = "${ESC}[100m"
		$global:BG_RED = "${ESC}[101m"
		$global:BG_GREEN = "${ESC}[102m"
		$global:BG_YELLOW = "${ESC}[103m"
		$global:BG_BLUE = "${ESC}[104m"
		$global:BG_MAGENTA = "${ESC}[105m"
		$global:BG_CYAN = "${ESC}[106m"
		$global:BG_WHITE = "${ESC}[107m"
		
		dk_echo "${blue}C${green}O${red}L${magenta}O${cyan}R ${blue}O${green}N${clr}"
	}
	else {
		#dk_unset ESC
		#dk_unset clr
		
		# Styles
		dk_unset bold
		dk_unset underline
		dk_unset inverse
		
		# Foreground Colors
		dk_unset black
		dk_unset red
		dk_unset green
		dk_unset yellow
		dk_unset blue
		dk_unset magenta
		dk_unset cyan
		dk_unset white
		
		# Background Colors
		dk_unset bg_black
		dk_unset bg_red
		dk_unset bg_green
		dk_unset bg_yellow
		dk_unset bg_blue
		dk_unset bg_magenta
		dk_unset bg_cyan
		dk_unset bg_white
		
		# Foreground Colors (Bright)
		dk_unset BLACK
		dk_unset RED
		dk_unset GREEN
		dk_unset YELLOW
		dk_unset BLUE
		dk_unset MAGENTA
		dk_unset CYAN
		dk_unset WHITE
		
		# Background Colors (Bright)
		dk_unset BG_BLACK
		dk_unset BG_RED
		dk_unset BG_GREEN
		dk_unset BG_YELLOW
		dk_unset BG_BLUE
		dk_unset BG_MAGENTA
		dk_unset BG_CYAN
		dk_unset BG_WHITE
	
		dk_echo "${clr} COLOR OFF"
	}
}
dk_color 1





function Global:DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### 
	dk_debugFunc
	
	dk_color 1			# true		good
	dk_color 0			# false		good
	dk_color $true 		# true		good
	#dk_color $false	# false		good
	
	#dk_color "1"		# true		bad
	#dk_color "0"		# true		bad
	#dk_color $1		# false		bad
	#dk_color $0		# false		bad
	#dk_color "$1"   	# false		bad
	#dk_color "$0"   	# false		bad
	#dk_color true   	# true		bad
	#dk_color false 	# true		bad
	#dk_color "true"	# true		bad
	#dk_color "false"	# true		bad
	
	
	dk_echo ""
	dk_echo "${black}${BG_BLACK}           Styles            ${clr}"
	dk_echo "`${clr}        ${clr}Reset${clr}"
	dk_echo "`${bold}       ${bold}Bold${clr}"
	dk_echo "`${underline}  ${underline}Underline${clr}"
	dk_echo "`${inverse}    ${inverse}Inverse${clr}"
	dk_echo ""
	dk_echo "${black}${BG_BLACK}      Foreground Colors      ${clr}"
	dk_echo "`${black}      ${black}Black${clr}"
	dk_echo "`${red}        ${red}Red${clr}"
	dk_echo "`${green}      ${green}Green${clr}"
	dk_echo "`${yellow}     ${yellow}Yellow${clr}"
	dk_echo "`${blue}       ${blue}BLUE${clr}"
	dk_echo "`${magenta}    ${magenta}Magenta${clr}"
	dk_echo "`${cyan}       ${cyan}Cyan${clr}"
	dk_echo "`${white}      ${white}White${clr}"
	dk_echo ""
	dk_echo "${black}${BG_BLACK}      Background Colors      ${clr}"
	dk_echo "`${bg_black}   ${bg_black}Black${clr}"
	dk_echo "`${bg_red}     ${bg_red}Red${clr}"
	dk_echo "`${bg_green}   ${bg_green}Green${clr}"
	dk_echo "`${bg_yellow}  ${bg_yellow}Yellow${clr}"
	dk_echo "`${bg_blue}    ${bg_blue}BLUE${clr}"
	dk_echo "`${bg_magenta} ${bg_magenta}Magenta${clr}"
	dk_echo "`${bg_cyan}    ${bg_cyan}Cyan${clr}"
	dk_echo "`${bg_white}   ${bg_white}White${clr}"
	dk_echo ""
	dk_echo "${black}${BG_BLACK} Foreground Colors  bright  ${clr}"
	dk_echo "`${BLACK}      ${BLACK}Black${clr}"
	dk_echo "`${RED}        ${RED}Red${clr}"
	dk_echo "`${GREEN}      ${GREEN}Green${clr}"
	dk_echo "`${YELLOW}     ${YELLOW}Yellow${clr}"
	dk_echo "`${BLUE}       ${BLUE}BLUE${clr}"
	dk_echo "`${MAGENTA}    ${MAGENTA}Magenta${clr}"
	dk_echo "`${CYAN}       ${CYAN}Cyan${clr}"
	dk_echo "`${WHITE}      ${WHITE}White${clr}"
	dk_echo ""
	dk_echo "${black}${BG_BLACK} Background Colors  bright  ${clr}"
	dk_echo "`${BG_BLACK}   ${BG_BLACK}Black${clr}"
	dk_echo "`${BG_RED}     ${BG_RED}Red${clr}"
	dk_echo "`${BG_GREEN}   ${BG_GREEN}Green${clr}"
	dk_echo "`${BG_YELLOW}  ${BG_YELLOW}Yellow${clr}"
	dk_echo "`${BG_BLUE}    ${BG_BLUE}BLUE${clr}"
	dk_echo "`${BG_MAGENTA} ${BG_MAGENTA}Magenta${clr}"
	dk_echo "`${BG_CYAN}    ${BG_CYAN}Cyan${clr}"
	dk_echo "`${BG_WHITE}   ${BG_WHITE}White${clr}"
	dk_echo ""
	dk_echo "${black}${BG_BLACK}        Combinations         ${clr}"
	dk_echo "`${inverse}                             ${inverse}   inverse foreground <-> background   ${clr}"
	dk_echo "`${bg_yellow}`${red}                     ${bg_yellow}${red}   yellow backgroud / red foreground   ${clr}"
	dk_echo "`${bg_yellow}`${red}`${inverse}           ${bg_yellow}${red}${inverse}        yellow / red inversed          ${clr}"
	dk_echo "`${bg_red}..`${bg_green}..`${bg_blue}     ${bg_red}    nested   ${bg_green}    colors    ${bg_blue}    text    ${clr}"
	dk_echo ""
	dk_echo ""
	dk_echo " ${bg_blue} * * * * * * * * * ${bg_red}                                  ${clr}"
	dk_echo " ${bg_blue}  * * * * * * * *  ${bg_white}                                  ${clr}"
	dk_echo " ${bg_blue} * * * * * * * * * ${bg_red}                                  ${clr}" 
	dk_echo " ${bg_blue}  * * * * * * * *  ${bg_white}                                  ${clr}"
	dk_echo " ${bg_blue} * * * * * * * * * ${bg_red}                                  ${clr}"
	dk_echo " ${bg_blue}  * * * * * * * *  ${bg_white}                                  ${clr}"
	dk_echo " ${bg_blue} * * * * * * * * * ${bg_red}                                  ${clr}"
	dk_echo " ${bg_white}                                                     ${clr}"
	dk_echo " ${bg_red}                                                     ${clr}"
	dk_echo " ${bg_white}                                                     ${clr}"
	dk_echo " ${bg_red}                                                     ${clr}"
	dk_echo " ${bg_white}                                                     ${clr}"
	dk_echo " ${bg_red}                                                     ${clr}"
}
