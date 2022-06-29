if(NOT ANDROID)
#	return()
endif()


FIND_LIBRARY(dl_Lib dl)
if(NOT dl_Lib)
	dk_error("Could not locate dl libraries") 
endif()
dk_lib(${dl_Lib})
