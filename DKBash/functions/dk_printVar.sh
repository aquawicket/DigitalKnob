#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# dk_printVar(<variable>)
#
#
dk_printVar() {
	dk_debugFunc
	[ $# -ne 1 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	varname=$1
	
	# https://github.com/flang-compiler/f18-llvm-project/issues/1344
	# https://unix.stackexchange.com/a/66009
	#if $(declare -n); then
		#declare -n _reference_=$1
		#if ! declaration="$(declare -p ${!_reference_} 2> /dev/null)"; then
		#	declaration=$1
		#fi	
	if (typeset -n 2>/dev/null); then
		typeset -n _reference_=$1
		if ! declaration="$(typeset -p ${!_reference_} 2> /dev/null)"; then
			declaration=$1
		fi
		#echo "declaration = $declaration"
		
		# IS VARIABLE
		if [[ $declaration == "declare -- "* ]]; then
			dk_echo "${Blue-}VARIABLE:\$${!_reference_} =${blue-} '$_reference_'${clr-}"
			return 0
		fi
			
		# IS ARRAY
		if [[ $declaration =~ "declare -a "* ]]; then
			for ((i=0; i < ${#_reference_[@]}; i++ )); do 
				dk_echo "${Blue-}ARRAY:\$${!_reference_}[$i] =${blue-} '${_reference_[$i]}'${clr-}";
			done
			return 0
		fi
			
		# IS ASSOCIATIVE_ARRAY
		if [[ $declaration =~ "declare -A "* ]]; then
			# https://stackoverflow.com/a/59991764												
			# printf "%s\n" "${!_reference_[@]}"												# print all keys separated by a newline
			# printf "%s\n" "${_reference_[@]}"													# print all values separated by a newline
			# paste <(cmd1) <(cmd2)																# merge output of cmd1 and cmd2 line by line (below)
			printf "${Blue-}"
			
			# FIXME: parsing error on OSX zsh
			#paste <(printf "ASSOCIATIVE_ARRAY:\$$1[%s] = \n" "${!_reference_[@]}") <(printf "%s\n" "${_reference_[@]}")
			printf "${clr-}"
			return 0
		fi
			
		# IS FUNCTION
		if [[ $declaration =~ "declare -f "* ]]; then
			_value=$(type $varname | sed '1,1d')
			dk_echo "${Blue-}FUNCTION:\$$varname =${blue-} '${_value}'${clr-}"
			return 0
		fi
			
		# IS INT
		if [[ $declaration =~ "declare -i "* ]]; then
			dk_echo "${Blue-}INT:\$${!_reference_} =${blue-} '$_reference_'${clr-}"
			return 0
		fi
			
		# IS LOWERCASE
		if [[ $declaration =~ "declare -l "* ]]; then
			dk_echo "${Blue-}LOWERCASE:\$${!_reference_} =${blue-} '$_reference_'${clr-}"
			return 0
		fi
			
		# IS REFERENCE
		if [[ $declaration =~ "declare -n "* ]]; then
			dk_echo "${Blue-}REFERENCE:\$${!_reference_} =${blue-} '$_reference_'${clr-}"
			return 0
		fi
			
		# IS READ_ONLY
		if [[ $declaration =~ "declare -r "* ]]; then
			dk_echo "${Blue-}READ_ONLY:\$${!_reference_} =${blue-} '$_reference_'${clr-}"
			return 0
		fi
			
		# IS TRACE
		if [[ $declaration =~ "declare -t "* ]]; then
			dk_echo "${Blue-}TRACE:\$${!_reference_} =${blue-} '$_reference_'${clr-}"
			return 0
		fi
			
		# IS UPPERCASE
		if [[ $declaration =~ "declare -u "* ]]; then
			dk_echo "${Blue-}UPPERCASE:\$${!_reference_} =${blue-} '$_reference_'${clr-}"
			return 0
		fi
			
		# IS EXPORT
		if [[ $declaration =~ "declare -x "* ]]; then
			dk_echo "${Blue-}EXPORT:\$${!_reference_} =${blue-} '$_reference_'${clr-}"
			return 0
		fi
	fi
	
	# IS VARIABLE
	if [ -n "${!varname+x}" ]; then
		dk_echo "${Blue-}VARIABLE:\$$varname =${blue-} '${!varname}'${clr-}"
		return 0
	fi
	
	# IS FUNCTION
	if [ "$(type -t ${varname})" = "function" ]; then
		_value=$(type $varname | sed '1,1d')
		dk_echo "${Blue-}FUNCTION:\$$varname =${blue-} '${_value}'${clr-}"
		return 0
	fi

	# IS ALIAS
	if [ "$(type -t ${varname})" = "alias" ]; then	
		_value=$(alias $varname)
		_value=${_value#*=}
		dk_echo "${Blue-}ALIAS:\$$varname =${blue-} '${_value}'${clr-}"
		return 0
	fi
		
	dk_echo "${Blue-}$1 =${red} UNDEFINED${clr-}"
}




DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	myVariable="this is the value of myVariable"
	dk_printVar myVariable
	
	myArray[0]="myArray element 0"
	myArray[1]="myArray element 1"
	myArray[2]="myArray element 2"
	dk_printVar myArray
	
	export myExport="an export variable"
	dk_printVar myExport
	
	local myLocal="a local variable"
	dk_printVar myLocal
	
	declare -A myHash=( ["indexA"]="this is indexA" ["indexB"]="this is indexB")
	dk_printVar myHash

	myFunction () {
		echo "myFunction body"
	}
	dk_printVar myFunction
	
	alias myAlias='{
		echo "This is an alias"
	}'
	dk_printVar myAlias
	
	#myUndefined="" #this variable is undefined
	dk_printVar myUndefined

}