include_guard()

##################################################################################
# dk_file_setDigitalknobPath()
#
#	Set the digitalknob root directory environment variable
#
function(dk_setDigitalknobPath)
	# Set the DIGITALKNOB environment variable 
	get_filename_component(path ${CMAKE_SOURCE_DIR} ABSOLUTE)
	string(FIND "${path}" "digitalknob" pos)
	string(SUBSTRING ${path} 0 ${pos} path)
	set(DIGITALKNOB ${path}digitalknob CACHE INTERNAL "")
	set(DKCMAKE ${DIGITALKNOB}/DK/DKCMake/ CACHE INTERNAL "")
	set(ENV{DIGITALKNOB} ${DIGITALKNOB})
	set(ENV{DKCMAKE} ${DKCMAKE})
	if(WIN_HOST)
		execute_process(COMMAND cmd /c setx DIGITALKNOB ${DIGITALKNOB})
		execute_process(COMMAND cmd /c setx DKCMAKE ${DKCMAKE})
	endif()
endfunction()
dk_setDigitalknobPath()
