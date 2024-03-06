include_guard()

##################################################################################
# dk_file_setDigitalknobPath()
#
#	Set the digitalknob root directory environment variable
#
function(dk_setDigitalknobPath)
	# Set the DIGITALKNOB_DIR environment variable 
	get_filename_component(path ${CMAKE_SOURCE_DIR} ABSOLUTE)
	string(FIND "${path}" "digitalknob" pos)
	string(SUBSTRING ${path} 0 ${pos} path)
	set(DIGITALKNOB_DIR ${path}digitalknob CACHE INTERNAL "")
	set(DKCMAKE_DIR ${DIGITALKNOB_DIR}/Development/DKCMake/ CACHE INTERNAL "")
	set(ENV{DIGITALKNOB_DIR} ${DIGITALKNOB_DIR})
	set(ENV{DKCMAKE_DIR} ${DKCMAKE_DIR})
	if(WIN_HOST)
		execute_process(COMMAND cmd /c setx DIGITALKNOB_DIR ${DIGITALKNOB_DIR})
		execute_process(COMMAND cmd /c setx DKCMAKE_DIR ${DKCMAKE_DIR})
	endif()
	#message(STATUS "DIGITALKNOB_DIR = ${DIGITALKNOB_DIR}")
	#message(STATUS "DKCMAKE_DIR = ${DKCMAKE_DIR}")
	#message(STATUS "ENV{DIGITALKNOB_DIR} = $ENV{DIGITALKNOB_DIR}")
	#message(STATUS "ENV{DKCMAKE_DIR} = $ENV{DKCMAKE_DIR}")
endfunction()
dk_setDigitalknobPath()
