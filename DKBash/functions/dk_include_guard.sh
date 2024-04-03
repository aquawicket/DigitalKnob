#dk_include_guard()
#if [ -n "$dk_include_guard" ]; then
#	echo "dk_include_guard already included"
#	return
#fi
#echo "including dk_include_guard"
#readonly dk_include_guard=1

##################################################################################
# dk_include_guard()
#
#
dk_include_guard () {
	dk_debug "dk_include_guard($0)"
	#DIR=$( cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P )
	echo "BASH_SOURCE = $BASH_SOURCE"
	echo "BASH_SOURCE[0] = $BASH_SOURCE[0]"
	echo "BASH_SOURCE[1] = $BASH_SOURCE[1]"
	#[ -n "$LIB_NAME" ] && return || readonly LIB_NAME=1
}


#if [ -n "$_for_example" ]; then
#	echo "already included"
#	return; 
#fi
#echo "first include"
#_for_example=`date`