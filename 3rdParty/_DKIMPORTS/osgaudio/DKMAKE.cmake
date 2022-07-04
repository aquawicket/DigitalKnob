# http://TODO.com/osgaudio-master.zip

dk_depend(openscenegraph)
dk_depend(ogg)
dk_depend(vorbis)
dk_depend(freealut)
dk_depend(openal-android)
dk_depend(freealut)
dk_depend(openal)


#${OSGAUDIO_VERSION master}
#${OSGAUDIO_DL http://TODO.com/${OSGAUDIO_NAME}.zip}
#${OSGAUDIO_NAME osgaudio-${OSG_VERSION}}
#${OSGAUDIO ${3RDPARTY}/${OSG_NAME})
#dk_set(OSGAUDIO ${3RDPARTY}/osgaudio-master)
#dk_import(${OSG_AUDIODL} ${OSGAUDIO})
dk_import(http://TODO.com/osgaudio-master.zip)


### LINK ###
dk_include(${OSGAUDIO}/include)
WIN_dk_libDebug(${OSGAUDIO}/${OS}/lib/${DEBUG_DIR}/openalppd.lib)
WIN_dk_libRelease(${OSGAUDIO}/${OS}/lib/${RELEASE_DIR}/openalpp.lib)
APPLE_dk_libDebug(${OSGAUDIO}/${OS}/lib/${DEBUG}/libopenalppd.a)
APPLE_dk_libRelease(${OSGAUDIO}/${OS}/lib/${RELEASE}/libopenalpp.a)
LINUX_dk_libDebug(${OSGAUDIO}/${OS}/${DEBUG_DIR}/lib/libopenalppd.a)
LINUX_dk_libRelease(${OSGAUDIO}/${OS}/${RELEASE_DIR}/lib/libopenalpp.a)
RASPBERRY_dk_libDebug(${OSGAUDIO}/${OS}/${DEBUG_DIR}/lib/libopenalppd.a)
RASPBERRY_dk_libRelease(${OSGAUDIO}/${OS}/${RELEASE_DIR}/lib/libopenalpp.a)
ANDROID_dk_libDebug(${OSGAUDIO}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libopenalpp.a)
ANDROID_dk_libRelease(${OSGAUDIO}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libopenalpp.a)

WIN_dk_libDebug(${OSGAUDIO}/${OS}/lib/${DEBUG_DIR}/osgAudiod.lib)
WIN_dk_libRelease(${OSGAUDIO}/${OS}/lib/${RELEASE_DIR}/osgAudio.lib)
APPLE_dk_libDebug(${OSGAUDIO}/${OS}/lib/${DEBUG}/libosgAudiod.a)
APPLE_dk_libRelease(${OSGAUDIO}/${OS}/lib/${RELEASE}/libosgAudio.a)
LINUX_dk_libDebug(${OSGAUDIO}/${OS}/${DEBUG_DIR}/lib/libosgAudiod.a)
LINUX_dk_libRelease(${OSGAUDIO}/${OS}/${RELEASE_DIR}/lib/libosgAudio.a)
RASPBERRY_dk_libDebug(${OSGAUDIO}/${OS}/${DEBUG_DIR}/lib/libosgAudiod.a)
RASPBERRY_dk_libRelease(${OSGAUDIO}/${OS}/${RELEASE_DIR}/lib/libosgAudio.a)
ANDROID_dk_libDebug(${OSGAUDIO}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libosgAudio.a)
ANDROID_dk_libRelease(${OSGAUDIO}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libosgAudio.a)

WIN_dk_libDebug(${OSGAUDIO}/${OS}/lib/${DEBUG_DIR}/osgdb_osgAudiod.lib)
WIN_dk_libRelease(${OSGAUDIO}/${OS}/lib/${RELEASE_DIR}/osgdb_osgAudio.lib)
APPLE_dk_libDebug(${OSGAUDIO}/${OS}/lib/${DEBUG}/libosgdb_osgAudiod.a)
APPLE_dk_libRelease(${OSGAUDIO}/${OS}/lib/${RELEASE}/libosgdb_osgAudio.a)
LINUX_dk_libDebug(${OSGAUDIO}/${OS}/${DEBUG_DIR}/lib/libosgdb_osgAudiod.a)
LINUX_dk_libRelease(${OSGAUDIO}/${OS}/${RELEASE_DIR}/lib/libosgdb_osgAudio.a)
RASPBERRY_dk_libDebug(${OSGAUDIO}/${OS}/${DEBUG_DIR}/lib/libosgdb_osgAudiod.a)
RASPBERRY_dk_libRelease(${OSGAUDIO}/${OS}/${RELEASE_DIR}/lib/libosgdb_osgAudio.a)
ANDROID_dk_libDebug(${OSGAUDIO}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libosgdb_osgAudio.a)
ANDROID_dk_libRelease(${OSGAUDIO}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libosgdb_osgAudio.a)


### GENERATE ###
dk_setPath(${OSGAUDIO}/${BUILD_DIR})

WIN_dk_queueCommand(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=/DOSG_LIBRARY_STATIC /DAL_LIBTYPE_STATIC /I${OPENAL}/include" "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} ${FREEALUT_CMAKE} -D0_BUILD_EXAMPLES_OALPP=OFF -D0_BUILD_EXAMPLES_OSGAUDIO=OFF -D0_BUILD_EXAMPLES_OSGAUDIO_LOWLEVEL=OFF -D0_ENABLE_SUBSYSTEM_OPENAL=ON -D0_ENABLE_SUBSYSTEM_FMOD=OFF -DFMOD_INCLUDE_DIR=OFF -DFMOD_LIBRARY=OFF -DOSGAUDIO_INSTALL_DATA=OFF ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${OSGAUDIO})

