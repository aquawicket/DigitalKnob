#include_guard()

##################################################################################
# dk_print_var(variable)
#
#
dk_print_var () {
	if [ -z "$1" ]; then
		dk_error "print_var <variable> requires 1 parameter"
		return $false
	fi
	
	var_name=$1
	exists=0
	
	if [[ $(type -t $1) == function ]]; then
		dk_debug "${blue} \$$var_name = function $1() ${CLR}"
		func=$(type $1 | sed '1,2d')
		dk_debug "${blue} $func ${CLR}"
		exists=1;
	fi
		
	if ! [ -v $1 ]; then
		if [ $exists -eq 1 ]; then
			return $true
		fi
			
		dk_error "${red} \$$1 is not set ${CLR}"
		return $false
	fi
		
	if $(declare -p $1 2> /dev/null | grep -q '^declare \-a'); then	
		declare -n arr="$1"
		for ((i=0; i < ${#arr[@]}; i++ )); do 
			dk_debug "${blue} \$$var_name[$i] = ${arr[$i]} ${CLR}";
		done
	else
		arr=$1
		dk_debug "${blue} \$$arr = ${!arr} ${CLR}"
	fi
}