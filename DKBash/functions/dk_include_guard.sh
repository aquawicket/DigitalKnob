#dk_include_guard()

##################################################################################
# dk_include_guard()
#
#
if [ -n "$_for_example" ]; then
	echo "already included"
	return; 
fi
echo "first include"
_for_example=`date`