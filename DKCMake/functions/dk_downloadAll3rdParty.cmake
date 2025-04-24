#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_downloadAll3rdParty()
#
#	TODO
#
function(dk_downloadAll3rdParty)
	dk_debugFunc()
	
	dk_dependAll()
	
<<<<<<< HEAD
	# Get a list of all /3rdParty/DKMAKE.cmake paths
	file(GLOB All3rdParty ${DKIMPORTS_DIR}/*)
	foreach(item ${All3rdParty})
		if(EXISTS ${item}/DKMAKE.cmake)
			dk_verbose(item)
			file(STRINGS ${item}/DKMAKE.cmake lines)
=======
	# Get a list of all /3rdParty/DKINSTALL.cmake paths
	file(GLOB All3rdParty $ENV{DKIMPORTS_DIR}/*)
	foreach(item ${All3rdParty})
		if(EXISTS ${item}/DKINSTALL.cmake)
			dk_verbose(item)
			file(STRINGS ${item}/DKINSTALL.cmake lines)
>>>>>>> Development
			dk_unset(temp_import_script)
			dk_unset(index)
			dk_unset(indexB)
			
			set(keepCommands "set;SET;dk_download;dk_install;dk_import")
			set(KEEPLINE 0)
			foreach(line ${lines})
			
				foreach(keepCommand ${keepCommands})
					if(line MATCHES "${keepCommand}(")
						set(KEEPLINE 1)
					endif()
					if(line MATCHES "${keepCommand} ")
						set(KEEPLINE 1)
					endif()
					if(line MATCHES "${keepCommand}	 ")
						set(KEEPLINE 1)
					endif()
				endforeach()
			
				if(KEEPLINE)
					set(dl_import_script "${dl_import_script}${line}\n")
				endif()
				if(line MATCHES ")")
					set(KEEPLINE 0)
				endif()
			endforeach()
			
			if(dl_import_script)
<<<<<<< HEAD
				dk_fileWrite(${DKDOWNLOAD_DIR}/TEMP/dl_import.TMP "${dl_import_script}")
				INCLUDE(${DKDOWNLOAD_DIR}/TEMP/dl_import.TMP)
				dk_delete(${DKDOWNLOAD_DIR}/TEMP/dl_import.TMP)
=======
				dk_fileWrite($ENV{DKDOWNLOAD_DIR}/TEMP/dl_import.TMP "${dl_import_script}")
				INCLUDE($ENV{DKDOWNLOAD_DIR}/TEMP/dl_import.TMP)
				dk_delete($ENV{DKDOWNLOAD_DIR}/TEMP/dl_import.TMP)
>>>>>>> Development
			endif()
		endif()
	endforeach()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_todo()
endfunction()