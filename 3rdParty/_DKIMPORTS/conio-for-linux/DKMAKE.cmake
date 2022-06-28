# https://github.com/nowres/conio-for-linux
# https://github.com/nowres/conio-for-linux/archive/refs/heads/master.zip
if(NOT UNIX_HOST)
	return()
endif()


dk_depend(ncurses)


#dk_set(CONIO-FOR-LINUX_VERSION master)
#dk_set(CONIO-FOR-LINUX_NAME conio-${CONIO-FOR-LINUX_VERSION})
#dk_install(https://github.com/nowres/conio-for-linux/archive/refs/heads/master.zip ${3RDPARTY}/${CONIO-FOR-LINUX_NAME})
dk_import(https://github.com/nowres/conio-for-linux.git)


### LINK ###
dk_include(${CONIO-FOR-LINUX})
