# dk_include_guard()

##################################################################################
# dk_replace_all(<input> <searchValue> <newValue> <output>)
#
#
dk_replace_all() {
    input=$1
	searchValue=$2
	newValue=$3
    output=
		
    while [ -n "$input" ]; do
        LEFT=${input%%$searchValue*}

        if [ "$LEFT" = "$input" ]; then
            output=$output$input
			break
        fi

        output=$output$LEFT$newValue
        input=${input#*$searchValue}
    done
	
	echo "output = '$output'"
	eval "$4=$output"
}