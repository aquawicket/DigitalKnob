#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

# This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
#
# For the latest information, see https://github.com/aquawicket/DigitalKnob
#
# Copyright(c) 2010 - 2024 Digitalknob Team, and contributors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files(the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions :
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

dk_disable(aubio)
dk_disable(boost)
dk_disable(bzip2-win-build)
#dk_disable(cef_binary)
dk_disable(dukluv)
dk_disable(fontconfig)
dk_disable(openal)
dk_disable(freealut)  # requires openal
dk_disable(gzip)
dk_disable(jasper)
dk_disable(jerryscript)
dk_disable(libcaca)
dk_disable(mbedtls)
dk_disable(libevent)
dk_disable(libjodycode)
dk_disable(libtorrent)
dk_disable(lighttpd)
dk_disable(llvm-project)
dk_disable(luajit)
dk_disable(netsurf)
dk_disable(notepadpp)
dk_disable(openblas)    # working
dk_disable(opencv)
dk_disable(openframeworks)
dk_disable(poco)
dk_disable(podofo)
dk_disable(sdl_mixer)
dk_disable(stackwalker)
dk_disable(rlottie)
dk_disable(rmlui_64b36dc)
dk_disable(rmlui-d3d11)
dk_disable(sdl-gpu)
dk_disable(sdl_net)
dk_disable(tesseract)
dk_disable(uwebsockets)
dk_disable(waave)
dk_disable(wasm3)
dk_disable(webref)
dk_disable(windows-sdk)
dk_disable(wxwidgets)
dk_disable(x264)
dk_disable(x265)
dk_disable(DKDOM_Window)
dk_disable(DKHook)
dk_disable(DKRestart)
dk_disable(DKRmlTestElements)	# build errors
dk_disable(DKWebSockets)
###########################


if("$ENV{WSL_DISTRO_NAME}" STREQUAL "Alpine")
	dk_disable(libxml2)
endif()
dk_disable(glfw)
#dk_disable(smpeg2)				# smpeg2-2.0.0/MPEGaudio.h:133:7: error: ISO C++17 does not allow 'register' storage class specifier

# DISABLED FOR ALL TARGETS
dk_disable(DKPlugin1)			# TODO
dk_disable(DKPlugin2)			# TODO
dk_disable(DKRmlAudio)			# build errors
dk_disable(DKRmlIframe)			# build errors

dk_disable(DKTemplateEventTest)	# DEPRECATED: using DKEventTargetTest instead
dk_disable(DKWidget)			# DEPRECATED
dk_disable(bgfx)				# TODO
dk_disable(java)				# TODO
dk_disable(jpeg)				# DEPRECATED: using libjpeg_turbo instead
dk_disable(libx11)				# TODO
dk_disable(mpg123)				# TODO
dk_disable(sdl2_gif)			# DEPRECATED: using SDL_Image animation instead
dk_disable(sdl2_giflib_sa)		# DEPRECATED: updated version of sdl2_gif. Using SDL_Image animation instead
dk_disable(simple-getch)		# DEPRECATED: kept for reference
dk_disable(sw)					# DEPRECATED: requested by leptonica but not required
dk_disable(sw-client)			# DEPRECATED: requested by leptonica but not required

# OpenSceneGraph (disabled)
dk_disable(openscenegraph)
dk_disable(osgaudio)			# requires openscenegraph
dk_disable(osgbullet)			# requires openscenegraph, bullet3, osgworks
dk_disable(osgrmlui)			# requires openscenegraph
dk_disable(osgworks)			# requires openscenegraph
dk_disable(DKOsgAudio)			# requires openscenegraph
dk_disable(DKOsgCef)			# requires openscenegraph
dk_disable(DKOsgLights)			# requires openscenegraph
dk_disable(DKOsgManipulator)	# requires openscenegraph
dk_disable(DKOsgModel)			# requires openscenegraph
dk_disable(DKOsgNotify)			# requires openscenegraph
dk_disable(DKOsgPhysics)		# requires openscenegraph
dk_disable(DKOsgPicker)			# requires openscenegraph
dk_disable(DKOsgRml)			# requires openscenegraph
dk_disable(DKOsgStats)			# requires openscenegraph
dk_disable(DKOsgTerrain)		# requires openscenegraph
dk_disable(DKOsgVideo)			# requires openscenegraph
dk_disable(DKOsgViewer)			# requires openscenegraph 
dk_disable(DKOsgWidget)			# requires openscenegraph 
dk_disable(DKOsgWindow)			# requires openscenegraph 
dk_disable(DKSDLOsg)			# requires openscenegraph, sdl

