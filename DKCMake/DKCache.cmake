MESSAGE("################ DKCache.cmake ##################")

cmake_policy(SET CMP0074 NEW)


SET(OS win32)
SET(3RDPARTY C:/Users/aquawicket/digitalknob/DK/3rdParty)
SET(ZLIB ${3RDPARTY}/zlib-1.2.11)
SET(BZIP2 ${3RDPARTY}/bzip2-1.0.6)
SET(FREETYPE ${3RDPARTY}/freetype-2.5.5)
project(HelloWorld C CXX)

## ZLIB
SET(ZLIB_ROOT ${ZLIB})
#INCLUDE_DIRECTORIES(${ZLIB})
#INCLUDE_DIRECTORIES(${ZLIB}/${OS})
SET(ZLIB_INCLUDE_DIR ${ZLIB} CACHE PATH "")
SET(ZLIB_LIBRARY ${ZLIB}/${OS}/Release/zlibstatic.lib CACHE FILEPATH "")
list(APPEND CMAKE_PREFIX_PATH ${ZLIB})
find_package(ZLIB REQUIRED)


##EXECUTE_PROCESS(COMMAND cmd /c set /p DUMMY=Hit ENTER to continue... WORKING_DIRECTORY C:/)

## BZIP2
SET(BZip2_ROOT ${BZIP2})
SET(BZIP2_INCLUDE_DIR ${BZIP2} CACHE PATH "")
SET(BZIP2_LIBRARY_DEBUG ${BZIP2}/${OS}/libbz2.lib FILEPATH "")
SET(BZIP2_LIBRARY_RELEASE ${BZIP2}/${OS}/libbz2.lib FILEPATH "")
SET(LIBGCC_LIBRARY ${BZIP2}/${OS}/libgcc.lib FILEPATH "")
list(APPEND CMAKE_PREFIX_PATH ${BZIP2})
find_package(BZip2 REQUIRED)

IF(EXISTS ${FREETYPE}/win32/Release/freetype.lib)
SET(FREETYPE_INCLUDE_DIRS ${FREETYPE}/include CACHE PATH "")
SET(FREETYPE_INCLUDE_DIR_freetype2 ${FREETYPE}/include CACHE PATH "")
SET(FREETYPE_INCLUDE_DIR_ft2build ${FREETYPE}/include CACHE PATH "")
SET(FREETYPE_LIBRARY ${FREETYPE}/win32/Release/freetype.lib CACHE FILEPATH "")
ENDIF()

SET(SDL2_INCLUDE_DIR C:/Users/aquawicket/digitalknob/DK/3rdParty/SDL2-2.0.14/include CACHE PATH "")
SET(SDL2_LIBRARY C:/Users/aquawicket/digitalknob/DK/3rdParty/SDL2-2.0.14/win32/Release/SDL2-static.lib CACHE FILEPATH "")
SET(SDL2MAIN_LIBRARY C:/Users/aquawicket/digitalknob/DK/3rdParty/SDL2-2.0.14/win32/Release/SDL2-static.lib CACHE FILEPATH "")

SET(SDL2_IMAGE_INCLUDE_DIR C:/Users/aquawicket/digitalknob/DK/3rdParty/SDL2_image-2.0.1 CACHE PATH "")
SET(SDL2_IMAGE_LIBRARY C:/Users/aquawicket/digitalknob/DK/3rdParty/SDL2_image-2.0.1/win32/lib/Release/SDL_image.lib CACHE FILEPATH "")


SET(GLEW_DIR C:/Users/aquawicket/digitalknob/DK/3rdParty/glew-2.1.0/ CACHE PATH "")
SET(GLEW_INCLUDE_DIR C:/Users/aquawicket/digitalknob/DK/3rdParty/glew-2.1.0/include CACHE PATH "")
SET(GLEW_INCLUDE_DIRS C:/Users/aquawicket/digitalknob/DK/3rdParty/glew-2.1.0/include CACHE PATH "")
SET(GLEW_LIBRARIES C:/Users/aquawicket/digitalknob/DK/3rdParty/glew-2.1.0/win32/lib CACHE PATH "")
SET(GLEW_SHARED_LIBRARY_DEBUG C:/Users/aquawicket/digitalknob/DK/3rdParty/glew-2.1.0/win32/lib/Debug/libglew32d.lib CACHE FILEPATH "")
SET(GLEW_SHARED_LIBRARY_RELEASE C:/Users/aquawicket/digitalknob/DK/3rdParty/glew-2.1.0/win32/lib/Release/libglew32.lib CACHE FILEPATH "")
SET(GLEW_STATIC_LIBRARY_DEBUG C:/Users/aquawicket/digitalknob/DK/3rdParty/glew-2.1.0/win32/lib/Debug/glew32d.lib CACHE FILEPATH "")
SET(GLEW_STATIC_LIBRARY_RELEASE C:/Users/aquawicket/digitalknob/DK/3rdParty/glew-2.1.0/win32/lib/Release/glew32.lib CACHE FILEPATH "")
list(APPEND CMAKE_PREFIX_PATH C:/Users/aquawicket/digitalknob/DK/3rdParty/glew-2.1.0)
#find_package(GLEW REQUIRED)