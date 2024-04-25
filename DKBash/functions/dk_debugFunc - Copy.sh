##################################################################################
## dk_includeGuard
#
#

alias dk_includeGuard='{
	filename=${BASH_SOURCE[0]}
	echo "filename = $filename"
	name=${${filename}##*/}
	echo "name = $name"
	
	if [ "$(echo -e)" = "" ]; then
		echo -e " [31m dk_includeGuard( $name ) [0m "
	else
		echo " [31m dk_includeGuard( $name ) [0m "
	fi
	
	#[ -n $include_guard_$(basename ${BASH_SOURCE[0]}) ] && return
	#export include_guard_$(basename ${BASH_SOURCE[0]})=1
}'