# OpenFrameworks (disabled)
dk_disable(DKOfWindow)

# SFML (disabled)
dk_disable(sfml)
dk_disable(DKSFMLRml)			# requires sfml
dk_disable(DKSFMLWindow)		# requires sfml

# doxygen (disabled)
dk_disable(doxygen)

# duk4vb (disabled)
dk_disable(duk4vb)

# ffmpeg (disabled)
dk_disable(ffmpeg)

# diff-match-patch (disabled)
dk_disable(diff-match-patch)

dk_disable(boxer)
dk_disable(lz4)
dk_disable(libb2)
dk_disable(Pyportable)
#dk_disable(visualstudio)

# Disabled for Android targets
if(ANDROID)
	dk_disable(DKCef)				# requires cef_binary
	dk_disable(DKCefChild)			# requires cef_binary
	dk_disable(DKHandles)			# could not find DKHandles
	dk_disable(DKMidi)				# requires rtmidi
	dk_disable(DKMySql)				# requires curl			
	dk_disable(DKOcr)				# requires tesseract
	dk_disable(DKSDLCef)			# requires cef_binary
	#dk_disable(DKSDLWaave)			# requires waave
	dk_disable(DKSDLWav)			# build errors
	dk_disable(DKScreenRecorder)	# requires opencv
	dk_disable(DKThread)			# requires threadpool
	dk_disable(DKTorrent)			# requires libtorrent
	dk_disable(DKUpdate)			# requires DKCurl
	dk_disable(DKVncClient)			# requires libvncserver
	dk_disable(DKVncServer)			# requires libvncserver
	dk_disable(DKWebSockets)		# requires libwebsockets or uwebsockets
	dk_disable(DKWebview)			# compiling errors
	dk_disable(android-java-tools) 	# download link broken
	dk_disable(aom)					# build errors
	dk_disable(aubio)				# build errors	
	dk_disable(boxer)				# fatal error : 'boxer/boxer.h' file not found
	dk_disable(bullet3)				# build errors
	dk_disable(cryptopp)
	dk_disable(dukluv)
	dk_disable(fontconfig)
	dk_disable(freealut)			# DKFunctions.cmake:4405->dk_findFiles():  files is invalid
	dk_disable(gdal)
	dk_disable(glew)
	dk_disable(glfw)
	dk_disable(gzip)
	dk_disable(jasper)
	dk_disable(kdevelop)			# Permission denied running KDevelop-5.6.1-x86_64.AppImage
	dk_disable(libcaca)				# no CMakeLists.txt
	dk_disable(libexpat)
	dk_disable(libtorrent)			# Could not find BOOST
	dk_disable(libvncserver)
	dk_disable(libwebp)
	dk_disable(lighttpd)			# DKMAKE.cmake incomplete
	#dk_disable(nasm)
	dk_disable(ncurses)				# error: '..' is not recognized as an internal or external command
	dk_disable(openal)				# The system cannot find the file specified
	dk_disable(openblas)
	dk_disable(opencv)				# build errors
	dk_disable(openframeworks)		# error: CMakeLists.txt broken
	dk_disable(openmw)
	dk_disable(openssl)
	dk_disable(poco)				# error: Compiler does not support C++14
	dk_disable(podofo)				# error: can't find "fontconfig/fontconfig.h"
	dk_disable(rmlui-d3d11)
	dk_disable(rtaudio)				# build errors
	dk_disable(rtmidi)				# ALSA API requested but no ALSA dev libraries found
	dk_disable(sdl-gpu)				# The target "Sdl_gpu" does not exist in the project
	dk_disable(sdl_rtf)
	dk_disable(tesseract)			# requires leptonica
	dk_disable(waave)
	dk_disable(wasm3)
	dk_disable(x264)
	dk_disable(x265)
endif(ANDROID)

# Disabled for Android 64bit targets
if(ANDROID_ARM64)
	dk_disable(boost)
endif(ANDROID_ARM64)

