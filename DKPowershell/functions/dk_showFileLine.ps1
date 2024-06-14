if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_showFileLine){ $dk_showFileLine = 1 } else{ return }

dk_load dk_debug
if(!$MAX_LINES){ $global:MAX_LINES = 30 }
################################################################################
# dk_showFileLine(<filepath> <match_string or line_num>)
#
#
#
function Global:dk_showFileLine($filepath, $goto) {
	dk_debugFunc
	if($(__ARGC__) -ne 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	dk_debug "dk_showFileLine($filepath, $goto)"
#	[ -n "${lastErrorFile-}" ] && _errfile="${lastErrorFile}"  || _errfile="$1"
#	[ -n "${lastErrorLine-}" ] && _lineno="${lastErrorLine}"   || _matchString="$2"
#	unset lastErrorFile
#	unset lastErrorLine
#	
#	#_filepath=$(realpath $_errfile)
#	dk_load dk_realpath; dk_realpath $_errfile _filepath
#	[[ ${_matchString} =~ ^[0-9]+$ ]] && _lineno=${_matchString}
#	
#	if [ -z ${_lineno-} ]; then
#		oldIFS=${IFS}
#		IFS=$'\n'
#		lines=$(grep -n -o "${_matchString}" "${_filepath}")
#		IFS=${oldIFS}
#		line=${lines[0]%%:*}	# remove everything after :
#		_lineno=$((${line} + 0))
#	fi
#	
#	dk_echo " File: ${_filepath}: ${_lineno-}"
#	echo ""
#	
#	min=$(( _lineno-(MAX_LINES / 2) ))
#	max=$(( _lineno+(MAX_LINES / 2) ))
#	n=1
#	while IFS= read -r line; do
#	    if [ "${n}" -lt "${max}" ]; then
#			if [ "${n}" -gt "${min}" ]; then
#				#line=!line::=:	! 
#				if [ "${n}" -eq "${_lineno}" ]; then
#					dk_echo "${bg_white-}${black-}> ${n}: ${line}${clr-}"
#				else
#					dk_echo "  ${n}: ${line}"
#				fi
#			fi
#		fi
#		n=$(( n+1 ))
#	done < "${_filepath}"
#	
#	# method 2
#	#awk 'NR>L-4 && NR<L+4 { printf "%-5d%3s%s\n",NR,(NR==L?">>>":""),$1 }' L=$2 $1
}









function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	dk_showFileLine "../../README.md" "How to build"
	dk_showFileLine $(__FILE__ 0) 5
}