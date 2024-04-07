# dk_include_guard()

##################################################################################
# dk_delete_temp_files()
#
#
dk_delete_temp_files() {
	dk_debug "dk_delete_temp_files($@)"
	echo "Deleting .TMP files . . ."
	cd $DIGITALKNOB_DIR
	rm -rf `find . -type d -name *.tmp`
	rm -rf `find . -type d -name *.TMP`
	find . -name "*.tmp" -delete
	find . -name "*.TMP" -delete
}