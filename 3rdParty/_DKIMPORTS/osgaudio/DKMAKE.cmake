IF(LINUX)
	#RETURN()
ENDIF()
IF(ANDROID)
	#RETURN()
ENDIF()

DKDEPEND(OpenSceneGraph-3.4.0)
DKDEPEND(libogg-1.3.2)
DKDEPEND(libvorbis-1.3.5)
DKDEPEND(freealut-1.1.0-src)
DKDEPEND(OpenAL-android)
DKDEPEND(freealut-master)
DKDEPEND(openal)


### INSTALL ###
DKINSTALL(http://digitalknob.com/Download/Libs/osgaudio-master.zip osgaudio-master)
DKSET(OSGAUDIO ${3RDPARTY}/osgaudio-master)


### LINK ###
DKINCLUDE(${OSGAUDIO}/include)
WIN_DEBUG_LIB(${OSGAUDIO}/${OS}/lib/Debug/openalppd.lib)
WIN_RELEASE_LIB(${OSGAUDIO}/${OS}/lib/Release/openalpp.lib)
APPLE_DEBUG_LIB(${OSGAUDIO}/${OS}/lib/${DEBUG}/libopenalppd.a)
APPLE_RELEASE_LIB(${OSGAUDIO}/${OS}/lib/${RELEASE}/libopenalpp.a)
LINUX_DEBUG_LIB(${OSGAUDIO}/${OS}/Debug/lib/libopenalppd.a)
LINUX_RELEASE_LIB(${OSGAUDIO}/${OS}/Release/lib/libopenalpp.a)
ANDROID_DEBUG_LIB(${OSGAUDIO}/${OS}/Debug/obj/local/armeabi-v7a/libopenalpp.a)
ANDROID_RELEASE_LIB(${OSGAUDIO}/${OS}/Release/obj/local/armeabi-v7a/libopenalpp.a)

WIN_DEBUG_LIB(${OSGAUDIO}/${OS}/lib/Debug/osgAudiod.lib)
WIN_RELEASE_LIB(${OSGAUDIO}/${OS}/lib/Release/osgAudio.lib)
APPLE_DEBUG_LIB(${OSGAUDIO}/${OS}/lib/${DEBUG}/libosgAudiod.a)
APPLE_RELEASE_LIB(${OSGAUDIO}/${OS}/lib/${RELEASE}/libosgAudio.a)
LINUX_DEBUG_LIB(${OSGAUDIO}/${OS}/Debug/lib/libosgAudiod.a)
LINUX_RELEASE_LIB(${OSGAUDIO}/${OS}/Release/lib/libosgAudio.a)
ANDROID_DEBUG_LIB(${OSGAUDIO}/${OS}/Debug/obj/local/armeabi-v7a/libosgAudio.a)
ANDROID_RELEASE_LIB(${OSGAUDIO}/${OS}/Release/obj/local/armeabi-v7a/libosgAudio.a)

WIN_DEBUG_LIB(${OSGAUDIO}/${OS}/lib/Debug/osgdb_osgAudiod.lib)
WIN_RELEASE_LIB(${OSGAUDIO}/${OS}/lib/Release/osgdb_osgAudio.lib)
APPLE_DEBUG_LIB(${OSGAUDIO}/${OS}/lib/${DEBUG}/libosgdb_osgAudiod.a)
APPLE_RELEASE_LIB(${OSGAUDIO}/${OS}/lib/${RELEASE}/libosgdb_osgAudio.a)
LINUX_DEBUG_LIB(${OSGAUDIO}/${OS}/Debug/lib/libosgdb_osgAudiod.a)
LINUX_RELEASE_LIB(${OSGAUDIO}/${OS}/Release/lib/libosgdb_osgAudio.a)
ANDROID_DEBUG_LIB(${OSGAUDIO}/${OS}/Debug/obj/local/armeabi-v7a/libosgdb_osgAudio.a)
ANDROID_RELEASE_LIB(${OSGAUDIO}/${OS}/Release/obj/local/armeabi-v7a/libosgdb_osgAudio.a)


### COMPILE ###
DKSETPATH(${OSGAUDIO}/${OS})
WIN32_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} "-DCMAKE_CXX_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo /GR /EHsc /DOSG_LIBRARY_STATIC /DAL_LIBTYPE_STATIC /I${OPENAL}/include" "-DCMAKE_CXX_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_CXX_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} -DALUT_INCLUDE_DIR=${FREEALUT}/include -DALUT_LIBRARY=${FREEALUT}/${OS}/Release/alut_static.lib -DALUT_LIBRARY_DEBUG=${FREEALUT}/${OS}/Debug/alut_static.lib -D0_BUILD_EXAMPLES_OALPP=OFF -D0_BUILD_EXAMPLES_OSGAUDIO=OFF -D0_BUILD_EXAMPLES_OSGAUDIO_LOWLEVEL=OFF -D0_ENABLE_SUBSYSTEM_OPENAL=ON -D0_ENABLE_SUBSYSTEM_FMOD=OFF -DFMOD_INCLUDE_DIR=OFF -DFMOD_LIBRARY=OFF -DOSGAUDIO_INSTALL_DATA=OFF -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY=${OPENAL}/${OS}/Release/OpenAL32.lib -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/Release/src/.libs/libogg.lib -DOGG_LIBRARY_DEBUG=${OGG}/${OS}/Debug/src/.libs/libogg.lib -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/Release/lib/.libs/libvorbis.lib -DVORBIS_LIBRARY_DEBUG=${VORBIS}/${OS}/Debug/lib/.libs/libvorbis.lib -DVORBISFILE_INCLUDE_DIR=${VORBIS}/include -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/Release/lib/.libs/libvorbisfile.lib -DVORBISFILE_LIBRARY_DEBUG=${VORBIS}/${OS}/Debug/lib/.libs/libvorbisfile.lib ${OSGAUDIO})
WIN32_VS_DEBUG(osgaudio-master osgAudio.sln)
WIN32_VS_RELEASE(osgaudio-master osgAudio.sln)

