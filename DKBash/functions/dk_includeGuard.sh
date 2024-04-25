##################################################################################
## dk_includeGuard
#
#

alias dk_includeGuard='{
	path=${BASH_SOURCE[0]}
	filename=${path##*/}
	name="${filename%.*}"

	[ -n "$(echo -e)" ] && export dkecho="echo -e" || export dkecho="echo"

	$dkecho "[36m dk_includeGuard( $name ) [0m"
	
	if [ "$include_guard_${name}" = "1" ]; then
		$dkecho "[31m $name BLOCKED BY INCLUDE GUARD [0m"
		return
	fi
	readonly include_guard_${name}=1
}'
