# This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
#
# For the latest information, see https://github.com/aquawicket/DigitalKnob
#
# Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
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
dk_disable(DKPlugin1)				# TODO
dk_disable(DKPlugin2)				# TODO
dk_disable(gradle)					# We don't need to build this from source
dk_disable(java)					# TODO
dk_disable(jpeg)					# DEPRECATED: using libjpeg_turbo instead
dk_disable(librocket)				# OBSOLETE: replaced by rmlui
dk_disable(libx11)					# TODO
dk_disable(mpg123)					# TODO
dk_disable(msys2)					# TODO: currently using msys
dk_disable(sdl2_gif)				# DEPRECATED: using SDL_Image animation instead
dk_disable(sdl2_giflib_sa)			# DEPRECATED: updated version of sdl2_gif. Using SDL_Image animation instead
dk_disable(simple-getch)			# DEPRECATED: kept for reference
dk_disable(sw)						# DEPRECATED: requested by leptonica but not required
dk_disable(sw-client)				# DEPRECATED: requested by leptonica but not required




if(WIN) # Disabled for Windows targets
	dk_disable(aom)					# Perl is required to build libaom.
	dk_disable(aubio)
	dk_disable(diff-match-patch)
	dk_disable(DKOcr)				# causing linking errors in tesseract
	dk_disable(DKOFWindow)			# requires openframeworks
	dk_disable(DKOSGAudio)			# requires freealut
	dk_disable(DKOSGCef)			# build errors
	dk_disable(DKOSGPhysics)		# requires bullet3
	dk_disable(DKOSGStats)			# build errors
	dk_disable(DKOSGVideo)			# TODO
	dk_disable(DKOSGWidget)			# build errors
	dk_disable(DKScreenRecorder)
	dk_disable(DKSDLWav)			# build errors
	dk_disable(DKSFMLRml)			# INCOMPLETE
	dk_disable(DKThread)			# build errors
	dk_disable(DKTorrent)			# requires libtorrent
	dk_disable(DKUpdate)			# build errors
	#dk_disable(DKVncServer)		# build errors
	dk_disable(dukluv)
	dk_disable(ffmpeg)
	dk_disable(fontconfig)
	dk_disable(gdal)
	dk_disable(gzip)
	dk_disable(jasper)
	dk_disable(libcaca)				# no CMakeLists.txt
	dk_disable(libexpat)
	dk_disable(libtorrent)			# Cannot find source file:  deps/try_signal/try_signal.cpp
	dk_disable(lighttpd)			# DKMAKE.cmake incomplete
	dk_disable(openframeworks)		# error: CMakeLists.txt broken
	dk_disable(osgaudio)			# openalpp\AudioBase.cpp(106,54): error C2440: '=': cannot convert from 'ALCcontext *' to 'openalpp::ALCcontext_struct *'
	dk_disable(osgbullet)			# requires osgworks
	dk_disable(osgrmlui)
	dk_disable(osgworks)			# osgwTools\GeometryModifier.cpp(64,13): error C2039: 'mergeGeode': is not a member of 'osgUtil::Optimizer::MergeGeometryVisitor'
	dk_disable(rmlui-d3d11)
	dk_disable(sdl_rtf)
	dk_disable(waave)				# error C2065: 'PIX_FMT_YUV420P': undeclared identifier.  https://sourceforge.net/p/guvcview/tickets/34/
	dk_disable(x264)
	dk_disable(x265)
endif(WIN)

if(WIN_64) # Disabled for Windows 64bit targets
	dk_disable(DKVncClient)			# requires libvncserver
	dk_disable(libvncserver)		# build errors
	dk_disable(opencv)				# error: Only SIMD128, AVX2 and NEON are supported in Winograd.
	dk_disable(sdl_net)				# can't find "sys/ioctl.h"
	dk_disable(smpeg2)				# fatal error C1083: Cannot open include file: 'unistd.h'
endif(WIN_64)


