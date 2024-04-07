#[ -n "$dk_load" ] && return || readonly dk_load=1     # dk_include_guard()
echo "dk_load.sh"

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
		fpath=${DKBASH_DIR}/functions/${fn}.sh
	fi
	
	# Convert to unix line endings if CRLF found
	#if file_exists $fpath; then
		if echo $(file -b - < $fpath) | grep -q CRLF; then	# POSIX REGEX MATCH
			echo Converting file to Unix line endings
			sed -i -e 's/\r$//' $fpath
		fi
	#fi
	
	if [ -f ${fpath} ]; then
		#declare ${fn}=$fpath
		local ${fn}=${fpath}
    else
        echo "$fpath: file not found"
		exit
    fi
	
	if echo $dk_load_list | grep -q "${fn}"; then		# POSIX REGEX MATCH
        echo "$fn: already in the list" 	# if already in list, do nothing
        return 0
    else
		dk_load_list="${dk_load_list};${fn}" # Add to list
		
		# https://stackoverflow.com/a/26144107/688352
		#set +m
		#shopt -s lastpipe
			
		oldIFS=$IFS
		IFS=$'\n'
		grep_raw=$(grep "dk_[a-zA-Z0-9]*" $fpath)
		
		echo $grep_raw
		#exit
		
		lines=$(array $grep_raw)
		IFS=$oldIFS
		echo $lines
		#exit
		
		#printf_lines=$(printf '%s\n' "$lines")
		#echo $printf_lines
		#exit
		
        #printf '%s\n' "$lines" | while read value; do 
        while IFS= read value; do 
            #value=${value%%N*}   # cut off everything from the first N to end
			#value=${value%N*}   # cut off everything from the last N to end
			#value=${value#*N}   # cut off everything from begining to first N
			#value=${value##*N}   # cut off everything from begining to last N

			value=${value%%#*}
			value=$(echo "$value" | grep -o "[Dd][Kk]_[A-Za-z0-9_]*")	# POSIX REGEX MATCH
			[ "${value}" = "" ] && continue
			echo "${fn}:lines $value"
				
			if echo $dk_load_list | grep -q "$value"; then				# POSIX REGEX MATCH
			    #echo "${fn}: skipping $value.    already in load_list"
			    continue
			#elif [[ ${fn} == $value ]]; then
			elif [ "${fn}" = "${value}" ]; then
			    #echo "${fn}: skipping $value.    already matches fn"
			    continue
 			#elif [[ $(command -v $value) != "" ]]; then
			elif [ "$(command -v $value)" != "" ]; then
			    #echo "${fn}: skipping $value.    command already recognized"
			    continue
			#elif [[ "$value" == "" ]]; then
			elif [ "$value" = "" ]; then
			    continue
			else
			    #echo "$fn: dk_load( $value )"
			    dk_load $value
			fi
		#done
		#done <<< "$printf_lines"
		done <<EOF
"$lines"
EOF
		
		if [ -f "${fpath}" ]; then
			if [ "$@" = "${fpath}" ]; then
				return 0
			fi
				echo "${fn}: source ${fpath}"
				. "${fpath}"
			#return 0
		fi	
	fi
}

dk_load "$0"