# https://github.com/nowres/conio-for-linux
# https://github.com/nowres/conio-for-linux/archive/refs/heads/master.zip
if(NOT UNIX_HOST)
	dk_return()
endif()


### DEPEND ###
dk_depend(ncurses)


### IMPORT ###
dk_import(https://github.com/nowres/conio-for-linux.git)


### LINK ###
dk_include(${CONIO-FOR-LINUX})