# Disabled for Emscripten targets
if(EMSCRIPTEN) 
	dk_disable(DKArchive)			# requires libarchive
	dk_disable(DKAudio)
	dk_disable(DKCef)
	dk_disable(DKCefChild)
	dk_disable(DKCrypto)
	dk_disable(DKCurl)				# requires curl
	dk_disable(DKDebug)				# DKDebug.cpp:158:10: fatal error: 'execinfo.h' file not found
	dk_disable(DKHook)
	dk_disable(DKImageMagick)
	dk_disable(DKJerryscript)
	dk_disable(DKMidi)
	dk_disable(DKMySql)
	dk_disable(DKOcr)
	dk_disable(DKRestart)
	dk_disable(DKSDLAudio)
	dk_disable(DKSDLCef)
	dk_disable(DKSDLMetalWindow)
	#dk_disable(DKSDLWaave)			# requires waave
	dk_disable(DKSDLWav)
	dk_disable(DKScreenRecorder)
	dk_disable(DKThread)
	dk_disable(DKTorrent)
	dk_disable(DKUpdate)
	dk_disable(DKUWebSocketsServer)
	dk_disable(DKVncClient)			# case value evaluates to 4294967295, which cannot be narrowed to type 'int'
	dk_disable(DKWebSockets)
	dk_disable(aom)
	dk_disable(astyle)
	dk_disable(aubio)
	dk_disable(audio_toolbox)
	dk_disable(av_foundation)
	dk_disable(av_kit)
	dk_disable(avf_audio)
	dk_disable(boxer)				# CMake Error: CMake can not determine link language for target "Boxer"
	dk_disable(cef_binary)
	dk_disable(core_audio)
	dk_disable(core_foundation)
	dk_disable(core_graphics)
	dk_disable(core_haptics)
	dk_disable(core_motion)
	dk_disable(core_services)
	dk_disable(core_video)
	dk_disable(dukluv)
	dk_disable(fontconfig)
	dk_disable(foundation)
	dk_disable(game_controller)
	dk_disable(gdal)
	dk_disable(gl_kit)
	dk_disable(glew)
	dk_disable(glfw)
	dk_disable(gzip)
	dk_disable(imagemagick)
	dk_disable(iokit)
	dk_disable(jasper)
	dk_disable(kdevelop)
	dk_disable(libcaca)
	dk_disable(libexpat)
	dk_disable(libsndfile)
	dk_disable(libtorrent)
	dk_disable(lighttpd)
	dk_disable(m)
	dk_disable(media_player)
	dk_disable(metal)
	dk_disable(mlocate)
	dk_disable(msinttypes)
	#dk_disable(nasm)
	dk_disable(ncurses)
	dk_disable(openblas)			# CMake Error: When cross compiling, a TARGET is required
	dk_disable(opencv)				# ittnotify_config.h:376:12: error: call to undeclared function '__TBB_machine_fetchadd4'
	dk_disable(openframeworks)
	dk_disable(opus)
	dk_disable(podofo)				# requires fontconfig
	dk_disable(quartz_core)
	dk_disable(rmlui-d3d11)
	dk_disable(rtaudio)				# ALSA API requested but no ALSA dev libraries found
	dk_disable(rtmidi)				# ALSA API requested but no ALSA dev libraries found
	dk_disable(sdl-gpu)				# emcc: error: setting 'USE_SDL' expects 'bool' but got 'int'
	dk_disable(sdl_mixer)			# emcc: error: setting 'USE_SDL' expects 'bool' but got 'int'
	dk_disable(sdl_net)				# emcc: error: setting 'USE_SDL' expects 'bool' but got 'int'
	dk_disable(sdl_rtf)
	dk_disable(system_configuration)
	dk_disable(tesseract)			# missing <allheaders.h>
	dk_disable(uwebsockets)
	dk_disable(waave)
	dk_disable(wasm3)
	dk_disable(x265)
	dk_disable(xz)					# CMake Error: TEST_BIG_ENDIAN found no result!
endif(EMSCRIPTEN) 


