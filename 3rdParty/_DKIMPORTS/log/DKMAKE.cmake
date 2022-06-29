if(NOT ANDROID)
	return()
endif()

ANDROID_dk_depend(android-ndk)

find_library(log_LIBRARY log)
if(NOT log_LIBRARY)
	dk_assert("Could not locate log libraries") 
endif()
dk_info(log_LIBRARY)
dk_lib(${log_LIBRARY})
