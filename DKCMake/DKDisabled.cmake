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


# DISABLED FOR ALL
dk_disable(astyle)
dk_disable(bullet3)				# Openscenegraph 
dk_disable(conio-for-linux)
dk_disable(DKJerryscript)
dk_disable(DKOcr)
dk_disable(DKOFWindow)
dk_disable(DKOSGAudio)			# Openscenegraph
dk_disable(DKOSGCef)			# Openscenegraph
dk_disable(DKOSGLights)			# Openscenegraph
dk_disable(DKOSGManipulator)	# Openscenegraph
dk_disable(DKOSGModel)			# Openscenegraph
dk_disable(DKOSGNotify)			# Openscenegraph
dk_disable(DKOSGPhysics)		# Openscenegraph
dk_disable(DKOSGPicker)			# Openscenegraph
dk_disable(DKOSGRml)			# Openscenegraph
dk_disable(DKOSGStats)			# Openscenegraph
dk_disable(DKOSGTerrain)		# Openscenegraph
dk_disable(DKOSGVideo)			# Openscenegraph
dk_disable(DKOSGViewer)			# Openscenegraph 
dk_disable(DKOSGWidget)			# Openscenegraph 
dk_disable(DKOSGWindow)			# Openscenegraph 
dk_disable(DKPlugin1)
dk_disable(DKPlugin2)
dk_disable(DKRestart)
dk_disable(DKScreenRecorder)
dk_disable(DKSDLAudio)
dk_disable(DKSDLWav)
dk_disable(DKSDLVideo)
dk_disable(DKSFMLRml)			# Incomplete
dk_disable(DKThread)
dk_disable(DKTorrent)
dk_disable(DKUpdate)
dk_disable(DKVncClient)
dk_disable(DKVncServer)
dk_disable(gradle)
dk_disable(java)
dk_disable(jpeg)				# DEPRECATED: using libjpeg_turbo instead
dk_disable(libcaca)
dk_disable(librocket)			# OBSOLETE: replaced with RmlUi
dk_disable(libvncserver)
dk_disable(libvncserver-master-win)
dk_disable(libx11)
dk_disable(miniweb)
dk_disable(msys2)
dk_disable(opencv)				# WORKING, only disabled because it takes a long time to compile
dk_disable(openframeworks)
dk_disable(openscenegraph)		# Openscenegraph
dk_disable(osgaudio)			# Openscenegraph
dk_disable(osgbullet)			# Openscenegraph
dk_disable(osgworks)			# Openscenegraph
dk_disable(sdl2_gif)			# DEPRECATED: using SDL_Image animation instead
dk_disable(sdl2_giflib_sa)		# DEPRECATED: updated version of sdl2_gif. Using SDL_Image animation instead
dk_disable(simple-getch)		# kept for reference
dk_disable(sw)
dk_disable(sw-client)


if(WIN) # Disabled for Windows targets
	dk_disable(android-java-tools)
	dk_disable(DKSFMLWindow)
	dk_disable(freealut)
	dk_disable(jerryscript)
	dk_disable(leptonica)
	dk_disable(libtorrent)
	dk_disable(libwebp)
	dk_disable(libwebsockets)
	dk_disable(lighttpd)
	dk_disable(lua)				# no CMakeLists.txt
	#dk_disable(opensles)
	dk_disable(sfml)
	dk_disable(tesseract)
	dk_disable(waave)
endif()

if(WIN_64) # Disabled for Windows 64bit targets
	dk_disable(smpeg2)
endif()


if(MAC)  # Disabled for MAC targets
	dk_disable(freealut)		# ** BUILD FAILED **
	dk_disable(imagemagick)		# no such file or directory: libimagemagik.a
	dk_disable(jerryscript)
	dk_disable(leptonica)
	dk_disable(libtorrent)
	dk_disable(libwebp)
	dk_disable(libwebsockets)
	dk_disable(libxml2)			# fatal error: 'extra/stricmp.h' file not found
	dk_disable(lighttpd)
	dk_disable(lua)				# no CMakeLists.txt file
	dk_disable(mlocate)			# Unable to locate a Java Runtime that supports apt
	dk_disable(rtmidi)			# Undefined symbols for architecture x86_64
	dk_disable(sdl-gpu)			# SDL for MAC OS X only supports deploying on 10.7 and above
	dk_disable(smpeg2)			# ** BUILD FAILED ** MPEGstream.cpp
	dk_disable(tesseract)
	dk_disable(waave)
endif()

if(IOS OR IOSSIM)  # Disabled for iOS and iOS-Simulator targets
	dk_disable(boost)			# clang error: no such file or direcotry: libboost_atomic.a, libboost_chrono.a, etc, etc, etc
	dk_disable(boxer)			# COCOA_LIBRARY not found
	dk_disable(bzip2)			# dk_include Function invoked with incorrect arguments
	dk_disable(cryptopp)		# ** BUILD FAILED ** /blake2b_simd.cpp
	dk_disable(DKCef)
	dk_disable(DKCefChild)
	dk_disable(DKMidi)
	dk_disable(DKSDLCef)
	dk_disable(DKSFMLWindow)
	dk_disable(freealut)		# freealut-master/iossim64 does not contain an Xcode project
	dk_disable(imagemagick)		# No such file or directory
	dk_disable(jerryscript)
	dk_disable(libiconv)		# CMake Error at cmake/dist.cmake:144 (install): install TARGETS given no BUNDLE DESTINATION for MACOSX_BUNDLE executable target "iconvcli"
	dk_disable(libjpeg-turbo)	# CMake Error at CMakeLists.txt:60 (string): string no output variable specified
	dk_disable(libmd)			# dk_getExtension Function invoked with incorrect arguments
	dk_disable(libpng)			# no such sysroot directory: 'iphonesimulator'
	dk_disable(leptonica)
	dk_disable(libtorrent)
	dk_disable(libwebp)			# TIFF is disabled when statically linking
	dk_disable(libwebsockets)
	dk_disable(libxml2)			# fatal error: 'config.h' file not found
	dk_disable(lighttpd)
	dk_disable(lua)				# no CMakeLists.txt
	dk_disable(mlocate)			# Unable to locate a Java Runtime that supports apt
	dk_disable(podofo)			# Could not find FREETYPE
	dk_disable(sdl-gpu)			# SDL2MAIN_LIBRARY is NOTFOUND
	dk_disable(sfml)			# Unknown CMake command "find_host_package"
	dk_disable(smpeg2)			# ** BUILD FAILED ** MPEGstream.cpp
	dk_disable(tesseract)
	dk_disable(tiff)			# install TARGETS given no BUNDLE DESTINATION for MACOSX_BUNDLE executable target "fax2ps"
	dk_disable(waave)			# ** BUILD FAILED ** src/audio_decoder.c
