# Install script for directory: C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/staticlib" TYPE FILE FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/3rdparty/ippicv/ippicv_win/lib/ia32/ippicvmt.lib")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv2" TYPE FILE FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/cvconfig.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv2" TYPE FILE FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/opencv2/opencv_modules.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/staticlib/OpenCVModules.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/staticlib/OpenCVModules.cmake"
         "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/CMakeFiles/Export/staticlib/OpenCVModules.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/staticlib/OpenCVModules-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/staticlib/OpenCVModules.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/staticlib" TYPE FILE FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/CMakeFiles/Export/staticlib/OpenCVModules.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/staticlib" TYPE FILE FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/CMakeFiles/Export/staticlib/OpenCVModules-debug.cmake")
  endif()
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/staticlib" TYPE FILE FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/CMakeFiles/Export/staticlib/OpenCVModules-release.cmake")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/staticlib" TYPE FILE FILES
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/win-install/OpenCVConfig-version.cmake"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/win-install/staticlib/OpenCVConfig.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/." TYPE FILE FILES
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/win-install/OpenCVConfig-version.cmake"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/win-install/OpenCVConfig.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xlibsx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/." TYPE FILE PERMISSIONS OWNER_READ GROUP_READ WORLD_READ FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/LICENSE")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/3rdparty/zlib/cmake_install.cmake")
  include("C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/3rdparty/libjpeg/cmake_install.cmake")
  include("C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/3rdparty/libtiff/cmake_install.cmake")
  include("C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/3rdparty/libwebp/cmake_install.cmake")
  include("C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/3rdparty/libjasper/cmake_install.cmake")
  include("C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/3rdparty/libpng/cmake_install.cmake")
  include("C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/3rdparty/openexr/cmake_install.cmake")
  include("C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/3rdparty/ippiw/cmake_install.cmake")
  include("C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/3rdparty/protobuf/cmake_install.cmake")
  include("C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/3rdparty/ittnotify/cmake_install.cmake")
  include("C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/include/cmake_install.cmake")
  include("C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/modules/cmake_install.cmake")
  include("C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/doc/cmake_install.cmake")
  include("C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/data/cmake_install.cmake")
  include("C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/apps/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
