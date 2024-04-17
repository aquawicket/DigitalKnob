# dk_include_guard()

##################################################################################
# dk_enter_manually()
#
#
dk_enter_manually () {
	dk_verbose "dk_enter_manually($*)"
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	
	dk_info "Please type the name of the library, tool or app to build. Then press enter."
	read input
	
	APP="_${input}_"
	
	#Search digitalknob for the matching entry containing a DKMAKE.cmake file  
	if test -f "$DKIMPORTS_DIR"/"$input"/DKMAKE.cmake; then
		TARGET_PATH=$DKIMPORTS_DIR/$input
	fi
	if test -f "$DKPLUGINS_DIR"/"$input"/DKMAKE.cmake; then
		TARGET_PATH=$DKPLUGINS_DIR/$input
	fi
	if test -f "$DKAPPS_DIR"/"$input"/DKMAKE.cmake; then
		TARGET_PATH=$DKAPPS_DIR/$input
		return $true
	fi
	dk_debug TARGET_PATH
	
	if [ ! -d "$DKAPPS_DIR"/"$APP" ]; then
		mkdir -p "$DKAPPS_DIR"/"$APP";
	fi
	
	# create DKApps/<APP>/DKMAKE.cmake 
	echo "dk_depend($input)" > "$DKAPPS_DIR"/"$APP"/DKMAKE.cmake
	
	# create DKApps/<APP>/main.cpp
	echo "int main(int argc, char** argv) { return 0; }" > "$DKAPPS_DIR"/"$APP"/main.cpp
}