# Disabled for iOS and iOS-Simulator targets
if(IOS OR IOSSIM)  
	dk_disable(DKCef)				# requires cef_binary
	#dk_disable(DKCefChild)			# requires cef_binary
	#dk_disable(DKJerryscript)		# requires jerryscript
	#dk_disable(DKMidi)				# requires rtmidi
	#dk_disable(DKOcr)				# requires tesseract
	#dk_disable(DKSDLCef)			# requires cef_binary
	##dk_disable(DKSDLWaave)			# requires waave
	#dk_disable(DKSDLWav)			# build errors
	#dk_disable(DKScreenRecorder)	# requires opencv
	#dk_disable(DKThread)			# requires threadpool
	#dk_disable(DKTorrent)			# requires libtorrent
	#dk_disable(DKUpdate)			# build errors
	#dk_disable(DKVncClient)			# requires libvncserver
	#dk_disable(DKVncServer)			# requires libvncserver
	#dk_disable(aom)					# build errors
	#dk_disable(aubio)				# build errors
	#dk_disable(boost)				# clang error: no such file or direcotry: libboost_atomic.a, libboost_chrono.a, etc, etc, etc
	#dk_disable(boxer)				# COCOA_LIBRARY not found
	#dk_disable(bullet3)				# OPENGL-NOTFOUND COCOA-NOTFOUND
	#dk_disable(cryptopp)			# ** BUILD FAILED ** /blake2b_simd.cpp
	#dk_disable(dukluv)
	#dk_disable(fontconfig)
	#dk_disable(gdal)
	#dk_disable(gzip)
	#dk_disable(imagemagick)			# No such file or directory
	#dk_disable(jasper)
	#dk_disable(jerryscript)			# Error: unknown linker option '-z'
	#dk_disable(leptonica)			# Build Failed: fhmtauto.o
	#dk_disable(libcaca)				# no CMakeLists.txt
	#dk_disable(libexpat)
	#dk_disable(libmd)				# dk_getExtension Function invoked with incorrect arguments
	#dk_disable(libsndfile)			# Cmake Error: install TARGETS given no BUNDLE DESTINATION for MACOSX_BUNDLE executable target "sndfile-info"
	#dk_disable(libtorrent)			# Could not find BOOST
	#dk_disable(libvncserver)		# error C2065: 'nonBlocking': undeclared identifier
	#dk_disable(libwebp)				# TIFF is disabled when statically linking
	#dk_disable(lighttpd)			# DKMAKE.cmake incomplete
	#dk_disable(mlocate)				# Unable to locate a Java Runtime that supports apt
	#dk_disable(ncurses)				# CMake Error: C preprocessor "/lib/cpp" fails sanity check
	#dk_disable(openblas)			# CMake Error: if given arguments: "STREQUAL" "CORE2" Unknown arguments specified
	#dk_disable(opencv)				# CMAKE_SYSTEM_PROCESSOR is not defined
	#dk_disable(openframeworks)		# error: tesselator.h: No such file or directory
	#dk_disable(opensles)			# could not locate OpenSLES Library
	#dk_disable(poco)
	#dk_disable(podofo)				# CMake errors
	#dk_disable(rmlui-d3d11)
	#dk_disable(rtaudio)				# 'CoreAudio/AudioHardware.h' file not found
	#dk_disable(sdl-gpu)				# SDL2MAIN_LIBRARY is NOTFOUND
	#dk_disable(sdl_rtf)
	##dk_disable(smpeg2)				# ** BUILD FAILED ** MPEGstream.cpp
	#dk_disable(tesseract)			# requires leptonica
	#dk_disable(waave)				# ** BUILD FAILED ** src/audio_decoder.c
	#dk_disable(wasm3)				# CMake Error: install TARGETS given no BUNDLE DESTINATION for MACOSX_BUNDLE executbale target "wasm3"
	#dk_disable(x265)
endif(IOS OR IOSSIM)


# Disabled for iOS targets
if(IOS AND NOT IOSSIM)  
	#TODO
endif(IOS AND NOT IOSSIM)


# Disabled for Linux targets
if(LINUX)
	#dk_disable(DKHook)				# 'read' was not declared in this scope
	#dk_disable(DKJerryscript)		# requires jerryscript
	#dk_disable(DKOcr)				# requires tesseract
	##dk_disable(DKSDLWaave)			# requires waave
	#dk_disable(DKSDLWav)			# build errors
	#dk_disable(DKScreenRecorder)
	#dk_disable(DKThread)			# error: need to implement boost::placeholders
	#dk_disable(DKTorrent)			# requires libtorrent
	#dk_disable(DKUpdate)			# error: need to implement boost::placeholders
	#dk_disable(DKWebSockets)		# requires libwebsockets, uwebsockets
	#dk_disable(aubio)
	#dk_disable(boxer)				# error: can't create CMakeFiles/Boxer.dir/src/boxer_linux.cpp.o: No such file or directory
	#dk_disable(dukluv)
	#dk_disable(fontconfig)
	#dk_disable(gdal)
	#dk_disable(glew)				
	#dk_disable(gnutls)
	#dk_disable(gzip)
	#dk_disable(imagemagick)			# libimagemagik.a not found
	#dk_disable(jerryscript)			# build errors
	#dk_disable(kdevelop)			# permission denied
	#dk_disable(leptonica)			# build errors
	#dk_disable(libcaca)				# no CMakeLists.txt
	#dk_disable(libevent)			# libmbedtls.a, needed by 'bin/bench_cascade'.
	#dk_disable(libexpat)
	#dk_disable(libsndfile)			# requires opus
	#dk_disable(libtorrent)			# CMake Error: cannot find source file: deps/try_signal/try_singal.cpp
	#dk_disable(lighttpd)			# DKMAKE.cmake incomplete
	##dk_disable(nasm)
	#dk_disable(openframeworks)		# error: tesselator.h: No such file or directory
	#dk_disable(podofo)				# build errors
	#dk_disable(python)
	#dk_disable(rmlui-d3d11)
	#dk_disable(sdl_rtf)
	##dk_disable(smpeg2)				# can't open patch
	#dk_disable(tesseract)			# requires leptonica
	#dk_disable(waave)
	#dk_disable(x265)
