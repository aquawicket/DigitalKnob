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
#dk_disable(_TEMPLATE-APP_)
#dk_disable(_TEMPLATE-LIB_)
dk_disable(android-java-tools)
dk_disable(astyle)
dk_disable(bullet3)
dk_disable(conio-for-linux)
dk_disable(DKJerryscript)
dk_disable(DKOFWindow)
dk_disable(DKOSGAudio)               # Openscenegraph
dk_disable(DKOSGCef)                 # Openscenegraph
dk_disable(DKOSGLights)              # Openscenegraph
dk_disable(DKOSGManipulator)         # Openscenegraph
dk_disable(DKOSGModel)               # Openscenegraph
dk_disable(DKOSGNotify)              # Openscenegraph
dk_disable(DKOSGPhysics)             # Openscenegraph
dk_disable(DKOSGPicker)              # Openscenegraph
dk_disable(DKOSGRml)                 # Openscenegraph
dk_disable(DKOSGStats)               # Openscenegraph
dk_disable(DKOSGTerrain)             # Openscenegraph
dk_disable(DKOSGVideo)               # Openscenegraph
dk_disable(DKOSGViewer)              # Openscenegraph 
dk_disable(DKOSGWidget)
dk_disable(DKOSGWindow)
dk_disable(DKPlugin1)
dk_disable(DKPlugin2)
dk_disable(DKRestart)
dk_disable(DKScreenRecorder)
dk_disable(DKSDLAudio)
dk_disable(DKSDLWav)
dk_disable(DKSDLVideo)
dk_disable(DKSFMLRml)               # incomplete
dk_disable(DKThread)
dk_disable(DKTorrent)
dk_disable(DKUpdate)
dk_disable(DKVncClient)
dk_disable(DKVncServer)
dk_disable(gradle)
dk_disable(java)
dk_disable(jpeg)                     # using libjpeg_turbo instead
dk_disable(libcaca)
dk_disable(librocket)                # replaced with RmlUi
dk_disable(libvncserver)
dk_disable(libvncserver-master-win)
dk_disable(libx11)
dk_disable(miniweb)
dk_disable(msys2)
dk_disable(opencv)					#WORKING, just disabled because it takes so long to compile
dk_disable(openframeworks)
dk_disable(openscenegraph)          # Openscenegraph
dk_disable(osgaudio)                # Openscenegraph
dk_disable(osgbullet)               # Openscenegraph
dk_disable(osgworks)                # Openscenegraph
dk_disable(sdl2_gif)                # use SDL_Image animation
dk_disable(sdl2_giflib_sa)          # updated version of sdl2_gif
dk_disable(simple-getch)            # kept for reference


if(NOT WIN_HOST) # Disabled on Non-Windows host machines
	#dk_disable(android-studio)
	#dk_disable(php-src)
endif()
if(WIN) # Disabled for Windows targets
	dk_disable(DKOcr)
	dk_disable(freealut)
	dk_disable(jerryscript)
	dk_disable(leptonica)
	dk_disable(libtorrent)
	dk_disable(libwebp)
	dk_disable(libwebsockets)
	dk_disable(lighttpd)
	dk_disable(lua)
	#dk_disable(openal-android)
	dk_disable(opensles)
	dk_disable(tesseract)
	#dk_disable(waave)
endif()
if(WIN_32) # Disabled for Windows 32bit targets
	#
endif()
if(WIN_64) # Disabled for Windows 64bit targets
	dk_disable(smpeg2)
endif()


if(MAC)  # Disabled on Mac host machines
	dk_disable(android-build-tools)
	dk_disable(android-ndk)
	dk_disable(android-platform-tools)
	dk_disable(bzip2)
	dk_disable(DKMySql)
	dk_disable(DKOcr)
	dk_disable(freealut)
	dk_disable(imagemagick)
	dk_disable(java)
	dk_disable(openjdk)
	dk_disable(openjdk-8u41)
	dk_disable(openjdk-9.0.4)
	dk_disable(openjdk-11)
	dk_disable(jerryscript)
	dk_disable(leptonica)
	dk_disable(libgtkglext1-dev)
	dk_disable(libtorrent)
	dk_disable(libwebp)
	dk_disable(libwebsockets)
	dk_disable(libxml2)
	dk_disable(lighttpd)
	dk_disable(lua)
	dk_disable(mlocate)
	dk_disable(mobile_core_services)
	dk_disable(openal-android)
	dk_disable(rtmidi)
	dk_disable(sdl-gpu)
	dk_disable(smpeg2)
	dk_disable(terminator)
	dk_disable(tesseract)
	dk_disable(tidy-html5)
	dk_disable(waave)
endif()

if(IOS OR IOSSIM)
	dk_disable(boost)
	dk_disable(boxer)
	dk_disable(bzip2)
	dk_disable(cryptopp)
	dk_disable(DKCef)
	dk_disable(DKCefChild)
	dk_disable(DKMidi)
	dk_disable(DKMySql)
	dk_disable(DKOcr)
	dk_disable(DKRmlIframe)
	dk_disable(DKSDLCef)
	dk_disable(DKSFMLRml)
	dk_disable(DKSFMLWindow)
	dk_disable(freealut)
	dk_disable(giflib)
	dk_disable(glew)
	dk_disable(imagemagick)
	dk_disable(java)
	dk_disable(openjdk)
	dk_disable(openjdk-8u41)
	dk_disable(jerryscript)
	dk_disable(libgtkglext1-dev)
	dk_disable(libiconv)
	dk_disable(libjpeg-turbo)
	dk_disable(libmd)
	dk_disable(libpng)
	dk_disable(leptonica)
	dk_disable(libtorrent)
	dk_disable(linusb)
	dk_disable(libwebp)
	dk_disable(libwebsockets)
	dk_disable(libxml2)
	dk_disable(lighttpd)
	dk_disable(lua)
	dk_disable(mlocate)
	dk_disable(openal)
	dk_disable(openal-android)
	dk_disable(podofo)
	dk_disable(rtmidi)
	dk_disable(sdl-gpu)
	dk_disable(sfml)
	dk_disable(smpeg2)
	dk_disable(tesseract)
	dk_disable(tidy-html5)
	dk_disable(tiff)
	dk_disable(waave)
