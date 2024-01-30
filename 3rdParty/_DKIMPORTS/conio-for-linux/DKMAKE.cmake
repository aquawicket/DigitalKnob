# https://github.com/nowres/conio-for-linux.git

if(NOT UNIX_HOST)
	dk_undepend(conio-for-linux)
	dk_return()
endif()


### DEPEND ###
dk_depend(ncurses)


### IMPORT ###
dk_import(https://github.com/nowres/conio-for-linux.git)


### LINK ###
dk_include(${CONIO_FOR_LINUX})
