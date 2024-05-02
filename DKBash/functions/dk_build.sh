#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
#dk_includeGuard


##################################################################################
# dk_build()
#
#
dk_build () {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"

	dk_echo
	dk_echo "##################################################################"
	dk_echo "****** Building $APP - $TARGET_OS - $TYPE - $DKLEVEL ******"
	dk_echo "##################################################################"
	dk_echo
	
	if [ "$TYPE" = "Debug" ] || [ "$TYPE" = "All" ]; then
		if dk_fileExists "$DKAPPS_DIR/$APP/$TARGET_OS/Debug/CMakeCache.txt"; then
			dk_call "$CMAKE_EXE" "--build" "$DKAPPS_DIR/$APP/$TARGET_OS/Debug" "--config Debug" "--verbose"
		elif dk_fileExists "$DKAPPS_DIR/$APP/$TARGET_OS/CMakeCache.txt"; then
			dk_call "$CMAKE_EXE" "--build" "$DKAPPS_DIR/$APP/$TARGET_OS" "--config Debug" "--verbose"
		else
			dk_error "Could not find CMakeCache.txt in $APP/$TARGET_OS/Debug or $APP/$TARGET_OS"
		fi
	fi
	if [ "$TYPE" = "Release" ] || [ "$TYPE" = "All" ]; then
		if dk_fileExists "$DKAPPS_DIR/$APP/$TARGET_OS/Release/CMakeCache.txt"; then
			dk_call "$CMAKE_EXE" --build "$DKAPPS_DIR/$APP/$TARGET_OS/Release" --config Release --verbose
		elif dk_fileExists "$DKAPPS_DIR/$APP/$TARGET_OS/CMakeCache.txt"; then
			dk_call "$CMAKE_EXE" --build "$DKAPPS_DIR/$APP/$TARGET_OS" --config Release --verbose
		else
			dk_error "Could not find CMakeCache.txt in $APP/$TARGET_OS/Release or $APP/$TARGET_OS"
		fi
	fi
	
	dk_echo
	dk_echo "##################################################################"
	dk_echo "****** Done Building $APP - $TARGET_OS - $TYPE - $DKLEVEL ******"
	dk_echo "##################################################################"
	dk_echo
}