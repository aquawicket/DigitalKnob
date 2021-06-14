cmake_minimum_required(VERSION 3.0)
project(openFrameworks)

set(OF_LIBS "")
set(OF_INCLUDE_PATH "")
set(ADDONS_SRC "")
set(ADDONS_HEADERS "")
set(ADDONS_LIBS "")
set(ADDONS_INCLUDE_PATH "")
set(ADDONS_PATH ${OF_PATH}/addons)
set(USE_PRECOMPILED_LIB false)
#This can also be Win32
set(AR ${ARCHITECTURE})

if (CMAKE_BUILD_TYPE STREQUAL "Debug")
  set(DEBUG_MODE ON CACHE BOOL "turn on debug mode")
elseif (CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
  set(DEBUG_MODE OFF CACHE BOOL "turn off debug mode")
else()
  set(DEBUG_MODE OFF CACHE BOOL "turn off debug mode")
endif()

if(MSVC)
    if (DEBUG_MODE)
        ADD_DEFINITIONS(
            -DWIN32
            -D_CONSOLE
            -DPOCO_STATIC
            -DCAIRO_WIN32_STATIC_BUILD
            -DDISABLE_SOME_FLOATING_POINT
            -D_UNICODE
            -DUNICODE
            )
    else()
        ADD_DEFINITIONS(
            -DWIN32
            -D_CONSOLE
            -DPOCO_STATIC
            -DCAIRO_WIN32_STATIC_BUILD
            -DDISABLE_SOME_FLOATING_POINT
            -D_UNICODE
            -DUNICODE
            )
    endif(DEBUG_MODE)
endif(MSVC)

#BOOST
if(DEBUG_MODE)
    list(APPEND OF_LIBS
        ${OF_PATH}/libs/boost/lib/vs/${AR}/libboost_filesystem-vc140-mt-gd-1_58.lib
        ${OF_PATH}/libs/boost/lib/vs/${AR}/libboost_system-vc140-mt-gd-1_58.lib
        )
else()
    list(APPEND OF_LIBS
        ${OF_PATH}/libs/boost/lib/vs/${AR}/libboost_filesystem-vc140-mt-1_58.lib
        ${OF_PATH}/libs/boost/lib/vs/${AR}/libboost_system-vc140-mt-1_58.lib
        )
endif(DEBUG_MODE)
    list(APPEND OF_INCLUDE_PATH
        ${OF_PATH}/libs/boost/include
        ${OF_PATH}/libs/boost/include/boost
        )


#CAIRO
list(APPEND OF_LIBS ${OF_PATH}/libs/cairo/lib/vs/${AR}/cairo-static.lib)
list(APPEND OF_LIBS ${OF_PATH}/libs/cairo/lib/vs/${AR}/libpng.lib)
list(APPEND OF_LIBS ${OF_PATH}/libs/cairo/lib/vs/${AR}/pixman-1.lib)

list(APPEND OF_INCLUDE_PATH ${OF_PATH}/libs/cairo/include)
list(APPEND OF_INCLUDE_PATH ${OF_PATH}/libs/cairo/include/libpng15)
list(APPEND OF_INCLUDE_PATH ${OF_PATH}/libs/cairo/include/pixman-1)
list(APPEND OF_INCLUDE_PATH ${OF_PATH}/libs/cairo/include/cairo)


#FMOEX
if (AR STREQUAL "x64")
    list(APPEND OF_LIBS ${OF_PATH}/libs/fmodex/lib/vs/${AR}/fmodex64_vc.lib)
else()
    list(APPEND OF_LIBS ${OF_PATH}/libs/fmodex/lib/vs/${AR}/fmodex_vc.lib)
endif()
list(APPEND OF_INCLUDE_PATH ${OF_PATH}/libs/fmodex/include)


#FREEIMAGE
list(APPEND OF_LIBS ${OF_PATH}/libs/FreeImage/lib/vs/${AR}/FreeImage.lib)
list(APPEND OF_INCLUDE_PATH ${OF_PATH}/libs/FreeImage/include)


#FREETYPE
list(APPEND OF_LIBS ${OF_PATH}/libs/freetype/lib/vs/${AR}/libfreetype.lib)
list(APPEND OF_INCLUDE_PATH
    ${OF_PATH}/libs/freetype/include
    ${OF_PATH}/libs/freetype/include/freetype2
    )


#GLEW
list(APPEND OF_LIBS ${OF_PATH}/libs/glew/lib/vs/${AR}/glew32s.lib)
list(APPEND OF_INCLUDE_PATH ${OF_PATH}/libs/glew/include)


#GLFW
list(APPEND OF_LIBS ${OF_PATH}/libs/glfw/lib/vs/${AR}/glfw3.lib)
list(APPEND OF_INCLUDE_PATH
    ${OF_PATH}/libs/glfw/include
    ${OF_PATH}/libs/glfw/include/GLFW
    )


#GLU
list(APPEND OF_LIBS ${OF_PATH}/libs/glu/lib/vs/Win32/glu32.lib)
list(APPEND OF_INCLUDE_PATH ${OF_PATH}/libs/glu/include)


#GLUT
list(APPEND OF_LIBS ${OF_PATH}/libs/glut/lib/vs/${AR}/glut32.lib)
list(APPEND OF_INCLUDE_PATH ${OF_PATH}/libs/glut/include)


#OPENSSL
list(APPEND OF_LIBS ${OF_PATH}/libs/openssl/lib/vs/${AR}/libeay32md.lib)
list(APPEND OF_LIBS ${OF_PATH}/libs/openssl/lib/vs/${AR}/ssleay32md.lib)
list(APPEND OF_INCLUDE_PATH ${OF_PATH}/libs/openssl/include)
list(APPEND OF_INCLUDE_PATH ${OF_PATH}/libs/openssl/include/openssl)


#POCO
if(DEBUG_MODE)
    list(APPEND OF_LIBS
        ${OF_PATH}/libs/poco/lib/vs/${AR}/PocoCryptomdd.lib
        ${OF_PATH}/libs/poco/lib/vs/${AR}/PocoUtilmdd.lib
        ${OF_PATH}/libs/poco/lib/vs/${AR}/PocoXMLmdd.lib
        ${OF_PATH}/libs/poco/lib/vs/${AR}/PocoNetmdd.lib
        ${OF_PATH}/libs/poco/lib/vs/${AR}/PocoNetSSLmdd.lib
        ${OF_PATH}/libs/poco/lib/vs/${AR}/PocoFoundationmdd.lib
        ${OF_PATH}/libs/poco/lib/vs/${AR}/PocoJSONmdd.lib
        )
else()
    list(APPEND OF_LIBS
        ${OF_PATH}/libs/poco/lib/vs/${AR}/PocoCryptomd.lib
        ${OF_PATH}/libs/poco/lib/vs/${AR}/PocoUtilmd.lib
        ${OF_PATH}/libs/poco/lib/vs/${AR}/PocoXMLmd.lib
        ${OF_PATH}/libs/poco/lib/vs/${AR}/PocoNetmd.lib
        ${OF_PATH}/libs/poco/lib/vs/${AR}/PocoNetSSLmd.lib
        ${OF_PATH}/libs/poco/lib/vs/${AR}/PocoFoundationmd.lib
        ${OF_PATH}/libs/poco/lib/vs/${AR}/PocoJSONmd.lib
        )
endif(DEBUG_MODE)
    list(APPEND OF_INCLUDE_PATH ${OF_PATH}/libs/poco/include)


#QUICKTIME
list(APPEND OF_LIBS ${OF_PATH}/libs/quicktime/lib/vs/Win32/qtmlClient.lib)
list(APPEND OF_LIBS ${OF_PATH}/libs/quicktime/lib/vs/Win32/QTSClient.lib)
list(APPEND OF_LIBS ${OF_PATH}/libs/quicktime/lib/vs/Win32/Rave.lib)
list(APPEND OF_INCLUDE_PATH ${OF_PATH}/libs/quicktime/include)


#RTAUDIO
if(DEBUG_MODE)
    list(APPEND OF_LIBS ${OF_PATH}/libs/rtAudio/lib/vs/${AR}/rtAudioD.lib)
else()
    list(APPEND OF_LIBS ${OF_PATH}/libs/rtAudio/lib/vs/${AR}/rtAudio.lib)
endif(DEBUG_MODE)
    list(APPEND OF_INCLUDE_PATH ${OF_PATH}/libs/rtAudio/include)


#TESS2
list(APPEND OF_LIBS ${OF_PATH}/libs/tess2/lib/vs/${AR}/tess2.lib)
list(APPEND OF_INCLUDE_PATH ${OF_PATH}/libs/tess2/include)


#UTF8CPP
list(APPEND OF_INCLUDE_PATH
    ${OF_PATH}/libs/utf8cpp/include
    ${OF_PATH}/libs/utf8cpp/include/utf8
    )


#VIDEO_INPUT
if(DEBUG_MODE)
    list(APPEND OF_LIBS ${OF_PATH}/libs/videoInput/lib/vs/${AR}/videoInputD.lib)
else()
    list(APPEND OF_LIBS ${OF_PATH}/libs/videoInput/lib/vs/${AR}/videoInput.lib)
endif(DEBUG_MODE)
    list(APPEND OF_INCLUDE_PATH ${OF_PATH}/libs/videoInput/include)


#SYSTEM LIBS
find_library(MSIMG32 msimg32)
find_library(OPEN_GL_32 OpenGL32)
find_library(KERNEL_32 kernel32)
find_library(SETUP_API setupapi)
find_library(VFW_32 Vfw32)
find_library(COMCTL_32 comctl32)
find_library(DSOUND dsound)
find_library(USER_32 user32)
find_library(GDI_32 gdi32)
find_library(WINSPOOL winspool)
find_library(COMDLG_32 comdlg32)
find_library(ADVAPI_32 advapi32)
find_library(SHELL_32 shell32)
find_library(OLE_32 ole32)
find_library(UUID uuid)
find_library(CRYPT_32 crypt32)
find_library(WS2_32 Ws2_32)
find_library(ODBC_32 odbc32)
find_library(ODBCCP_32 odbccp32)
find_library(GLU_32 GLu32)
find_library(WINMM winmm)

list(APPEND OF_LIBS
    ${MSIMG32}
    ${OPEN_GL_32}
    ${KERNEL_32}
    ${SETUP_API}
    ${VFW_32}
    ${COMCTL_32}
    ${DSOUND}
    ${USER_32}
    ${GDI_32}
    ${WINSPOOL}
    ${COMDLG_32}
    ${ADVAPI_32}
    ${SHELL_32}
    ${OLE_32}
    ${UUID}
    ${CRYPT_32}
    ${WS2_32}
    ${ODBC_32}
    ${ODBCCP_32}
    ${GLU_32}
    )

#OPENFRAMEORKS
list(APPEND OF_INCLUDE_PATH
    ${OF_PATH}/libs/openFrameworks
    ${OF_PATH}/libs/openFrameworks/types
    ${OF_PATH}/libs/openFrameworks/sound
    ${OF_PATH}/libs/openFrameworks/video
    ${OF_PATH}/libs/openFrameworks/3d
    ${OF_PATH}/libs/openFrameworks/math
    ${OF_PATH}/libs/openFrameworks/events
    ${OF_PATH}/libs/openFrameworks/utils
    ${OF_PATH}/libs/openFrameworks/gl
    ${OF_PATH}/libs/openFrameworks/app
    ${OF_PATH}/libs/openFrameworks/graphics
    ${OF_PATH}/libs/openFrameworks/communication
    )

if (USE_PRECOMPILED_LIB)
    if (DEBUG_MODE)
        set(OF_LIB_PATH ${OF_PATH}/libs/openFrameworksCompiled/lib/vs/${AR}/openframeworksLib_debug.lib)
    else()
        set(OF_LIB_PATH ${OF_PATH}/libs/openFrameworksCompiled/lib/vs/${AR}/openframeworksLib_release.lib)
    endif(DEBUG_MODE)

    if (EXISTS ${OF_LIB_PATH})
        list(APPEND OF_LIBS ${OF_LIB_PATH})
        message("Using precompiled openFrameworks")
    else()
        set(USE_PRECOMPILED_LIB false)
        message("Compiling openFrameworks from source")
    endif()
else()
    message("Compiling openFrameworks from source")
endif(USE_PRECOMPILED_LIB)

###########################################################
list(APPEND OF_INCLUDE_PATH ${OF_PATH}/libs/json/include)
include_directories(${OF_INCLUDE_PATH})

#3d
set(OF_SRC
    ${OF_PATH}/libs/openFrameworks/3d/of3dPrimitives.cpp
    ${OF_PATH}/libs/openFrameworks/3d/of3dUtils.cpp
    ${OF_PATH}/libs/openFrameworks/3d/ofCamera.cpp
    ${OF_PATH}/libs/openFrameworks/3d/ofEasyCam.cpp
    ${OF_PATH}/libs/openFrameworks/3d/ofMesh.cpp
    ${OF_PATH}/libs/openFrameworks/3d/ofNode.cpp
    )

set(OF_HEADERS
    ${OF_PATH}/libs/openFrameworks/3d/of3dPrimitives.h
    ${OF_PATH}/libs/openFrameworks/3d/of3dUtils.h
    ${OF_PATH}/libs/openFrameworks/3d/ofCamera.h
    ${OF_PATH}/libs/openFrameworks/3d/ofEasyCam.h
    ${OF_PATH}/libs/openFrameworks/3d/ofMesh.h
    ${OF_PATH}/libs/openFrameworks/3d/ofNode.h
    )


#app
list(APPEND OF_SRC
    ${OF_PATH}/libs/openFrameworks/app/ofAppGLFWWindow.cpp
    ${OF_PATH}/libs/openFrameworks/app/ofAppGlutWindow.cpp
    ${OF_PATH}/libs/openFrameworks/app/ofAppNoWindow.cpp
    ${OF_PATH}/libs/openFrameworks/app/ofAppRunner.cpp
    ${OF_PATH}/libs/openFrameworks/app/ofMainLoop.cpp
    )

list(APPEND OF_HEADERS
    ${OF_PATH}/libs/openFrameworks/app/ofAppBaseWindow.h
    ${OF_PATH}/libs/openFrameworks/app/ofAppGLFWWindow.h
    ${OF_PATH}/libs/openFrameworks/app/ofAppGlutWindow.h
    ${OF_PATH}/libs/openFrameworks/app/ofAppNoWindow.h
    ${OF_PATH}/libs/openFrameworks/app/ofAppRunner.h
    ${OF_PATH}/libs/openFrameworks/app/ofBaseApp.h
    ${OF_PATH}/libs/openFrameworks/app/ofMainLoop.h
    )


#communication
list(APPEND OF_SRC
    ${OF_PATH}/libs/openFrameworks/communication/ofSerial.cpp
    ${OF_PATH}/libs/openFrameworks/communication/ofArduino.cpp
    )

list(APPEND OF_HEADERS
    ${OF_PATH}/libs/openFrameworks/communication/ofSerial.h
    ${OF_PATH}/libs/openFrameworks/communication/ofArduino.h
    )


#events
list(APPEND OF_SRC
    ${OF_PATH}/libs/openFrameworks/events/ofEvents.cpp
    )

list(APPEND OF_HEADERS
    ${OF_PATH}/libs/openFrameworks/events/ofEvent.h
    ${OF_PATH}/libs/openFrameworks/events/ofEvents.h
    ${OF_PATH}/libs/openFrameworks/events/ofEventUtils.h
    )


#gl
list(APPEND OF_SRC
    ${OF_PATH}/libs/openFrameworks/gl/ofBufferObject.cpp
    ${OF_PATH}/libs/openFrameworks/gl/ofFbo.cpp
    ${OF_PATH}/libs/openFrameworks/gl/ofGLProgrammableRenderer.cpp
    ${OF_PATH}/libs/openFrameworks/gl/ofGLRenderer.cpp
    ${OF_PATH}/libs/openFrameworks/gl/ofGLUtils.cpp
    ${OF_PATH}/libs/openFrameworks/gl/ofLight.cpp
    ${OF_PATH}/libs/openFrameworks/gl/ofMaterial.cpp
    ${OF_PATH}/libs/openFrameworks/gl/ofShader.cpp
    ${OF_PATH}/libs/openFrameworks/gl/ofTexture.cpp
    ${OF_PATH}/libs/openFrameworks/gl/ofVbo.cpp
    ${OF_PATH}/libs/openFrameworks/gl/ofVboMesh.cpp
    )

list(APPEND OF_HEADERS
    ${OF_PATH}/libs/openFrameworks/gl/ofBufferObject.h
    ${OF_PATH}/libs/openFrameworks/gl/ofFbo.h
    ${OF_PATH}/libs/openFrameworks/gl/ofGLProgrammableRenderer.h
    ${OF_PATH}/libs/openFrameworks/gl/ofGLRenderer.h
    ${OF_PATH}/libs/openFrameworks/gl/ofGLUtils.h
    ${OF_PATH}/libs/openFrameworks/gl/ofLight.h
    ${OF_PATH}/libs/openFrameworks/gl/ofMaterial.h
    ${OF_PATH}/libs/openFrameworks/gl/ofShader.h
    ${OF_PATH}/libs/openFrameworks/gl/ofTexture.h
    ${OF_PATH}/libs/openFrameworks/gl/ofVbo.h
    ${OF_PATH}/libs/openFrameworks/gl/ofVboMesh.h
    )


#graphics
list(APPEND OF_SRC
    ${OF_PATH}/libs/openFrameworks/graphics/of3dGraphics.cpp
    ${OF_PATH}/libs/openFrameworks/graphics/ofBitmapFont.cpp
    ${OF_PATH}/libs/openFrameworks/graphics/ofCairoRenderer.cpp
    ${OF_PATH}/libs/openFrameworks/graphics/ofGraphics.cpp
    ${OF_PATH}/libs/openFrameworks/graphics/ofImage.cpp
    ${OF_PATH}/libs/openFrameworks/graphics/ofPath.cpp
    ${OF_PATH}/libs/openFrameworks/graphics/ofPixels.cpp
    ${OF_PATH}/libs/openFrameworks/graphics/ofPolyline.cpp
    ${OF_PATH}/libs/openFrameworks/graphics/ofRendererCollection.cpp
    ${OF_PATH}/libs/openFrameworks/graphics/ofTessellator.cpp
    ${OF_PATH}/libs/openFrameworks/graphics/ofTrueTypeFont.cpp
    )

list(APPEND OF_HEADERS
    ${OF_PATH}/libs/openFrameworks/graphics/of3dGraphics.h
    ${OF_PATH}/libs/openFrameworks/graphics/ofBitmapFont.h
    ${OF_PATH}/libs/openFrameworks/graphics/ofCairoRenderer.h
    ${OF_PATH}/libs/openFrameworks/graphics/ofGraphics.h
    ${OF_PATH}/libs/openFrameworks/graphics/ofImage.h
    ${OF_PATH}/libs/openFrameworks/graphics/ofPath.h
    ${OF_PATH}/libs/openFrameworks/graphics/ofPixels.h
    ${OF_PATH}/libs/openFrameworks/graphics/ofPolyline.h
    ${OF_PATH}/libs/openFrameworks/graphics/ofRendererCollection.h
    ${OF_PATH}/libs/openFrameworks/graphics/ofTessellator.h
    ${OF_PATH}/libs/openFrameworks/graphics/ofTrueTypeFont.h
    )


#math
list(APPEND OF_SRC
    ${OF_PATH}/libs/openFrameworks/math/ofMath.cpp
    ${OF_PATH}/libs/openFrameworks/math/ofMatrix3x3.cpp
    ${OF_PATH}/libs/openFrameworks/math/ofMatrix4x4.cpp
    ${OF_PATH}/libs/openFrameworks/math/ofQuaternion.cpp
    ${OF_PATH}/libs/openFrameworks/math/ofVec2f.cpp
    ${OF_PATH}/libs/openFrameworks/math/ofVec4f.cpp
    )

list(APPEND OF_HEADERS
    ${OF_PATH}/libs/openFrameworks/math/ofMath.h
    ${OF_PATH}/libs/openFrameworks/math/ofMatrix3x3.h
    ${OF_PATH}/libs/openFrameworks/math/ofMatrix4x4.h
    ${OF_PATH}/libs/openFrameworks/math/ofQuaternion.h
    ${OF_PATH}/libs/openFrameworks/math/ofVec2f.h
    ${OF_PATH}/libs/openFrameworks/math/ofVec3f.h
    ${OF_PATH}/libs/openFrameworks/math/ofVec4f.h
    ${OF_PATH}/libs/openFrameworks/math/ofVectorMath.h
    )


#sound
list(APPEND OF_SRC
    ${OF_PATH}/libs/openFrameworks/sound/ofBaseSoundStream.cpp
    ${OF_PATH}/libs/openFrameworks/sound/ofFmodSoundPlayer.cpp
    ${OF_PATH}/libs/openFrameworks/sound/ofOpenALSoundPlayer.cpp
    ${OF_PATH}/libs/openFrameworks/sound/ofRtAudioSoundStream.cpp
    ${OF_PATH}/libs/openFrameworks/sound/ofSoundBuffer.cpp
    ${OF_PATH}/libs/openFrameworks/sound/ofSoundPlayer.cpp
    ${OF_PATH}/libs/openFrameworks/sound/ofSoundStream.cpp
    )

list(APPEND OF_HEADERS
    ${OF_PATH}/libs/openFrameworks/sound/ofBaseSoundPlayer.h
    ${OF_PATH}/libs/openFrameworks/sound/ofBaseSoundStream.h
    ${OF_PATH}/libs/openFrameworks/sound/ofOpenALSoundPlayer.h
    ${OF_PATH}/libs/openFrameworks/sound/ofFmodSoundPlayer.h
    ${OF_PATH}/libs/openFrameworks/sound/ofRtAudioSoundStream.h
    ${OF_PATH}/libs/openFrameworks/sound/ofSoundBuffer.h
    ${OF_PATH}/libs/openFrameworks/sound/ofSoundPlayer.h
    ${OF_PATH}/libs/openFrameworks/sound/ofSoundStream.h
    ${OF_PATH}/libs/openFrameworks/sound/ofSoundUtils.h
    )

#types
list(APPEND OF_SRC
    ${OF_PATH}/libs/openFrameworks/types/ofBaseTypes.cpp
    ${OF_PATH}/libs/openFrameworks/types/ofColor.cpp
    ${OF_PATH}/libs/openFrameworks/types/ofParameter.cpp
    ${OF_PATH}/libs/openFrameworks/types/ofParameterGroup.cpp
    ${OF_PATH}/libs/openFrameworks/types/ofRectangle.cpp
    )

list(APPEND OF_HEADERS
    ${OF_PATH}/libs/openFrameworks/types/ofBaseTypes.h
    ${OF_PATH}/libs/openFrameworks/types/ofColor.h
    ${OF_PATH}/libs/openFrameworks/types/ofParameter.h
    ${OF_PATH}/libs/openFrameworks/types/ofParameterGroup.h
    ${OF_PATH}/libs/openFrameworks/types/ofPoint.h
    ${OF_PATH}/libs/openFrameworks/types/ofRectangle.h
    ${OF_PATH}/libs/openFrameworks/types/ofTypes.h
    )


#utils
list(APPEND OF_SRC
    ${OF_PATH}/libs/openFrameworks/utils/ofFileUtils.cpp
    ${OF_PATH}/libs/openFrameworks/utils/ofFpsCounter.cpp
    ${OF_PATH}/libs/openFrameworks/utils/ofLog.cpp
    ${OF_PATH}/libs/openFrameworks/utils/ofMatrixStack.cpp
    ${OF_PATH}/libs/openFrameworks/utils/ofSystemUtils.cpp
    ${OF_PATH}/libs/openFrameworks/utils/ofThread.cpp
    ${OF_PATH}/libs/openFrameworks/utils/ofTimer.cpp
    ${OF_PATH}/libs/openFrameworks/utils/ofURLFileLoader.cpp
    ${OF_PATH}/libs/openFrameworks/utils/ofUtils.cpp
    ${OF_PATH}/libs/openFrameworks/utils/ofXml.cpp
    )

list(APPEND OF_HEADERS
    ${OF_PATH}/libs/openFrameworks/utils/ofFpsCounter.h
    ${OF_PATH}/libs/openFrameworks/utils/ofConstants.h
    ${OF_PATH}/libs/openFrameworks/utils/ofFileUtils.h
    ${OF_PATH}/libs/openFrameworks/utils/ofLog.h
    ${OF_PATH}/libs/openFrameworks/utils/ofMatrixStack.h
    ${OF_PATH}/libs/openFrameworks/utils/ofSystemUtils.h
    ${OF_PATH}/libs/openFrameworks/utils/ofThread.h
    ${OF_PATH}/libs/openFrameworks/utils/ofThreadChannel.h
    ${OF_PATH}/libs/openFrameworks/utils/ofTimer.h
    ${OF_PATH}/libs/openFrameworks/utils/ofURLFileLoader.h
    ${OF_PATH}/libs/openFrameworks/utils/ofUtils.h
    ${OF_PATH}/libs/openFrameworks/utils/ofXml.h
    ${OF_PATH}/libs/openFrameworks/utils/ofNoise.h
    )


#video
list(APPEND OF_SRC
    ${OF_PATH}/libs/openFrameworks/video/ofDirectShowGrabber.cpp
    ${OF_PATH}/libs/openFrameworks/video/ofDirectShowPlayer.cpp
    ${OF_PATH}/libs/openFrameworks/video/ofVideoGrabber.cpp
    ${OF_PATH}/libs/openFrameworks/video/ofVideoPlayer.cpp
)

list(APPEND OF_HEADERS
    ${OF_PATH}/libs/openFrameworks/video/ofDirectShowGrabber.h
    ${OF_PATH}/libs/openFrameworks/video/ofDirectShowPlayer.h
    ${OF_PATH}/libs/openFrameworks/video/ofVideoGrabber.h
    ${OF_PATH}/libs/openFrameworks/video/ofVideoPlayer.h
)


list(APPEND OF_HEADERS ${OF_PATH}/libs/openFrameworks/ofMain.h)

add_library(openFrameworks STATIC
  ${OF_SRC}
)


set_target_properties(openFrameworks
    PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
)
