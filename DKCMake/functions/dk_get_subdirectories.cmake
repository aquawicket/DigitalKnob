include_guard()

###############################################################################
# dk_get_subdirectories(input_path dirlist)
#
#	TODO
#
#
function(dk_get_subdirectories input_dir dir_list)
	file(GLOB_RECURSE children LIST_DIRECTORIES true ${input_dir}/*) # This was changed
    set(dirlist "")
    foreach(child ${children})
        if(IS_DIRECTORY ${child})
            list(APPEND dir_list ${child})
        endif()
    endforeach()
    set(${result} ${dir_list} PARENT_SCOPE)
endfunction()