if(MAC)  # Disabled for MAC targets
	dk_disable(aubio)				# breaks DKCefV8
	dk_disable(DKOcr)				# requires tesseract
	dk_disable(DKOFWindow)			# requires openframeworks
	dk_disable(DKOSGAudio)			# requires freealut
	dk_disable(DKOSGCef)			# build errors
	dk_disable(DKOSGPhysics)		# requires bullet3
	dk_disable(DKOSGStats)			# build errors
	dk_disable(DKOSGVideo)			# TODO
	dk_disable(DKOSGWidget)			# build errors
	dk_disable(DKScreenRecorder)
	dk_disable(DKSDLVideo)			# requires ffmpeg
	dk_disable(DKSDLWav)			# build errors
	dk_disable(DKSFMLRml)			# INCOMPLETE
	dk_disable(DKThread)			# Error: 'boost/thread/xtime.hpp:24 expected identifier TIME_UTC_=1
	dk_disable(DKTorrent)			# requires libtorrent
	dk_disable(DKUpdate)			# Error: 'boost/thread/xtime.hpp:24 expected identifier TIME_UTC_=1
	#dk_disable(DKVncClient)			# requires libvncserver
	#dk_disable(DKVncServer)			# requires libvncserver
	dk_disable(dukluv)
	dk_disable(ffmpeg)
	dk_disable(flac)				# 'asm' undelcared identifier
	dk_disable(fontconfig)
	dk_disable(gdal)
	dk_disable(gzip)
	dk_disable(imagemagick)			# no such file or directory: libimagemagik.a
	dk_disable(leptonica)			# Build Failed: fhmtauto.o
	dk_disable(libcaca)				# no CMakeLists.txt
	dk_disable(libexpat)
	dk_disable(libtorrent)			# CMake Error: cannot find deps/try_signal/try_signal.cpp
	#dk_disable(libvncserver)		# build errors in main.c
	dk_disable(libwebsockets)		# error: unknown type name 'lws_mutex_t'
	dk_disable(libxml2)				# fatal error: 'extra/stricmp.h' file not found
	dk_disable(lighttpd)			# DKMAKE.cmake incomplete
	dk_disable(mlocate)				# Unable to locate a Java Runtime that supports apt
	dk_disable(ncurses)				# error: C preprocessor "/lib/cpp" fails sanity check
	dk_disable(openframeworks)		# fatal error: /utils/ofConstants.h:183     'GL/glew.h' file not found
	#dk_disable(openssl)
	dk_disable(osgbullet)			# requires osgworks
	dk_disable(osgaudio)			# opengl identifier errors
	dk_disable(osgrmlui)
	dk_disable(osgworks)			# Error: 'osgworks-master/src/osgwTools/GeometeryModifier.cpp:64' no member named 'mergeGeode'
	dk_disable(podofo)				# error: expected ';' at end of declaration
	dk_disable(rmlui-d3d11)
	dk_disable(rtmidi)				# Undefined symbols for architecture x86_64
	dk_disable(sdl-gpu)				# SDL for MAC OS X only supports deploying on 10.7 and above
	dk_disable(sdl_rtf)
	dk_disable(smpeg2)				# ** BUILD FAILED ** MPEGstream.cpp
	dk_disable(tesseract)			# requires leptonica
	dk_disable(waave)				# error: streaming_objet.h:59 field has incomplete type 'enum PixelFormat'
	dk_disable(x264)
	dk_disable(x265)
endif(MAC)

