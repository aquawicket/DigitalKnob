#!/bin/sh

takes_ary_as_arg() {
	declare -a arg1_array=("${!1}")
	echo ""
	echo "arg1_array = ${arg1_array[@]}"
	echo "arg1_array size = ${#arg1_array[@]}"
	
	local arg2_array=("${!2}")
    echo ""
	echo "arg2_array = ${arg2_array[@]}"
	echo "arg2_array size = ${#arg2_array[@]}"
	
	local output_array=(
        "This"
        "is"
        "a"
		"returned"
        "array"
    )
	
	eval "$3=(${output_array[@]})"
}


main() {
	local myArry1=(
        "This"
        "is"
        "array"
        "1"
    )
	
	local myArry2=(
        "And"
        "this"
        "is"
		"the" 
		"second"
        "array"
    )
	
	takes_ary_as_arg myArry1[@] myArry2[@] return_array
	
	echo ""
	echo "return_array = ${return_array[@]}"
	echo "return_array size = ${#return_array[@]}"
	
	echo ""
	read -rp 'press enter to exit' 
}

main