#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

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
dk_color (){
	dk_debugFunc
	
	export USE_COLOR=1
	if [ "${1-}" = "OFF" ]; then
		unset USE_COLOR
	fi
	
	if dk_defined USE_COLOR; then
		export ESC=""      # escape character
		export clr="${ESC}[0m"   # reset color
		
		# Styles
		export bold="${ESC}[1m"
		export underline="${ESC}[4m"
		export inverse="${ESC}[7m"

		# Foreground Colors
		export black="${ESC}[30m"
		export red="${ESC}[31m"
		export green="${ESC}[32m"
		export yellow="${ESC}[33m"
		export blue="${ESC}[34m"
		export magenta="${ESC}[35m"
		export cyan="${ESC}[36m" 
		export white="${ESC}[37m"
		
		# Background Colors
		export bg_black="${ESC}[40m"
		export bg_red="${ESC}[41m"
		export bg_green="${ESC}[42m"
		export bg_yellow="${ESC}[43m"
		export bg_blue="${ESC}[44m"
		export bg_magenta="${ESC}[45m"
		export bg_cyan="${ESC}[46m" 
		export bg_white="${ESC}[47m"
		
		# Foreground Colors (Bright)
		export BLACK="${ESC}[90m"
		export RED="${ESC}[91m"
		export GREEN="${ESC}[92m"
		export YELLOW="${ESC}[93m"
		export BLUE="${ESC}[94m"
		export MAGENTA="${ESC}[95m"
		export CYAN="${ESC}[96m"
		export WHITE="${ESC}[97m"
		
		# Background Colors (Bright)
		export BG_BLACK="${ESC}[100m"
		export BG_RED="${ESC}[101m"
		export BG_GREEN="${ESC}[102m"
		export BG_YELLOW="${ESC}[103m"
		export BG_BLUE="${ESC}[104m"
		export BG_MAGENTA="${ESC}[105m"
		export BG_CYAN="${ESC}[106m"
		export BG_WHITE="${ESC}[107m"
		
		dk_echo "${blue}C${green}O${red}L${magenta}O${cyan}R ${blue}O${green}N${clr}"
	else
		#unset ESC
		#unset clr
		
		# Styles
		unset bold
		unset underline
		unset inverse
		
		# Foreground Colors
		unset black
		unset red
		unset green
		unset yellow
		unset blue
		unset magenta
		unset cyan
		unset white
		
		# Background Colors
		unset bg_black
		unset bg_red
		unset bg_green
		unset bg_yellow
		unset bg_blue
		unset bg_magenta
		unset bg_cyan
		unset bg_white
		
		# Foreground Colors (Bright)
		unset BLACK
		unset RED
		unset GREEN
		unset YELLOW
		unset BLUE
		unset MAGENTA
		unset CYAN
		unset WHITE
		
		# Background Colors (Bright)
		unset BG_BLACK
		unset BG_RED
		unset BG_GREEN
		unset BG_YELLOW
		unset BG_BLUE
		unset BG_MAGENTA
		unset BG_CYAN
		unset BG_WHITE
	
		dk_echo "${clr}COLOR OFF"
	fi
}
dk_color 1





DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc
	
	dk_color ON
	dk_color OFF
	dk_color 
	dk_color OFF
	dk_color ON
	#dk_color OFF
	
	dk_echo ""
	dk_echo "${black}${BG_BLACK}           Styles            ${clr}"
	dk_echo "\${clr}        ${clr}Reset${clr}"
	dk_echo "\${bold}       ${bold}Bold${clr}"
	dk_echo "\${underline}  ${underline}Underline${clr}"
	dk_echo "\${inverse}    ${inverse}Inverse${clr}"
	dk_echo ""
	dk_echo "${black}${BG_BLACK}      Foreground Colors      ${clr}"
	dk_echo "\${black}      ${black}Black${clr}"
	dk_echo "\${red}        ${red}Red${clr}"
	dk_echo "\${green}      ${green}Green${clr}"
	dk_echo "\${yellow}     ${yellow}Yellow${clr}"
	dk_echo "\${blue}       ${blue}BLUE${clr}"
	dk_echo "\${magenta}    ${magenta}Magenta${clr}"
	dk_echo "\${cyan}       ${cyan}Cyan${clr}"
	dk_echo "\${white}      ${white}White${clr}"
	dk_echo ""
	dk_echo "${black}${BG_BLACK}      Background Colors      ${clr}"
	dk_echo "\${bg_black}   ${bg_black}Black${clr}"
	dk_echo "\${bg_red}     ${bg_red}Red${clr}"
	dk_echo "\${bg_green}   ${bg_green}Green${clr}"
	dk_echo "\${bg_yellow}  ${bg_yellow}Yellow${clr}"
	dk_echo "\${bg_blue}    ${bg_blue}BLUE${clr}"
	dk_echo "\${bg_magenta} ${bg_magenta}Magenta${clr}"
	dk_echo "\${bg_cyan}    ${bg_cyan}Cyan${clr}"
	dk_echo "\${bg_white}   ${bg_white}White${clr}"
	dk_echo ""
	dk_echo "${black}${BG_BLACK} Foreground Colors  bright  ${clr}"
	dk_echo "\${BLACK}      ${BLACK}Black${clr}"
	dk_echo "\${RED}        ${RED}Red${clr}"
	dk_echo "\${GREEN}      ${GREEN}Green${clr}"
	dk_echo "\${YELLOW}     ${YELLOW}Yellow${clr}"
	dk_echo "\${BLUE}       ${BLUE}BLUE${clr}"
	dk_echo "\${MAGENTA}    ${MAGENTA}Magenta${clr}"
	dk_echo "\${CYAN}       ${CYAN}Cyan${clr}"
	dk_echo "\${WHITE}      ${WHITE}White${clr}"
	dk_echo ""
	dk_echo "${black}${BG_BLACK} Background Colors  bright  ${clr}"
	dk_echo "\${BG_BLACK}   ${BG_BLACK}Black${clr}"
	dk_echo "\${BG_RED}     ${BG_RED}Red${clr}"
	dk_echo "\${BG_GREEN}   ${BG_GREEN}Green${clr}"
	dk_echo "\${BG_YELLOW}  ${BG_YELLOW}Yellow${clr}"
	dk_echo "\${BG_BLUE}    ${BG_BLUE}BLUE${clr}"
	dk_echo "\${BG_MAGENTA} ${BG_MAGENTA}Magenta${clr}"
	dk_echo "\${BG_CYAN}    ${BG_CYAN}Cyan${clr}"
	dk_echo "\${BG_WHITE}   ${BG_WHITE}White${clr}"
	dk_echo ""
	dk_echo "${black}${BG_BLACK}        Combinations         ${clr}"
	dk_echo "\${inverse}                             ${inverse}   inverse foreground <-> background   ${clr}"
	dk_echo "\${bg_yellow}\${red}                     ${bg_yellow}${red}   yellow backgroud / red foreground   ${clr}"
	dk_echo "\${bg_yellow}\${red}\${inverse}           ${bg_yellow}${red}${inverse}        yellow / red inversed          ${clr}"
	dk_echo "\${bg_red}..\${bg_green}..\${bg_blue}     ${bg_red}    nested   ${bg_green}    colors    ${bg_blue}    text    ${clr}"
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
