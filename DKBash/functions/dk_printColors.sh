#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


###############################################
# dk_print_colors()
#
#
#
dk_printColors () {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
	
	dk_echo
	dk_echo "${ESC}[101;93m STYLES ${clr}"
	dk_echo "\${clr}        ${clr}Reset${clr}"
	dk_echo "\${bold}       ${bold}Bold${clr}"
	dk_echo "\${underline}  ${underline}Underline${clr}"
	dk_echo "\${inverse}    ${inverse}Inverse${clr}"
	dk_echo
	dk_echo "${ESC}[101;93m NORMAL FOREGROUND COLORS ${clr}"
	dk_echo "\${black}      ${black}Black${clr}"
	dk_echo "\${red}        ${red}Red${clr}"
	dk_echo "\${green}      ${green}Green${clr}"
	dk_echo "\${yellow}     ${yellow}Yellow${clr}"
	dk_echo "\${blue}       ${blue}Blue${clr}"
	dk_echo "\${magenta}    ${magenta}Magenta${clr}"
	dk_echo "\${cyan}       ${cyan}Cyan${clr}"
	dk_echo "\${white}      ${white}White${clr}"
	dk_echo
	dk_echo "${ESC}[101;93m NORMAL BACKGROUND COLORS ${clr}"
	dk_echo "\${bg_black}   ${bg_black}Black${clr}"
	dk_echo "\${bg_red}     ${bg_red}Red${clr}"
	dk_echo "\${bg_green}   ${bg_green}Green${clr}"
	dk_echo "\${bg_yellow}  ${bg_yellow}Yellow${clr}"
	dk_echo "\${bg_blue}    ${bg_blue}Blue${clr}"
	dk_echo "\${bg_magenta} ${bg_magenta}Magenta${clr}"
	dk_echo "\${bg_cyan}    ${bg_cyan}Cyan${clr}"
	dk_echo "\${bg_white}   ${bg_white}White${clr}"
	dk_echo
	dk_echo "${ESC}[101;93m STRONG FOREGROUND COLORS ${clr}"
	dk_echo "\${Black}      ${Black}Black${clr}"
	dk_echo "\${Red}        ${Red}Red${clr}"
	dk_echo "\${Green}      ${Green}Green${clr}"
	dk_echo "\${Yellow}     ${Yellow}Yellow${clr}"
	dk_echo "\${Blue}       ${Blue}Blue${clr}"
	dk_echo "\${Magenta}    ${Magenta}Magenta${clr}"
	dk_echo "\${Cyan}       ${Cyan}Cyan${clr}"
	dk_echo "\${White}      ${White}White${clr}"
	dk_echo
	dk_echo "${ESC}[101;93m STRONG BACKGROUND COLORS ${clr}"
	dk_echo "\${BG_Black}   ${BG_Black}Black${clr}"
	dk_echo "\${BG_Red}     ${BG_Red}Red${clr}"
	dk_echo "\${BG_Green}   ${BG_Green}Green${clr}"
	dk_echo "\${BG_Yellow}  ${BG_Yellow}Yellow${clr}"
	dk_echo "\${BG_Blue}    ${BG_Blue}Blue${clr}"
	dk_echo "\${BG_Magenta} ${BG_Magenta}Magenta${clr}"
	dk_echo "\${BG_Cyan}    ${BG_Cyan}Cyan${clr}"
	dk_echo "\${BG_White}   ${BG_White}White${clr}"
	dk_echo
	dk_echo "${ESC}[101;93m COMBINATIONS ${clr}"
	dk_echo "\${ESC}[31m                       ${ESC}[31mred foreground color${clr}"
	dk_echo "\${ESC}[7m                        ${ESC}[7minverse foreground <-> background${clr}"
	dk_echo "\${ESC}[7;31m                     ${ESC}[7;31minverse red foreground color${clr}"
	dk_echo "\${ESC}[7m and nested \${ESC}[31m  ${ESC}[7mbefore ${ESC}[31mnested${clr}"
	dk_echo "\${ESC}[31m and nested \${ESC}[7m  ${ESC}[31mbefore ${ESC}[7mnested${clr}"
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_printColors
}