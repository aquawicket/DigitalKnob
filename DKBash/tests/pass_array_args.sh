#!/bin/sh

# https://stackoverflow.com/a/4017175

is_array(){
	if [[ "$(declare -p ${1})" =~ "declare -a" ]]; then
		echo ${1} is an array
		return $(true)
	fi
	echo ${1} is NOT an array
	return $(false)
}

takes_array(){
	#eval local arg1=('${'$1'[@]}')
	typeset -n arg1=${1}

	echo "array name = $1"
	echo "$1[@] = ${arg1[@]}"
	for ((i=0; i < ${#arg1[@]}; i++)); do echo "$1[$i] = ${arg1[$i]}"; done
	echo "$1 size = ${#arg1[@]}"
}

returns_array(){
	local rtn1=("1" "2" "3" "4")
	
	eval $1="(${rtn1[@]})"
	#typeset -n ${1}=rtn1   # Does NOT work
}



main (){
	local array1=("a" "b" "c" "d")
	echo ""
	is_array array1
	takes_array array1
	
	
	local array2=()
	returns_array array2
	echo ""
	is_array array2
	echo "array name = array2"
	echo "array2[@] = ${array2[@]}"
	for ((i=0; i < ${#array2[@]}; i++)); do echo "array2[$i] = ${array2[$i]}"; done
	echo "array2 size = ${#array2[@]}"
	
	local array3="string variable"
	echo ""
	is_array array3
	
	
	echo ""
	read -rp 'press enter to exit' 
}
main