cmake_minimum_required(VERSION 3.2)

project(giflib VERSION 5.1.2 LANGUAGES C)

if(MSVC)
  set(CMAKE_DEBUG_POSTFIX "d")
endif()

add_library(giflib
  dgif_lib.c
  egif_lib.c
  gif_err.c
  gif_font.c
  gif_hash.c
  gif_hash.h
  gif_lib.h
  gif_lib_private.h
  gifalloc.c
  quantize.c
)

target_include_directories(giflib
  PRIVATE
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
  INTERFACE
  $<INSTALL_INTERFACE:include>
  PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

target_compile_definitions(giflib
  PRIVATE
  _CRT_SECURE_NO_WARNINGS
  _CRT_STDC_NO_DEPRECATE
)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY AnyNewerVersion
)

install(TARGETS giflib EXPORT giflib
  RUNTIME DESTINATION bin
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
)

install(FILES
  ${CMAKE_CURRENT_SOURCE_DIR}/gif_lib.h
  DESTINATION include
)

install(EXPORT giflib
  FILE
  ${PROJECT_NAME}.cmake
  NAMESPACE
    ${PROJECT_NAME}::
  DESTINATION
    cmake/${PROJECT_NAME}
)

install(FILES
  cmake/${PROJECT_NAME}-config.cmake
  ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
  DESTINATION
    cmake/${PROJECT_VERSION}
)

export(TARGETS giflib
  FILE
  ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config.cmake
  NAMESPACE ${PROJECT_NAME}::
)