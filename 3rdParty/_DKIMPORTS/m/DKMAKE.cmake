if(NOT ANDROID)
	return()
endif()


FIND_LIBRARY(m_Lib m)
if(NOT m_Lib)
	dk_error("Could not locate m libraries") 
endif()
dk_lib(${m_Lib})