if(IOS OR IOSSIM)  # Disabled for iOS and iOS-Simulator targets
	dk_disable(aom)					# build errors
	dk_disable(aubio)				# build errors
	dk_disable(boost)				# clang error: no such file or direcotry: libboost_atomic.a, libboost_chrono.a, etc, etc, etc
	dk_disable(boxer)				# COCOA_LIBRARY not found
	dk_disable(bullet3)				# OPENGL-NOTFOUND COCOA-NOTFOUND
	dk_disable(bzip2)
	dk_disable(cryptopp)			# ** BUILD FAILED ** /blake2b_simd.cpp
	dk_disable(DKCef)				# requires cef_binary
	dk_disable(DKCefChild)			# requires cef_binary
	dk_disable(DKJerryscript)		# requires jerryscript
	dk_disable(DKMidi)				# requires rtmidi
	dk_disable(DKOcr)				# requires tesseract
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
	dk_disable(DKSDLCef)			# requires cef_binary
	dk_disable(DKSDLVideo)			# requires ffmpeg
	dk_disable(DKSDLWav)			# build errors
	dk_disable(DKSFMLRml)			# requires sfml
	dk_disable(DKSFMLWindow)		# requires sfml
	dk_disable(DKThread)			# requires threadpool
	dk_disable(DKTorrent)			# requires libtorrent
	dk_disable(DKUpdate)			# build errors
	dk_disable(DKVncClient)			# requires libvncserver
	dk_disable(DKVncServer)			# requires libvncserver
	dk_disable(dukluv)
	dk_disable(ffmpeg)
	dk_disable(fontconfig)
	dk_disable(gdal)
	dk_disable(gzip)
	dk_disable(imagemagick)			# No such file or directory
	dk_disable(jasper)
	dk_disable(jerryscript)			# Error: unknown linker option '-z'
	dk_disable(leptonica)			# Build Failed: fhmtauto.o
	dk_disable(libcaca)				# no CMakeLists.txt
	dk_disable(libexpat)
	dk_disable(libiconv)			# CMake Error at cmake/dist.cmake:144 (install): install TARGETS given no BUNDLE DESTINATION for MACOSX_BUNDLE executable target "iconvcli"
	dk_disable(libjpeg-turbo)		# CMake Error at CMakeLists.txt:60 (string): string no output variable specified
	dk_disable(libmd)				# dk_getExtension Function invoked with incorrect arguments
	dk_disable(libpng)				# no such sysroot directory: 'iphonesimulator'
	dk_disable(libsndfile)			# Cmake Error: install TARGETS given no BUNDLE DESTINATION for MACOSX_BUNDLE executable target "sndfile-info"
	dk_disable(libtorrent)			# Could not find BOOST
	dk_disable(libvncserver)		# error C2065: 'nonBlocking': undeclared identifier
	dk_disable(libwebp)				# TIFF is disabled when statically linking
	dk_disable(libwebsockets)		# compiling errors
	dk_disable(libxml2)				# fatal error: 'config.h' file not found
	dk_disable(lighttpd)			# DKMAKE.cmake incomplete
	dk_disable(lua)					# error:'system' is unavailable: not available on iOS
	dk_disable(mlocate)				# Unable to locate a Java Runtime that supports apt
	dk_disable(ncurses)				# CMake Error: C preprocessor "/lib/cpp" fails sanity check
	dk_disable(opencv)				# CMAKE_SYSTEM_PROCESSOR is not defined
	dk_disable(openframeworks)		# error: tesselator.h: No such file or directory
	dk_disable(openscenegraph)		# CMake errors
	dk_disable(opensles)			# could not locate OpenSLES Library
	dk_disable(osgaudio)			# requires openscenegraph
	dk_disable(osgbullet)			# requires osgworks
	dk_disable(osgrmlui)			# requires openscenegraph
	dk_disable(osgworks)			# requires openscenegraph
	dk_disable(poco)
	dk_disable(podofo)				# CMake errors
	dk_disable(rmlui-d3d11)
	dk_disable(rtaudio)				# 'CoreAudio/AudioHardware.h' file not found
	dk_disable(sdl-gpu)				# SDL2MAIN_LIBRARY is NOTFOUND
	dk_disable(sdl_rtf)
	dk_disable(sfml)				# Unknown CMake command "find_host_package"
	dk_disable(smpeg2)				# ** BUILD FAILED ** MPEGstream.cpp
	dk_disable(tesseract)			# requires leptonica
	dk_disable(tiff)				# install TARGETS given no BUNDLE DESTINATION for MACOSX_BUNDLE executable target "fax2ps"
	dk_disable(waave)				# ** BUILD FAILED ** src/audio_decoder.c
	dk_disable(x264)
	dk_disable(x265)
	dk_disable(zstd)
