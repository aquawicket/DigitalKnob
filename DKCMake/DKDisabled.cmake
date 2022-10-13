# This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
#
# For the latest information, see https://github.com/aquawicket/DigitalKnob
#
# Copyright(c) 2010 - 2022 Digitalknob Team, and contributors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files(the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions :
#
# The above copyright noticeand this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
include_guard()


# DISABLED FOR ALL - TODO: move these into the select OS targets below			
dk_disable(DKPlugin1)				# TODO
dk_disable(DKPlugin2)				# TODO
dk_disable(DKSDLWav)				# compiling errors
dk_disable(DKSDLVideo)				# requires ffmpeg
dk_disable(DKSFMLRml)				# requires sfml, rmlui.  INCOMPLETE
dk_disable(DKThread)				# requires threadpool
dk_disable(DKUpdate)				# compiling errors
dk_disable(gradle)					# TODO
dk_disable(java)					# TODO
dk_disable(jpeg)					# DEPRECATED: using libjpeg_turbo instead
dk_disable(librocket)				# OBSOLETE: replaced by rmlui
dk_disable(libvncserver-master-win) # DEPRECATED: using libvncserver instead
dk_disable(libx11)					# TODO
dk_disable(msys2)					# TODO: currently using msys
dk_disable(sdl2_gif)				# DEPRECATED: using SDL_Image animation instead
dk_disable(sdl2_giflib_sa)			# DEPRECATED: updated version of sdl2_gif. Using SDL_Image animation instead
dk_disable(simple-getch)			# DEPRECATED: kept for reference
dk_disable(sw)						# DEPRECATED: requested by leptonica but not required
dk_disable(sw-client)				# DEPRECATED: requested by leptonica but not required




if(WIN) # Disabled for Windows targets
	dk_disable(DKOcr)				# requires leptonica, tesseract
	dk_disable(DKOFWindow)			# requires openframeworks
	dk_disable(DKOSGAudio)			# requires openscenegraph
	dk_disable(DKOSGCef)			# requires openscenegraph
	dk_disable(DKOSGLights)			# requires openscenegraph
	dk_disable(DKOSGManipulator)	# requires openscenegraph
	dk_disable(DKOSGModel)			# requires openscenegraph
	dk_disable(DKOSGNotify)			# requires openscenegraph
	dk_disable(DKOSGPhysics)		# requires openscenegraph
	dk_disable(DKOSGPicker)			# requires openscenegraph
	dk_disable(DKOSGRml)			# requires openscenegraph
	dk_disable(DKOSGStats)			# requires openscenegraph
	dk_disable(DKOSGTerrain)		# requires openscenegraph
	dk_disable(DKOSGVideo)			# requires openscenegraph
	dk_disable(DKOSGViewer)			# requires openscenegraph 
	dk_disable(DKOSGWidget)			# requires openscenegraph 
	dk_disable(DKOSGWindow)			# requires openscenegraph
	dk_disable(DKScreenRecorder)	# error: 'cvSize' was not declared in this scope
	dk_disable(DKTorrent)			# requires libtorrent
	dk_disable(DKVncClient)			# requires libvncserver
	dk_disable(DKVncServer)			# requires libvncserver
	dk_disable(bullet3)				# build errors
	dk_disable(libcaca)				# no CMakeLists.txt
	dk_disable(libtorrent)			# CMAKE ERROR:  No SOURCES given to target: torrent-rasterbar
	dk_disable(libvncserver)		# error C2065: 'nonBlocking': undeclared identifier
	dk_disable(lighttpd)			# DKMAKE.cmake incomplete
	dk_disable(lua)					# no CMakeLists.txt
	dk_disable(openframeworks)		# error: CMakeLists.txt broken
	dk_disable(openscenegraph)		# osgGA broken
	dk_disable(osgaudio)			# requires openscenegraph
	dk_disable(osgbullet)			# requires openscenegraph
	dk_disable(osgworks)			# requires openscenegraph
	dk_disable(tesseract)			# build errors
	dk_disable(waave)				# requires sdl
endif()

if(WIN_64) # Disabled for Windows 64bit targets
	dk_disable(smpeg2)				# fatal error C1083: Cannot open include file: 'unistd.h'
endif()


