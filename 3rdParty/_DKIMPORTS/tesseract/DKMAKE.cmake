# https://github.com/tesseract-ocr/tessdoc
# README: https://tinsuke.wordpress.com/2011/02/17/how-to-cross-compiling-libraries-for-ios-armv6armv7i386/


dk_depend(leptonica)

dk_import(https://github.com/tesseract-ocr/tessdoc.git)

#dk_set(TESSERACT_VERSION master)
#dk_set(TESSERACT_NAME tesseract-${TESSERACT_VERSION})
#dk_set(TESSERACT_DL https://github.com/tesseract-ocr/tessdoc/archive/refs/heads/master.zip)
#dk_set(TESSERACT ${3RDPARTY}/${TESSERACT_NAME})
#dk_install(${TESSERACT_DL} tesseract ${TESSERACT})


### LINK ###
dk_include(${TESSERACT})
dk_include(${TESSERACT}/ccutil)
dk_include(${TESSERACT}/ccstruct)
dk_include(${TESSERACT}/ccmain)
WIN_dk_libDebug(${TESSERACT}/${OS}/${DEBUG_DIR}/tesseract305d.lib)
WIN_dk_libRelease(${TESSERACT}/${OS}/${RELEASE_DIR}/tesseract305.lib)
APPLE_dk_libDebug(${TESSERACT}/${OS}/${DEBUG_DIR}/liblibtesseract.a)
APPLE_dk_libRelease(${TESSERACT}/${OS}/${RELEASE_DIR}/liblibtesseract.a)
LINUX_dk_libDebug(${TESSERACT}/${OS}/${DEBUG_DIR}/liblibtesseract.a)
LINUX_dk_libRelease(${TESSERACT}/${OS}/${RELEASE_DIR}/liblibtesseract.a)
ANDROID_dk_libDebug(${TESSERACT}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libtesseract.a)
ANDROID_dk_libRelease(${TESSERACT}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libtesseract.a)


### COMPILE ###
dk_setPath(${TESSERACT}/${BUILD_DIR})

#WIN_dk_setPath(${TESSERACT}/${OS})
WIN32_dk_queueCommand(${DKCMAKE_BUILD} -DSTATIC=ON -DBUILD_TRAINING_TOOLS=OFF ${LEPTONICA_WIN} ${TESSERACT})
WIN64_dk_queueCommand(${DKCMAKE_BUILD} -DSTATIC=ON -DBUILD_TRAINING_TOOLS=OFF ${LEPTONICA_WIN} ${TESSERACT})
WIN_dk_visualStudio(${TESSERACT_NAME} tesseract.sln libtesseract)


#MAC_dk_setPath(${TESSERACT}/${OS})
MAC64_dk_queueCommand(${DKCMAKE_BUILD} -DSTATIC=ON -DBUILD_TRAINING_TOOLS=OFF -DLeptonica_DIR=${LEPTONICA}/${OS} ${TESSERACT})
MAC_dk_xcode(${TESSERACT_NAME} libtesseract)

#IOS_dk_setPath(${TESSERACT}/${OS})
IOS64_dk_queueCommand(${DKCMAKE_BUILD} -DSTATIC=ON -DBUILD_TRAINING_TOOLS=OFF -DLeptonica_DIR=${LEPTONICA}/${OS} ${TESSERACT})
IOS_dk_xcode(${TESSERACT_NAME} libtesseract)

#IOSSIM_dk_setPath(${TESSERACT}/${OS})
IOSSIM64_dk_queueCommand(${DKCMAKE_BUILD} -DSTATIC=ON -DBUILD_TRAINING_TOOLS=OFF -DLeptonica_DIR=${LEPTONICA}/${OS} ${TESSERACT})
IOSSIM_dk_xcode(${TESSERACT_NAME} libtesseract)

#LINUX_DEBUG_dk_setPath(${TESSERACT}/${OS}/Debug)
LINUX_DEBUG_dk_queueCommand(${DKCMAKE_BUILD} -DSTATIC=ON "-DCMAKE_CXX_FLAGS=-DGRAPHICS_DISABLED" -DBUILD_TRAINING_TOOLS=OFF -DLeptonica_DIR=${LEPTONICA}/${OS}/${RELEASE_DIR} ${TESSERACT})
LINUX_DEBUG_dk_queueCommand(make libtesseract)

#LINUX_RELEASE_dk_setPath(${TESSERACT}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_dk_queueCommand(${DKCMAKE_BUILD} -DSTATIC=ON "-DCMAKE_CXX_FLAGS=-DGRAPHICS_DISABLED" -DBUILD_TRAINING_TOOLS=OFF -DLeptonica_DIR=${LEPTONICA}/${OS}/${RELEASE_DIR} ${TESSERACT})
LINUX_RELEASE_dk_queueCommand(make libtesseract)

ANDROID_dk_ndk(${TESSERACT_NAME})