endif(LINUX)


# Disabled for Mac targets
if(MAC) 
	#dk_disable(DKOcr)				# requires tesseract
	##dk_disable(DKSDLWaave)			# requires waave
	#dk_disable(DKSDLWav)			# build errors
	#dk_disable(DKScreenRecorder)
	#dk_disable(DKThread)			# Error: 'boost/thread/xtime.hpp:24 expected identifier TIME_UTC_=1
	#dk_disable(DKTorrent)			# requires libtorrent
	#dk_disable(DKUpdate)			# Error: 'boost/thread/xtime.hpp:24 expected identifier TIME_UTC_=1
	#dk_disable(DKVncClient)			# case value evaluates to 4294967295, which cannot be narrowed to type 'int'
	#dk_disable(aubio)				# breaks DKCefV8
	#dk_disable(dukluv)
	#dk_disable(fontconfig)
	#dk_disable(gdal)
	#dk_disable(gzip)
	#dk_disable(imagemagick)			# no such file or directory: libimagemagik.a
	#dk_disable(leptonica)			# Build Failed: fhmtauto.o
	#dk_disable(libcaca)				# no CMakeLists.txt
	#dk_disable(libexpat)
	#dk_disable(libtorrent)			# CMake Error: cannot find deps/try_signal/try_signal.cpp
	#dk_disable(lighttpd)			# DKMAKE.cmake incomplete
	#dk_disable(mlocate)				# Unable to locate a Java Runtime that supports apt
	#dk_disable(openblas)
	#dk_disable(podofo)				# error: expected ';' at end of declaration
	#dk_disable(rmlui-d3d11)
	#dk_disable(rtmidi)				# Undefined symbols for architecture x86_64
	#dk_disable(sdl-gpu)				# SDL for MAC OS X only supports deploying on 10.7 and above
	#dk_disable(sdl_rtf)
	##dk_disable(smpeg2)				# ** BUILD FAILED ** MPEGstream.cpp
	#dk_disable(tesseract)			# requires leptonica
	#dk_disable(waave)				# error: streaming_objet.h:59 field has incomplete type 'enum PixelFormat'
	#dk_disable(x265)
	#dk_disable(zstd)				# https://github.com/facebook/zstd/issues/3622
endif(MAC)


# Disabled for Raspberry Pi targets
if(RASPBERRY) 
	#dk_disable(DKHook)				# 'read' was not declared in this scope
	#dk_disable(DKJerryscript)		# requires jerryscript
	#dk_disable(DKMidi)				# requires rtmidi
	#dk_disable(DKOcr)				# requires tesseract
	##dk_disable(DKSDLWaave)			# requires waave
	#dk_disable(DKSDLWav)			# build errors
	#dk_disable(DKScreenRecorder)	# requires opencv
	#dk_disable(DKThread)			# requires threadpool
	#dk_disable(DKTorrent)			# requires libtorrent
	#dk_disable(DKUpdate)			# compiling errors
	#dk_disable(DKVncClient)			# requires libvncserver
	#dk_disable(DKVncServer)			# requires libvncserver
	#dk_disable(aom)
	#dk_disable(aubio)
	#dk_disable(boxer)				# fatal error : 'boxer/boxer.h' file not found	
	#dk_disable(dukluv)
	#dk_disable(emsdk)				# 64bit source only
	#dk_disable(fontconfig)
	#dk_disable(gdal)
	#dk_disable(glew)
	#dk_disable(glfw)				# cannot find wayland-scanner
	#dk_disable(gzip)
	#dk_disable(imagemagick)
	#dk_disable(java)
	#dk_disable(jerryscript)
	#dk_disable(kdevelop)
	#dk_disable(libcaca)				# no CMakeLists.txt
	#dk_disable(libexpat)
	#dk_disable(libgtk-3-dev)		# unable to download package
	#dk_disable(libsndfile)
	#dk_disable(libtorrent)			# Could not find BOOST
	#dk_disable(libwebp)
	#dk_disable(libxinerama-dev)		# apt: Unable to locate package libXinerama-dev
	#dk_disable(lighttpd)			# DKMAKE.cmake incomplete
	#dk_disable(lua)
	##dk_disable(nasm)
	#dk_disable(openblas)
	#dk_disable(opencv)				# build errors
	#dk_disable(openframeworks)		# error: cannot find opengles
	#dk_disable(openjdk)
	#dk_disable(opus)
	#dk_disable(pyyaml)
	#dk_disable(rmlui-d3d11)
	#dk_disable(rtmidi)
	#dk_disable(sdl-gpu)
	#dk_disable(sdl_rtf)
	#dk_disable(stackwalker)
	#dk_disable(tesseract)			# requires leptonica
	#dk_disable(upx)
	#dk_disable(waave)
	#dk_disable(x265)