if(MAC)  # Disabled for MAC targets
	dk_disable(DKOcr)				# requires leptonica, tesseract
	dk_disable(DKOFWindow)			# requires openframeworks
	dk_disable(DKOSGAudio)			# requires openscenegraph, freealut
	dk_disable(DKOSGCef)			# build errors
	dk_disable(DKOSGPhysics)		# 'btBulletDynamicsCommon.h' file not found
	dk_disable(DKOSGRml)			# build errors
	dk_disable(DKOSGStats)			# build errors
	dk_disable(DKOSGVideo)			# TODO
	dk_disable(DKOSGWidget)			# build errors
	dk_disable(DKScreenRecorder)	# error: 'cvSize' was not declared in this scope
	dk_disable(DKTorrent)			# requires libtorrent
	dk_disable(DKVncClient)			# requires libvncserver
	dk_disable(DKVncServer)			# requires libvncserver
	dk_disable(bullet3)				# library not found for -lBulletInverseDynamicsUtils
	dk_disable(freealut)			# ** BUILD FAILED **
	dk_disable(imagemagick)			# no such file or directory: libimagemagik.a
	dk_disable(leptonica)			# Build Failed: fhmtauto.o
	dk_disable(libcaca)				# no CMakeLists.txt
	dk_disable(libtorrent)			# Could not find BOOST
	dk_disable(libvncserver)		# error C2065: 'nonBlocking': undeclared identifier
	dk_disable(libwebsockets)		# error: unknown type name 'lws_mutex_t'
	dk_disable(libxml2)				# fatal error: 'extra/stricmp.h' file not found
	dk_disable(lighttpd)			# DKMAKE.cmake incomplete
	dk_disable(lua)					# no CMakeLists.txt
	dk_disable(mlocate)				# Unable to locate a Java Runtime that supports apt
	dk_disable(openframeworks)		# error: CMakeLists.txt broken
	dk_disable(osgaudio)			# requires openscenegraph, freealut. ERROR: 'AL/alut.h' file not found
	dk_disable(podofo)				# error: expected ';' at end of declaration
	dk_disable(rtmidi)				# Undefined symbols for architecture x86_64
	dk_disable(sdl-gpu)				# SDL for MAC OS X only supports deploying on 10.7 and above
	dk_disable(smpeg2)				# ** BUILD FAILED ** MPEGstream.cpp
	dk_disable(tesseract)			# requires leptonica
	dk_disable(waave)				# requires sdl
endif()

