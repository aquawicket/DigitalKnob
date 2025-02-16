dk_depend(zlib)
dk_depend(DK)






#[[ Work In Progress
	#!/usr/bin/cmake -P
	if(NOT DKCMAKE_FUNCTIONS_DIR_)
		set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
	endif()
	include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


	############ CLEAR CMAKE CACHE ############
	#dk_clearCmakeCache()


	############ GENERATE APP CMAKE ############
	set(DK_Project_Dir ${CMAKE_SOURCE_DIR})
	dk_generateAppCmake(${DK_Project_Dir} "zlib;DK")


	############ CONFIGURE APP ############
	dk_configure(${DK_Project_Dir} -DDKCMAKE_FUNCTIONS_DIR=${DKCMAKE_FUNCTIONS_DIR} -DTRIPLE=${TRIPLE})


	############ BUILD APP ############
	dk_build(${DK_Project_Dir})
]]
