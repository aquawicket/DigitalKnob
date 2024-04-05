# dk_include_guard()

###### STYLES ######
export clr="[0m"
export bold="[1m"
export underline="[4m"
export inverse="[7m"

###### NORMAL FOREGROUND COLORS ######
export black="[30m"
export red="[31m"
export green="[32m"
export yellow="[33m"
export blue="[34m"
export magenta="[35m"
export cyan="[36m"
export white="[37m"

###### NORMAL BACKGROUND COLORS ######
export bg_black="[40m"
export bg_red="[41m"
export bg_green="[42m"
export bg_yellow="[43m"
export bg_blue="[44m"
export bg_magenta="[45m"
export bg_cyan="[46m"
export bg_white="[47m"

###### STRONG FOREGROUND COLORS ######
export BLACK="[90m"
export RED="[91m"
export GREEN="[92m"
export YELLOW="[93m"
export BLUE="[94m"
export MAGENTA="[95m"
export CYAN="[96m"
export WHITE="[97m"

###### STRONG BACKGROUND COLORS ######
export BG_BLACK="[100m"
export BG_RED="[101m"
export BG_GREEN="[102m"
export BG_YELLOW="[103m"
export BG_BLUE="[104m"
export BG_MAGENTA="[105m"
export BG_CYAN="[106m"
export BG_WHITE="[107m"


###############################################
# dk_color()
#
#
#
dk_color () {
	echo "dk_color($@)"
}


###############################################
# d_k_print_colors()
#
#
#
#d_k_print_colors () {
	echo "d_k_print_colors($@)"
	echo ""
	echo "[101;93m STYLES ${clr}"
	echo "\${clr}        ${clr}Reset${clr}"
	echo "\${bold}       ${cbold}Bold${clr}"
	echo "\${underline}  ${cunderline}Underline${clr}"
	echo "\${inverse}    ${cinverse}Inverse${clr}"
	echo ""
	echo "[101;93m NORMAL FOREGROUND COLORS ${clr}"
	echo "\${black}      ${black}Black${clr}"
	echo "\${red}        ${red}Red${clr}"
	echo "\${green}      ${green}Green${clr}"
	echo "\${yellow}     ${yellow}Yellow${clr}"
	echo "\${blue}       ${blue}Blue${clr}"
	echo "\${magenta}    ${magenta}Magenta${clr}"
	echo "\${cyan}       ${cyan}Cyan${clr}"
	echo "\${white}      ${white}White${clr}"
	echo ""
	echo "[101;93m NORMAL BACKGROUND COLORS ${clr}"
	echo "\${bg_black}   ${bg_black}Black${clr}"
	echo "\${bg_red}     ${bg_red}Red${clr}"
	echo "\${bg_green}   ${bg_green}Green${clr}"
	echo "\${bg_yellow}  ${bg_yellow}Yellow${clr}"
	echo "\${bg_blue}    ${bg_blue}Blue${clr}"
	echo "\${bg_magenta} ${bg_magenta}Magenta${clr}"
	echo "\${bg_cyan}    ${bg_cyan}Cyan${clr}"
	echo "\${bg_white}   ${bg_white}White${clr}"
	echo ""
	echo "[101;93m STRONG FOREGROUND COLORS ${clr}"
	echo "\${BLACK}      ${BLACK}Black${clr}"
	echo "\${RED}        ${RED}Red${clr}"
	echo "\${GREEN}      ${GREEN}Green${clr}"
	echo "\${YELLOW}     ${YELLOW}Yellow${clr}"
	echo "\${BLUE}       ${BLUE}Blue${clr}"
	echo "\${MAGENTA}    ${MAGENTA}Magenta${clr}"
	echo "\${CYAN}       ${CYAN}Cyan${clr}"
	echo "\${WHITE}      ${WHITE}White${clr}"
	echo ""
	echo "[101;93m STRONG BACKGROUND COLORS ${clr}"
	echo "\${BG_BLACK}   ${BG_BLACK}Black${clr}"
	echo "\${BG_RED}     ${BG_RED}Red${clr}"
	echo "\${BG_GREEN}   ${BG_GREEN}Green${clr}"
	echo "\${BG_YELLOW}  ${BG_YELLOW}Yellow${clr}"
	echo "\${BG_BLUE}    ${BG_BLUE}Blue${clr}"
	echo "\${BG_MAGENTA} ${BG_MAGENTA}Magenta${clr}"
	echo "\${BG_CYAN}    ${BG_CYAN}Cyan${clr}"
	echo "\${BG_WHITE}   ${BG_WHITE}White${clr}"
	echo ""
	echo "[101;93m COMBINATIONS ${clr}"
	echo "<ESC>[31m                     [31mred foreground color${clr}"
	echo "<ESC>[7m                      [7minverse foreground <-> background${clr}"
	echo "<ESC>[7;31m                   [7;31minverse red foreground color${clr}"
	echo "<ESC>[7m and nested <ESC>[31m [7mbefore [31mnested${clr}"
	echo "<ESC>[31m and nested <ESC>[7m [31mbefore [7mnested${clr}"

	#pause
#}


