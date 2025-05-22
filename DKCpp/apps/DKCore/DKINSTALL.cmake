dk_depend(zlib)
dk_depend(DK)






#[[ Work In Progress
	#!/usr/bin/cmake -P
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


	############ CLEAR CMAKE CACHE ############
	#dk_clearCmakeCache()


	############ GENERATE APP CMAKE ############
	set(Target_App_Dir ${CMAKE_SOURCE_DIR})
	dk_generateAppCmake(${Target_App_Dir} "zlib;DK")


	############ CONFIGURE APP ############
	dk_configure(${Target_App_Dir} -DDKCMAKE_FUNCTIONS_DIR=$ENV{DKCMAKE_FUNCTIONS_DIR} -DTUPLE=${TUPLE})


	############ BUILD APP ############
	dk_build(${Target_App_Dir})
]]
