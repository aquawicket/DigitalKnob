#!/bin/sh
#[ -n "${HAVE_dk_load}" ] && return || readonly HAVE_dk_load=1
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_load()
#
#
dk_load() {
	dk_debugFunc
	[ $# -ne 1 ] && echo "${FUNCNAME}(): incorrect number of arguments" && return 1
	[ "$1" = "dk_depend" ] && return 0  #FIXME: need to better handle non-existant files
	

	local fn=	
	if [ -e "$1" ]; then
		fpath=$(cd $(dirname $1); pwd -P)/$(basename $1)
		fn=$(basename ${fpath})
	    fn="${fn%.*}"
	else
		fn="$1"
		fn=$(basename ${fn})
		fpath=${DKBASH_DIR}/functions/${fn}.sh
	fi
	
	#### download if missing ####
	[ ! -e ${fpath} ] && echo "Dowloading ${fn}"
	[ ! -e ${fpath} ] && curl -Lo ${DKBASH_DIR}/functions/${fn}.sh https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBash/functions/${fn}.sh
	[ ! -e ${fpath} ] && wget -P ${DKBASH_DIR}/functions https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBash/functions/${fn}.sh
	
	[ ! -e ${fpath} ] && echo "ERROR: ${fpath}: file not found" && return
	
	# Convert to unix line endings if CRLF found
	#if [ -e ${fpath}]; then
		#if [[ $(file -b - < ${fpath}) =~ CRLF ]]; then		# BASH REGEX MATCH
		if builtin echo $(file -b - < ${fpath}) | grep -q CRLF; then	# POSIX REGEX MATCH
			echo "Converting file to Unix line endings"
			sed -i -e 's/\r$//' ${fpath}
		fi
	#fi
	
	if [ -f ${fpath} ]; then
		local ${fn}=${fpath}
    else
        echo "${fpath}: file not found"
		return 0
		#1
    fi

	#dkload_list="init_dkload_list"
	if ! [[ "${dkload_list-}" =~ ";${fn};" ]]; then			# BASH REGEX MATCH
	#if echo "${dkload_list}" | grep -q ";${fn};"; then
		dkload_list="${dkload_list-};${fn};" 			# Add to list
		#echo "added ${fn} to dkload_list"
		
		oldIFS=${IFS}
		IFS=$'\n'
		lines=( $(grep -E "(dk|DK)_[a-zA-Z0-9]*" ${fpath}) ); true # || true; #return 0
		#IFS=$'\n' read -r -d '' -a lines < <( echo "$(grep -E "(dk|DK)_[a-zA-Z0-9]*" ${fpath})" && printf '\0' )
		IFS=${oldIFS}
		for value in "${lines[@]}"; do
			#value=${value%%N*}   # cut off everything from the first N to end
			#value=${value%N*}    # cut off everything from the last N to end
			#value=${value#*N}    # cut off everything from begining to first N
			#value=${value##*N}   # cut off everything from begining to last N
				
			value=${value//'$#'/}					    # remove any $# before removing #comments
			value=${value%%#*}						    # remove everything after # (comments)
			if ! [[ "${value}" =~ [Dd][Kk]_[A-Za-z0-9_]* ]];then  continue; fi	# BASH REGEX MATCH
			value=${BASH_REMATCH[0]}				    	# BASH REGEX VALUE
#			for i in "${!BASH_REMATCH[@]}"; do
#				echo "$i: ${BASH_REMATCH[${i}]}"
#			done
			
			#value=$(echo "${value}" | grep -o "[Dd][Kk]_[A-Za-z0-9_]*" | head -1)	# POSIX REGEX MATCH
			#[ -z "${value}" ] && continue

			if [[ ${dkload_list} =~ ";${value};" ]]; then			# BASH REGEX MATCH
			#if echo ${dkload_list} | grep -q "${value};"; then	# POSIX REGEX MATCH
				#echo "${fn}: skipping ${value}.    already in load_list"
				continue
			elif [ ${fn} = ${value} ]; then
				#echo "${fn}: skipping ${value}.    already matches fn"
				continue
			# FIXME: this messes things up 
			#elif ! [ $(command -v ${value}) = "" ]; then
				#echo "${fn}: skipping ${value}.    command already recognized"
				#continue
			elif [ "${value}" = "" ]; then
				#echo "${fn}: skipping ${value}.    empty"
				continue
			else
				dk_load ${value}
			fi
		done

		#echo "fn = ${fn}"
		#echo "!fn = ${!fn}"
		#echo "fpath = ${fpath}"
		if [ -f "${!fn}" ]; then
			#if ! [ "${@}" = "${!fn}" ]; then
				. "${!fn}"
			
				#echo "Sourced ${!fn}"
			#fi
			#return 0
		fi
	else
		#echo "${fn}: already in the list" 				# if already in list, do nothing
		return 0
	fi
	
	#echo "${dkload_list}" > dkload_list.txt
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	
	dk_load
}