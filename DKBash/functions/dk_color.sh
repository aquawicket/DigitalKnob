#include_guard()

export clr="\033[0m"
export black="\033[100m"
export red="\033[31m"
export green="\033[32m"
export yellow="\033[33m"
export blue="\033[34m"
export magenta="\033[35m"
export cyan="\033[36m"
export white="\033[37m"
export current_color=$clr
export previous_color=$clr

##################################################################################
# dk_color()
#
#
#
dk_color () {
	echo "dk_color($@)"
	#export previous_color=$current_color
	#export current_color=$1
	#$echo "$current_color $2 $clr"
	return 0 #true
}
