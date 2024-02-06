# not found on Android host devices the first time round. 
# add hints to point to the library in the ndk

if(NOT ANDROID)
	dk_undepend(android)
	dk_return()
endif()

dk_depend(android-ndk)

dk_findLibrary(android)
