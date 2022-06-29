if(NOT ANDROID)
	return()
endif()


FIND_LIBRARY(log_Lib log)
if(NOT log_Lib)
	dk_error("Could not locate log libraries") 
endif()
dk_lib(${log_Lib})
