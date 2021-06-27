#----------------------------------------------------------------
# Generated CMake target import file for configuration "MinSizeRel".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "cryptopp-shared" for configuration "MinSizeRel"
set_property(TARGET cryptopp-shared APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(cryptopp-shared PROPERTIES
  IMPORTED_IMPLIB_MINSIZEREL "${_IMPORT_PREFIX}/lib/cryptopp-shared.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_MINSIZEREL "ws2_32"
  IMPORTED_LOCATION_MINSIZEREL "${_IMPORT_PREFIX}/bin/cryptopp-shared.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS cryptopp-shared )
list(APPEND _IMPORT_CHECK_FILES_FOR_cryptopp-shared "${_IMPORT_PREFIX}/lib/cryptopp-shared.lib" "${_IMPORT_PREFIX}/bin/cryptopp-shared.dll" )

# Import target "cryptopp-static" for configuration "MinSizeRel"
set_property(TARGET cryptopp-static APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(cryptopp-static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_MINSIZEREL "ASM_MASM;CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES_MINSIZEREL "ws2_32"
  IMPORTED_LOCATION_MINSIZEREL "${_IMPORT_PREFIX}/lib/cryptopp-static.lib"
  )

list(APPEND _IMPORT_CHECK_TARGETS cryptopp-static )
list(APPEND _IMPORT_CHECK_FILES_FOR_cryptopp-static "${_IMPORT_PREFIX}/lib/cryptopp-static.lib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