if(IOS OR IOSSIM)  # Disabled for iOS and iOS-Simulator targets
	dk_disable(boost)				# clang error: no such file or direcotry: libboost_atomic.a, libboost_chrono.a, etc, etc, etc
	dk_disable(boxer)				# COCOA_LIBRARY not found
	dk_disable(bullet3)				# OPENGL-NOTFOUND COCOA-NOTFOUND
	dk_disable(bzip2)				# dk_include Function invoked with incorrect arguments
	dk_disable(cryptopp)			# ** BUILD FAILED ** /blake2b_simd.cpp
	dk_disable(DKCef)				# requires cef_binary
	dk_disable(DKCefChild)			# requires cef_binary
	dk_disable(DKJerryscript)		# requires jerryscript
	dk_disable(DKMidi)				# requires rtmidi
	dk_disable(DKOcr)				# requires leptonica, tesseract
	dk_disable(DKOFWindow)			# requires openframeworks
	dk_disable(DKOSGAudio)			# requires openscenegraph
	dk_disable(DKOSGCef)			# requires openscenegraph
	dk_disable(DKOSGLights)			# requires openscenegraph
	dk_disable(DKOSGManipulator)	# requires openscenegraph
	dk_disable(DKOSGModel)			# requires openscenegraph
	dk_disable(DKOSGNotify)			# requires openscenegraph
	dk_disable(DKOSGPhysics)		# requires openscenegraph
	dk_disable(DKOSGPicker)			# requires openscenegraph
	dk_disable(DKOSGRml)			# requires openscenegraph
	dk_disable(DKOSGStats)			# requires openscenegraph
	dk_disable(DKOSGTerrain)		# requires openscenegraph
	dk_disable(DKOSGVideo)			# requires openscenegraph
	dk_disable(DKOSGViewer)			# requires openscenegraph 
	dk_disable(DKOSGWidget)			# requires openscenegraph 
	dk_disable(DKOSGWindow)			# requires openscenegraph 
	dk_disable(DKScreenRecorder)	# requires opencv
	dk_disable(DKSDLCef)			# requires cef_binary, sdl
	dk_disable(DKSFMLWindow)		# requires sfml
	dk_disable(DKTorrent)			# requires libtorrent
	dk_disable(DKVncClient)			# requires libvncserver
	dk_disable(DKVncServer)			# requires libvncserver
	dk_disable(freealut)			# freealut-master/iossim64 does not contain an Xcode project
	dk_disable(imagemagick)			# No such file or directory
	dk_disable(jerryscript)			# build failed
	dk_disable(leptonica)			# Build Failed: fhmtauto.o
	dk_disable(libcaca)				# no CMakeLists.txt
	dk_disable(libiconv)			# CMake Error at cmake/dist.cmake:144 (install): install TARGETS given no BUNDLE DESTINATION for MACOSX_BUNDLE executable target "iconvcli"
	dk_disable(libjpeg-turbo)		# CMake Error at CMakeLists.txt:60 (string): string no output variable specified
	dk_disable(libmd)				# dk_getExtension Function invoked with incorrect arguments
	dk_disable(libpng)				# no such sysroot directory: 'iphonesimulator'
	dk_disable(libtorrent)			# Could not find BOOST
	dk_disable(libvncserver)		# error C2065: 'nonBlocking': undeclared identifier
	dk_disable(libwebp)				# TIFF is disabled when statically linking
	dk_disable(libwebsockets)		# compiling errors
	dk_disable(libxml2)				# fatal error: 'config.h' file not found
	dk_disable(lighttpd)			# DKMAKE.cmake incomplete
	dk_disable(lua)					# no CMakeLists.txt
	dk_disable(mlocate)				# Unable to locate a Java Runtime that supports apt
	dk_disable(opencv)				# CMAKE_SYSTEM_PROCESSOR is not defined
	dk_disable(openframeworks)		# error: CMakeLists.txt broken
	dk_disable(openscenegraph)		# CMAKE ERROR: FIndAVFoundation.cmake:23 (IF): unknown arguments specified "LESS" "6.0"
	dk_disable(opensles)			# could not locate OpenSLES Library
	dk_disable(osgaudio)			# requires openscenegraph
	dk_disable(osgbullet)			# requires openscenegraph
	dk_disable(osgworks)			# requires openscenegraph
	dk_disable(podofo)				# Could not find FREETYPE
	dk_disable(sdl-gpu)				# SDL2MAIN_LIBRARY is NOTFOUND
	dk_disable(sfml)				# Unknown CMake command "find_host_package"
	dk_disable(smpeg2)				# ** BUILD FAILED ** MPEGstream.cpp
	dk_disable(tesseract)			# requires leptonica
	dk_disable(tiff)				# install TARGETS given no BUNDLE DESTINATION for MACOSX_BUNDLE executable target "fax2ps"
	dk_disable(waave)				# requires sdl, ** BUILD FAILED ** src/audio_decoder.c
endif()


if(LINUX) # Disabled for Linux targets
	dk_disable(boxer)				# no package gtk+-3.0 found
	dk_disable(bullet3)				# library not found for -lBulletInverseDynamicsUtils
	dk_disable(DKHook)				# 'read' was not declared in this scope
	dk_disable(DKJerryscript)		# requires jerryscript
	dk_disable(DKOcr)				# requires leptonica, tesseract
	dk_disable(DKOFWindow)			# requires openframeworks
	dk_disable(DKOSGAudio)			# requires openscenegraph
	dk_disable(DKOSGCef)			# build errors
	dk_disable(DKOSGPhysics)		# 'btBulletDynamicsCommon.h' file not found
	dk_disable(DKOSGRml)			# build errors
	dk_disable(DKOSGVideo)			# requires openscenegraph
	dk_disable(DKOSGWidget)			# build errors 
	dk_disable(DKScreenRecorder)	# error: 'cvSize' was not declared in this scope
	dk_disable(DKSFMLWindow)		# requires sfml
	dk_disable(DKTorrent)			# requires libtorrent
	dk_disable(DKVncClient)			# requires libvncserver
	dk_disable(DKVncServer)			# requires libvncserver
	dk_disable(DKWebSockets)		# requires libwebsockets, uwebsockets
	dk_disable(freealut)			# AL/al.h: No such file or directory
	dk_disable(imagemagick)			# libimagemagik.a not found
	dk_disable(jerryscript)			# build errors
	dk_disable(kdevelop)			# permission denied
	dk_disable(leptonica)			# build errors
	dk_disable(libcaca)				# no CMakeLists.txt
	dk_disable(libtorrent)			# Could not find BOOST
	dk_disable(libvncserver)		# error C2065: 'nonBlocking': undeclared identifier
	dk_disable(libxml2)				# Not such file or directory
	dk_disable(lighttpd)			# DKMAKE.cmake incomplete
	dk_disable(lua)					# no CMakeLists.txt
	dk_disable(openframeworks)		# error: CMakeLists.txt broken
	dk_disable(openssl)				# compiling errors
	dk_disable(osgaudio)			# requires openscenegraph
	dk_disable(podofo)				# build errors
	dk_disable(tesseract)			# requires leptonica
	dk_disable(uwebsockets)			# requires openssl
	dk_disable(waave)				# requires sdl
