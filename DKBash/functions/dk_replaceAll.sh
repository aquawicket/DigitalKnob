# dk_includeGuard()

##################################################################################
# dk_replaceAll(<input> <searchValue> <newValue> <output>)
#
#
dk_replaceAll () {
	dk_verbose "dk_replaceAll($*)"
	[ $# -ne 4 ] && dk_error "Incorrect number of parameters"
	
    input=$1
	searchValue=$2
	newValue=$3
    output=
		
    while [ -n "$input" ]; do
        LEFT=${input%%"$searchValue"*}

        if [ "$LEFT" = "$input" ]; then
            output=$output$input
			break
        fi

        output=$output$LEFT$newValue
        input=${input#*"$searchValue"}
    done
	
	dk_debug "output = '$output'"
	eval "$4=$output"
}