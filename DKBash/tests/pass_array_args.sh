#!/bin/sh

# https://stackoverflow.com/a/4017175

takes_array(){
	eval local arg1=('${'$1'[@]}')
	
	echo ""
	echo "array name = $1"
	echo "$1[@] = ${arg1[@]}"
	for ((i=0; i < ${#arg1[@]}; i++)); do echo "$1[$i] = ${arg1[$i]}"; done
	echo "$1 size = ${#arg1[@]}"
}

returns_array(){
	local rtn1=("1" "2" "3" "4")
	eval $1="(${rtn1[@]})"
}



main (){
	local array1=("a" "b" "c" "d")
	takes_array array1
	
	
	local array2=()
	returns_array array2
	echo ""
	echo "array name = array2"
	echo "array2[@] = ${array2[@]}"
	for ((i=0; i < ${#array2[@]}; i++)); do echo "array2[$i] = ${array2[$i]}"; done
	echo "array2 size = ${#array2[@]}"
	
	
	echo ""
	read -rp 'press enter to exit' 
}
main