include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_downloadAll3rdParty()
#
#	TODO
#
function(dk_downloadAll3rdParty)
	dk_debugFunc(${ARGV})
	
	dk_dependAll()
	
	# Get a list of all /3rdParty/DKMAKE.cmake paths
	file(GLOB All3rdParty ${DKIMPORTS_DIR}/*)
	foreach(item ${All3rdParty})
		if(EXISTS ${item}/DKMAKE.cmake)
			#dk_info("item = ${item}")
			dk_info(item)
			file(STRINGS ${item}/DKMAKE.cmake lines)
			dk_unset(temp_import_script)
			dk_unset(index)
			dk_unset(indexB)
			
			set(keepCommands "set;SET;dk_download;dk_install;dk_import")
			set(KEEPLINE 0)
			foreach(line ${lines})
			
				foreach(keepCommand ${keepCommands})
					dk_includes("${line}" "${keepCommand}(" hasCommand) # trailing (
					if(${hasCommand})
						set(KEEPLINE 1)
					endif()
					dk_includes("${line}" "${keepCommand} " hasCommand) # trailing space
					if(${hasCommand})
						set(KEEPLINE 1)
					endif()
					dk_includes("${line}" "${keepCommand}	" hasCommand) # trailing tab
					if(${hasCommand})
						set(KEEPLINE 1)
					endif()
				endforeach()
			
				if(KEEPLINE)
					set(dl_import_script "${dl_import_script}${line}\n")
				endif()
				string(FIND "${line}" ")" indexB) 
				if(${indexB} GREATER -1)
				#dk_includes("${line}" ")" indexB)
				#if(${indexB})
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





function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()