#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_smartExtract(src, dest)
#
#
function(dk_smartExtract src dest)
    dk_debugFunc()
	dk_debug("dk_smartExtract(${ARGV})")
 
	dk_getOptionValues(NO_HALT 			${ARGV})
	#dk_getOptionValues(EXTRACT_PATH 	${ARGV})
	
    #set(src ${ARGV1})
    #set(dest ${ARGV2})
    
    dk_realpath("${src}" src_realpath)
	dk_printVar(src_realpath)
    
    dk_dirname("${src_realpath}" src_dirname)
	dk_printVar(src_dirname)
    
    dk_basename("${src_realpath}" src_basename)
	dk_printVar(src_basename)
    
    dk_basename("${src_basename}" src_folder)
	dk_printVar(src_folder)
	
	#if(EXTRACT_PATH)
	#	dk_set(src_extractPath "${EXTRACT_PATH}/${src_basename}_EXTRACTED")
	#else)_
	#	dk_set(src_extractPath "${src_dirname}/${src_basename}_EXTRACTED")
	#endif()
	#dk_printVar(src_extractPath)
    
    dk_realpath("${dest}" dest_realpath)
	dk_printVar(dest_realpath)
    
    dk_dirname("${dest_realpath}" dest_dirname)
	dk_printVar(dest_dirname)
	
    dk_set(src_extractPath "${dest_dirname}/${src_basename}_EXTRACTED")
	dk_printVar(src_extractPath)
	
    dk_basename("${dest_realpath}" dest_folder)
	dk_printVar(dest_folder)

#  if not exist "${dest_realpath}" dk_makeDirectory "${dest_realpath}"

    dk_info("Extracting ${src_realpath}  to  ${src_extractPath}")
	
	if(EXISTS "${src_extractPath}")
		dk_delete("${src_extractPath}")
	endif()
	
	dk_extract("${src_realpath}" "${src_extractPath}" ${NO_HALT})
	
	dk_getDirectories("${src_extractPath}" directories)
    dk_printVar(directories)
	
    dk_arrayLength("${directories}" dir_count)
    dk_printVar(dir_count)
    
	dk_getFiles("${src_extractPath}" files)
	dk_printVar(files)
	
    dk_arrayLength("${files}" file_count)
    dk_printVar(file_count)
	
    if("${dir_count}" STREQUAL "1") 
		dk_debug("dir_count EQUAL 1")
		if(${file_count} LESS 2)
			dk_debug("file_count LESS 2")
			# rename/move EXTRACTED/root folder to dest path"
			list(GET directories 0 directories_0)
			dk_debug("directories_0 = ${directories_0}")
			dk_move("${directories_0}" "${dest_realpath}" OVERWRITE)
			if(EXISTS "${src_extractPath}")
				dk_delete("${src_extractPath}")
			endif()
			dk_return()
		endif()
    endif()

    # rename/move EXTRACTED folder to dest path"
	dk_move("${src_extractPath}" "${dest_realpath}" OVERWRITE)
	if(EXISTS "${src_extractPath}")
		dk_delete("${src_extractPath}")
	endif()
endfunction()




####### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
	
	dk_validate(DKDOWNLOAD_DIR "dk_DIGITALKNOB_DIR()")
	dk_download("https://github.com/libsdl-org/SDL/archive/refs/tags/release-2.26.1.zip" "${DKDOWNLOAD_DIR}/sdl-release-2.26.1.zip")
	dk_smartExtract("${DKDOWNLOAD_DIR}/sdl-release-2.26.1.zip" "${DKDOWNLOAD_DIR}/sdl-release-2.26.1")
	
	#dk_validate(DKDOWNLOAD_DIR "dk_DIGITALKNOB_DIR()")
	#dk_download("https://newcontinuum.dl.sourceforge.net/project/lzmautils/xz-5.4.6.tar.gz" "${DKDOWNLOAD_DIR}/xz-5.4.6.tar.gz")
    #dk_smartExtract("${DKDOWNLOAD_DIR}/xz-5.4.6.tar.gz" "${DKDOWNLOAD_DIR}/xz-5.4.6")
endfunction()