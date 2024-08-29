include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)

LINUX_TARGET_dk_lib		(pthread)
RASPBERRY_TARGET_dk_lib	(pthread)


# MSYS2 (-lpthread)
if(MSYSTEM)
	dk_set(PTHREAD_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lpthread")
endif()
