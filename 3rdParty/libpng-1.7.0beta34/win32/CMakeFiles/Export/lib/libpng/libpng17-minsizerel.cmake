#----------------------------------------------------------------
# Generated CMake target import file for configuration "MinSizeRel".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "png17_static" for configuration "MinSizeRel"
set_property(TARGET png17_static APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(png17_static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_MINSIZEREL "C"
  IMPORTED_LINK_INTERFACE_LIBRARIES_MINSIZEREL "C:/Users/aquawicket/digitalknob/DK/3rdParty/zlib-1.2.11/win32/Release/zlibstatic.lib"
  IMPORTED_LOCATION_MINSIZEREL "${_IMPORT_PREFIX}/lib/libpng17_static.lib"
  )

list(APPEND _IMPORT_CHECK_TARGETS png17_static )
list(APPEND _IMPORT_CHECK_FILES_FOR_png17_static "${_IMPORT_PREFIX}/lib/libpng17_static.lib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
