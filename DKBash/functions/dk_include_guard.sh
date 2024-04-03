#dk_include_guard()
if [ -n "$dk_include_guard" ]; then
	echo "dk_include_guard already included"
	return
fi
echo "including dk_include_guard"
readonly dk_include_guard=1

##################################################################################
# dk_include_guard()
#
#
dk_include_guard () {
	[ -n "$LIB_NAME" ] && return || readonly LIB_NAME=1
}


#if [ -n "$_for_example" ]; then
#	echo "already included"
#	return; 
#fi
#echo "first include"
#_for_example=`date`