endif(RASPBERRY)


# Disabled for tinycore targets
if(TINYCORE)
	#dk_disable(glew)
	#dk_disable(libasound2-dev)
	#dk_disable(libgl1-mesa-dev)	
#	#dk_disable(mesa)
	#dk_disable(opengl)
	#dk_disable(pyyaml)
endif(TINYCORE)


# Disabled for Windows (MSVC) targets
if(MSVC) 
	#dk_disable(boost)				# error: cl command not found
	#dk_disable(DKOcr)				# requires tesseract
	#dk_disable(DKScreenRecorder)    # requires opencv
	#dk_disable(DKSDLVideo)			# error: 'av_mallocz_array': identifier not found
	##dk_disable(DKSDLWaave)			# requires waave
	#dk_disable(DKSDLWav)			# build errorsE
	#dk_disable(DKThread)			# build errors
	#dk_disable(DKTorrent)			# requires libtorrent
	#dk_disable(DKUpdate)			# build errors
	#dk_disable(aom)					# Perl is required to build libaom.
	#dk_disable(aubio)
	#dk_disable(bzip2)
	#dk_disable(dukluv)
	#dk_disable(fontconfig)
	#dk_disable(gdal)
	#dk_disable(gzip)
	#dk_disable(jasper)
	#dk_disable(leptonica)			# this library is hard to keep alive for some reason. silent dependencies?
	#dk_disable(libcaca)				# no CMakeLists.txt
	#dk_disable(libevent)
	#dk_disable(libexpat)
	#dk_disable(libtorrent)			# Cannot find source file:  deps/try_signal/try_signal.cpp
	#dk_disable(lighttpd)			# DKMAKE.cmake incomplete
	#dk_disable(opencv)
	#dk_disable(openblas)
	#dk_disable(openframeworks)		# error: CMakeLists.txt broken
	#dk_disable(php-src)
	#dk_disable(poco)
	##dk_disable(python3)
	#dk_disable(rmlui-d3d11)
	#dk_disable(sdl_rtf)
	#dk_disable(tesseract)
	#dk_disable(waave)				# error C2065: 'PIX_FMT_YUV420P': undeclared identifier.  https://sourceforge.net/p/guvcview/tickets/34/
	#dk_disable(x264)				# broken with new msys2,   check DKMAKE.cmake build script
	#dk_disable(x265)
endif(MSVC)


# Disabled for Windows 64bit (MSVC) targets
if(MSVC AND WIN_X86_64)
	#dk_disable(DKVncClient)			# requires libvncserver
	#dk_disable(DKVncServer)			# requires libvncserver
	#dk_disable(libvncserver)		# build errors
	#dk_disable(opencv)				# error: Only SIMD128, AVX2 and NEON are supported in Winograd.
	#dk_disable(sdl_net)				# can't find "sys/ioctl.h"
	##dk_disable(smpeg2)				# fatal error C1083: Cannot open include file: 'unistd.h'
endif(MSVC AND WIN_X86_64)


# Disabled for Windows (MINGW) targets
if(MINGW)
	#dk_disable(boost)
	#dk_disable(glew)
	#dk_disable(flac)
	#dk_disable(libexpat)
	#dk_disable(libiconv)
	##dk_disable(smpeg2)	
	#dk_disable(stackwalker)
endif(MINGW)

