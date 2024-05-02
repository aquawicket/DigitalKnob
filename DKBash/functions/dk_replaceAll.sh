#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
#dk_includeGuard


##################################################################################
# dk_replaceAll("input" "searchValue" "newValue" <output_variable>)
#
#
dk_replaceAll () {
	dk_debugFunc
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
	
	#dk_debug "output = '$output'"
	eval "$4=$output"
}



################################ DKTEST #########################################
[ -n "$DKTEST" ] && {


	string_var="AZC AZC Zannana Zread"
	echo "string before:  $string_var"
	
	dk_replaceAll "$string_var" "Z" "B" string_var
	
	echo "string after:  $string_var"
	


} && exec $SHELL