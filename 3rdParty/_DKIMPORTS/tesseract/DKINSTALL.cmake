#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ tesseract ############
# https://github.com/tesseract-ocr/tesseract
# https://tinsuke.wordpress.com/2011/02/17/how-to-cross-compiling-libraries-for-ios-armv6armv7i386
# https://github.com/tesseract-ocr/tesseract/archive/refs/heads/main.zip)

# dk_validate(Target_Config  "dk_Target_Config()")

dk_depend(curl)
dk_depend(leptonica)
dk_depend(libarchive)
dk_depend(sw)

dk_import()

#dk_include				(${tesseract})
dk_include				(${tesseract}/include)
dk_include				(${tesseract}/${Target_Tuple}/include)
#dk_include				(${tesseract}/src/ccutil)
#dk_include				(${tesseract}/src/ccstruct)
#dk_include				(${tesseract}/src/ccmain)
Android_dk_libDebug		(${tesseract_Debug_Dir}/obj/local/armeabi-v7a/libtesseract.a)
Android_dk_libRelease	(${tesseract_Release_Dir}/obj/local/armeabi-v7a/libtesseract.a)
Apple_dk_libDebug		(${tesseract_Debug_Dir}/libtesseract.a)
Apple_dk_libRelease		(${tesseract_Release_Dir}/libtesseract.a)
Emscripten_dk_libDebug	(${tesseract_Debug_Dir}/libtesseract.a)
Emscripten_dk_libRelease(${tesseract_Release_Dir}/libtesseract.a)
Linux_dk_libDebug		(${tesseract_Debug_Dir}/libtesseract.a)
Linux_dk_libRelease		(${tesseract_Release_Dir}/libtesseract.a)
Raspberry_dk_libDebug	(${tesseract_Debug_Dir}/libtesseract.a)
Raspberry_dk_libRelease	(${tesseract_Release_Dir}/libtesseract.a)
Windows_dk_libDebug		(${tesseract_Debug_Dir}/tesseract53d.lib)
Windows_dk_libRelease	(${tesseract_Release_Dir}/tesseract53.lib)

Android_dk_configure			(${tesseract} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${CURL_CMAKE} ${LEPTONICA_CMAKE} ${LIBARCHIVE_CMAKE} "-DCMAKE_CXX_FLAGS=-I${LEPTONICA}/src -I${LEPTONICA}/${Target_Tuple}/src")
Apple_dk_configure				(${tesseract} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${CURL_CMAKE} ${LEPTONICA_CMAKE} ${LIBARCHIVE_CMAKE})
Emscripten_Debug_dk_configure	(${tesseract} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${CURL_CMAKE} ${LEPTONICA_CMAKE} ${LIBARCHIVE_CMAKE} "-DCMAKE_CXX_FLAGS=-DGRAPHICS_DISABLED")
Emscripten_Release_dk_configure	(${tesseract} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${CURL_CMAKE} ${LEPTONICA_CMAKE} ${LIBARCHIVE_CMAKE} "-DCMAKE_CXX_FLAGS=-DGRAPHICS_DISABLED")
Linux_Debug_dk_configure		(${tesseract} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${CURL_CMAKE} ${LEPTONICA_CMAKE} ${LIBARCHIVE_CMAKE} "-DCMAKE_CXX_FLAGS=-DGRAPHICS_DISABLED")
Linux_Release_dk_configure		(${tesseract} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${CURL_CMAKE} ${LEPTONICA_CMAKE} ${LIBARCHIVE_CMAKE} "-DCMAKE_CXX_FLAGS=-DGRAPHICS_DISABLED")
Raspberry_Debug_dk_configure	(${tesseract} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${CURL_CMAKE} ${LEPTONICA_CMAKE} ${LIBARCHIVE_CMAKE} "-DCMAKE_CXX_FLAGS=-DGRAPHICS_DISABLED")
Raspberry_Release_dk_configure	(${tesseract} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${CURL_CMAKE} ${LEPTONICA_CMAKE} ${LIBARCHIVE_CMAKE} "-DCMAKE_CXX_FLAGS=-DGRAPHICS_DISABLED")
Windows_dk_configure			(${tesseract} -DSTATIC=ON -DSW_BUILD=OFF -DBUILD_TRAINING_TOOLS=OFF ${CURL_CMAKE} ${LEPTONICA_CMAKE} ${LIBARCHIVE_CMAKE} "-DCMAKE_CXX_FLAGS=/I${LEPTONICA}/src /I${LEPTONICA}/${Target_Tuple}/src")

dk_build(${tesseract} libtesseract)
