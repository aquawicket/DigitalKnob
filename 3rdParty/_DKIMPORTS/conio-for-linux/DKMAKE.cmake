if(NOT UNIX_HOST)
	return()
endif()

# https://github.com/nowres/conio-for-linux
#
# https://github.com/nowres/conio-for-linux/archive/refs/heads/master.zip

### DEPENDS ###
DKDEPEND(ncurses)


DKIMPORT(https://github.com/nowres/conio-for-linux)
#DKSET(CONIO-FOR-LINUX_VERSION master)
#DKSET(CONIO-FOR-LINUX_NAME conio-${CONIO-FOR-LINUX_VERSION})
#DKSET(CONIO-FOR-LINUX_DL https://github.com/nowres/conio-for-linux/archive/refs/heads/${CONIO-FOR-LINUX_VERSION}.zip)
#DKSET(CONIO-FOR-LINUX ${3RDPARTY}/${CONIO-FOR-LINUX_NAME})
#DKINSTALL(${CONIO-FOR-LINUX_DL} conio.h ${CONIO-FOR-LINUX})


### LINK ###
DKINCLUDE(${CONIO-FOR-LINUX})
