# https://github.com/tesseract-ocr
# https://tinsuke.wordpress.com/2011/02/17/how-to-cross-compiling-libraries-for-ios-armv6armv7i386/


dk_depend(leptonica)


#dk_import(https://github.com/tesseract-ocr/tessdoc.git)
dk_import(https://github.com/tesseract-ocr/tesseract.git)


### LINK ###
dk_include				(${TESSERACT})
dk_include				(${TESSERACT}/ccutil)
dk_include				(${TESSERACT}/ccstruct)
dk_include				(${TESSERACT}/ccmain)
WIN_dk_libDebug			(${TESSERACT}/${OS}/${DEBUG_DIR}/tesseract305d.lib)
WIN_dk_libRelease		(${TESSERACT}/${OS}/${RELEASE_DIR}/tesseract305.lib)
APPLE_dk_libDebug		(${TESSERACT}/${OS}/${DEBUG_DIR}/liblibtesseract.a)
APPLE_dk_libRelease		(${TESSERACT}/${OS}/${RELEASE_DIR}/liblibtesseract.a)
LINUX_dk_libDebug		(${TESSERACT}/${OS}/${DEBUG_DIR}/liblibtesseract.a)
LINUX_dk_libRelease		(${TESSERACT}/${OS}/${RELEASE_DIR}/liblibtesseract.a)
ANDROID_dk_libDebug		(${TESSERACT}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libtesseract.a)
ANDROID_dk_libRelease	(${TESSERACT}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libtesseract.a)


### GENERATE ###
dk_setPath						(${TESSERACT}/${BUILD_DIR})
WIN32_dk_queueCommand			(${DKCMAKE_BUILD} -DSTATIC=ON -DBUILD_TRAINING_TOOLS=OFF ${LEPTONICA_WIN} ${TESSERACT})
WIN64_dk_queueCommand			(${DKCMAKE_BUILD} -DSTATIC=ON -DBUILD_TRAINING_TOOLS=OFF ${LEPTONICA_WIN} ${TESSERACT})
MAC64_dk_queueCommand			(${DKCMAKE_BUILD} -DSTATIC=ON -DBUILD_TRAINING_TOOLS=OFF -DLeptonica_DIR=${LEPTONICA}/${OS} ${TESSERACT})
IOS64_dk_queueCommand			(${DKCMAKE_BUILD} -DSTATIC=ON -DBUILD_TRAINING_TOOLS=OFF -DLeptonica_DIR=${LEPTONICA}/${OS} ${TESSERACT})
IOSSIM64_dk_queueCommand		(${DKCMAKE_BUILD} -DSTATIC=ON -DBUILD_TRAINING_TOOLS=OFF -DLeptonica_DIR=${LEPTONICA}/${OS} ${TESSERACT})
LINUX_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DSTATIC=ON -DBUILD_TRAINING_TOOLS=OFF -DLeptonica_DIR=${LEPTONICA}/${OS}/${RELEASE_DIR} "-DCMAKE_CXX_FLAGS=-DGRAPHICS_DISABLED" ${TESSERACT})
LINUX_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DSTATIC=ON -DBUILD_TRAINING_TOOLS=OFF -DLeptonica_DIR=${LEPTONICA}/${OS}/${RELEASE_DIR} "-DCMAKE_CXX_FLAGS=-DGRAPHICS_DISABLED" ${TESSERACT})


### COMPILE ###
WIN_dk_visualStudio				(${TESSERACT_NAME} libtesseract)
dk_xcode						(${TESSERACT_NAME} libtesseract)
LINUX_dk_queueCommand			(make libtesseract)
RASPBERRY_dk_queueCommand		(make libtesseract)
ANDROID_dk_ndk					(${TESSERACT_NAME})
