# https://github.com/mouuff/simple-getch
# https://github.com/mouuff/simple-getch/archive/refs/heads/master.zip
if(NOT UNIX_HOST)
	dk_undepend(simple-getch)
	dk_return()
endif()


dk_import(https://github.com/mouuff/simple-getch.git)


### LINK ###
dk_include		(${SIMPLE_GETCH}/getch/include)
dk_libDebug		(${SIMPLE_GETCH}/getch/libgetch.a)
dk_libRelease	(${SIMPLE_GETCH}/getch/libgetch.a)


### COMPILE ###
DEBUG_dk_queueCommand	(../../make)
RELEASE_dk_queueCommand	(../../make)
