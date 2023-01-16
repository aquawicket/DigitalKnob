# https://github.com/tesseract-ocr/tesseract
# https://tinsuke.wordpress.com/2011/02/17/how-to-cross-compiling-libraries-for-ios-armv6armv7i386/


### DEPEND ###
dk_depend(sw)
dk_depend(leptonica)


### IMPORT ###
dk_import(https://github.com/tesseract-ocr/tesseract.git BRANCH main)


### LINK ###
#dk_include				(${TESSERACT})
dk_include				(${TESSERACT}/include)
dk_include				(${TESSERACT}/${OS}/include)
#dk_include				(${TESSERACT}/src/ccutil)
#dk_include				(${TESSERACT}/src/ccstruct)
#dk_include				(${TESSERACT}/src/ccmain)
WIN_dk_libDebug			(${TESSERACT}/${OS}/${DEBUG_DIR}/tesseract52d.lib)
WIN_dk_libRelease		(${TESSERACT}/${OS}/${RELEASE_DIR}/tesseract52.lib)
APPLE_dk_libDebug		(${TESSERACT}/${OS}/${DEBUG_DIR}/libtesseract.a)
APPLE_dk_libRelease		(${TESSERACT}/${OS}/${RELEASE_DIR}/libtesseract.a)
LINUX_dk_libDebug		(${TESSERACT}/${OS}/${DEBUG_DIR}/libtesseract.a)
LINUX_dk_libRelease		(${TESSERACT}/${OS}/${RELEASE_DIR}/libtesseract.a)
ANDROID_dk_libDebug		(${TESSERACT}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libtesseract.a)
ANDROID_dk_libRelease	(${TESSERACT}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libtesseract.a)


### GENERATE ###
WIN_dk_queueCommand				(${DKCMAKE_BUILD} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${LEPTONICA_CMAKE} "-DCMAKE_CXX_FLAGS=/I${LEPTONICA}/src /I${LEPTONICA}/${OS}/src" ${TESSERACT})
MAC_dk_queueCommand				(${DKCMAKE_BUILD} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${LEPTONICA_CMAKE} ${TESSERACT})
IOS_dk_queueCommand				(${DKCMAKE_BUILD} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${LEPTONICA_CMAKE} ${TESSERACT})
IOSSIM_dk_queueCommand			(${DKCMAKE_BUILD} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${LEPTONICA_CMAKE} ${TESSERACT})
LINUX_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${LEPTONICA_CMAKE} "-DCMAKE_CXX_FLAGS=-DGRAPHICS_DISABLED" ${TESSERACT})
LINUX_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${LEPTONICA_CMAKE} "-DCMAKE_CXX_FLAGS=-DGRAPHICS_DISABLED" ${TESSERACT})


### COMPILE ###
WIN_dk_visualStudio	(${TESSERACT} libtesseract)	# windows
dk_xcode			(${TESSERACT} libtesseract)	# mac, ios, iossim
dk_make				(${TESSERACT} libtesseract)	#linux, raspberry
ANDROID_dk_ndk		(${TESSERACT})				# android
