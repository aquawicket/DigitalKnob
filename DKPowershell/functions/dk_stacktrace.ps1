if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_stacktrace){ $dk_stacktrace = 1 } else{ return }

##################################################################################
# dk_stacktrace()
#
#
function Global:dk_stacktrace() {
    dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_echo "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments"; return }


	### VERSION 1 ###
	$stack_size = $(Get-PSCallStack).count
	dk_echo "STACKTRACE[${stack_size}]" 
	$i = 0

    while($i -lt $stack_size) {

        $i=$i+1
        $frame = $i - 2
        if($i -eq 2){
			dk_echo "  [${frame}] $(__FILE__ $i)}:$(__LINE__ $i):  $(__FUNCTION__ $i)($(__ARGV__ $i))"
			continue
        }
    }

#	while [ "${i}" -lt "${stack_size}" ]; do
#		i=$(( i + 1 ))
#		frame=$(( i - 2 ))
#		if [ $i -eq 2 ]; then
#			fileline=$(sed -n ${BASH_LINENO[${i}-1]-}p ${BASH_SOURCE[${i}]:-})
#			dk_echo "  [${frame}] ${BASH_SOURCE[${i}]:-}:${bg_white-}${black-}${BASH_LINENO[${i}-1]-}: > ${fileline}${clr-}"
#			continue
#		fi
#		[ $i -gt 2 ] && dk_echo "  [${frame}] ${BASH_SOURCE[${i}]:-}:${BASH_LINENO[${i}-1]-} ${FUNCNAME[${i}-1]-}()" # && continue
#	done 


#	### VERSION 2 ###
#	[ "${FUNCNAME-}" = "" ] && return 0
#	[ "${BASH_SOURCE-}" = "" ] && return 0
#	[ "${BASH_LINENO-}" = "" ] && return 0
#	local status_code="${1-}" 
#	local -a stack=("Stack trace of error code '${status_code}':")
#	local stack_size=${#FUNCNAME[@]}
#	local -i i
#	local indent="    "
#	# to avoid noise we start with 1 to skip the stack function
#	for (( i = 1; i < stack_size; i++ )); do
#	    local func="${FUNCNAME[${i}]:-(top level)}"
#	    local -i line="${BASH_LINENO[$(( i - 1 ))]}"
#	    local src="${BASH_SOURCE[${i}]:-(no file)}"
#	    stack+=("${indent} └ ${src}:${line} (${func})")
#	    indent="${indent}    "
#	done
#	(IFS=$'\n'; dk_echo "${stack[*]}")


#	### VERSION 3 ###
#	local i=1 line file func
#	while read -r line func file < <(caller ${i}); do
#		dk_echo >&2 [${i}] ${file}:${line} ${func}(): $(sed -n ${line}p ${file})
#		((i++))
#	done
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc
	
	
	dk_stacktrace
}