#!/bin/sh
#. ./DK.sh
dk_includeGuard

##################################################################################
# dk_printVar(variable)
#
#
dk_printVar() {
	dk_debugFunc
	[ -z "$1" ] && dk_error "dk_printVar <variable> requires 1 parameter"
	
	var_name=$1
	exists=0
	
	if [ "$(type -t $1)" = "function" ]; then
		dk_debug "${blue} \$$var_name = function $1() ${clr}"
		func=$(type $1 | sed '1,2d')
		dk_debug "${blue} $func ${clr}"
		exists=1;
	fi
		
	if ! [ -v $1 ]; then
		if [ $exists -eq 1 ]; then
			return $true
		fi
			
		dk_warning "${red} \$$1 is not set ${clr}"
		return $false
	fi
		
	if $(declare -p $1 2> /dev/null | grep -q '^declare \-a'); then	
		declare -n arr="$1"
		for ((i=0; i < ${#arr[@]}; i++ )); do 
			dk_debug "${blue} \$$var_name[$i] = ${arr[$i]} ${clr}";
		done
	else
		arr=$1
		dk_debug "${blue} \$$arr = ${!arr} ${clr}"
	fi
}