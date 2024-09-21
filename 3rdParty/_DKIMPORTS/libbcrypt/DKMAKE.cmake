include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
if(NOT MINGW)
	dk_undepend(libbcrypt)
	dk_return()
endif()

### INSTALL ###
	
#dynamic linking
SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE} -lbcrypt")
#dk_findLibrary(bcrypt.lib)

	

