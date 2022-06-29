if(NOT ANDROID)
	return()
endif()

ANDROID_dk_depend(android-ndk)

find_library(android_LIBRARY android)
if(NOT android_LIBRARY)
	dk_assert("Could not locate android libraries") 
endif()
dk_info(android_LIBRARY)
dk_lib(${android_LIBRARY})
