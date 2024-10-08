#!/bin/sh
#[ -n "${HAVE_dk_load}" ] && return || readonly HAVE_dk_load=1
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# dk_load(funcName OR funcPath)
#
#	Source a DKBash function. Download it if needed then parse it and source all of it's content DKBash functions recursivley.
#
#	@funcName OR funcPath  - The name of an existing "functions/funcname.sh" file, or a full filepath to a .sh file.
#
dk_load() {
	dk_debugFunc 1
	echo "dk_load($*)"
	[ "$*" = "/usr/bin/bash" ] && return
	#dk_call dk_notice "dk_load is temporarily disabled. Use dk_call and dk_source to download, load and run functions."
	#return

	EXCLUDE_LIST="dk_whatever,dk_depend,dk_DontLoadMe"
	[[ ${EXCLUDE_LIST} =~ "${1}" ]] && dk_warning "${1} is excluded" && return 0  #FIXME: need to better handle non-existant files
	
	local funcName=
	local funcPath=
	if [ -e "${1}" ]; then
		funcPath=$(realpath "${1}")
		funcName=$(basename "${funcPath}")
	    funcName="${funcName%.*}"
	else
		funcName="${1}"
		funcName=$(basename ${funcName})
		funcName="${funcName%.*}"
		funcPath=${DKBASH_FUNCTIONS_DIR}/${funcName}.sh
	fi
	
	#### download if missing ####
	if [ ! -e "${funcPath}" ]; then
		if [[ "${funcName}" =~ ^dk_[a-zA-Z0-9]+ ]]; then
			[ -e "${DKBASH_FUNCTIONS_DIR}/dk_download.sh" ] || dk_call wget -P ${DKBASH_FUNCTIONS_DIR} ${DKHTTP_DKBASH_FUNCTIONS_DIR}/dk_download.sh
			[ -e "${DKBASH_FUNCTIONS_DIR}/dk_download.sh" ] || dk_call curl -Lo ${DKBASH_FUNCTIONS_DIR}/dk_download.sh ${DKHTTP_DKBASH_FUNCTIONS_DIR}/dk_download.sh
			[ -n "$(command -v "dk_download")" ] || . ${DKBASH_FUNCTIONS_DIR}/dk_download.sh
			dk_download "$DKHTTP_DKBASH_FUNCTIONS_DIR/${funcName}.sh" "$DKBASH_FUNCTIONS_DIR/${funcName}.sh"
			[ -e ${funcPath} ] || dk_error "ERROR: ${funcPath}: file not found"
		else
			dk_call dk_warning "'${funcName}' does not match the dk_ regex pattern"
		fi
	fi
	
	# Convert to unix line endings if CRLF found
	#if builtin echo $(file -b - < ${funcPath}) | grep -q CRLF; then	# POSIX REGEX MATCH
	#if [[ $(dk_call file -b - < ${funcPath}) =~ CRLF ]]; then		# BASH REGEX MATCH
	if (command -v file); then
		if [[ $(file -b - < ${funcPath}) =~ CRLF ]]; then		        # BASH REGEX MATCH
			dk_echo "Converting file to Unix line endings"
			sed -i -e 's/\r$//' ${funcPath}
		fi
	fi
	
	#if echo "${DKFUNCTIONS_LIST}" | grep -q ";${funcName};"; then      # POSIX REGEX
	if ! [[ "${DKFUNCTIONS_LIST-}" =~ ";${funcName};" ]]; then			# BASH REGEX MATCH
	
		DKFUNCTIONS_LIST="${DKFUNCTIONS_LIST-};${funcName};" 			# Add to list
		#dk_echo "added ${funcName} to DKFUNCTIONS_LIST"
		
		oldIFS=${IFS}
		IFS=$'\n'
		matchList=( $(grep -E "dk_[a-zA-Z0-9]+" ${funcPath}) ) || true # || true; #return 0
		#IFS=$'\n' read -r -d '' -a matchList < <( echo "$(grep -E "dk_[a-zA-Z0-9]+" ${funcPath})" && printf '\0' )
		IFS=${oldIFS}
		for match in "${matchList[@]}"; do
			#dk_echo "match = ${match}"
			#match=${match%%N*}   # cut off everything from the first N to end
			#match=${match%N*}    # cut off everything from the last N to end
			#match=${match#*N}    # cut off everything from begining to first N
			#match=${match##*N}   # cut off everything from begining to last N
				
			match=${match//'$#'/}					                 # remove any $# before removing #comments
			match=${match//'${#}'/}					                 # remove any ${#} before removing #comments
			match=${match%%#*}						                 # remove everything after # (comments)
			[[ "${match}" =~ dk_[a-zA-Z0-9]+ ]] || continue 	     # BASH REGEX MATCH
			
			match=${BASH_REMATCH[0]}				                 # BASH REGEX VALUE
			#dk_echo "match = ${match}"
			
			#match=$(builtin echo "${match}" | grep -o "[Dd][Kk]_[A-Za-z0-9_]*" | head -1)	# POSIX REGEX MATCH
			#[ -z "${match}" ] && continue

			if [[ ${DKFUNCTIONS_LIST} =~ ";${match};" ]]; then			# BASH REGEX MATCH
			#if echo ${DKFUNCTIONS_LIST} | grep -q ";${match};"; then   # POSIX REGEX MATCH
				#dk_echo "${funcName}: skipping ${match}.    already in load_list"
				continue
			elif [ "${funcName}" = "${match}" ]; then
				dk_error "${funcName}: skipping ${match}.    already matches funcName"   
				continue
			# FIXME: this messes things up 
			#elif ! [ $(command -v ${match}) = "" ]; then
				#dk_echo "${funcName}: skipping ${match}.    command already recognized"
				#continue
			elif [ "${match}" = "" ]; then
				dk_error "${funcName}: skipping ${match}.    empty"
				continue
			else
				#dk_echo "dk_load(match:${match})"
				dk_load ${match}
			fi
		done

		#dk_echo "if [ -f "${funcPath}" ]"
		if [ -f "${funcPath}" ]; then
			dk_echo ". ${funcPath}"
			. "${funcPath}"
			return 0
		fi
	fi
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_load dk_debug
}
