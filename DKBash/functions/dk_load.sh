#include_guard()
echo "entry($@)"


export DKBASH_DIR=$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )
##################################################################################
# dk_load()
#
#
#
dk_load () {
	echo "dk_load($1)"
	[ -z $@ ] && return 0 #true
	
	if [ -f "$1" ]; then
		fpath=$1
		fn=$(basename ${fpath})
		fn="${fn%.*}"
	else
		fn=$1
		fpath=$DKBASH_DIR/functions/$fn.sh
	fi
	
	# Convert to unix line endings if CRLF found
	if [[ $(file -b - < $fpath) =~ CRLF ]]; then
		echo Converting file to Unix line endings
		sed -i -e 's/\r$//' $fpath
	fi
	
	dk_parseFunctionsAndLoad $fn $fpath
	#return 0 #true
}

dk_parseFunctionsAndLoad () {
	echo "dk_parseFunctionsAndLoad($1, $2)"
	fn=$1
	fpath=$2
	
	if [ -f "$DKBASH_DIR/functions/$fpath.sh" ]; then
		declare ${fn}_file="$DKBASH_DIR/functions/$fpath.sh"
	elif [ -f $fpath ]; then
		declare ${fn}_file=$fpath
    else
        dk_error "$fpath: file not found"
    fi
    #elif [ -f $ENV_DKBASH_DIR_/functions/$fpath.cmake ]; then
    #	set(${fn}_file $ENV_DKBASH_DIR_/functions/$fpath.sh
    #	dk_error "$fpath: file not found"
    #fi
	
    fn_file=${fn}_file
    #echo ""
    #echo fn_file = ${!fn_file}
	
    if [[ $dk_load_list =~ "$fn_file" ]]; then
        #echo "already in the list" 	# if allready in list, do nothing
        return 0
    else
        dk_load_list="${dk_load_list};$fn_file" # Add to list

        targets=($(grep -o "[Dd][Kk]_.[A-Za-z0-9_\t] " ${!fn_file}))
		
        for value in "${targets[@]}"
        do
            value=${value::-1}
			echo $value
				
            if [[ $dk_load_list =~ "$value" ]]; then
               echo "skipping $value.    already in load_list"
            elif [[ $fn_file == ${fn} ]]; then
               echo "skipping $value.    already matches fn"
            elif [[ $(command -v $value) != "" ]]; then
               echo "skipping $value.    command already recognized"
            else
               echo "loading $value"
               dk_load $value
            fi
        done
		
		if [ -f "${!fn_file}" ]; then
			echo "include(${!fn_file})"
			. "${!fn_file}"
		fi
    fi
}

dk_load "$@"