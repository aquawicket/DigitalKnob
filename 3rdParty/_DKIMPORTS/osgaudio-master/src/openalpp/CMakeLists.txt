SET(LIB_NAME openalpp)
SET(HEADER_PATH "${osgAudio_SOURCE_DIR}/include/${LIB_NAME}")
SET(OSGAUDIO_USER_DEFINED_DYNAMIC_OR_STATIC STATIC)

SET(LIB_PUBLIC_HEADERS
    ${HEADER_PATH}/AudioBase.h
    ${HEADER_PATH}/AudioConvert.h
    ${HEADER_PATH}/AudioEnvironment.h
    ${HEADER_PATH}/Capture.h
    ${HEADER_PATH}/config.h
    ${HEADER_PATH}/DeviceUpdater.h
    ${HEADER_PATH}/Error.h
    ${HEADER_PATH}/Export.h
    ${HEADER_PATH}/FileStream.h
    ${HEADER_PATH}/FileStreamUpdater.h
    ${HEADER_PATH}/GroupSource.h
    ${HEADER_PATH}/Listener.h
    ${HEADER_PATH}/NetStream.h
    ${HEADER_PATH}/NetUpdater.h
    ${HEADER_PATH}/PositionedObject.h
    ${HEADER_PATH}/Sample.h
    ${HEADER_PATH}/SoundData.h
    ${HEADER_PATH}/Source.h
    ${HEADER_PATH}/SourceBase.h
    ${HEADER_PATH}/Stream.h
    ${HEADER_PATH}/StreamUpdater.h
    ${HEADER_PATH}/windowsstuff.h
)

ADD_LIBRARY(
    ${LIB_NAME}
    ${OSGAUDIO_USER_DEFINED_DYNAMIC_OR_STATIC}
    ${LIB_PUBLIC_HEADERS}
    AudioBase.cpp
    AudioConvert.cpp
    AudioEnvironment.cpp
    Capture.cpp
    DeviceUpdater.cpp
    Error.cpp
    FileStream.cpp
    FileStreamUpdater.cpp
    GroupSource.cpp
    Listener.cpp
    NetStream.cpp
    NetUpdater.cpp
    Openalpp.cpp
    Sample.cpp
    SoundData.cpp
    Source.cpp
    SourceBase.cpp
    Stream.cpp
    StreamUpdater.cpp
)

add_definitions( 
    -DOPENALPP_EXPORTS
)
INCLUDE_DIRECTORIES( ${OSG_INCLUDE_DIRS} )

LINK_WITH_VARIABLES( ${LIB_NAME} ${SUBSYSTEM_OPENAL_LINKS} )
TARGET_LINK_LIBRARIES( ${LIB_NAME} ${OSG_LIBRARIES} )
    
INCLUDE(ModuleInstall OPTIONAL)