endif(IOS OR IOSSIM)
if(IOS AND NOT IOSSIM)  # Disabled for iOS targets
	dk_disable(flac)				# configure: error: C compiler cannot create executables
	dk_disable(ogg)					# configure: error: C compiler cannot create executables
	dk_disable(vorbis)				# configure: error: C compiler cannot create executables
endif()


if(LINUX) # Disabled for Linux targets
	dk_disable(aubio)
	dk_disable(boxer)				# error: can't create CMakeFiles/Boxer.dir/src/boxer_linux.cpp.o: No such file or directory
	dk_disable(DKHook)				# 'read' was not declared in this scope
	dk_disable(DKJerryscript)		# requires jerryscript
	dk_disable(DKOcr)				# requires tesseract
	dk_disable(DKOFWindow)			# requires openframeworks
	dk_disable(DKOSGAudio)			# requires freealut
	dk_disable(DKOSGCef)			# build errors
	dk_disable(DKOSGPhysics)		# requires bullet3
	dk_disable(DKOSGStats)			# build errors
	dk_disable(DKOSGVideo)			# TODO
	dk_disable(DKOSGWidget)			# build errors
	dk_disable(DKScreenRecorder)
	dk_disable(DKSDLVideo)			# requires waave
	dk_disable(DKSDLWav)			# build errors
	dk_disable(DKSFMLRml)			# INCOMPLETE
	dk_disable(DKThread)			# error: need to implement boost::placeholders
	dk_disable(DKTorrent)			# requires libtorrent
	dk_disable(DKUpdate)			# error: need to implement boost::placeholders
	#dk_disable(DKVncClient)			# requires libvncserver
	#dk_disable(DKVncServer)			# requires libvncserver
	dk_disable(DKWebSockets)		# requires libwebsockets, uwebsockets
	dk_disable(dukluv)
	dk_disable(ffmpeg)
	dk_disable(fontconfig)
	dk_disable(gdal)
	dk_disable(gzip)
	dk_disable(jerryscript)			# build errors
	dk_disable(imagemagick)			# libimagemagik.a not found
	dk_disable(kdevelop)			# permission denied
	dk_disable(leptonica)			# build errors
	dk_disable(libcaca)				# no CMakeLists.txt
	dk_disable(libexpat)
	dk_disable(libsndfile)			# requires opus
	dk_disable(libtorrent)			# CMake Error: cannot find source file: deps/try_signal/try_singal.cpp
	#dk_disable(libvncserver)		# requires openssl
	dk_disable(libxml2)				# Not such file or directory
	dk_disable(lighttpd)			# DKMAKE.cmake incomplete
	dk_disable(openframeworks)		# error: tesselator.h: No such file or directory
	dk_disable(openssl)				# undefined reference errors
	dk_disable(osgaudio)			# can't find libosg_osgAudiod.a
	dk_disable(osgbullet)			# requires osgworks
	dk_disable(osgrmlui)
	dk_disable(osgworks)			# error: osgUtil::Optimizer::MergeGeometryVisitor has no member named 'mergeGeode'
	dk_disable(podofo)				# build errors
	dk_disable(rmlui-d3d11)
	dk_disable(sdl_rtf)
	dk_disable(tesseract)			# requires leptonica
	dk_disable(uwebsockets)			# requires openssl
	dk_disable(waave)
	dk_disable(x264)
	dk_disable(x265)
endif(LINUX)


