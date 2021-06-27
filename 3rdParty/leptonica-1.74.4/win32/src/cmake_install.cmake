# Install script for directory: C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4")
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

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/win32/src/Debug/leptonica-1.74.4d.lib")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/win32/src/Release/leptonica-1.74.4.lib")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/win32/src/MinSizeRel/leptonica-1.74.4.lib")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/win32/src/RelWithDebInfo/leptonica-1.74.4.lib")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/cmake/LeptonicaTargets.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/cmake/LeptonicaTargets.cmake"
         "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/win32/src/CMakeFiles/Export/cmake/LeptonicaTargets.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/cmake/LeptonicaTargets-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/cmake/LeptonicaTargets.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/cmake" TYPE FILE FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/win32/src/CMakeFiles/Export/cmake/LeptonicaTargets.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/cmake" TYPE FILE FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/win32/src/CMakeFiles/Export/cmake/LeptonicaTargets-debug.cmake")
  endif()
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/cmake" TYPE FILE FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/win32/src/CMakeFiles/Export/cmake/LeptonicaTargets-minsizerel.cmake")
  endif()
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/cmake" TYPE FILE FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/win32/src/CMakeFiles/Export/cmake/LeptonicaTargets-relwithdebinfo.cmake")
  endif()
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/cmake" TYPE FILE FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/win32/src/CMakeFiles/Export/cmake/LeptonicaTargets-release.cmake")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/leptonica" TYPE FILE FILES
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/allheaders.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/alltypes.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/array.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/arrayaccess.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/bbuffer.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/bilateral.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/bmf.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/bmfdata.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/bmp.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/ccbord.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/dewarp.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/environ.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/gplot.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/heap.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/imageio.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/jbclass.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/leptwin.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/list.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/morph.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/pix.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/ptra.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/queue.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/rbtree.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/readbarcode.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/recog.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/regutils.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/stack.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/stringcode.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/sudoku.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/src/watershed.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/leptonica-1.74.4/win32/src/endianness.h"
    )
endif()

