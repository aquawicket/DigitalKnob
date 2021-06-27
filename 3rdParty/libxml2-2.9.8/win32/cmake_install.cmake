# Install script for directory: C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "C:/Program Files (x86)/xml2")
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
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/win32/Debug/xml2.lib")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/win32/Release/xml2.lib")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/win32/MinSizeRel/xml2.lib")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/win32/RelWithDebInfo/xml2.lib")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/libxml" TYPE FILE FILES
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/DOCBparser.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/HTMLparser.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/HTMLtree.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/SAX.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/SAX2.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/c14n.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/catalog.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/chvalid.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/debugXML.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/dict.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/encoding.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/entities.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/globals.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/hash.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/list.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/nanoftp.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/nanohttp.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/parser.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/parserInternals.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/pattern.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/relaxng.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/schemasInternals.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/schematron.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/threads.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/tree.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/uri.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/valid.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/xinclude.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/xlink.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/xmlIO.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/xmlautomata.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/xmlerror.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/xmlexports.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/xmlmemory.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/xmlmodule.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/xmlreader.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/xmlregexp.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/xmlsave.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/xmlschemas.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/xmlschemastypes.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/xmlstring.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/xmlunicode.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/xmlversion.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/xmlwriter.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/xpath.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/xpathInternals.h"
    "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/include/libxml/xpointer.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "C:/Users/aquawicket/digitalknob/DK/3rdParty/libxml2-2.9.8/win32/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