DKSETPATH(${OSGAUDIO}/${OS})
WIN64_COMMAND(${CMAKE_COMMAND} -G ${X64GENERATOR} "-DCMAKE_CXX_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo /GR /EHsc /DOSG_LIBRARY_STATIC /DAL_LIBTYPE_STATIC /I${OPENAL}/include" "-DCMAKE_CXX_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_CXX_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} -DALUT_INCLUDE_DIR=${FREEALUT}/include -DALUT_LIBRARY=${FREEALUT}/${OS}/Release/alut_static.lib -DALUT_LIBRARY_DEBUG=${FREEALUT}/${OS}/Debug/alut_static.lib -D0_BUILD_EXAMPLES_OALPP=OFF -D0_BUILD_EXAMPLES_OSGAUDIO=OFF -D0_BUILD_EXAMPLES_OSGAUDIO_LOWLEVEL=OFF -D0_ENABLE_SUBSYSTEM_OPENAL=ON -D0_ENABLE_SUBSYSTEM_FMOD=OFF -DFMOD_INCLUDE_DIR=OFF -DFMOD_LIBRARY=OFF -DOSGAUDIO_INSTALL_DATA=OFF -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY=${OPENAL}/${OS}/Release/OpenAL32.lib -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/Release/src/.libs/libogg.lib -DOGG_LIBRARY_DEBUG=${OGG}/${OS}/Debug/src/.libs/libogg.lib -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/Release/lib/.libs/libvorbis.lib -DVORBIS_LIBRARY_DEBUG=${VORBIS}/${OS}/Debug/lib/.libs/libvorbis.lib -DVORBISFILE_INCLUDE_DIR=${VORBIS}/include -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/Release/lib/.libs/libvorbisfile.lib -DVORBISFILE_LIBRARY_DEBUG=${VORBIS}/${OS}/Debug/lib/.libs/libvorbisfile.lib ${OSGAUDIO})
WIN64_VS_DEBUG(osgaudio-master osgAudio.sln)
WIN64_VS_RELEASE(osgaudio-master osgAudio.sln)

DKSETPATH(${OSGAUDIO}/${OS})
MAC_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DCMAKE_OSX_ARCHITECTURES=x86_64 "-DCMAKE_CXX_FLAGS=-I${OPENAL}/include -I${FREEALUT}/include" "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} -DALUT_INCLUDE_DIR=${OSG}/include -DALUT_LIBRARY=${FREEALUT}/${OS}/Release/libalut_static.a -DALUT_LIBRARY_DEBUG=${FREEALUT}/${OS}/Debug/libalut_static.a -D0_BUILD_EXAMPLES_OALPP=OFF -D0_BUILD_EXAMPLES_OSGAUDIO=OFF -D0_BUILD_EXAMPLES_OSGAUDIO_LOWLEVEL=OFF -D0_ENABLE_SUBSYSTEM_OPENAL=ON -D0_ENABLE_SUBSYSTEM_FMOD=OFF -DFMOD_INCLUDE_DIR=OFF -DFMOD_LIBRARY=OFF -DOSGAUDIO_INSTALL_DATA=OFF -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY=${OPENAL}/${OS}/Release/libopenal.a -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/Release/src/.libs/libogg.a -DOGG_LIBRARY_DEBUG=${OGG}/${OS}/Debug/src/.libs/libogg.a -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/Release/lib/.libs/libvorbis.a -DVORBIS_LIBRARY_DEBUG=${VORBIS}/${OS}/Debug/lib/.libs/libvorbis.a -DVORBISFILE_INCLUDE_DIR=${VORBIS}/include -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/Release/lib/.libs/libvorbisfile.a -DVORBISFILE_LIBRARY_DEBUG=${VORBIS}/${OS}/Debug/lib/.libs/libvorbisfile.a ${OSGAUDIO})
MAC_XCODE_DEBUG(osgaudio-master)
MAC_XCODE_RELEASE(osgaudio-master)


DKSETPATH(${OSGAUDIO}/${OS}/Debug)
LINUX_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG -DCMAKE_C_FLAGS=-fPIC "-DCMAKE_CXX_FLAGS=-I${OPENAL}/include -I${FREEALUT}/include" "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS}/Debug -DOSGSourceRoot=${OSG} -DALUT_INCLUDE_DIR=${OSG}/include -DALUT_LIBRARY=${FREEALUT}/${OS}/Debug/libalut_static.a -DALUT_LIBRARY_DEBUG=${FREEALUT}/${OS}/Debug/libalut_static.a -D0_BUILD_EXAMPLES_OALPP=OFF -D0_BUILD_EXAMPLES_OSGAUDIO=OFF -D0_BUILD_EXAMPLES_OSGAUDIO_LOWLEVEL=OFF -D0_ENABLE_SUBSYSTEM_OPENAL=ON -D0_ENABLE_SUBSYSTEM_FMOD=OFF -DFMOD_INCLUDE_DIR=OFF -DFMOD_LIBRARY=OFF -DOSGAUDIO_INSTALL_DATA=OFF -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY=${OPENAL}/${OS}/Debug/libopenal.a -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/Debug/src/.libs/libogg.a -DOGG_LIBRARY_DEBUG=${OGG}/${OS}/Debug/src/.libs/libogg.a -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/Debug/lib/.libs/libvorbis.a -DVORBIS_LIBRARY_DEBUG=${VORBIS}/${OS}/Debug/lib/.libs/libvorbis.a -DVORBISFILE_INCLUDE_DIR=${VORBIS}/include -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/Debug/lib/.libs/libvorbisfile.a -DVORBISFILE_LIBRARY_DEBUG=${VORBIS}/${OS}/Debug/lib/.libs/libvorbisfile.a ${OSGAUDIO})
LINUX_DEBUG_COMMAND(make)

DKSETPATH(${OSGAUDIO}/${OS}/Release)
LINUX_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_C_FLAGS=-fPIC "-DCMAKE_CXX_FLAGS=-I${OPENAL}/include -I${FREEALUT}/include" "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS}/Release -DOSGSourceRoot=${OSG} -DALUT_INCLUDE_DIR=${OSG}/include -DALUT_LIBRARY=${FREEALUT}/${OS}/Release/libalut_static.a -DALUT_LIBRARY_DEBUG=${FREEALUT}/${OS}/Debug/libalut_static.a -D0_BUILD_EXAMPLES_OALPP=OFF -D0_BUILD_EXAMPLES_OSGAUDIO=OFF -D0_BUILD_EXAMPLES_OSGAUDIO_LOWLEVEL=OFF -D0_ENABLE_SUBSYSTEM_OPENAL=ON -D0_ENABLE_SUBSYSTEM_FMOD=OFF -DFMOD_INCLUDE_DIR=OFF -DFMOD_LIBRARY=OFF -DOSGAUDIO_INSTALL_DATA=OFF -DOPENAL_INCLUDE_DIR=${OPENAL}/include/AL -DOPENAL_LIBRARY=${OPENAL}/${OS}/Release/libopenal.a -DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/Release/src/.libs/libogg.a -DOGG_LIBRARY_DEBUG=${OGG}/${OS}/Debug/src/.libs/libogg.a -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/Release/lib/.libs/libvorbis.a -DVORBIS_LIBRARY_DEBUG=${VORBIS}/${OS}/Debug/lib/.libs/libvorbis.a -DVORBISFILE_INCLUDE_DIR=${VORBIS}/include -DVORBISFILE_LIBRARY=${VORBIS}/${OS}/Release/lib/.libs/libvorbisfile.a -DVORBISFILE_LIBRARY_DEBUG=${VORBIS}/${OS}/Debug/lib/.libs/libvorbisfile.a ${OSGAUDIO})
LINUX_RELEASE_COMMAND(make)


ANDROID_INCLUDE(${OSGAUDIO}/${OS})
ANDROID_NDK_DEBUG(osgaudio-master)
ANDROID_NDK_RELEASE(osgaudio-master)