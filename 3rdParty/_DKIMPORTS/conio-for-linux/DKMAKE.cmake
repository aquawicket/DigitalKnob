# https://github.com/nowres/conio-for-linux
# https://github.com/nowres/conio-for-linux/archive/refs/heads/master.zip
if(NOT UNIX_HOST)
	return()
endif()


### DEPENDS ###
DKDEPEND(ncurses)

dk_import(https://github.com/nowres/conio-for-linux.git)

#dk_set(CONIO-FOR-LINUX_VERSION master)
#dk_set(CONIO-FOR-LINUX_NAME conio-${CONIO-FOR-LINUX_VERSION})
#dk_set(CONIO-FOR-LINUX_DL https://github.com/nowres/conio-for-linux/archive/refs/heads/${CONIO-FOR-LINUX_VERSION}.zip)
#dk_set(CONIO-FOR-LINUX ${3RDPARTY}/${CONIO-FOR-LINUX_NAME})
#DKINSTALL(${CONIO-FOR-LINUX_DL} conio.h ${CONIO-FOR-LINUX})


### LINK ###
DKINCLUDE(${CONIO-FOR-LINUX})
