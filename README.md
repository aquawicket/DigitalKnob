![](http://digitalknob.com/Digitalknob/Digitalknob/logo.png)
# DigitalKnob

<!-- [![Gitter](https://badges.gitter.im/DigitalKnob/community.svg)](https://gitter.im/DigitalKnob/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge) -->

### Digitalknob is a Cross-Platform Solution that embraces C++, JavaScript, Html, and CSS.
*"Apps should look and act the same on every operating system and browser."* <br><br>

### Supported Platforms
Windows x86 <br>
Windows x86_64 <br>
Mac x86_64 <br>
Linux x86 <br>
Linux x86_64 <br>
iPhone/iPad arm64 (<br>
iPhone/iPad-Simulator x86_64 <br>
Android arm32 <br>
Android arm64 <br>
Raspberry Pi <br>
Chrome <br>
Safari <br>
Firefox <br>
Opera <br>
Internet Explorer (9.0+) <br>
Emscripten <br>

### Supported Frameworks
[SDL](https://github.com/spurious/SDL-mirror) <br>

### Supported Tools, Libraries and Frameworks
agl
android
android-build-tools
android-cmake
android-cmdline-tools
android-java-tools
android-ndk
android-platform-tools
android-platforms
android-sdk
android-sdk-tools
android-sources
android-studio
android-system-images
ant
aom
appkit
asio
astyle
aubio
audiounit
audio_toolbox
autotools
avf_audio
av_foundation
av_kit
babel
backward-cpp
boost
boxer
build-essential
bullet3
bzip2
bzip2-win-build
carbon
cef_binary
chart.js
cmake
cocoa
codemirror
command_line_tools
conio-for-linux
content
core_audio
core_foundation
core_graphics
core_haptics
core_media
core_motion
core_services
core_video
cpp-subprocess
crosswalk
cryptopp
curl
ddd
dependencywalker
diff-match-patch
dl
doxygen
duk4vb
dukluv
duktape
dxva2.dll
emsdk
far
ffmpeg
ffmpeg-dev
ffmpeg-shared
ffmpeg-static
fftw3
flac
fmt
fontconfig
force_feedback
foundation
freealut
freeimage
freetype
game_controller
gdal
ghidra
ghostscript
giflib
git
glew
glintercept
gl_kit
gnutls
gradle
gstreamer
gzip
homebrew
ilmerge
imageio
imagemagick
imm32.lib
iokit
ios-cmake
iphlpapi.lib
jasper
java
jerryscript
jpeg
js-yaml
json
kdevelop
lame
leptonica
libarchive
libasound2-dev
libatomic
libb2
libcaca
libexpat
libgcc
libgl1-mesa-dev
libglfw3-dev
libglib2.0-dev
libglu1-mesa-dev
libgtk-3-dev
libgtk2.0-dev
libgtkglext1-dev
libiconv
libjpeg-turbo
libmd
libmingwex
libpng
libpsl
librocket
libsndfile
libsndfile1-dev
libssh
libsystemd-dev
libtorrent
libudev-dev
libusb
libuv
libvncserver
libwebp
libwebsockets
libwinpthread
libx11
libx11-dev
libxcursor-dev
libxml2
libxrandr-dev
libxtst-dev
lighttpd
lodepng
log
lua
lz4
m
macports
media_player
mesa-common-dev
metal
metal-cpp
metalKit
mingw-win32-application
mingw32
mingw64
miniweb
mlocate
mobile_core_services
moment
mpg123
msinttypes
msys
msys2
nasm
ncurses
nodejs
notepadpp
ofxcmake
ofxiosboost-1.60.0
ofxiosboost-1.60.0-libc-bitcode
ogg
openal
openblas
opencv
openframeworks
opengl
opengles
openjdk
openjdk-8u41
openjpeg
openmw
openscenegraph
opensles
openssl
opus
os.js
osgaudio
osgbullet
osgrmlui
osgworks
pacman.c
pako
pcre2
pdh.lib
pearl
php-src
poco
podofo
psapi.lib
pugixml
python
pyyaml
quartz_core
rlottie
rmlui
rmlui-d3d11
rmluieditor
rocketship
rpm
rtaudio
rtmidi
sdl
sdl-gpu
sdl2_gif
sdl2_giflib_sa
sdl_image
sdl_mixer
sdl_net
sdl_rtf
sdl_ttf
secur32.lib
security
setupapi.lib
sfml
shlwapi.lib
simple-getch
smpeg2
stackwalker
strmiids.lib
sun-js
sw
sw-client
system_configuration
terminator
termux
tesseract
threadpool
tidy-html5
tiff
uikit
upx
userenv.lib
uwebsockets
vccorlib.lib
vcpkg
vc_redist
version.lib
verysleepy
vfw32.lib
video_toolbox
visualstudio
vorbis
waave
wasi
wasm2brs
wasm3
winmm.lib
ws2_32.lib
x264
x265
xcode
xquartz
xz
zlib
zstd


# How to build
### Windows Host
Download and run [build.cmd](https://github.com/aquawicket/DigitalKnob/releases/download/1.0b/build.cmd) 

### Unix Host
Download [build.sh](https://github.com/aquawicket/DigitalKnob/releases/download/1.0b/build.sh) <br>
From terminal run 'chmod 777 /path/to/build.sh' <br>
Run '/path/to/build.sh'

### DKCMake
Digitalknob uses it's own build system powered by the cmake scripting language. (DKCMake) <br>
Invoking cmake -G"<generator>" -S<DKCMake_directory> -B<DKApps/MyApp/'OS'> will use a universal /DKCMake/CMakeLists.txt script. <br>
The build system will differenciate the appropriate scripts to use when the output directory is pointed to a valid <OS> folder
EXAMPLE: "<DKApps/MyApp/ios_arm64>" <br>

Valid <'OS'>'s are <br>
android_arm32 <br>
android_arm64 <br>
emscripten <br>
ios_arm32 <br>
ios_arm64 <br>
iossim_x86 <br>
iossim_x86_64 <br>
linux_x86 <br>
linux_x86_64 <br>
mac_x86 <br>
mac_x86_64 <br>
raspberry_arm32 <br>
raspberry_arm64 <br>
win_x86 <br>
win_x86_64 <br>

EXAMPLE: cmake -G"Visual Studio 17 2022" -SC:/Users/<username>/digitalknob/Development/DKCMake -BC:/Users/<username>/digitalknob/Development/DKApps/DKCore/win_x86
	"will use Visual Studio 17 2022 to build DKCore for the windows i686 platform"
"NOTE: using build.sh to build DKBuilder, and using DKBuilder_APP.exe is the prefered and tested way to build DK Apps" 




<br><br><br>
[Forking, Branching and Pull Requests](https://github.com/Kunena/Kunena-Forum/wiki/Create-a-new-branch-with-git-and-manage-branches)<br>
[Markdown Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
[.](http://aquawicket.github.io/DigitalKnob/DKPlugins/index.html)


# License
DigitalKnob is published under the MIT license. 
This repository references the use of third-party source code and assets with their own licenses. Upon any use of DigitalKnob and/or any part of its code base, you hereby fully agree to, and acknowledge all licensees of said third-party source code.

MIT License

Copyright (c) 2010-2023 DigitalKnob, and contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
