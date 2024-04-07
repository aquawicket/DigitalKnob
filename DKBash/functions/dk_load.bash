#[ -n "$dk_load" ] && return || readonly dk_load=1     # dk_include_guard()
echo "dk_load.bash"

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
		fpath=${DKBASH_DIR}/functions/$fn.sh
	fi
	
	# Convert to unix line endings if CRLF found
	#if file_exists $fpath; then
		#if [[ $(file -b - < $fpath) =~ CRLF ]]; then		# BASH REGEX MATCH
		if echo $(file -b - < $fpath) | grep -q CRLF; then	# POSIX REGEX MATCH
			echo Converting file to Unix line endings
			sed -i -e 's/\r$//' $fpath
		fi
	#fi
	
	if [ -f $fpath ]; then
		#declare ${fn}=$fpath
		local ${fn}=$fpath
    else
        echo "$fpath: file not found"
    fi
	
	#if [[ $dk_load_list =~ "$fn" ]]; then			# BASH REGEX MATCH
	if echo $dk_load_list | grep -q "$fn"; then		# POSIX REGEX MATCH
        echo "$fn: already in the list" 	# if already in list, do nothing
        return 0
    else
		dk_load_list="${dk_load_list};$fn" # Add to list
		
		if [ $DKBASH ]; then
			#echo "USING BASH ARRAYS"
			oldIFS=$IFS
			IFS=$'\n'
			lines=( $(grep -E "(dk|DK)_[a-zA-Z0-9]*" $fpath) )
			#IFS=$'\n' read -r -d '' -a lines < <( echo "$(grep -E "(dk|DK)_[a-zA-Z0-9]*" $fpath)" && printf '\0' )
			IFS=$oldIFS
			for value in "${lines[@]}"; do
				#value=${value%%N*}   # cut off everything from the first N to end
				#value=${value%N*}   # cut off everything from the last N to end
				#value=${value#*N}   # cut off everything from begining to first N
				#value=${value##*N}   # cut off everything from begining to last N
				
				value=${value%%#*}
				[[ $value =~ [Dd][Kk]_[A-Za-z0-9_]* ]]						# BASH REGEX MATCH
				value=${BASH_REMATCH[0]}									# BASH REGEX VALUE
				#value=$(echo "$value" | grep -o "[Dd][Kk]_[A-Za-z0-9_]*")	# POSIX REGEX MATCH
				[ "$value" == "" ] && continue
				echo "${fn}:lines '$value'"
				
				if [[ $dk_load_list =~ "$value" ]]; then		# BASH REGEX MATCH
				#if echo $dk_load_list | grep -q "$value"; then	# POSIX REGEX MATCH
				  #echo "${fn}: skipping $value.    already in load_list"
					continue
				elif [[ ${fn} == $value ]]; then
				   #echo "${fn}: skipping $value.    already matches fn"
				   continue
				elif [[ $(command -v $value) != "" ]]; then
				   #echo "${fn}: skipping $value.    command already recognized"
				   continue
				elif [[ "$value" == "" ]]; then
				   continue
				else
				   #echo "$fn: dk_load( $value )"
				   dk_load $value
				fi
			done

: '	
			funcs=($(grep -o "[Dd][Kk]_.[A-Za-z0-9_\t]*" ${!fn}))
			#for funcs_value in "${funcs[@]}"
			#do
			#	echo "${fn}:funcs $funcs_value"
			#done
			
			targets=($(printf "%s\n" "${funcs[@]}" | sort -u));
			for value in "${targets[@]}"
			do
				echo "${fn}:targets $value"
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
'		
		elif [ $DKSH ]; then
			#echo "USING POSIX ARRAYS"
			
			# https://stackoverflow.com/a/26144107/688352
			shopt -s lastpipe
			
			oldIFS=$IFS
			IFS=$'\n' 
			lines=$(array $(grep -E "(dk|DK)_[a-zA-Z0-9]*" $fpath))
			IFS=$oldIFS
			printf_lines=$(printf '%s\n' "$lines")
			#echo "$printf_lines" | while read value; do 
			while read value; do 
				#value=${value%%N*}   # cut off everything from the first N to end
				#value=${value%N*}   # cut off everything from the last N to end
				#value=${value#*N}   # cut off everything from begining to first N
				#value=${value##*N}   # cut off everything from begining to last N

				value=${value%%#*}
				#[[ $value =~ [Dd][Kk]_[A-Za-z0-9_]* ]]						# BASH REGEX MATCH
				#value=${BASH_REMATCH[0]}									# BASH REGEX VALUE
				value=$(echo "$value" | grep -o "[Dd][Kk]_[A-Za-z0-9_]*")	# POSIX REGEX MATCH
				[ "$value" == "" ] && continue
				echo "${fn}:lines $value"
				
				#if [[ $dk_load_list =~ "$value" ]]; then					# BASH REGEX MATCH
				if echo $dk_load_list | grep -q "$value"; then				# POSIX REGEX MATCH
                    #echo "${fn}: skipping $value.    already in load_list"
					continue
				elif [[ ${fn} == $value ]]; then
                    #echo "${fn}: skipping $value.    already matches fn"
                    continue
				elif [[ $(command -v $value) != "" ]]; then
                    #echo "${fn}: skipping $value.    command already recognized"
                    continue
				elif [[ "$value" == "" ]]; then
                    continue
				else
                    #echo "$fn: dk_load( $value )"
                    dk_load $value
				fi
			#done
			done < echo "$printf_lines"
		fi
		
		if [ -f "${!fn}" ]; then
			#echo "{@}: ${@}"
			#echo "{fn}: ${!fn}"
			if ! [ $@ == ${!fn} ]; then
				echo "$fn: source ${!fn}"
				. "${!fn}"
			fi
			#return 0
		fi	
	fi
}

dk_load "$0"