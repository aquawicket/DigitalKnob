project ( lua C )
cmake_minimum_required ( VERSION 2.8 )
 
include(GNUInstallDirs)
 
include_directories ( src ${CMAKE_CURRENT_BINARY_DIR} )
set ( SRC_CORE src/lapi.c src/lcode.c src/lctype.c src/ldebug.c src/ldo.c src/ldump.c src/lfunc.c src/lgc.c src/llex.c
  src/lmem.c src/lobject.c src/lopcodes.c src/lparser.c src/lstate.c src/lstring.c src/ltable.c
  src/ltm.c src/lundump.c src/lvm.c src/lzio.c )
set ( SRC_LIB src/lauxlib.c src/lbaselib.c src/lcorolib.c src/ldblib.c src/liolib.c
  src/lmathlib.c src/loslib.c src/lstrlib.c src/ltablib.c src/lutf8lib.c src/loadlib.c src/linit.c )
 
set ( SRC_LUA src/lua.c )
set ( SRC_LUAC src/luac.c )
 
add_library ( liblua ${SRC_CORE} ${SRC_LIB} )
set_target_properties ( liblua PROPERTIES OUTPUT_NAME lua )
 
add_library ( libluadll SHARED ${SRC_CORE} ${SRC_LIB} )
target_compile_definitions ( libluadll PRIVATE _CRT_SECURE_NO_WARNINGS LUA_BUILD_AS_DLL LUA_COMPAT_ALL )
set_target_properties ( libluadll PROPERTIES OUTPUT_NAME lua54 )
 
add_executable ( lua ${SRC_LUA} )
target_link_libraries ( lua libluadll )
 
add_executable ( luac ${SRC_LUAC} )
target_link_libraries ( luac liblua )
 
set ( LUA_INCLUDES src/lua.h src/lualib.h src/lauxlib.h src/lua.hpp src/luaconf.h )
 
# Installation
if(NOT BUNDLED_MODE)
  install(
    TARGETS lua
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
  )
 
  install(
    TARGETS luac
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
  )
 
  install(
    TARGETS liblua
    ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
    LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
  )
 
  install(
    TARGETS libluadll
    ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
    LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
  )
 
  install(
    FILES src/lua.h src/lualib.h src/lauxlib.h src/lua.hpp src/luaconf.h 
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
  )
endif()
 
## install_executable ( lua luac )
## install_library ( liblua )
## install_data ( README.md )
## #install_lua_module ( strict etc/strict.lua )
## install_header ( src/lua.h src/lualib.h src/lauxlib.h src/lua.hpp ${CMAKE_CURRENT_BINARY_DIR}/luaconf.h )
## #install_doc ( doc/ )
## #install_test ( test/ )