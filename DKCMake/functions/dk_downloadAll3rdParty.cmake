#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_downloadAll3rdParty()
#
#	TODO
#
function(dk_downloadAll3rdParty)
	dk_debugFunc()
	
	dk_dependAll()
	
	# Get a list of all /3rdParty/DKMAKE.cmake paths
	file(GLOB All3rdParty ${DKIMPORTS_DIR}/*)
	foreach(item ${All3rdParty})
		if(EXISTS ${item}/DKMAKE.cmake)
			dk_verbose(item)
			file(STRINGS ${item}/DKMAKE.cmake lines)
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
				dk_fileWrite(${DKDOWNLOAD_DIR}/TEMP/dl_import.TMP "${dl_import_script}")
				INCLUDE(${DKDOWNLOAD_DIR}/TEMP/dl_import.TMP)
				dk_delete(${DKDOWNLOAD_DIR}/TEMP/dl_import.TMP)
			endif()
		endif()
	endforeach()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()