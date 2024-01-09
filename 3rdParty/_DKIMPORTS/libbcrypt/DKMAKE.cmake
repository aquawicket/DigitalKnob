if(NOT MSYS)
	dk_undepend(libcrypt)
	dk_return()
endif()

### INSTALL ###
	
#dynamic linking
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lbrypt")
	