APPLE_dk_queueCommand(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=-I${OPENAL}/include -I${FREEALUT}/include" "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} -DALUT_INCLUDE_DIR=${OSG}/include -DALUT_LIBRARY=${FREEALUT}/${OS}/${RELEASE_DIR}/libalut_static.a -DALUT_LIBRARY_DEBUG=${FREEALUT}/${OS}/${DEBUG_DIR}/libalut_static.a -D0_BUILD_EXAMPLES_OALPP=OFF -D0_BUILD_EXAMPLES_OSGAUDIO=OFF -D0_BUILD_EXAMPLES_OSGAUDIO_LOWLEVEL=OFF -D0_ENABLE_SUBSYSTEM_OPENAL=ON -D0_ENABLE_SUBSYSTEM_FMOD=OFF -DFMOD_INCLUDE_DIR=OFF -DFMOD_LIBRARY=OFF -DOSGAUDIO_INSTALL_DATA=OFF ${OPENAL} ${OGG_CMAKE} ${VORBIS_CMAKE} ${OSGAUDIO})

LINUX_DEBUG_dk_queueCommand(${DKCMAKE_BUILD} -DCMAKE_C_FLAGS=-fPIC "-DCMAKE_CXX_FLAGS=-I${OPENAL}/include -I${FREEALUT}/include" "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS}/${DEBUG_DIR} -DOSGSourceRoot=${OSG} -DALUT_INCLUDE_DIR=${OSG}/include -DALUT_LIBRARY=${FREEALUT}/${OS}/${DEBUG_DIR}/libalut_static.a -DALUT_LIBRARY_DEBUG=${FREEALUT}/${OS}/${DEBUG_DIR}/libalut_static.a -D0_BUILD_EXAMPLES_OALPP=OFF -D0_BUILD_EXAMPLES_OSGAUDIO=OFF -D0_BUILD_EXAMPLES_OSGAUDIO_LOWLEVEL=OFF -D0_ENABLE_SUBSYSTEM_OPENAL=ON -D0_ENABLE_SUBSYSTEM_FMOD=OFF -DFMOD_INCLUDE_DIR=OFF -DFMOD_LIBRARY=OFF -DOSGAUDIO_INSTALL_DATA=OFF ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${OSGAUDIO})

LINUX_RELEASE_dk_queueCommand(${DKCMAKE_BUILD} -DCMAKE_C_FLAGS=-fPIC "-DCMAKE_CXX_FLAGS=-I${OPENAL}/include -I${FREEALUT}/include" "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS}/${RELEASE_DIR} -DOSGSourceRoot=${OSG} -DALUT_INCLUDE_DIR=${OSG}/include -DALUT_LIBRARY=${FREEALUT}/${OS}/${RELEASE_DIR}/libalut_static.a -DALUT_LIBRARY_DEBUG=${FREEALUT}/${OS}/${DEBUG_DIR}/libalut_static.a -D0_BUILD_EXAMPLES_OALPP=OFF -D0_BUILD_EXAMPLES_OSGAUDIO=OFF -D0_BUILD_EXAMPLES_OSGAUDIO_LOWLEVEL=OFF -D0_ENABLE_SUBSYSTEM_OPENAL=ON -D0_ENABLE_SUBSYSTEM_FMOD=OFF -DFMOD_INCLUDE_DIR=OFF -DFMOD_LIBRARY=OFF -DOSGAUDIO_INSTALL_DATA=OFF ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${OSGAUDIO})

RASPBERRY_DEBUG_dk_queueCommand(${DKCMAKE_BUILD} -DCMAKE_C_FLAGS=-fPIC "-DCMAKE_CXX_FLAGS=-I${OPENAL}/include -I${FREEALUT}/include" "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS}/${DEBUG_DIR} -DOSGSourceRoot=${OSG} -DALUT_INCLUDE_DIR=${OSG}/include -DALUT_LIBRARY=${FREEALUT}/${OS}/${DEBUG_DIR}/libalut_static.a -DALUT_LIBRARY_DEBUG=${FREEALUT}/${OS}/${DEBUG_DIR}/libalut_static.a -D0_BUILD_EXAMPLES_OALPP=OFF -D0_BUILD_EXAMPLES_OSGAUDIO=OFF -D0_BUILD_EXAMPLES_OSGAUDIO_LOWLEVEL=OFF -D0_ENABLE_SUBSYSTEM_OPENAL=ON -D0_ENABLE_SUBSYSTEM_FMOD=OFF -DFMOD_INCLUDE_DIR=OFF -DFMOD_LIBRARY=OFF -DOSGAUDIO_INSTALL_DATA=OFF ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${OSGAUDIO})

RASPBERRY_RELEASE_dk_queueCommand(${DKCMAKE_BUILD} -DCMAKE_C_FLAGS=-fPIC "-DCMAKE_CXX_FLAGS=-I${OPENAL}/include -I${FREEALUT}/include" "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS}/${RELEASE_DIR} -DOSGSourceRoot=${OSG} -DALUT_INCLUDE_DIR=${OSG}/include -DALUT_LIBRARY=${FREEALUT}/${OS}/${RELEASE_DIR}/libalut_static.a -DALUT_LIBRARY_DEBUG=${FREEALUT}/${OS}/${DEBUG_DIR}/libalut_static.a -D0_BUILD_EXAMPLES_OALPP=OFF -D0_BUILD_EXAMPLES_OSGAUDIO=OFF -D0_BUILD_EXAMPLES_OSGAUDIO_LOWLEVEL=OFF -D0_ENABLE_SUBSYSTEM_OPENAL=ON -D0_ENABLE_SUBSYSTEM_FMOD=OFF -DFMOD_INCLUDE_DIR=OFF -DFMOD_LIBRARY=OFF -DOSGAUDIO_INSTALL_DATA=OFF ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${OSGAUDIO})

ANDROID_dk_queueCommand(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=/DOSG_LIBRARY_STATIC /DAL_LIBTYPE_STATIC /I${OPENAL}/include" "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} ${FREEALUT_CMAKE} -D0_BUILD_EXAMPLES_OALPP=OFF -D0_BUILD_EXAMPLES_OSGAUDIO=OFF -D0_BUILD_EXAMPLES_OSGAUDIO_LOWLEVEL=OFF -D0_ENABLE_SUBSYSTEM_OPENAL=ON -D0_ENABLE_SUBSYSTEM_FMOD=OFF -DFMOD_INCLUDE_DIR=OFF -DFMOD_LIBRARY=OFF -DOSGAUDIO_INSTALL_DATA=OFF ${OPENAL_CMAKE} ${OGG_CMAKE} ${VORBIS_CMAKE} ${OSGAUDIO})


### COMPILE ###
#WIN_dk_visualStudio(osgaudio-master)
dk_visualStudio(osgaudio-master)
#MAC_dk_xcodeDebug(osgaudio-master)
#MAC_dk_xcodeRelease(osgaudio-master)
dk_xcode(osgaudio-master)
#LINUX_DEBUG_dk_queueCommand(make)
#LINUX_RELEASE_dk_queueCommand(make)
LINUX_dk_queueCommand(make)
RASPBERRY_dk_queueCommand(make)
#ANDROID_dk_visualStudio(osgaudio-master)
