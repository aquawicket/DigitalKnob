# dk_include_guard()

##################################################################################
# dk_build_project()
#
#
dk_build_project () {
	dk_debug "dk_build_project($@)"
	echo ""
	echo "##################################################################"
	echo "****** Building $APP - $TARGET_OS - $TYPE - $DKLEVEL ******"
	echo "##################################################################"
	echo ""
	
	if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
		if dk_file_exists $DKAPPS_DIR/$APP/$TARGET_OS/Debug/CMakeCache.txt; then
			dk_call $CMAKE_EXE --build $DKAPPS_DIR/$APP/$TARGET_OS/Debug --config Debug --verbose
		elif dk_file_exists $DKAPPS_DIR/$APP/$TARGET_OS/CMakeCache.txt; then
			dk_call $CMAKE_EXE --build $DKAPPS_DIR/$APP/$TARGET_OS --config Debug --verbose
		else
			dk_error "Could not find CMakeCache.txt in $APP/$TARGET_OS/Debug or $APP/$TARGET_OS"
		fi
	fi
	if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
		if dk_file_exists $DKAPPS_DIR/$APP/$TARGET_OS/Release/CMakeCache.txt; then
			dk_call $CMAKE_EXE --build $DKAPPS_DIR/$APP/$TARGET_OS/Release --config Release --verbose
		elif dk_file_exists $DKAPPS_DIR/$APP/$TARGET_OS/CMakeCache.txt; then
			dk_call $CMAKE_EXE --build $DKAPPS_DIR/$APP/$TARGET_OS --config Release --verbose
		else
			dk_error "Could not find CMakeCache.txt in $APP/$TARGET_OS/Release or $APP/$TARGET_OS"
		fi
	fi
	
	echo ""
	echo "##################################################################"
	echo "****** Done Building $APP - $TARGET_OS - $TYPE - $DKLEVEL ******"
	echo "##################################################################"
	echo ""
}