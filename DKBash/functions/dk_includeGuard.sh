##################################################################################
## dk_includeGuard
#
#

alias dk_includeGuard='{
	path=${BASH_SOURCE[0]}
	filename=${path##*/}
	name="${filename%.*}"
	eval value=\${include_guard_$name}

	[ -n "$(echo -e)" ] && dkecho="echo -e" || dkecho="echo"

	if [ -n "$value" ]; then
		$dkecho "[31m dk_includeGuard(): $filename already included [0m"
		return
	fi
	
	readonly include_guard_${name}=1
	### $dkecho "[36m added include_guard_$name [0m"
}'
