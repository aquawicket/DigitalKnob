
#find_package( Threads )
#dk_lib		(${CMAKE_THREAD_LIBS_INIT})


# MSYS2 (-lpthread)
if(MSYSTEM)
	dk_set(PTHREAD_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lpthread")
endif()
