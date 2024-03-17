# https://github.com/tesseract-ocr/tesseract
# https://tinsuke.wordpress.com/2011/02/17/how-to-cross-compiling-libraries-for-ios-armv6armv7i386/


### DEPEND ###
dk_depend(curl)
dk_depend(leptonica)
dk_depend(libarchive)
dk_depend(sw)


### IMPORT ###
dk_import(https://github.com/tesseract-ocr/tesseract.git BRANCH main)


### LINK ###
#dk_include				(${TESSERACT})
dk_include				(${TESSERACT}/include)
dk_include				(${TESSERACT}/${OS}/include)
#dk_include				(${TESSERACT}/src/ccutil)
#dk_include				(${TESSERACT}/src/ccstruct)
#dk_include				(${TESSERACT}/src/ccmain)
ANDROID_dk_libDebug		(${TESSERACT}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libtesseract.a)
ANDROID_dk_libRelease	(${TESSERACT}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libtesseract.a)
APPLE_dk_libDebug		(${TESSERACT}/${OS}/${DEBUG_DIR}/libtesseract.a)
APPLE_dk_libRelease		(${TESSERACT}/${OS}/${RELEASE_DIR}/libtesseract.a)
EMSCRIPTEN_dk_libDebug	(${TESSERACT}/${OS}/${DEBUG_DIR}/libtesseract.a)
EMSCRIPTEN_dk_libRelease(${TESSERACT}/${OS}/${RELEASE_DIR}/libtesseract.a)
LINUX_dk_libDebug		(${TESSERACT}/${OS}/${DEBUG_DIR}/libtesseract.a)
LINUX_dk_libRelease		(${TESSERACT}/${OS}/${RELEASE_DIR}/libtesseract.a)
RASPBERRY_dk_libDebug	(${TESSERACT}/${OS}/${DEBUG_DIR}/libtesseract.a)
RASPBERRY_dk_libRelease	(${TESSERACT}/${OS}/${RELEASE_DIR}/libtesseract.a)
WIN_dk_libDebug			(${TESSERACT}/${OS}/${DEBUG_DIR}/tesseract53d.lib)
WIN_dk_libRelease		(${TESSERACT}/${OS}/${RELEASE_DIR}/tesseract53.lib)


### GENERATE ###
ANDROID_dk_configure			(${TESSERACT} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${CURL_CMAKE} ${LEPTONICA_CMAKE} ${LIBARCHIVE_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LEPTONICA}/src -I${LEPTONICA}/${OS}/src")
APPLE_dk_configure				(${TESSERACT} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${CURL_CMAKE} ${LEPTONICA_CMAKE} ${LIBARCHIVE_CMAKE})
EMSCRIPTEN_DEBUG_dk_configure	(${TESSERACT} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${CURL_CMAKE} ${LEPTONICA_CMAKE} ${LIBARCHIVE_CMAKE} "-DCMAKE_CXX_FLAGS=-DGRAPHICS_DISABLED")
EMSCRIPTEN_RELEASE_dk_configure	(${TESSERACT} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${CURL_CMAKE} ${LEPTONICA_CMAKE} ${LIBARCHIVE_CMAKE} "-DCMAKE_CXX_FLAGS=-DGRAPHICS_DISABLED")
LINUX_DEBUG_dk_configure		(${TESSERACT} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${CURL_CMAKE} ${LEPTONICA_CMAKE} ${LIBARCHIVE_CMAKE} "-DCMAKE_CXX_FLAGS=-DGRAPHICS_DISABLED")
LINUX_RELEASE_dk_configure		(${TESSERACT} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${CURL_CMAKE} ${LEPTONICA_CMAKE} ${LIBARCHIVE_CMAKE} "-DCMAKE_CXX_FLAGS=-DGRAPHICS_DISABLED")
RASPBERRY_DEBUG_dk_configure	(${TESSERACT} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${CURL_CMAKE} ${LEPTONICA_CMAKE} ${LIBARCHIVE_CMAKE} "-DCMAKE_CXX_FLAGS=-DGRAPHICS_DISABLED")
RASPBERRY_RELEASE_dk_configure	(${TESSERACT} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${CURL_CMAKE} ${LEPTONICA_CMAKE} ${LIBARCHIVE_CMAKE} "-DCMAKE_CXX_FLAGS=-DGRAPHICS_DISABLED")
WIN_dk_configure				(${TESSERACT} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${CURL_CMAKE} ${LEPTONICA_CMAKE} ${LIBARCHIVE_CMAKE} "-DCMAKE_CXX_FLAGS=/I${LEPTONICA}/src /I${LEPTONICA}/${OS}/src")


### COMPILE ###
dk_build(${TESSERACT} libtesseract)
