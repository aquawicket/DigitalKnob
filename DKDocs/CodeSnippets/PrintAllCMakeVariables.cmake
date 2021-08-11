##https://stackoverflow.com/a/9328525/688352

##"Using the get_cmake_property function, the following loop will print out all CMake variables defined and their values:"

get_cmake_property(_variableNames VARIABLES)
list (SORT _variableNames)
foreach (_variableName ${_variableNames})
    message(STATUS "${_variableName}=${${_variableName}}")
endforeach()


##"This can also be embedded in a convenience function which can optionally use a regular expression to print only a subset of variables with matching names"

function(dump_cmake_variables)
    get_cmake_property(_variableNames VARIABLES)
    list (SORT _variableNames)
    foreach (_variableName ${_variableNames})
        if (ARGV0)
            unset(MATCHED)
            string(REGEX MATCH ${ARGV0} MATCHED ${_variableName})
            if (NOT MATCHED)
                continue()
            endif()
        endif()
        message(STATUS "${_variableName}=${${_variableName}}")
    endforeach()
endfunction()


##"To print environment variables, use CMake's command mode:"

execute_process(COMMAND "${CMAKE_EXE}" "-E" "environment")