# dk_include_guard()

##################################################################################
# dk_get_host_triple()
#
#	Get host variable such as 'HOST_OS', 'HOST_ARCH', 'HOST_ENV', 'HOST_VENDOR
#	and build the accoring HOST_TRIPLE variable.  I.E. windows_x86_64_msys2
#
dk_get_host_triple () {
	dk_verbose "dk_get_host_triple($*)"
	
	# currently, our host triple consists of only 2 variable needed
	# HOST_TRIPLE=${HOST_OS}_${HOST_ARCH}
	
	# https://unix.stackexchange.com/questions/225350/how-to-find-out-triplet-without-gcc
	
	# Get the HOST_OS
	# https://llvm.org/doxygen/Triple_8h_source.html
	#if [ "$MODEL" = "Raspberry"* ]; then		#							  [ .. ] can't match globs. Use [[ .. ]] or grep.
	if dk_string_contains "$MODEL" "raspberry"; then
		HOST_OS="raspberry"
	elif [ "$OSTYPE" = "linux-android" ]; then	# FIXME:  $OSTYPE not POSIX
		HOST_OS="android"
	elif [ "$DKHOST" = "Linux" ]; then
		HOST_OS="linux"
	elif [ "$OSTYPE" = "linux-gnu"* ]; then		# FIXME:  $OSTYPE not POSIX   [ .. ] can't match globs. Use [[ .. ]] or grep.
		HOST_OS="linux"
	#elif [ "$OSTYPE" = "darwin"* ]; then		# FIXME:  $OSTYPE not POSIX   [ .. ] can't match globs. Use [[ .. ]] or grep.
	elif dk_string_contains "$OSTYPE" "mac"; then
		HOST_OS="mac"
	elif [ "$OSTYPE" = "msys" ]; then			# FIXME:  $OSTYPE not POSIX
		HOST_OS="win"
	else
		dk_error "Unknown HOST_OS"
	fi
	[ -z "$HOST_OS" ] && dk_error "Failed to get HOST_OS variable" && return $false
	dk_print_var HOST_OS
	
	# Get the HOST_ARCH
	if [ "$HOSTTYPE" = "x86" ]; then			# FIXME:  $HOSTTYPE not POSIX	
		HOST_ARCH="x86"
	elif [ "$HOSTTYPE" = "x86_64" ]; then		# FIXME:  $HOSTTYPE not POSIX
		HOST_ARCH="x86_64"
	elif [ "$HOSTTYPE" = "aarch64" ]; then		# FIXME:  $HOSTTYPE not POSIX
		HOST_ARCH="arm64"
	else
		dk_error "Unknown HOST_ARCH"
	fi
	[ -z "$HOST_ARCH" ] && dk_error "Failed to get HOST_ARCH variable" && return $false
	dk_print_var HOST_ARCH
	
	HOST_TRIPLE=${HOST_OS}_${HOST_ARCH}
	dk_print_var HOST_TRIPLE
}