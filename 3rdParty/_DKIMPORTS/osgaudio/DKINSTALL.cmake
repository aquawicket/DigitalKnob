#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


dk_validate(Target_Config  "dk_Target_Config()")
# https://github.com/mccdo/osgaudio.git


### DEPEND ###
dk_depend(freealut)
dk_depend(ogg)
dk_depend(openal)
#dk_depend(opengl)
dk_depend(openscenegraph)
dk_depend(vorbis)


### IMPORT ###
#dk_import(https://github.com/mccdo/osgaudio.git)
dk_import(https://github.com/mccdo/osgaudio/archive/refs/heads/master.zip)


### LINK ###
dk_include(${OSGAUDIO}/include)

# openalpp
Android_dk_libDebug(${OSGAUDIO_Debug_Dir}/obj/local/armeabi-v7a/libopenalpp.a)
Android_dk_libRelease(${OSGAUDIO_Release_Dir}/obj/local/armeabi-v7a/libopenalpp.a)
Apple_dk_libDebug(${OSGAUDIO}/${Target_Tuple}/lib/${DEBUG}/libopenalppd.a)
Apple_dk_libRelease(${OSGAUDIO}/${Target_Tuple}/lib/${RELEASE}/libopenalpp.a)
Emscripten_dk_libDebug(${OSGAUDIO_Debug_Dir}/lib/libopenalppd.a)
Emscripten_dk_libRelease(${OSGAUDIO_Release_Dir}/lib/libopenalpp.a)
Linux_dk_libDebug(${OSGAUDIO_Debug_Dir}/lib/libopenalppd.a)
Linux_dk_libRelease(${OSGAUDIO_Release_Dir}/lib/libopenalpp.a)
Raspberry_dk_libDebug(${OSGAUDIO_Debug_Dir}/lib/libopenalppd.a)
Raspberry_dk_libRelease(${OSGAUDIO_Release_Dir}/lib/libopenalpp.a)
Windows_dk_libDebug(${OSGAUDIO}/${Target_Tuple}/lib/${Debug_Dir}/openalppd.lib)
Windows_dk_libRelease(${OSGAUDIO}/${Target_Tuple}/lib/${Release_Dir}/openalpp.lib)

# osgAudio
Android_dk_libDebug(${OSGAUDIO_Debug_Dir}/obj/local/armeabi-v7a/libosgAudio.a)
Android_dk_libRelease(${OSGAUDIO_Release_Dir}/obj/local/armeabi-v7a/libosgAudio.a)
Apple_dk_libDebug(${OSGAUDIO}/${Target_Tuple}/lib/${DEBUG}/libosgAudiod.a)
Apple_dk_libRelease(${OSGAUDIO}/${Target_Tuple}/lib/${RELEASE}/libosgAudio.a)
Emscripten_dk_libDebug(${OSGAUDIO_Debug_Dir}/lib/libosgAudiod.a)
Emscripten_dk_libRelease(${OSGAUDIO_Release_Dir}/lib/libosgAudio.a)
Linux_dk_libDebug(${OSGAUDIO_Debug_Dir}/lib/libosgAudiod.a)
Linux_dk_libRelease(${OSGAUDIO_Release_Dir}/lib/libosgAudio.a)
Raspberry_dk_libDebug(${OSGAUDIO_Debug_Dir}/lib/libosgAudiod.a)
Raspberry_dk_libRelease(${OSGAUDIO_Release_Dir}/lib/libosgAudio.a)
Windows_dk_libDebug(${OSGAUDIO}/${Target_Tuple}/lib/${Debug_Dir}/osgAudiod.lib)
Windows_dk_libRelease(${OSGAUDIO}/${Target_Tuple}/lib/${Release_Dir}/osgAudio.lib)

# osgdb_osgAudio
Android_dk_libDebug(${OSGAUDIO_Debug_Dir}/obj/local/armeabi-v7a/libosgdb_osgAudio.a)
Android_dk_libRelease(${OSGAUDIO_Release_Dir}/obj/local/armeabi-v7a/libosgdb_osgAudio.a)
Apple_dk_libDebug(${OSGAUDIO}/${Target_Tuple}/lib/${DEBUG}/libosgdb_osgAudiod.a)
Apple_dk_libRelease(${OSGAUDIO}/${Target_Tuple}/lib/${RELEASE}/libosgdb_osgAudio.a)
Emscripten_dk_libDebug(${OSGAUDIO_Debug_Dir}/lib/libosgdb_osgAudiod.a)
Emscripten_dk_libRelease(${OSGAUDIO_Release_Dir}/lib/libosgdb_osgAudio.a)
Linux_dk_libDebug(${OSGAUDIO_Debug_Dir}/lib/libosgdb_osgAudiod.a)
Linux_dk_libRelease(${OSGAUDIO_Release_Dir}/lib/libosgdb_osgAudio.a)
Raspberry_dk_libDebug(${OSGAUDIO_Debug_Dir}/lib/libosgdb_osgAudiod.a)
Raspberry_dk_libRelease(${OSGAUDIO_Release_Dir}/lib/libosgdb_osgAudio.a)
Windows_dk_libDebug(${OSGAUDIO}/${Target_Tuple}/lib/${Debug_Dir}/osgdb_osgAudiod.lib)
Windows_dk_libRelease(${OSGAUDIO}/${Target_Tuple}/lib/${Release_Dir}/osgdb_osgAudio.lib)


### GENERATE ###
string(REPLACE "-std=c++17" "" OSGAUDIO_BUILD "${DKCMAKE_BUILD}")
string(REPLACE "-std=gnu++17" "" OSGAUDIO_BUILD "${OSGAUDIO_BUILD}")
string(REPLACE "  " " " OSGAUDIO_BUILD "${OSGAUDIO_BUILD}")
Android_dk_exec				(${OSGAUDIO_BUILD} "-DCMAKE_CXX_FLAGS=-I${OSGAUDIO}/include" -D0_BUILD_EXAMPLES_OALPP=OFF -D0_BUILD_EXAMPLES_OSGAUDIO=OFF -D0_BUILD_EXAMPLES_OSGAUDIO_LOWLEVEL=OFF -D0_ENABLE_SUBSYSTEM_OPENAL=ON -D0_ENABLE_SUBSYSTEM_FMOD=OFF -DFMOD_INCLUDE_DIR=OFF -DFMOD_LIBRARY=OFF -DOSGAUDIO_INSTALL_DATA=OFF ${FREEALUT_CMAKE} ${ogg_CMAKE} ${OPENAL_CMAKE} ${OPENSCENEGRAPH_CMAKE} ${vorbis_CMAKE} ${OSGAUDIO})
Apple_dk_exec				(${OSGAUDIO_BUILD} "-DCMAKE_CXX_FLAGS=-I${OSGAUDIO}/include" -D0_BUILD_EXAMPLES_OALPP=OFF -D0_BUILD_EXAMPLES_OSGAUDIO=OFF -D0_BUILD_EXAMPLES_OSGAUDIO_LOWLEVEL=OFF -D0_ENABLE_SUBSYSTEM_OPENAL=ON -D0_ENABLE_SUBSYSTEM_FMOD=OFF -DFMOD_INCLUDE_DIR=OFF -DFMOD_LIBRARY=OFF -DOSGAUDIO_INSTALL_DATA=OFF ${FREEALUT_CMAKE} ${ogg_CMAKE} ${OPENAL_CMAKE} ${OPENSCENEGRAPH_CMAKE} ${vorbis_CMAKE} ${OSGAUDIO})
Emscripten_Debug_dk_exec	(${OSGAUDIO_BUILD} "-DCMAKE_CXX_FLAGS=-I${OSGAUDIO}/include" -DOSGAUDIO_USER_DEFINED_DYNAMIC_OR_STATIC=STATIC -DCMAKE_C_FLAGS=-fPIC -D0_BUILD_EXAMPLES_OALPP=OFF -D0_BUILD_EXAMPLES_OSGAUDIO=OFF -D0_BUILD_EXAMPLES_OSGAUDIO_LOWLEVEL=OFF -D0_ENABLE_SUBSYSTEM_OPENAL=ON -D0_ENABLE_SUBSYSTEM_FMOD=OFF -DFMOD_INCLUDE_DIR=OFF -DFMOD_LIBRARY=OFF -DOSGAUDIO_INSTALL_DATA=OFF ${FREEALUT_CMAKE} ${ogg_CMAKE} ${OPENAL_CMAKE} ${OPENSCENEGRAPH_CMAKE} ${vorbis_CMAKE} ${OSGAUDIO})
Emscripten_Release_dk_exec	(${OSGAUDIO_BUILD} "-DCMAKE_CXX_FLAGS=-I${OSGAUDIO}/include" -DCMAKE_C_FLAGS=-fPIC -D0_BUILD_EXAMPLES_OALPP=OFF -D0_BUILD_EXAMPLES_OSGAUDIO=OFF -D0_BUILD_EXAMPLES_OSGAUDIO_LOWLEVEL=OFF -D0_ENABLE_SUBSYSTEM_OPENAL=ON -D0_ENABLE_SUBSYSTEM_FMOD=OFF -DFMOD_INCLUDE_DIR=OFF -DFMOD_LIBRARY=OFF -DOSGAUDIO_INSTALL_DATA=OFF ${FREEALUT_CMAKE} ${ogg_CMAKE} ${OPENAL_CMAKE} ${OPENSCENEGRAPH_CMAKE} ${vorbis_CMAKE} ${OSGAUDIO})
Linux_Debug_dk_exec			(${OSGAUDIO_BUILD} "-DCMAKE_CXX_FLAGS=-I${OSGAUDIO}/include" -DOSGAUDIO_USER_DEFINED_DYNAMIC_OR_STATIC=STATIC -DCMAKE_C_FLAGS=-fPIC -D0_BUILD_EXAMPLES_OALPP=OFF -D0_BUILD_EXAMPLES_OSGAUDIO=OFF -D0_BUILD_EXAMPLES_OSGAUDIO_LOWLEVEL=OFF -D0_ENABLE_SUBSYSTEM_OPENAL=ON -D0_ENABLE_SUBSYSTEM_FMOD=OFF -DFMOD_INCLUDE_DIR=OFF -DFMOD_LIBRARY=OFF -DOSGAUDIO_INSTALL_DATA=OFF ${FREEALUT_CMAKE} ${ogg_CMAKE} ${OPENAL_CMAKE} ${OPENSCENEGRAPH_CMAKE} ${vorbis_CMAKE} ${OSGAUDIO})
Linux_Release_dk_exec		(${OSGAUDIO_BUILD} "-DCMAKE_CXX_FLAGS=-I${OSGAUDIO}/include" -DCMAKE_C_FLAGS=-fPIC -D0_BUILD_EXAMPLES_OALPP=OFF -D0_BUILD_EXAMPLES_OSGAUDIO=OFF -D0_BUILD_EXAMPLES_OSGAUDIO_LOWLEVEL=OFF -D0_ENABLE_SUBSYSTEM_OPENAL=ON -D0_ENABLE_SUBSYSTEM_FMOD=OFF -DFMOD_INCLUDE_DIR=OFF -DFMOD_LIBRARY=OFF -DOSGAUDIO_INSTALL_DATA=OFF ${FREEALUT_CMAKE} ${ogg_CMAKE} ${OPENAL_CMAKE} ${OPENSCENEGRAPH_CMAKE} ${vorbis_CMAKE} ${OSGAUDIO})
Raspberry_Debug_dk_exec		(${OSGAUDIO_BUILD} "-DCMAKE_CXX_FLAGS=-I${OSGAUDIO}/include" -DCMAKE_C_FLAGS=-fPIC -D0_BUILD_EXAMPLES_OALPP=OFF -D0_BUILD_EXAMPLES_OSGAUDIO=OFF -D0_BUILD_EXAMPLES_OSGAUDIO_LOWLEVEL=OFF -D0_ENABLE_SUBSYSTEM_OPENAL=ON -D0_ENABLE_SUBSYSTEM_FMOD=OFF -DFMOD_INCLUDE_DIR=OFF -DFMOD_LIBRARY=OFF -DOSGAUDIO_INSTALL_DATA=OFF ${FREEALUT_CMAKE} ${ogg_CMAKE} ${OPENAL_CMAKE} ${OPENSCENEGRAPH_CMAKE} ${vorbis_CMAKE} ${OSGAUDIO})
Raspberry_Release_dk_exec	(${OSGAUDIO_BUILD} "-DCMAKE_CXX_FLAGS=-I${OSGAUDIO}/include" -DCMAKE_C_FLAGS=-fPIC -D0_BUILD_EXAMPLES_OALPP=OFF -D0_BUILD_EXAMPLES_OSGAUDIO=OFF -D0_BUILD_EXAMPLES_OSGAUDIO_LOWLEVEL=OFF -D0_ENABLE_SUBSYSTEM_OPENAL=ON -D0_ENABLE_SUBSYSTEM_FMOD=OFF -DFMOD_INCLUDE_DIR=OFF -DFMOD_LIBRARY=OFF -DOSGAUDIO_INSTALL_DATA=OFF ${FREEALUT_CMAKE} ${ogg_CMAKE} ${OPENAL_CMAKE} ${OPENSCENEGRAPH_CMAKE} ${vorbis_CMAKE} ${OSGAUDIO})
Windows_dk_exec				(${OSGAUDIO_BUILD} "-DCMAKE_CXX_FLAGS=/I${OSGAUDIO}/include" -D0_BUILD_EXAMPLES_OALPP=OFF -D0_BUILD_EXAMPLES_OSGAUDIO=OFF -D0_BUILD_EXAMPLES_OSGAUDIO_LOWLEVEL=OFF -D0_ENABLE_SUBSYSTEM_OPENAL=ON -D0_ENABLE_SUBSYSTEM_FMOD=OFF -DFMOD_INCLUDE_DIR=OFF -DFMOD_LIBRARY=OFF -DOSGAUDIO_INSTALL_DATA=OFF ${FREEALUT_CMAKE} ${ogg_CMAKE} ${OPENAL_CMAKE} ${OPENSCENEGRAPH_CMAKE} ${vorbis_CMAKE} ${OSGAUDIO})


### COMPILE ###
dk_build()
