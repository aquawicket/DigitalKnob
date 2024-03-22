include_guard()

###############################################################################
# dk_bin2h(SOURCE_FILE arg1 HEADER_FILE arg2 VARIABLE_NAME arg3)
#
#	https://gist.github.com/sivachandran/3a0de157dccef822a230#file-bin2h-cmake
#	Function to embed contents of a file as byte array in C/C++ header file(.h). The header file
#	will contain a byte array and integer variable holding the size of the array.
#	
#	@SOURCE_FILE     - The path of source file whose contents will be embedded in the header file.
#   @VARIABLE_NAME   - The name of the variable for the byte array. The string "_SIZE" will be append
#                      to this name and will be used a variable name for size variable.
#   @HEADER_FILE     - The path of header file.
#   @APPEND          - If specified appends to the header file instead of overwriting it
#   @NULL_TERMINATE  - If specified a null byte(zero) will be append to the byte array. This will be
#                      useful if the source file is a text file and we want to use the file contents
#                      as string. But the size variable holds size of the byte array without this
#                      null byte.
#	Usage:
#		dk_bin2h(SOURCE_FILE "Logo.png" HEADER_FILE "Logo.h" VARIABLE_NAME "LOGO_PNG")
#
function(dk_bin2h)
	DKDEBUGFUNC(${ARGV})
    set(options APPEND NULL_TERMINATE)
    set(oneValueArgs SOURCE_FILE VARIABLE_NAME HEADER_FILE)
    cmake_parse_arguments(dk_bin2h "${options}" "${oneValueArgs}" "" ${ARGN})
    # reads source file contents as hex string
    file(READ ${DK_BIN2H_SOURCE_FILE} hexString HEX)
    string(LENGTH ${hexString} hexStringLength)
    # appends null byte if asked
    if(DK_BIN2H_NULL_TERMINATE)
        set(hexString "${hexString}00")
    endif()
    # wraps the hex string into multiple lines at column 32(i.e. 16 bytes per line)
#	dk_wrapString(VARIABLE hexString AT_COLUMN 32)
    math(EXPR arraySize "${hexStringLength} / 2")
    # adds '0x' prefix and comma suffix before and after every byte respectively
#	string(REGEX REPLACE "([0-9a-f][0-9a-f])" "\\1" arrayValues ${hexString})
    # removes trailing comma
#	string(REGEX REPLACE ", $" "" arrayValues ${arrayValues})
    # converts the variable name into proper C identifier
    string(MAKE_C_IDENTIFIER "${DK_BIN2H_VARIABLE_NAME}" DK_BIN2H_VARIABLE_NAME)
    string(TOUPPER "${DK_BIN2H_VARIABLE_NAME}" DK_BIN2H_VARIABLE_NAME)
    # declares byte array and the length variables
    set(arrayDefinition "std::string ${DK_BIN2H_VARIABLE_NAME} = \"${hexString}\";")
    set(arraySizeDefinition "size_t ${DK_BIN2H_VARIABLE_NAME}_SIZE = ${arraySize};")
    set(declarations "${arrayDefinition}\n\n${arraySizeDefinition}\n\n")
    if(DK_BIN2H_APPEND)
        file(APPEND ${DK_BIN2H_HEADER_FILE} "${declarations}")
    else()
        file(WRITE ${DK_BIN2H_HEADER_FILE} "${declarations}")
    endif()
endfunction()