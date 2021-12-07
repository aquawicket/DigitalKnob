SET(LIB_NAME osgAudio)
SET(HEADER_PATH "${osgAudio_SOURCE_DIR}/include/${LIB_NAME}")
SET(OSGAUDIO_USER_DEFINED_DYNAMIC_OR_STATIC STATIC)

configure_file( "${HEADER_PATH}/Version.h.in" "${HEADER_PATH}/Version.h" @ONLY)
configure_file( "${HEADER_PATH}/Config.h.in" "${HEADER_PATH}/Config.h" )

IF(0_ENABLE_SUBSYSTEM_FMOD)
  SET(LIB_PUBLIC_HEADERS_SUBSYSTEM
    ${HEADER_PATH}/BackendFMOD/AudioEnvironmentFMOD.h
    ${HEADER_PATH}/BackendFMOD/FileStreamFMOD.h
    ${HEADER_PATH}/BackendFMOD/ListenerFMOD.h
    ${HEADER_PATH}/BackendFMOD/SampleFMOD.h
    ${HEADER_PATH}/BackendFMOD/SourceFMOD.h
    ${HEADER_PATH}/BackendFMOD/StreamFMOD.h
    ${HEADER_PATH}/BackendFMOD/SoundFMOD.h
  )
  SET(LIB_PUBLIC_SOURCES_SUBSYSTEM
    BackendFMOD/AudioEnvironmentFMOD.cpp
    BackendFMOD/FileStreamFMOD.cpp
    BackendFMOD/ListenerFMOD.cpp
    BackendFMOD/SampleFMOD.cpp
    BackendFMOD/SourceFMOD.cpp
    BackendFMOD/StreamFMOD.cpp
  )
ENDIF(0_ENABLE_SUBSYSTEM_FMOD)

IF(0_ENABLE_SUBSYSTEM_OPENAL)
  SET(LIB_PUBLIC_HEADERS_SUBSYSTEM
    ${HEADER_PATH}/BackendOpenALpp/AudioEnvironmentOpenALpp.h
    ${HEADER_PATH}/BackendOpenALpp/FileStreamOpenALpp.h
    ${HEADER_PATH}/BackendOpenALpp/ListenerOpenALpp.h
    ${HEADER_PATH}/BackendOpenALpp/SampleOpenALpp.h
    ${HEADER_PATH}/BackendOpenALpp/SourceOpenALpp.h
    ${HEADER_PATH}/BackendOpenALpp/StreamOpenALpp.h
  )
  SET(LIB_PUBLIC_SOURCES_SUBSYSTEM
    BackendOpenALpp/AudioEnvironmentOpenALpp.cpp
    BackendOpenALpp/FileStreamOpenALpp.cpp
    BackendOpenALpp/ListenerOpenALpp.cpp
    BackendOpenALpp/SampleOpenALpp.cpp
    BackendOpenALpp/SourceOpenALpp.cpp
    BackendOpenALpp/StreamOpenALpp.cpp
  )
ENDIF(0_ENABLE_SUBSYSTEM_OPENAL)


SET(LIB_PUBLIC_HEADERS
    ${HEADER_PATH}/AudioEnvironment.h
    ${HEADER_PATH}/Config.h
    ${HEADER_PATH}/Error.h
    ${HEADER_PATH}/Export.h
    ${HEADER_PATH}/FileStream.h
    ${HEADER_PATH}/Listener.h
    ${HEADER_PATH}/OccludeCallback.h
    ${HEADER_PATH}/Sample.h
    ${HEADER_PATH}/SoundDefaults.h
    ${HEADER_PATH}/SoundManager.h
    ${HEADER_PATH}/SoundNode.h
    ${HEADER_PATH}/SoundUpdateCB.h
    ${HEADER_PATH}/SoundRoot.h
    ${HEADER_PATH}/SoundState.h
    ${HEADER_PATH}/Source.h
    ${HEADER_PATH}/SourceBase.h
    ${HEADER_PATH}/Stream.h
    ${HEADER_PATH}/Version.h
)

ADD_LIBRARY(
    ${LIB_NAME}
    ${OSGAUDIO_USER_DEFINED_DYNAMIC_OR_STATIC}
    ${LIB_PUBLIC_HEADERS}
    ${LIB_PUBLIC_HEADERS_SUBSYSTEM}
    ${LIB_PUBLIC_SOURCES_SUBSYSTEM}
    Error.cpp
    FileStream.cpp
    Listener.cpp
    OccludeCallback.cpp
    Sample.cpp
    SoundDefaults.cpp
    SoundManager.cpp
    SoundNode.cpp
    SoundUpdateCB.cpp
    SoundRoot.cpp
    SoundState.cpp
    Source.cpp
    Stream.cpp
    Version.cpp
)

add_definitions( 
  -DOSGAUDIO_LIBRARY
)

INCLUDE_WITH_VARIABLES( ${LIB_NAME} ${SUBSYSTEM_INCLUDES} )
INCLUDE_DIRECTORIES( ${OSG_INCLUDE_DIRS} )
LINK_WITH_VARIABLES( ${LIB_NAME} ${SUBSYSTEM_LINKS} )
TARGET_LINK_LIBRARIES( ${LIB_NAME} ${OSG_LIBRARIES} )
TARGET_LINK_LIBRARIES( ${LIB_NAME} ${SUBSYSTEM_TARGET_LINKS} )
    
INCLUDE(ModuleInstall OPTIONAL)
