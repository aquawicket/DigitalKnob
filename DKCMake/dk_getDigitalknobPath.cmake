##################################################################################
# dk_file_getDigitalknobPath(result)
#
#	Get the digitalknob root directory
#
#	@result: string containing full path
#
function(dk_getDigitalknobPath result)
	#DKDEBUGFUNC(${ARGV})
	get_filename_component(DIGITALKNOB ${CMAKE_SOURCE_DIR} ABSOLUTE)
	get_filename_component(FOLDER_NAME ${DIGITALKNOB} NAME)
	while(NOT FOLDER_NAME STREQUAL "digitalknob")
		get_filename_component(DIGITALKNOB ${DIGITALKNOB} DIRECTORY)
		get_filename_component(FOLDER_NAME ${DIGITALKNOB} NAME)
		if(NOT FOLDER_NAME)
			message(FATAL_ERROR "Could not locate digitalknob root path")
		endif()
	endwhile()
	set(${result} ${DIGITALKNOB} PARENT_SCOPE)
endfunction()
dk_getDigitalknobPath(DIGITALKNOB)
set(DKCMAKE ${DIGITALKNOB}/DK/DKCMake)