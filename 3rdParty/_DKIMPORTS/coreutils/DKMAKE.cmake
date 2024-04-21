# https://formulae.brew.sh/formula/coreutils
# https://ports.macports.org/port/realpath

if(MAC_HOST)
	dk_command(bash -c "command -v realpath" OUTPUT_VARIABLE REALPATH_EXE)
	if(NOT REALPATH_EXE)
		dk_command(brew install coreutils)
		dk_command(bash -c "command -v realpath" OUTPUT_VARIABLE REALPATH_EXE)
	endif()
endif()