if(RASPBERRY) # Disabled for Raspberry Pi targets
	dk_disable(aom)
	dk_disable(aubio)
	dk_disable(boxer)				# fatal error : 'boxer/boxer.h' file not found	
	dk_disable(DKHook)				# 'read' was not declared in this scope
	dk_disable(DKJerryscript)		# requires jerryscript
	dk_disable(DKMidi)				# requires rtmidi
	dk_disable(DKOcr)				# requires tesseract
	dk_disable(DKOFWindow)			# requires openframeworks
	dk_disable(DKOSGAudio)			# requires osgaudio
	dk_disable(DKOSGCef)			# build errors
	dk_disable(DKOSGPhysics)		# requires bullet3
	dk_disable(DKOSGStats)			# build errors
	dk_disable(DKOSGVideo)			# TODO
	dk_disable(DKOSGWidget)			# build errors
	dk_disable(DKScreenRecorder)	# requires opencv
	dk_disable(DKSDLVideo)			# requires ffmpeg
	dk_disable(DKSDLWav)			# build errors
	dk_disable(DKSFMLRml)			# INCOMPLETE
	dk_disable(DKThread)			# requires threadpool
	dk_disable(DKTorrent)			# requires libtorrent
	dk_disable(DKUpdate)			# compiling errors
	dk_disable(DKVncClient)			# requires libvncserver
	dk_disable(DKVncServer)			# requires libvncserver
	dk_disable(DKWebSockets)		# requires openssl
	dk_disable(dukluv)
	dk_disable(emsdk)				# 64bit source only
	dk_disable(ffmpeg)
	dk_disable(fontconfig)
	dk_disable(gdal)
	dk_disable(gzip)
	dk_disable(imagemagick)
	dk_disable(java)
	dk_disable(jerryscript)
	dk_disable(kdevelop)
	dk_disable(openjdk)
	dk_disable(libcaca)				# no CMakeLists.txt
	dk_disable(libexpat)
	dk_disable(libgtk-3-dev)		# unable to download package
	dk_disable(libsndfile)
	dk_disable(libtorrent)			# Could not find BOOST
	dk_disable(libwebp)
	dk_disable(libxml2)
	dk_disable(lighttpd)			# DKMAKE.cmake incomplete
	dk_disable(opencv)				# build errors
	dk_disable(openframeworks)		# error: cannot find opengles
	dk_disable(openssl)				# lots of undefined references
	dk_disable(opus)
	dk_disable(osgaudio)
	dk_disable(osgbullet)			# requires osgworks
	dk_disable(osgrmlui)
	dk_disable(osgworks)
	dk_disable(rmlui-d3d11)
	dk_disable(rtmidi)
	dk_disable(sdl-gpu)
	dk_disable(sdl_rtf)
	dk_disable(stackwalker)
	dk_disable(tesseract)			# requires leptonica
	dk_disable(tiff)
	dk_disable(upx)
	dk_disable(uwebsockets)			# broken
	dk_disable(waave)
	dk_disable(x264)
	dk_disable(x265)
endif(RASPBERRY)


