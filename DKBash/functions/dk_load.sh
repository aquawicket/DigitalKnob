#!/bin/sh
#[ -n "${HAVE_dk_load}" ] && return || readonly HAVE_dk_load=1
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# dk_load(funcName OR funcPath)
#
#	Source a dk_bash function. Download it if needed then parse it and source all of it's content dk_bash functions recursivley.
#
#	@funcName OR funcPath  - The name of an existing "functions/funcname.sh" file, or a full filepath to a .sh file.
#
dk_load (){
	dk_debugFunc
	[ $# -ne 1 ] && echo "${FUNCNAME}($#): incorrect number of arguments" && return 1
	[ "$1" = "dk_depend" ] && return 0  #FIXME: need to better handle non-existant files
	
	local funcName=
	local funcPath=
	if [ -e "$1" ]; then
		funcPath=$(cd $(dirname $1); pwd -P)/$(basename $1)
		funcName=$(basename ${funcPath})
	    funcName="${funcName%.*}"
	else
		funcName="$1"
		funcName=$(basename ${funcName})
		funcName="${funcName%.*}"
		funcPath=${DKBASH_FUNCTIONS_DIR}/${funcName}.sh
	fi
	
	#### download if missing ####
	if [ ! -e ${funcPath} ]; then
		[ ! -e "${DKBASH_FUNCTIONS_DIR}/dk_download.sh" ] && dk_command curl -Lo ${DKBASH_FUNCTIONS_DIR}/dk_download.sh ${DKHTTP_DKBASH_FUNCTIONS_DIR}/dk_download.sh
		[ ! -e "${DKBASH_FUNCTIONS_DIR}/dk_download.sh" ] && dk_command wget -P ${DKBASH_FUNCTIONS_DIR} ${DKHTTP_DKBASH_FUNCTIONS_DIR}/dk_download.sh
		$(dk_download) || . ${DKBASH_FUNCTIONS_DIR}/dk_download.sh
	
		echo "Dowloading ${funcName}"
		dk_download "$DKHTTP_DKBASH_FUNCTIONS_DIR/${funcName}.sh" "$DKBASH_FUNCTIONS_DIR/${funcName}.sh"
		
		[ ! -e ${funcPath} ] && echo "ERROR: ${funcPath}: file not found" && return
		
		#[ ! -e ${funcPath} ] && dk_command curl -Lo ${DKBASH_FUNCTIONS_DIR}/${funcName}.sh ${DKHTTP_DKBASH_FUNCTIONS_DIR}/${funcName}.sh
		#[ ! -e ${funcPath} ] && dk_command wget -P ${DKBASH_FUNCTIONS_DIR} ${DKHTTP_DKBASH_FUNCTIONS_DIR}/${funcName}.sh
		#[ ! -e ${funcPath} ] && echo "ERROR: ${funcPath}: file not found" && return
	fi
	
	
	# Convert to unix line endings if CRLF found
	#if builtin echo $(file -b - < ${funcPath}) | grep -q CRLF; then	# POSIX REGEX MATCH
	#if [[ $(dk_command file -b - < ${funcPath}) =~ CRLF ]]; then		# BASH REGEX MATCH
	if [[ $(file -b - < ${funcPath}) =~ CRLF ]]; then		            # BASH REGEX MATCH
		echo "Converting file to Unix line endings"
		sed -i -e 's/\r$//' ${funcPath}
	fi
	

	#if echo "${DKFUNCTIONS_LIST}" | grep -q ";${funcName};"; then      # POSIX REGEX
	if ! [[ "${DKFUNCTIONS_LIST-}" =~ ";${funcName};" ]]; then			# BASH REGEX MATCH
	
		DKFUNCTIONS_LIST="${DKFUNCTIONS_LIST-};${funcName};" 			# Add to list
		#echo "added ${funcName} to DKFUNCTIONS_LIST"
		
		oldIFS=${IFS}
		IFS=$'\n'
		matchList=( $(grep -E "(dk|DK)_[a-zA-Z0-9]*" ${funcPath}) ) || true # || true; #return 0
		#IFS=$'\n' read -r -d '' -a matchList < <( echo "$(grep -E "(dk|DK)_[a-zA-Z0-9]*" ${funcPath})" && printf '\0' )
		IFS=${oldIFS}
		for match in "${matchList[@]}"; do
			#match=${match%%N*}   # cut off everything from the first N to end
			#match=${match%N*}    # cut off everything from the last N to end
			#match=${match#*N}    # cut off everything from begining to first N
			#match=${match##*N}   # cut off everything from begining to last N
				
			match=${match//'$#'/}					    # remove any $# before removing #comments
			match=${match%%#*}						    # remove everything after # (comments)
			if ! [[ "${match}" =~ [Dd][Kk]_[A-Za-z0-9_]* ]];then  continue; fi	# BASH REGEX MATCH
			match=${BASH_REMATCH[0]}				    	# BASH REGEX VALUE
			
			#match=$(builtin echo "${match}" | grep -o "[Dd][Kk]_[A-Za-z0-9_]*" | head -1)	# POSIX REGEX MATCH
			#[ -z "${match}" ] && continue

			if [[ ${DKFUNCTIONS_LIST} =~ ";${match};" ]]; then			# BASH REGEX MATCH
			#if echo ${DKFUNCTIONS_LIST} | grep -q "${match};"; then    # POSIX REGEX MATCH
				#echo "${funcName}: skipping ${match}.    already in load_list"
				continue
			elif [ ${funcName} = ${match} ]; then
				#echo "${funcName}: skipping ${match}.    already matches funcName"
				continue
			# FIXME: this messes things up 
			#elif ! [ $(command -v ${match}) = "" ]; then
				#echo "${funcName}: skipping ${match}.    command already recognized"
				#continue
			elif [ "${match}" = "" ]; then
				#echo "${funcName}: skipping ${match}.    empty"
				continue
			else
				dk_load ${match}
			fi
		done

		if [ -f "${funcPath}" ]; then
			. "${funcPath}"
			return
		fi
	fi
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	
	dk_load
}
