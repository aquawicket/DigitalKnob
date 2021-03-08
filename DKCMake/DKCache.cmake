MESSAGE("################ DKCache.cmake ##################")
##We need to find a good way to pull in the variables for all the library paths

SET(FREETYPE C:/digitalknob/DK/3rdParty/freetype-2.5.5)
IF(EXISTS ${FREETYPE}/win32/Release/freetype.lib)
SET(FREETYPE_INCLUDE_DIRS ${FREETYPE}/include CACHE PATH "")
SET(FREETYPE_INCLUDE_DIR_freetype2 ${FREETYPE}/include CACHE PATH "")
SET(FREETYPE_INCLUDE_DIR_ft2build ${FREETYPE}/include CACHE PATH "")
SET(FREETYPE_LIBRARY ${FREETYPE}/win32/Release/freetype.lib CACHE FILEPATH "")
ENDIF()

SET(SDL2_INCLUDE_DIR C:/digitalknob/DK/3rdParty/SDL2-2.0.14/include CACHE PATH "")
SET(SDL2_LIBRARY C:/digitalknob/DK/3rdParty/SDL2-2.0.14/win32/Release/SDL2-static.lib CACHE FILEPATH "")
SET(SDL2MAIN_LIBRARY C:/digitalknob/DK/3rdParty/SDL2-2.0.14/win32/Release/SDL2-static.lib CACHE FILEPATH "")
SET(SDL2_IMAGE_INCLUDE_DIR C:/digitalknob/DK/3rdParty/SDL2_image-2.0.1 CACHE PATH "")
SET(SDL2_IMAGE_LIBRARY C:/digitalknob/DK/3rdParty/SDL2_image-2.0.1/win32/lib/Release/SDL_image.lib CACHE FILEPATH "")


SET(GLEW_DIR C:/digitalknob/DK/3rdParty/glew-2.1.0/ CACHE PATH "")
SET(GLEW_INCLUDE_DIR C:/digitalknob/DK/3rdParty/glew-2.1.0/include CACHE PATH "")
SET(GLEW_INCLUDE_DIRS C:/digitalknob/DK/3rdParty/glew-2.1.0/include CACHE PATH "")
SET(GLEW_LIBRARIES C:/digitalknob/DK/3rdParty/glew-2.1.0/win32/lib CACHE FILEPATH "")
SET(GLEW_SHARED_LIBRARY_DEBUG C:/digitalknob/DK/3rdParty/glew-2.1.0/win32/lib/Debug/libglew32d.lib CACHE FILEPATH "")
SET(GLEW_SHARED_LIBRARY_RELEASE C:/digitalknob/DK/3rdParty/glew-2.1.0/win32/lib/Release/libglew32.lib CACHE FILEPATH "")
SET(GLEW_STATIC_LIBRARY_DEBUG C:/digitalknob/DK/3rdParty/glew-2.1.0/win32/lib/Debug/glew32d.lib CACHE FILEPATH "")
SET(GLEW_STATIC_LIBRARY_RELEASE C:/digitalknob/DK/3rdParty/glew-2.1.0/win32/lib/Release/glew32.lib CACHE FILEPATH "")

list(APPEND CMAKE_PREFIX_PATH C:/digitalknob/DK/3rdParty/glew-2.1.0)
find_package(GLEW REQUIRED)