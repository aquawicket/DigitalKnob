#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


# https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797

###### STYLES ######
export clr="[0m"
export bold="[1m"
export underline="[4m"
export inverse="[7m"

# Foreground Colors
export black="[30m"
export red="[31m"
export green="[32m"
export yellow="[33m"
export blue="[34m"
export magenta="[35m"
export cyan="[36m"
export white="[37m"

# Background Colors
export bg_black="[40m"
export bg_red="[41m"
export bg_green="[42m"
export bg_yellow="[43m"
export bg_blue="[44m"
export bg_magenta="[45m"
export bg_cyan="[46m"
export bg_white="[47m"

# Foreground Colors (Bright)
export Black="[90m"
export Red="[91m"
export Green="[92m"
export Yellow="[93m"
export Blue="[94m"
export Magenta="[95m"
export Cyan="[96m"
export White="[97m"

# Background Colors (Bright)
export BG_Black="[100m"
export BG_Red="[101m"
export BG_Green="[102m"
export BG_Yellow="[103m"
export BG_Blue="[104m"
export BG_Magenta="[105m"
export BG_Cyan="[106m"
export BG_White="[107m"


###############################################
# dk_color()
#
#
#
dk_color() {
	dk_debugFunc
}





DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_color
}