#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ libexpat ############
# https://github.com/libexpat/libexpat.git
dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/libexpat/libexpat/archive/b70c8f5.zip)

### LINK ###
dk_include			(${LIBEXPAT}/include				    	LIBEXPAT_INCLUDE_DIR)
dk_include			(${LIBEXPAT}/${target_triple})
if(MSVC)
	dk_libDebug		(${LIBEXPAT_DEBUG_DIR}/libexpatdMT.lib		LIBEXPAT_LIBRARY_DEBUG)
	dk_libRelease	(${LIBEXPAT_RELEASE_DIR}/libexpatdMT.lib	LIBEXPAT_LIBRARY_RELEASE)
else()
	if(WIN)
		dk_libDebug	(${LIBEXPAT_DEBUG_DIR}/libexpatd.a			LIBEXPAT_LIBRARY_DEBUG)
	else()
		dk_libDebug	(${LIBEXPAT_DEBUG_DIR}/libexpat.a			LIBEXPAT_LIBRARY_DEBUG)
	endif()
	dk_libRelease	(${LIBEXPAT_RELEASE_DIR}/libexpat.a			LIBEXPAT_LIBRARY_RELEASE)
endif()

### GENERATE ###
dk_configure(${LIBEXPAT_DIR}/expat
	-DEXPAT_BUILD_TOOLS=ON				# "Build the xmlwf tool for expat library"  ${_EXPAT_BUILD_TOOLS_DEFAULT} 
	-DEXPAT_BUILD_EXAMPLES=ON       	# "Build the examples for expat library" ON
	-DEXPAT_BUILD_TESTS=ON          	# "Build the tests for expat library" ON
	-DEXPAT_SHARED_LIBS=OFF           	# "Build a shared expat library" ${_EXPAT_SHARED_LIBS_DEFAULT} 
	-DEXPAT_BUILD_DOCS=OFF            	# "Build man page for xmlwf" ${_EXPAT_BUILD_DOCS_DEFAULT}  
	-DEXPAT_BUILD_FUZZERS=OFF         	# "Build fuzzers for the expat library" OFF
	-DEXPAT_BUILD_PKGCONFIG=ON       	# "Build pkg-config file" ${_EXPAT_BUILD_PKGCONFIG_DEFAULT}  
	-DEXPAT_OSSFUZZ_BUILDOFF=OFF      	# "Build fuzzers via ossfuzz for the expat library" OFF
	-DEXPAT_WITH_LIBBSD=OFF           	# "Utilize libbsd (for arc4random_buf)" OFF
	-DEXPAT_ENABLE_INSTALL=ON        	# "Install expat files in cmake install target" ON
	-DEXPAT_CONTEXT_BYTES=1024         	# "Define to specify how much context to retain around the current parse point, 0 to disable" 1024 
	-DEXPAT_DTD=ON                 		# "Define to make parameter entity parsing functionality available" ON
	-DEXPAT_GE=ON                 		# "Define to make general entity parsing functionality available" ON
	-DEXPAT_NS=ON                 		# "Define to make XML Namespaces functionality available" ON
	-DEXPAT_WARNINGS_AS_ERRORS=OFF    	# "Treat all compiler warnings as errors" OFF
	-DEXPAT_DEV_URANDOM=ON           	# "Define to include code reading entropy from `/dev/urandom'." ON
	-DEXPAT_WITH_GETRANDOM="AUTO"       # "Make use of getrandom function (ON|OFF|AUTO) [default=AUTO]" "AUTO" 
	-DEXPAT_WITH_SYS_GETRANDOM="AUTO"	# "Make use of syscall SYS_getrandom (ON|OFF|AUTO) [default=AUTO]" "AUTO" 
	-DEXPAT_CHAR_TYPE=char            # "Character type to use (char|ushort|wchar_t) [default=char]" "char"
	-DEXPAT_ATTR_INFO=OFF             	# "Define to allow retrieving the byte offsets for attribute names and values" OFF
	-DEXPAT_LARGE_SIZE=OFF            	# "Make XML_GetCurrent* functions return <(unsigned) long long> rather than <(unsigned) long>" OFF
	-DEXPAT_MIN_SIZE=OFF            	# "Get a smaller (but slower) parser (in particular avoid multiple copies of the tokenizer)" OFF
	-DEXPAT_MSVC_STATIC_CRT=ON      	# "Use /MT flag (static CRT) when compiling in MSVC" OFF
	-D_EXPAT_M32=OFF)                	# "(Unofficial!) Produce 32bit code with -m32" OFF



### COMPILE ###
dk_build(${LIBEXPAT})