endif()


if(RASPBERRY) # Disabled for Raspberry Pi targets
	dk_disable(boxer)				# fatal error : 'boxer/boxer.h' file not found	
	dk_disable(DKHook)				# 'read' was not declared in this scope
	dk_disable(DKJerryscript)		# requires jerryscript
	dk_disable(DKMidi)				# requires rtmidi
	dk_disable(DKOcr)				# requires leptonica, tesseract
	dk_disable(DKOFWindow)			# requires openframeworks
	dk_disable(DKOSGAudio)			# requires openscenegraph
	dk_disable(DKOSGCef)			# requires openscenegraph
	dk_disable(DKOSGLights)			# requires openscenegraph
	dk_disable(DKOSGManipulator)	# requires openscenegraph
	dk_disable(DKOSGModel)			# requires openscenegraph
	dk_disable(DKOSGNotify)			# requires openscenegraph
	dk_disable(DKOSGPhysics)		# requires openscenegraph
	dk_disable(DKOSGPicker)			# requires openscenegraph
	dk_disable(DKOSGRml)			# requires openscenegraph
	dk_disable(DKOSGStats)			# requires openscenegraph
	dk_disable(DKOSGTerrain)		# requires openscenegraph
	dk_disable(DKOSGVideo)			# requires openscenegraph
	dk_disable(DKOSGViewer)			# requires openscenegraph 
	dk_disable(DKOSGWidget)			# requires openscenegraph 
	dk_disable(DKOSGWindow)			# requires openscenegraph 
	dk_disable(DKScreenRecorder)	# error: 'cvSize' was not declared in this scope
	dk_disable(DKTorrent)			# requires libtorrent
	dk_disable(DKVncClient)			# requires libvncserver
	dk_disable(DKVncServer)			# requires libvncserver
	dk_disable(DKWebSockets)		# requires libwebsocket, uwebsockets
	dk_disable(emsdk)				# 64bit source only
	dk_disable(freealut)			# no ruleto make 'alut_static'
	dk_disable(java)
	dk_disable(jerryscript)			# build errors
	dk_disable(kdevelop)
	dk_disable(openjdk)
	dk_disable(libcaca)				# no CMakeLists.txt
	dk_disable(libtorrent)			# Could not find BOOST
	dk_disable(libvncserver)		# error C2065: 'nonBlocking': undeclared identifier
	dk_disable(libwebp)
	dk_disable(libxml2)
	dk_disable(lighttpd)			# DKMAKE.cmake incomplete
	dk_disable(lua)					# no CMakeLists.txt
	dk_disable(openframeworks)		# error: CMakeLists.txt broken
	dk_disable(osgaudio)			# requires openscenegraph
	dk_disable(osgbullet)			# requires openscenegraph
	dk_disable(osgworks)			# requires openscenegraph
	dk_disable(rtmidi)
	dk_disable(sdl-gpu)
	dk_disable(stackwalker)
	dk_disable(tesseract)			# requires leptonica
	dk_disable(tiff)
	dk_disable(upx)
	dk_disable(waave)				# requires sdl
endif()


