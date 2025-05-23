#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_printVar(variable)
#
#
dk_printVar() {
	dk_debugFunc 1
	#[ -z ${dk_printVar-} ] && dk_printVar=1
	#( ${dk_printVar} eq 1 ) || return 0
	
	[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
	
	varname=${1}
	
	# https://github.com/flang-compiler/f18-llvm-project/issues/1344
	# https://unix.stackexchange.com/a/66009
	#if $(declare -n); then
		#declare -n _reference_=${1}
		#if ! declaration="$(declare -p ${!_reference_} 2>/dev/null)"; then
		#	declaration=${1}
		#fi	
	if (typeset -n > /dev/null 2>&1); then
		typeset -n _reference_=${1}
		if ! declaration="$(typeset -p ${!_reference_} 2>/dev/null)"; then
			declaration=${1}
		fi
		#echo "declaration = $declaration"
		
		# IS VARIABLE
		if [[ $declaration == "declare -- "* ]]; then
			[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
			dk_call dk_echo "${cyan-}VARIABLE:${!_reference_} =${blue-} '$_reference_'${clr-}"
			return 0
		fi
			
		# IS ARRAY
		if [[ $declaration =~ "declare -a "* ]]; then
			for ((i=0; i < ${#_reference_[@]}; i++ )); do
				[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
				dk_echo "${cyan-}ARRAY:${!_reference_}[$i] =${blue-} '${_reference_[$i]}'${clr-}";
			done
			return 0
		fi
			
		# IS ASSOCIATIVE_ARRAY
		if [[ $declaration =~ "declare -A "* ]]; then
			# https://stackoverflow.com/a/59991764												
			# printf "%s\n" "${!_reference_[@]}"												# print all keys separated by a newline
			# printf "%s\n" "${_reference_[@]}"													# print all values separated by a newline
			# paste <(cmd1) <(cmd2)																# merge output of cmd1 and cmd2 line by line (below)
			printf "${cyan-}"
			
			# FIXME: parsing error on OSX zsh
			#paste <(printf "ASSOCIATIVE_ARRAY:\$${1}[%s] = \n" "${!_reference_[@]}") <(printf "%s\n" "${_reference_[@]}")
			printf "${clr-}"
			return 0
		fi
			
		# IS FUNCTION
		if [[ $declaration =~ "declare -f "* ]]; then
			_value=$(type $varname | sed '1,1d')
			[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
			dk_echo "${cyan-}FUNCTION:$varname =${blue-} '${_value}'${clr-}"
			return 0
		fi
			
		# IS INT
		if [[ $declaration =~ "declare -i "* ]]; then
			[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
			dk_echo "${cyan-}INT:${!_reference_} =${blue-} '$_reference_'${clr-}"
			return 0
		fi
			
		# IS LOWERCASE
		if [[ $declaration =~ "declare -l "* ]]; then
			[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
			dk_echo "${cyan-}LOWERCASE:${!_reference_} =${blue-} '$_reference_'${clr-}"
			return 0
		fi
			
		# IS REFERENCE
		if [[ $declaration =~ "declare -n "* ]]; then
			[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
			dk_echo "${cyan-}REFERENCE:${!_reference_} =${blue-} '$_reference_'${clr-}"
			return 0
		fi
			
		# IS READ_ONLY
		if [[ $declaration =~ "declare -r "* ]]; then
			[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
			dk_echo "${cyan-}READ_ONLY:${!_reference_} =${blue-} '$_reference_'${clr-}"
			return 0
		fi
			
		# IS TRACE
		if [[ $declaration =~ "declare -t "* ]]; then
			[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
			dk_echo "${cyan-}TRACE:${!_reference_} =${blue-} '$_reference_'${clr-}"
			return 0
		fi
			
		# IS UPPERCASE
		if [[ $declaration =~ "declare -u "* ]]; then
			[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
			dk_echo "${cyan-}UPPERCASE:${!_reference_} =${blue-} '$_reference_'${clr-}"
			return 0
		fi
			
		# IS EXPORT
		if [[ $declaration =~ "declare -x "* ]]; then
			[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
			dk_echo "${cyan-}EXPORT:${!_reference_} =${blue-} '$_reference_'${clr-}"
			return 0
		fi
	fi
	
	# IS VARIABLE
	if [ -n "${!varname+x}" ]; then
		[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
		dk_echo "${cyan-}VARIABLE:$varname =${blue-} '${!varname}'${clr-}"
		return 0
	fi
	
	# IS FUNCTION
	if [ "$(type -t ${varname})" = "function" ]; then
		_value=$(type $varname | sed '1,1d')
		[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
		dk_echo "${cyan-}FUNCTION:$varname =${blue-} '${_value}'${clr-}"
		return 0
	fi

	# IS ALIAS
	if [ "$(type -t ${varname})" = "alias" ]; then	
		_value=$(alias $varname)
		_value=${_value#*=}
		[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
		dk_echo "${cyan-}ALIAS:$varname =${blue-} '${_value}'${clr-}"
		return 0
	fi
	
	[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
	dk_echo "${cyan-}${1} =${red} UNDEFINED${clr-}"
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_set myVariable "this is the value of myVariable"
	dk_printVar myVariable
	
	myArray[0]="myArray element 0"
	myArray[1]="myArray element 1"
	myArray[2]="myArray element 2"
	dk_printVar myArray
	
	dk_export myExport "an export variable"
	dk_printVar myExport
	
	local myLocal="a local variable"
	dk_printVar myLocal
	
	declare -A myHash=( ["indexA"]="this is indexA" ["indexB"]="this is indexB")
	dk_printVar myHash

	myFunction() {
		dk_echo "myFunction body"
	}
	dk_printVar myFunction
	
	alias myAlias='{
		dk_echo "This is an alias"
	}'
	dk_printVar myAlias
	
	#myUndefined="" #this variable is undefined
	dk_printVar myUndefined
}
