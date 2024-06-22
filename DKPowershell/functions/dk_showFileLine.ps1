if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_showFileLine){ $dk_showFileLine = 1 } else{ return }

dk_load dk_echo
if(!$MAX_LINES){ $global:MAX_LINES = 30 }
################################################################################
# dk_showFileLine(filepath <match_string or line_num>)
#
#
#
function Global:dk_showFileLine($filepath, $goto) {
	dk_debugFunc
	if($(__ARGC__) -ne 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	$lineno = $goto
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
	dk_echo " File: ${filepath}: ${lineno}"
	dk_echo
	
	$half = $MAX_LINES / 2
	$min = ($lineno - $half)
	#if($min -lt 1){$min = 1}
	$max = ($half + $lineno)
	$n = 1
	
	#dk_echo "MAX_LINES = $MAX_LINES"
	#dk_echo "min = $min"
	#dk_echo "lineno = $lineno"
	#dk_echo "max = $max"
	
	foreach($line in Get-Content "${filepath}") {
		if($n -lt $max){
			if($n -gt $min){
				if($n -eq $lineno){
					dk_echo "${bg_white}${black}> ${n}: $line${clr}"
				} else {
					dk_echo "  ${n}: $line"
				}
			}
		}
		$n++
	} 
}









function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	dk_showFileLine "../../README.md" "37"
	dk_showFileLine $(__FILE__ 0) 5
}