if(ANDROID) # Disabled for Android targets
	dk_disable(android-java-tools) 	# download link broken
	dk_disable(boxer)				# fatal error : 'boxer/boxer.h' file not found
	dk_disable(bullet3)				# build errors
	dk_disable(bzip2)				# 'make' is not recognized as an internal or external command
	dk_disable(cryptopp)			# error : cannot use 'throw' with exceptions disabled
	dk_disable(curl)				# error : "strerror_r MUST be either POSIX, glibc style"
	dk_disable(DKCef)				# requires cef_binary
	dk_disable(DKCefChild)			# requires cef_binary
	dk_disable(DKCurl)				# requires curl
	dk_disable(DKHandles)			# could not find DKHandles
	dk_disable(DKMidi)				# requires rtmidi
	dk_disable(DKMySql)				# requires curl
	dk_disable(DKOcr)				# requires leptonica, tesseract
	dk_disable(DKOFWindow)			# requires openframeworks
	dk_disable(DKOSGAudio)			# requires openscenegraph
	dk_disable(DKOSGCef)			# requires openscenegraph
	dk_disable(DKOSGLights)			# requires openscenegraph
	dk_disable(DKOSGManipulator)	# requires openscenegraph
	dk_disable(DKOSGModel)			# requires openscenegraph
	dk_disable(DKOSGNotify)			# requires openscenegraph
	dk_disable(DKOSGPhysics)		# requires openscenegraph
	dk_disable(DKOSGPicker)			# requires openscenegraph
	dk_disable(DKOSGRml)			# requires openscenegraph
	dk_disable(DKOSGStats)			# requires openscenegraph
	dk_disable(DKOSGTerrain)		# requires openscenegraph
	dk_disable(DKOSGVideo)			# requires openscenegraph
	dk_disable(DKOSGViewer)			# requires openscenegraph 
	dk_disable(DKOSGWidget)			# requires openscenegraph 
	dk_disable(DKOSGWindow)			# requires openscenegraph 
	dk_disable(DKScreenRecorder)	# requires opencv
	dk_disable(DKSDLCef)			# requires sdl, cef_binary
	dk_disable(DKSFMLWindow)		# requires sfml
	dk_disable(DKTorrent)			# requires libtorrent
	dk_disable(DKVncClient)			# requires libvncserver
	dk_disable(DKVncServer)			# requires libvncserver
	dk_disable(DKWebSockets)		# requires libwebsockets or uwebsockets
	dk_disable(DKWebview)			# compiling errors
	dk_disable(flac)				# configure: error: unrecognized option: `-DANDROID32'
	dk_disable(freealut)			# DKFunctions.cmake:4405->dk_findFiles():  files is invalid
	dk_disable(imagemagick)			# dkscript.tmp: line 2: cd: /android32/Debug: No such file or directory
	dk_disable(leptonica)			# fatal error : 'tiffconf.h' file not found
	dk_disable(libcaca)				# no CMakeLists.txt
	dk_disable(libtorrent)			# Could not find BOOST
	dk_disable(libuv)				# error : incomplete definition of type 'struct ifaddrs'
	dk_disable(libvncserver)		# error C2065: 'nonBlocking': undeclared identifier
	dk_disable(libwebsockets)		# compiling errors
	dk_disable(libxml2)				# ../../configure: No such file or directory
	dk_disable(lighttpd)			# DKMAKE.cmake incomplete
	dk_disable(lua)					# no CMakeLists.txt
	dk_disable(ogg)					# configure: error: unrecognized option: `-DANDROID32'
	dk_disable(openal)				# The system cannot find the file specified
	dk_disable(opencv)				# error : cannot use 'throw' with exceptions disabled
	dk_disable(openframeworks)		# error: CMakeLists.txt broken
	#dk_disable(openscenegraph)
	dk_disable(openssl)				# Perl v5.10.0 required
	dk_disable(osgaudio)			# requires openscenegraph
	dk_disable(osgbullet)			# requires openscenegraph
	dk_disable(osgworks)			# requires openscenegraph
	dk_disable(podofo)				# error : cannot use 'throw' with exceptions disabled
	dk_disable(rtmidi)				# ALSA API requested but no ALSA dev libraries found
	dk_disable(sdl-gpu)				# The target "SDL_gpu" does not exist in the project
	dk_disable(sfml)				# Unsupported compiler
	dk_disable(smpeg2)				# error : ISO C++17 does not allow 'register' storage class specifier
	dk_disable(tesseract)			# requires leptonica
	dk_disable(uwebsockets)			# Could NOT find OpenSSL
	dk_disable(vorbis)				# configure: error: unrecognized option: `-DANDROID32'
	dk_disable(waave)				# requires sdl
endif()

if(ANDROID_64) # Disabled for Android 64bit targets
	dk_disable(boost)
endif()
