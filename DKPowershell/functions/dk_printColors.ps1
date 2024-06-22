if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_printColors){ $dk_printColors = 1 } else{ return }

####################################################################
# dk_printColors()
#
function Global:dk_printColors () {
	dk_debugFunc
	
	
	dk_echo
	dk_info "${ESC}[101;93m STYLES ${clr}"
	dk_info "clr        ${clr}Reset${clr}"
	dk_info "bold       ${bold}Bold${clr}"
	dk_info "underline  ${underline}Underline${clr}"
	dk_info "inverse    ${inverse}Inverse${clr}"
	dk_echo
	dk_info "${ESC}[101;93m NORMAL FOREGROUND COLORS ${clr}"
	dk_info "black      ${black}Black${clr}"
	dk_info "red        ${red}Red${clr}"
	dk_info "green      ${green}Green${clr}"
	dk_info "yellow     ${yellow}Yellow${clr}"
	dk_info "blue       ${blue}Blue${clr}"
	dk_info "magenta    ${magenta}Magenta${clr}"
	dk_info "cyan       ${cyan}Cyan${clr}"
	dk_info "white      ${white}White${clr}"
	dk_echo
	dk_info "${ESC}[101;93m NORMAL BACKGROUND COLORS ${clr}"
	dk_info "bg_black   ${bg_black}Black${clr}"
	dk_info "bg_red     ${bg_red}Red${clr}"
	dk_info "bg_green   ${bg_green}Green${clr}"
	dk_info "bg_yellow  ${bg_yellow}Yellow${clr}"
	dk_info "bg_blue    ${bg_blue}Blue${clr}"
	dk_info "bg_magenta ${bg_magenta}Magenta${clr}"
	dk_info "bg_cyan    ${bg_cyan}Cyan${clr}"
	dk_info "bg_white   ${bg_white}White${clr}"
	dk_echo
	dk_info "${ESC}[101;93m STRONG FOREGROUND COLORS ${clr}"
	dk_info "BLACK      ${BLACK}Black${clr}"
	dk_info "RED        ${RED}Red${clr}"
	dk_info "GREEN      ${GREEN}Green${clr}"
	dk_info "YELLOW     ${YELLOW}Yellow${clr}"
	dk_info "BLUE       ${BLUE}Blue${clr}"
	dk_info "MAGENTA    ${MAGENTA}Magenta${clr}"
	dk_info "CYAN       ${CYAN}Cyan${clr}"
	dk_info "WHITE      ${WHITE}White${clr}"
	dk_echo
	dk_info "${ESC}[101;93m STRONG BACKGROUND COLORS ${clr}"
	dk_info "BG_BLACK   ${BG_BLACK}Black${clr}"
	dk_info "BG_RED     ${BG_RED}Red${clr}"
	dk_info "BG_GREEN   ${BG_GREEN}Green${clr}"
	dk_info "BG_YELLOW  ${BG_YELLOW}Yellow${clr}"
	dk_info "BG_BLUE    ${BG_BLUE}Blue${clr}"
	dk_info "BG_MAGENTA ${BG_MAGENTA}Magenta${clr}"
	dk_info "BG_CYAN    ${BG_CYAN}Cyan${clr}"
	dk_info "BG_WHITE   ${BG_WHITE}White${clr}"
	dk_echo
	dk_info "${ESC}[101;93m COMBINATIONS ${clr}"
	dk_info "`${ESC}[31m                     ${ESC}[31m red foreground color${clr}"
	dk_info "`${ESC}[7m                      ${ESC}[7m inverse foreground `<-`> background${clr}"
	dk_info "`${ESC}[7;31m                   ${ESC}[7;31m inverse red foreground color${clr}"
	dk_info "`${ESC}[7m and nested `${ESC}[31m ${ESC}[7m before ${ESC}[31mnested${clr}"
	dk_info "`${ESC}[31m and nested `${ESC}[7m ${ESC}[31m before ${ESC}[7mnested${clr}"
	
	
	
	# 256-Color Foreground & Background Charts
	${ESC}=$([char]27)
	dk_echo "`n${ESC}[1;4m256-Color Foreground & Background Charts${ESC}[0m"
	foreach ($fgbg in 38,48) {  # foreground/background switch
	  foreach ($color in 0..255) {  # color range
		#Display the colors
		$field = "$color".PadLeft(4)  # pad the chart boxes with spaces
		Write-Host -NoNewLine "${ESC}[$fgbg;5;${color}m$field ${ESC}[0m"
		#Display 6 colors per line
		if ( (($color+1)%6) -eq 4 ) { dk_echo "`r" }
	  }
	  dk_echo `n
	}
}


function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	dk_printColors
}