endif()


if(NOT LINUX AND NOT RASPBERRY) # Disabled NON Linux targets -> "Disabled for: WINDOWS, MAC, IOS, ANDROID"
	dk_disable(libasound2-dev)
	dk_disable(libgl1-mesa-dev)
	dk_disable(libglib2.0-dev)
	dk_disable(libglu1-mesa-dev)
	dk_disable(libgtk2.0-dev)
	dk_disable(libsndfile1-dev)
	dk_disable(libsystemd-dev)
	dk_disable(libudev-dev)
	dk_disable(libx11-dev)
	dk_disable(libxcursor-dev)
	dk_disable(libxrandr-dev)
	dk_disable(libxtst-dev)
	dk_disable(mesa-common-dev)
endif()
if(LINUX) # Disabled for Linux targets
	dk_disable(android-build-tools)
	dk_disable(boxer)
	dk_disable(DKHook)         # NOTE: this has linux functions too
	dk_disable(DKOcr)
	dk_disable(DKSDLWav)
	dk_disable(DKSFMLRml)
	dk_disable(DKSFMLWindow)
	dk_disable(DKTorrent)
	dk_disable(freealut)
	dk_disable(giflib)
	dk_disable(imagemagick)
	dk_disable(java)
	dk_disable(openjdk)
	dk_disable(jerryscript)
	dk_disable(kdevelop)
	dk_disable(leptonica)
	dk_disable(libjpeg-turbo)
	dk_disable(libtorrent)
	dk_disable(libwebp)
	dk_disable(libwebsockets)
	dk_disable(libxml2)
	dk_disable(lighttpd)
	dk_disable(lua)
	#dk_disable(python)
	dk_disable(rtmidi)
	dk_disable(sdl-gpu)
	dk_disable(sfml)           # sfml_sfml-network)  #TODO: disabling individual sublibraries
	dk_disable(stackwalker)
	dk_disable(tesseract)
	dk_disable(tiff)
	dk_disable(upx)
	dk_disable(uwebsockets)
	dk_disable(waave)
endif()


if(RASPBERRY) # Disabled for Raspberry Pi targets
	dk_disable(android-build-tools)
	dk_disable(boxer)
	dk_disable(DKHook)           # NOTE: this has linux functions too
	dk_disable(DKMidi)
	dk_disable(DKOcr)
	dk_disable(DKWebSockets)
	dk_disable(freealut)
	dk_disable(imagemagick)
	dk_disable(java)
	dk_disable(openjdk)
	dk_disable(jerryscript)
	dk_disable(leptonica)
	dk_disable(libtorrent)
	dk_disable(libwebp)
	dk_disable(libwebsockets)
	dk_disable(libxml2)
	dk_disable(lighttpd)
	dk_disable(lua)
	dk_disable(openal-android)
	dk_disable(python)
	dk_disable(sdl-gpu)
	dk_disable(stackwalker)
	dk_disable(tesseract)
	dk_disable(upx)
	dk_disable(waave)
endif()


if(ANDROID) # Disabled for Android targets
	dk_disable(boxer)
	dk_disable(bzip2)
	dk_disable(cef_binary)
	dk_disable(cryptopp)
	dk_disable(curl)
	dk_disable(DKCef)
	dk_disable(DKCefChild)
	dk_disable(DKCurl)
	dk_disable(DKWebSockets)
	dk_disable(DKHandles)
	dk_disable(DKHook)        # NOTE: this has linux functions too
	dk_disable(DKMidi)
	dk_disable(DKMySql)
	dk_disable(DKOcr)
	dk_disable(DKRmlIframe)
	dk_disable(DKSDLCef)
	dk_disable(DKSFMLWindow)
	dk_disable(DKWebSockets)
	dk_disable(DKWebview)
	dk_disable(flac)
	dk_disable(freealut)
	dk_disable(glew)
	dk_disable(imagemagick)
	dk_disable(java)
	dk_disable(jerryscript)
	dk_disable(kdevelop)
	dk_disable(leptonica)
	dk_disable(libtorrent)
	dk_disable(libiconv)
	dk_disable(ogg)
	dk_disable(libuv)
	dk_disable(vorbis)
	dk_disable(libwebp)
	dk_disable(libwebsockets)
	dk_disable(libxml2)
	dk_disable(lighttpd)
	dk_disable(lua)
	dk_disable(openal)
	dk_disable(openal-android)
	dk_disable(openssl)
	dk_disable(podofo)
	dk_disable(rlottie)
	dk_disable(rtmidi)
	dk_disable(sdl-gpu)
	dk_disable(sdl_mixer)
	dk_disable(sfml)
	dk_disable(smpeg2)
	dk_disable(stackwalker)
	dk_disable(tesseract)
	dk_disable(tidy-html5)
	dk_disable(uwebsockets)
	dk_disable(xz)
	dk_disable(waave)
endif()
if(ANDROID_64) # Disabled for Android 64bit targets
	dk_disable(boost)
endif()
