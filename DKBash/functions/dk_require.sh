#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

arrayAsArg() {
	dk_debugFunc 3
	
	local arg1=${1}
	echo "arg1 = ${arg1}"
	
	local args=("${!2}")
	echo "args = ${args[@]}"
	
	local arg3=${3}
	echo "arg3 = ${arg3}"
}

checkFunc() {
	dk_debugFunc 0
	
	args=("${@}")
	for ((i=0; i < ${#args[@]}; i++ )); do 
		dk_debug "args[$i] = ${args[$i]}";
	done
	
	A_START=0
	C_END=${#args[@]}
	
	for i in "${!args[@]}"; do
		[ ${i} -eq 0 ]           && A_END=$(( ${args[i]} + i + 1)) && continue
		[ ${i} -lt ${A_END} ]    && A_args+=("${args[i]}")         && continue
		[ ${i} -eq ${A_END} ]    && B_END=$(( ${args[i]} + i + 1)) && continue
		[ ${i} -lt ${B_END} ]    && B_args+=("${args[i]}")         && continue
		[ ${i} -lt ${C_END} ]    && C_args+=("${args[i]}")         && continue 
	done
	
	#echo "A_END = ${A_END}"
	echo "A_size = ${#A_args[@]}"
	echo "A_args = ${A_args[@]}"
	
	#echo "B_END = ${B_END}"
	echo "B_size = ${#B_args[@]}"
	echo "B_args = ${B_args[@]}"
	
	#echo "C_END = ${C_END}"
	echo "C_size = ${#C_args[@]}"
	echo "C_args = ${C_args[@]}"
	return 
	
#	# clean up the gaps in the array
#	for i in "${!args[@]}"; do
#		new_array+=( "${args[i]}" )
#	done
#	args=("${new_array[@]}")
#	unset new_array
}

##################################################################################
# dk_require()
#
#
#alias dk_require='checkFunc ${FUNCNAME} ${#} "${@}"'
#alias dk_require='checkFunc 3 A1 A2 A3 ${#} "${@}"' 
alias dk_require='
	args=(${@}) 
	arrayAsArg "firstArg" args[@] "lastArg"
'