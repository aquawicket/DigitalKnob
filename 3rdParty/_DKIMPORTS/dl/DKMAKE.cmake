ANDROID_dk_depend(android-ndk)

find_library(dl_LIBRARY dl)
if(NOT dl_LIBRARY)
	dk_assert("Could not locate dl libraries") 
endif()
dk_info(dl_LIBRARY)
dk_lib(${dl_LIBRARY})
