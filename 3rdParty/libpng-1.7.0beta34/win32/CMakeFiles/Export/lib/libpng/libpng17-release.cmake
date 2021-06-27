#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "png17_static" for configuration "Release"
set_property(TARGET png17_static APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(png17_static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "C:/Users/aquawicket/digitalknob/DK/3rdParty/zlib-1.2.11/win32/Release/zlibstatic.lib"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libpng17_static.lib"
  )

list(APPEND _IMPORT_CHECK_TARGETS png17_static )
list(APPEND _IMPORT_CHECK_FILES_FOR_png17_static "${_IMPORT_PREFIX}/lib/libpng17_static.lib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