if(ANDROID) # Disabled for Android targets
	dk_disable(android-java-tools) 	# download link broken
	dk_disable(aom)					# build errors
	dk_disable(aubio)				# build errors
	dk_disable(boxer)				# fatal error : 'boxer/boxer.h' file not found
	dk_disable(bullet3)				# build errors
	dk_disable(bzip2)				# 'make' is not recognized as an internal or external command
	dk_disable(cryptopp)
	dk_disable(curl)				# error : "strerror_r MUST be either POSIX, glibc style"
	dk_disable(diff-match-patch)
	dk_disable(DKArchive)			# requires libarchive
	dk_disable(DKCef)				# requires cef_binary
	dk_disable(DKCefChild)			# requires cef_binary
	dk_disable(DKCurl)				# requires curl
	dk_disable(DKHandles)			# could not find DKHandles
	dk_disable(DKMidi)				# requires rtmidi
	dk_disable(DKMySql)				# requires curl
	dk_disable(DKOcr)				# requires tesseract
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
	dk_disable(DKSDLCef)			# requires cef_binary
	dk_disable(DKSDLVideo)			# requires ffmpeg
	dk_disable(DKSDLWav)			# build errors
	dk_disable(DKSFMLRml)			# requires sfml
	dk_disable(DKSFMLWindow)		# requires sfml
	dk_disable(DKThread)			# requires threadpool
	dk_disable(DKTorrent)			# requires libtorrent
	dk_disable(DKUpdate)			# requires DKCurl
	dk_disable(DKVncClient)			# requires libvncserver
	dk_disable(DKVncServer)			# requires libvncserver
	dk_disable(DKWebSockets)		# requires libwebsockets or uwebsockets
	dk_disable(DKWebview)			# compiling errors
	dk_disable(dl)
	dk_disable(dukluv)
	dk_disable(ffmpeg)
	dk_disable(flac)				# configure: error: unrecognized option: `-DANDROID32'
	dk_disable(fontconfig)
	dk_disable(freealut)			# DKFunctions.cmake:4405->dk_findFiles():  files is invalid
	dk_disable(gdal)
	if(MAC_HOST)
		dk_disable(giflib)
	endif()
	dk_disable(gzip)
	dk_disable(jasper)
	dk_disable(libarchive)
	dk_disable(libcaca)				# no CMakeLists.txt
	dk_disable(libexpat)
	dk_disable(libtorrent)			# Could not find BOOST
	dk_disable(libuv)				# error : incomplete definition of type 'struct ifaddrs'
	dk_disable(libvncserver)		# error C2065: 'nonBlocking': undeclared identifier
	dk_disable(libwebp)
	dk_disable(libwebsockets)		# compiling errors
	dk_disable(libxml2)				# ../../configure: No such file or directory
	dk_disable(lighttpd)			# DKMAKE.cmake incomplete
	dk_disable(ncurses)				# error: '..' is not recognized as an internal or external command
	dk_disable(ogg)					# configure: error: unrecognized option: `-DANDROID32'
	dk_disable(openal)				# The system cannot find the file specified
	dk_disable(opencv)				# build errors
	dk_disable(openframeworks)		# error: CMakeLists.txt broken
	dk_disable(openmw)
	dk_disable(openscenegraph)
	dk_disable(openssl)				# Perl v5.10.0 required
	dk_disable(osgaudio)			# requires openscenegraph
	dk_disable(osgbullet)			# requires bullet3, osgworks
	dk_disable(osgrmlui)
	dk_disable(osgworks)			# requires openscenegraph
	dk_disable(poco)				# error: Compiler does not support C++14
	dk_disable(podofo)				# error: can't find "fontconfig/fontconfig.h"
	dk_disable(rmlui-d3d11)
	dk_disable(rtaudio)				# build errors
	dk_disable(rtmidi)				# ALSA API requested but no ALSA dev libraries found
	dk_disable(sdl-gpu)				# The target "SDL_gpu" does not exist in the project
	dk_disable(sdl_rtf)
	dk_disable(sfml)				# Unsupported compiler
	dk_disable(smpeg2)				# error : ISO C++17 does not allow 'register' storage class specifier
	dk_disable(tesseract)			# requires leptonica
	dk_disable(uwebsockets)			# Could NOT find OpenSSL
	dk_disable(vorbis)				# configure: error: unrecognized option: `-DANDROID32'
	dk_disable(waave)
	dk_disable(x264)
	dk_disable(x265)
endif(ANDROID)

if(ANDROID_64) # Disabled for Android 64bit targets
	dk_disable(boost)
endif(ANDROID_64)


