##################################################################################
## dk_includeGuard
#
#

alias dk_includeGuard='{
	[ -z ${BASH_SOURCE[0]} ] && echo "BASH_SOURCE[0] is empty"
	path=${BASH_SOURCE[0]}
	filename=${path##*/}
	name="${filename%.*}"
	eval value=\${include_guard_$name}
	[ -n "$value" ] && echo "already included" && return || readonly include_guard_${name}=1
	
	#######################################
	#if [ -n "$value" ]; then
	#	[ -n "$(echo -e)" ] && dkecho="echo -e" || dkecho="echo"
	#	$dkecho "[31m dk_includeGuard(): $filename already included [0m"
	#	return
	#fi
	
	#readonly include_guard_${name}=1
	### $dkecho "[36m added include_guard_$name [0m"
}'
