#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
#dk_includeGuard


[ -z ${MAX_LINES-} ]   && MAX_LINES=30
################################################################################
# dk_showFileLine(<filepath> <match_string>)
#
#
#
dk_showFileLine() {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "Incorrect number of parameters"
	
	filepath=$(realpath $1)
	match_string="$2"
	#$(dk_fileContains $filepath "$match_string") && echo "file contains the string" || echo "file DOES NOT contain the string"
	
	oldIFS=$IFS
	IFS=$'\n'
	lines=$(grep -n -o "${match_string}" "${filepath}")
	IFS=$oldIFS
	
	line=${lines[0]%%:*}	# remove everything after :
	lineno=$(($line + 0))
	
	dk_echo " File: $filepath: $line"
	
	min=$(( line-(MAX_LINES / 2) ))
	max=$(( line+(MAX_LINES / 2) ))
	n=1
	while IFS= read -r line; do
	    if [ "$n" -lt "$max" ]; then
			if [ "$n" -gt "$min" ]; then
				#line=!line::=:	! 
				if [ "$n" -eq "${lineno}" ]; then
					dk_echo "${bg_white}${black}> $n: ${line}${clr}"
				else
					dk_echo "  $n: ${line}"
				fi
			fi
		fi
		n=$(( n+1 ))
	done < "$filepath"
}









################################ DKTEST #########################################
DKTEST_START

	dk_showFileLine "../../README.md" "How to build"

DKTEST_END