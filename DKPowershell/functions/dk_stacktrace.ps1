if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_stacktrace_ps1){ $dk_stacktrace_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_stacktrace()
#
#
function Global:dk_stacktrace() {
    dk_debugFunc 0;

	### VERSION 1 ###
	$i = 0
    $Global:Var = (Get-PSCallStack).Command
	
    $Var | ForEach-Object {
		#$(dk_call __FRAME__ $i)
		$fileline = "[${i}] $(__FILE__ $i):$(__LINE__ $i):";
		$args = "$(__ARGV__ $i)";
		$args = $args.Trim();
		$funcargs = "$(__FUNCTION__ $i)($(__ARGC__ $i): $args)";
		$fileline = $fileline.PadRight(30,' ');
        dk_call dk_echo "$($fileline)$($funcargs)"
        $i++
    }

#	while [ "${i}" -lt "${stack_size}" ]; do
#		i=$(( i + 1 ))
#		frame=$(( i - 2 ))
#		if [ $i -eq 2 ]; then
#			fileline=$(sed -n ${BASH_LINENO[${i}-1]-}p ${BASH_SOURCE[${i}]:-})
#			dk_call dk_echo "  [${frame}] ${BASH_SOURCE[${i}]:-}:${bg_white-}${black-}${BASH_LINENO[${i}-1]-}: > ${fileline}${clr-}"
#			continue
#		fi
#		[ $i -gt 2 ] && dk_call dk_echo "  [${frame}] ${BASH_SOURCE[${i}]:-}:${BASH_LINENO[${i}-1]-} ${FUNCNAME[${i}-1]-}()" # && continue
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
#	(IFS=$'\n'; dk_call dk_echo "${stack[*]}")


#	### VERSION 3 ###
#	local i=1 line file func
#	while read -r line func file < <(caller ${i}); do
#		dk_call dk_echo >&2 [${i}] ${file}:${line} ${func}(): $(sed -n ${line}p ${file})
#		((i++))
#	done
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST_1() {
	dk_debugFunc 0 99;
	
	dk_call dk_stacktrace;
}

function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call DKTEST_1 abc 123
}
