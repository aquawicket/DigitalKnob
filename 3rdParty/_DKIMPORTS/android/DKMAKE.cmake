if(NOT ANDROID)
	return()
endif()


FIND_LIBRARY(android_Lib android)
if(NOT android_Lib)
	dk_error("Could not locate android libraries") 
endif()
dk_lib(${android_Lib})
