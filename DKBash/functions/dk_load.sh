[ -n "$dk_load" ] && return || readonly dk_load=1     #include_guard()

#echo "entry($0)"


export DKBASH_DIR=$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )
##################################################################################
# dk_load()
#
#
#
dk_load () {
	#echo "dk_load($@)"
	local fn=
	[ -z $1 ] && return 0 #true
	
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
	
	if [ -f $fpath ]; then
		declare ${fn}=$fpath
    else
        echo "$fpath: file not found"
    fi
	
	if [[ $dk_load_list =~ "$fn" ]]; then
        echo "$fn: already in the list" 	# if allready in list, do nothing
        return 0
    else
		dk_load_list="${dk_load_list};$fn" # Add to list

		funcs=($(grep -o "[Dd][Kk]_.[A-Za-z0-9_\t]* " ${!fn}))
		targets=($(printf "%s\n" "${funcs[@]}" | sort -u));
        for value in "${targets[@]}"
        do
			#echo "${fn}: $value"
            if [[ $dk_load_list =~ "$value" ]]; then
                #echo "${fn}: skipping $value.    already in load_list"
				continue
            elif [[ ${fn} == $value ]]; then
			   #echo "${fn}: skipping $value.    already matches fn"
			   continue
            elif [[ $(command -v $value) != "" ]]; then
			   #echo "${fn}: skipping $value.    command already recognized"
			   continue
            else
               #echo "$fn: dk_load( $value )"
               dk_load $value
            fi
        done
		
		if [ -f "${!fn}" ]; then
			#echo "source $fn"
			echo "$fn: include(${!fn})"
			source "${!fn}" || echo "SOURCE_LOAD_ERROR"
			return 0
		fi
    fi
	
	
}

#dk_load "$@"
dk_load "$0"