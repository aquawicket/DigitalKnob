include_guard()

###############################################################################
# dk_DownloadAll3rdParty()
#
#	TODO
#
function(dk_DownloadAll3rdParty)
	DKDEBUGFUNC(${ARGV})
	
	dk_dependAll()
	
	# Get a list of all /3rdParty/DKMAKE.cmake paths
	file(GLOB All3rdParty ${DKIMPORTS_DIR}/*)
	foreach(item ${All3rdParty})
		if(EXISTS ${item}/DKMAKE.cmake)
			#dk_info("item = ${item}")
			dk_info(item)
			file(STRINGS ${item}/DKMAKE.cmake lines)
			unset(temp_import_script)
			unset(index)
			unset(indexB)
			
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
				file(WRITE ${DKDOWNLOAD_DIR}/TEMP/dl_import.TMP "${dl_import_script}")
				INCLUDE(${DKDOWNLOAD_DIR}/TEMP/dl_import.TMP)
				dk_remove(${DKDOWNLOAD_DIR}/TEMP/dl_import.TMP)
			endif()
		endif()
	endforeach()
endfunction()