endif()


if(LINUX) # Disabled for Linux targets
	dk_disable(boxer)			# no package gtk+-3.0 found
	dk_disable(DKHook)
	dk_disable(DKSDLWav)
	dk_disable(DKSFMLWindow)
	dk_disable(DKWebSockets)
	dk_disable(freealut)		# AL/al.h: No such file or directory
	dk_disable(giflib)			# aclocal-1.15: command not found
	dk_disable(imagemagick)		#libimagemagik.a not found
	dk_disable(jerryscript)
	dk_disable(kdevelop)
	dk_disable(leptonica)
	dk_disable(libtorrent)		# Could not find BOOST
	dk_disable(libwebp)
	dk_disable(libwebsockets)
	dk_disable(libxml2)			# Not such file or directory
	dk_disable(lighttpd)
	dk_disable(lua)				# no CMakeLists.txt
	#dk_disable(sdl_image)		# cannot locate tiffconf.h
	dk_disable(sfml)           	# sfml_sfml-network)  #TODO: disabling individual sublibraries
	dk_disable(stackwalker)
	dk_disable(tesseract)
	dk_disable(uwebsockets)
	dk_disable(waave)
endif()


if(RASPBERRY) # Disabled for Raspberry Pi targets
	#dk_disable(android-build-tools)
	dk_disable(boxer)
	dk_disable(DKMidi)
	dk_disable(DKWebSockets)
	dk_disable(emsdk)
	dk_disable(freealut)
	dk_disable(giflib)
	dk_disable(imagemagick)
	dk_disable(java)
	dk_disable(kdevelop)
	dk_disable(openjdk)
	dk_disable(jerryscript)
	dk_disable(leptonica)
	dk_disable(libtorrent)
	dk_disable(libwebp)
	dk_disable(libwebsockets)
	dk_disable(libxml2)
	dk_disable(lighttpd)
	dk_disable(lua)				# no CMakeLists.txt
	dk_disable(rtmidi)
	dk_disable(sdl-gpu)
	dk_disable(stackwalker)
	dk_disable(tesseract)
	dk_disable(tiff)
	dk_disable(upx)
	dk_disable(uwebsockets)
	dk_disable(waave)
endif()


if(ANDROID) # Disabled for Android targets
	dk_disable(boxer)			# fatal error : 'boxer/boxer.h' file not found
	dk_disable(bzip2)			# 'make' is not recognized as an internal or external command
	dk_disable(cryptopp)		# error : cannot use 'throw' with exceptions disabled
	dk_disable(curl)			# error : "strerror_r MUST be either POSIX, glibc style"
	dk_disable(DKCef)
	dk_disable(DKCefChild)
	dk_disable(DKCurl)			
	dk_disable(DKWebSockets)
	dk_disable(DKHandles)
	dk_disable(DKMidi)
	dk_disable(DKMySql)			# fatal error : 'curl/curl.h' file not found
	dk_disable(DKSDLCef)
	dk_disable(DKSFMLWindow)
	dk_disable(DKWebSockets)
	dk_disable(DKWebview)
	dk_disable(flac)			# configure: error: unrecognized option: `-DANDROID32'
	dk_disable(freealut)		# DKFunctions.cmake:4405->dk_findFiles():  files is invalid
	dk_disable(imagemagick)		# dkscript.tmp: line 2: cd: /android32/Debug: No such file or directory
	dk_disable(jerryscript)
	dk_disable(kdevelop)
	dk_disable(leptonica)
	dk_disable(libtorrent)
	dk_disable(ogg)				# configure: error: unrecognized option: `-DANDROID32'
	dk_disable(libuv)			# error : incomplete definition of type 'struct ifaddrs'
	dk_disable(vorbis)			# configure: error: unrecognized option: `-DANDROID32'
	dk_disable(libwebp)
	dk_disable(libwebsockets)
	dk_disable(libxml2)			# ../../configure: No such file or directory
	dk_disable(lighttpd)
	dk_disable(lua)				# no CMakeLists.txt
	dk_disable(openal)			# The system cannot find the file specified
	dk_disable(openssl)
	dk_disable(podofo)			# error : cannot use 'throw' with exceptions disabled
	dk_disable(rtmidi)			# ALSA API requested but no ALSA dev libraries found
	dk_disable(sdl-gpu)			# The target "SDL_gpu" does not exist in the project
	dk_disable(sfml)
	dk_disable(smpeg2)
	dk_disable(stackwalker)
	dk_disable(tesseract)
	dk_disable(uwebsockets)		# Could NOT find OpenSSL
	dk_disable(waave)
endif()

if(ANDROID_64) # Disabled for Android 64bit targets
	dk_disable(boost)
endif()