if(EMSCRIPTEN) # Disabled for Emscripten targets
	if(WIN_HOST)
		dk_disable(aom)
	endif()
	dk_disable(aubio)
	dk_disable(audio_toolbox)
	dk_disable(av_foundation)
	dk_disable(av_kit)
	dk_disable(avf_audio)
	dk_disable(boxer)				# CMake Error: CMake can not determine link language for target "Boxer"
	dk_disable(bzip2)				# error='make' is not recognized as an internal or external command
	dk_disable(cef_binary)
	dk_disable(core_audio)
	dk_disable(core_foundation)
	dk_disable(core_graphics)
	dk_disable(core_haptics)
	dk_disable(core_motion)
	dk_disable(core_services)
	dk_disable(core_video)
	dk_disable(DKArchive)			# requires libarchive
	dk_disable(DKAudio)
	dk_disable(DKCef)
	dk_disable(DKCefChild)
	dk_disable(DKCurl)				# requires curl
	dk_disable(DKCrypto)
	dk_disable(DKDebug)				# DKDebug.cpp:158:10: fatal error: 'execinfo.h' file not found
	dk_disable(DKJerryscript)
	dk_disable(DKHook)
	dk_disable(DKImageMagick)
	dk_disable(DKMidi)
	dk_disable(DKMySql)
	dk_disable(DKOcr)
	dk_disable(DKOFWindow)
	dk_disable(DKOSGAudio)
	dk_disable(DKOSGCef)
	dk_disable(DKOSGLights)
	dk_disable(DKOSGManipulator)
	dk_disable(DKOSGModel)
	dk_disable(DKOSGNotify)
	dk_disable(DKOSGPhysics)
	dk_disable(DKOSGPicker)
	dk_disable(DKOSGRml)
	dk_disable(DKOSGStats)
	dk_disable(DKOSGTerrain)
	dk_disable(DKOSGVideo)
	dk_disable(DKOSGViewer)
	dk_disable(DKOSGWidget)
	dk_disable(DKOSGWindow)
	dk_disable(DKRestart)
	dk_disable(DKScreenRecorder)
	dk_disable(DKSDLAudio)
	dk_disable(DKSDLCef)
	dk_disable(DKSDLMetalWindow)
	dk_disable(DKSDLVideo)			# requires waave
	dk_disable(DKSDLWav)
	dk_disable(DKSFMLRml)
	dk_disable(DKSFMLWindow)
	dk_disable(DKThread)
	dk_disable(DKTorrent)
	dk_disable(DKTray)
	dk_disable(DKUpdate)
	#dk_disable(DKVncClient)
	#dk_disable(DKVncServer)
	dk_disable(DKWebSockets)
	dk_disable(dukluv)
	dk_disable(ffmpeg)
	dk_disable(fontconfig)
	dk_disable(foundation)
	dk_disable(game_controller)
	dk_disable(gdal)
	dk_disable(gl_kit)
	dk_disable(gzip)
	dk_disable(imagemagick)
	dk_disable(iokit)
	dk_disable(jasper)
	dk_disable(libarchive)			# /archive_write_set_format_7zip.c:1541:13:  error: implicit truncation from 'int' to a one-bit wide bit-filed
	dk_disable(libexpat)
	dk_disable(libsndfile)
	dk_disable(libuv)
	#dk_disable(libvncserver)
	dk_disable(libwebsockets)
	dk_disable(libxml2)				# fatal error: 'config.h' file not found
	dk_disable(lighttpd)
	dk_disable(kdevelop)
	dk_disable(m)
	dk_disable(media_player)
	dk_disable(metal)
	dk_disable(metalKit)
	dk_disable(msinttypes)
	dk_disable(mlocate)
	dk_disable(ncurses)
	dk_disable(openframeworks)
	dk_disable(openssl)
	dk_disable(opus)
	dk_disable(osgrmlui)
	dk_disable(quartz_core)
	dk_disable(rmlui-d3d11)
	dk_disable(system_configuration)
	dk_disable(waave)
	dk_disable(wasm3)
	dk_disable(x264)
	dk_disable(x265)
	dk_disable(xz)					# CMake Error: TEST_BIG_ENDIAN found no result!
	dk_disable(zstd)				# error: call to undeclared function 'fileno'; ISO C99 and later do not support implicit function declarations
endif()
