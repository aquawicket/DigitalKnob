/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2025 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

// https://clang.llvm.org/docs/LanguageExtensions.html
// https://sourceforge.net/p/predef/wiki/Home/
// https://github.com/nemequ/pre-defined-macros
// https://stackoverflow.com/a/3672331/688352
// https://learn.microsoft.com/en-us/cpp/preprocessor/pragma-directives-and-the-pragma-keyword?view=msvc-170
// https://stackoverflow.com/questions/471935/user-warnings-on-msvc-and-gcc
// https://stackoverflow.com/questions/171435/portability-of-warning-preprocessor-directive
#pragma once
#ifndef dk_preprocessor_hpp
#define dk_preprocessor_hpp

#include <stdio.h>


// https://developercommunity.visualstudio.com/t/error-c2872-byte-ambiguous-symbol/93889
// Fix for DKVncServer
#if HAVE_DKVncServer
	//#ifndef _HAS_STD_BYTE  //TESTME
		#define _HAS_STD_BYTE 0
	//#endif
#endif

#define XSTR(tok) #tok
#define STR(x) XSTR(x)

// https://stackoverflow.com/a/59157875/688352
//#define STRS(str1,str2) str1 ## str2
//#define JOIN_TWO(_1, _2) STR(_1._2)
//#define JOIN_THREE(_1, _2, _3) STR(_1._2._3)



/////////////////////////////////////////////
// DKPRAGMA(<args>)
//   alias for _Pragma and #pragma
//
#if defined(__GNUC__) || defined(__clang__) && !defined(DKPRAGMA)
	#define DKPRAGMA(x) _Pragma(#x)
#endif


/////////////////////////////////////////////
// DKMESSAGE(<string>)
//    pass a message string to the compiler
//
#if defined(_MSC_VER)
    #define DKMESSAGE(x) __pragma(message(STR(x)))
#elif defined(__GNUC__) || defined(__GNUG__) || defined(__clang__)
	#define DKMESSAGE(x) DKPRAGMA(message #x)
#else
	#define DKMESSAGE(X)
#endif
//KMESSAGE(test DKMESSAGE)


//////////////////////////////////////////////
// DKWARNING(string)
//    pass a warning string to the compiler
//
#if defined(_MSC_VER)
    #define DKWARNING(x) __pragma(warning(STR(x)))
#elif defined(__GNUC__) || defined(__clang__)
	#define DKWARNING(x) DKPRAGMA(GCC warning #x)
#else
	#define DKWARNING(X)
#endif
//DKWARNING(test DKWARNING)


////////////////////////////////////////////////
// DKERROR(string)
//     pass a error string to the compiler   NOTE: use #error instead 
//
#if defined(_MSC_VER)
    #define DKERR(x) static_assert(false, STR(x));
#elif defined(__GNUC__) || defined(__clang__)
	#define DKERROR(x) DKPRAGMA(GCC error #x)
#else
	#define DKERROR(X)
#endif
//DKERROR(test DKERROR)



//#define TOSTRING(x) STR(x)
#define PRNT_NAME(x) printf("%s", #x)
#define PRNT_NAME_VALUE(x) printf("%s=%s", #x, STR(x))
#define PRNT_VALUE(x) printf(%s, STR(x))




#define DKDATE 						__DATE__
#define DKTIME 						__TIME__

#if __x86_64__ || _M_X64
#	define DKARCH 					STR(x86_64)
#	define DKBITS 					64
#elif __i386 || _M_IX86
#	define DKARCH 					STR(x86_32)
#	define DKBITS 					32
#elif __aarch64__
#	define DKARCH 					STR(ARM64)
#	define DKBITS 					64
#elif __arm__
#	define DKARCH 					STR(ARM32)
#	define DKBITS 					32
#else
#	define DKARCH 					STR(UNKNOWN)
#	define DKBITS 					STR(UNKNOWN)
#endif

// https://web.archive.org/web/20191012035921/http://nadeausoftware.com/articles/2012/01/c_c_tip_how_use_compiler_predefined_macros_detect_operating_system
#if _WIN32
#	ifndef DESKTOP
#		define DESKTOP 				1
#	endif
#	ifndef WIN
#		define WIN 					1
#	endif
#   ifndef WIN_X86
#		define WIN_X86 				1
#	endif
#	if DKBITS == 32
#		define DKOS 				STR(WIN_X86)
#		define DKOS_VERSION 		STR(UNKNOWN)
#	endif
#	if DKBITS == 64
#		ifndef WIN_X86_64
#			define WIN_X86_64 		1
#		endif
#		define DKOS 				STR(WIN_X86_64)
#		define DKOS_VERSION 		STR(UNKNOWN)
#	endif
#elif __APPLE__ && __MACH__
#   ifndef APPLE
#		define APPLE 				1
#	endif
#	include <TargetConditionals.h>
#	if TARGET_IPHONE_SIMULATOR == 1
#		ifndef MOBILE
#			define MOBILE 			1
#		endif
#		ifndef IOS
#			define IOS 				1
#		endif
#		if DKBITS == 64
#			ifndef IOS_ARM64
#				define IOS_ARM64 	1
#			endif
#			ifndef IOSSIM_X86_64
#				define IOSSIM_X86_64 1
#			endif
#			define DKOS 			STR(IOSSIM_X86_64)
#			define DKOS_VERSION 	STR(UNKNOWN)
#		endif
#		if DKBITS == 32
#			ifndef IOS_ARM32
#				define IOS_ARM32 	1
#			endif
#			ifndef IOSSIM_X86
#				define IOSSIM_X86 	1
#			endif
#			define DKOS 			STR(IOSSIM_X86)
#			define DKOS_VERSION 	STR(UNKNOWN)
#		endif
#	elif TARGET_OS_IPHONE == 1
#		ifndef MOBILE
#			define MOBILE 			1
#		endif
#		ifndef IOS
#			define IOS 				1
#		endif
#		if DKBITS == 64
#			ifndef IOS_ARM64
#				define IOS_ARM64 	1
#			endif
#			define DKOS 			STR(IOS_ARM64)
#			define DKOS_VERSION 	STR(UNKNOWN)
#		endif
#		if DKBITS == 32
#			ifndef IOS_ARM32
#				define IOS_ARM32 	1
#			endif
#			define DKOS 			STR(IOS_ARM32)
#			define DKOS_VERSION 	STR(UNKNOWN)
#		endif
#	elif TARGET_OS_MAC == 1
#		ifndef DESKTOP
#			define DESKTOP 			1
#		endif
#		ifndef MAC
#			define MAC 				1
#		endif
#		if DKBITS == 64
#			ifndef MAC_X86_64
#				define MAC_X86_64 	1
#			endif
#			define DKOS 			STR(MAC_X86_64)
#			define DKOS_VERSION 	STR(UNKNOWN)
#		endif
#		if DKBITS == 32
#			ifndef MAC_X86
#				define MAC_X86 		1
#			endif
#			define DKOS 			STR(MAC_X86)
#			define DKOS_VERSION 	STR(UNKNOWN)
#		endif
#	else
#	endif
#elif __ANDROID__
#	ifndef MOBILE
#		define MOBILE 				1
#	endif
#	ifndef ANDROID
#		define ANDROID 				1
#	endif
#	if DKBITS == 64
#		ifndef ANDROID_ARM64
#			define ANDROID_ARM64 	1
#		endif
#		define DKOS 				STR(ANDROID_ARM64)
#		define DKOS_VERSION 		STR(UNKNOWN) //TOSTRING(__ANDROID_API__)  FIXME: defining from another macro
#	endif
#	if DKBITS == 32
#		ifndef ANDROID_ARM32
#			define ANDROID_ARM32 	1
#		endif
#		define DKOS 				STR(ANDROID_ARM32)
#		define DKOS_VERSION 		STR(UNKNOWN) //TOSTRING(__ANDROID_API__)  FIXME: defining from another macro
#	endif
#elif __linux__
#	ifndef DESKTOP
#		define DESKTOP 				1
#	endif
#	ifndef LINUX
#		define LINUX 				1
#	endif
#	if DKBITS == 64
#		ifndef LINUX_X86_64
#			define LINUX_X86_64 	1
#		endif
#		define DKOS 				STR(LINUX_X86_64)
#		define DKOS_VERSION 		STR(UNKNOWN)
#	endif
#	if DKBITS == 32
#		ifndef LINUX_X86
#			define LINUX_X86 		1
#		endif
#		define DKOS 				STR(LINUX_X86)
#		define DKOS_VERSION 		STR(UNKNOWN)
#	endif
#elif MSDOS
#	define DKOS 					STR(MSDOS)
#	define DKOS_VERSION 			STR(UNKNOWN)
#else
#	define DKOS         			STR(UNKNOWN)
#	define DKOS_VERSION 			STR(UNKNOWN)
#endif

////// DKMAJOR //////
#if defined(__clang_major__)
	#define DKMAJOR 				__clang_major__
#elif defined(__GNUC__)
	#define DKMAJOR 				__GNUC__
#elif defined(__GNUG__)
	#define DKMAJOR 				__GNUG__
#elif defined(__MINGW32_VERSION_MAJOR)
	#define DKMAJOR 				__MINGW32_VERSION_MAJOR
#elif defined(__MINGW64_VERSION_MAJOR)
	#define DKMAJOR 				__MINGW64_VERSION_MAJOR
#else 
	#define DKMAJOR 				UNKNOWN
#endif

////// DKMINOR //////
#if defined(__clang_minor__)
	#define DKMINOR 				__clang_minor__
#elif defined(__GNUC_MINOR__)
	#define DKMINOR 				__GNUC_MINOR__
#elif defined(__GNUG_MINOR__)
	#define DKMINOR 				__GNUG_MINOR__
#elif defined(__MINGW64_VERSION_MINOR)
	#define DKMINOR 				__MINGW64_VERSION_MINOR
#elif defined(__MINGW64_VERSION_MINOR)
	#define DKMINOR 				__MINGW64_VERSION_MINOR
#else 
	#define DKMINOR 				UNKNOWN
#endif

////// DKPATCH //////
#if defined(__clang_patchlevel__)
	#define DKPATCH 				__clang_patchlevel__
#elif defined(__GNUC_PATCHLEVEL__)
	#define DKPATCH 				__GNUC_PATCHLEVEL__
#elif defined(__GNUG_PATCHLEVEL__)
	#define DKPATCH 				__GNUG_PATCHLEVEL__
#elif defined(__MINGW32_VERSION_BUGFIX)
	#define DKPATCH 				__MINGW32_VERSION_BUGFIX
#elif defined(__MINGW64_VERSION_BUGFIX)
	#define DKPATCH 				__MINGW64_VERSION_BUGFIX
#else 
	#define DKPATCH 				UNKNOWN
#endif

////// DKCOMPILER_VERSION //////
#if defined(DKMAJOR) && defined(DKMINOR) && defined(DKPATCH)
	#define DKCOMPILER_VERSION 		STR(DKMAJOR.DKMINOR.DKPATCH)
#elif _MSC_VER
	#define DKCOMPILER_VERSION 		STR(_MSC_FULL_VER)
#else
	#define DKCOMPILER_VERSION 		STR(UNKNOWN)
#endif


////// DKCOMPILER //////
#if __clang__ && __GNUG__
#	define DKCOMPILER 				STR(clang++)
#	define DKCOMPILER_FULL 			STR(clang++ DKMAJOR.DKMINOR.DKPATCH)
#elif __clang__
#	define DKCOMPILER 				STR(clang)
#	define DKCOMPILER_FULL 			STR(clang DKMAJOR.DKMINOR.DKPATCH)
#elif __clang__ && __GNUG__ && __COSMOCC__
#	define DKCOMPILER 				STR(COSMOCC clang++)
#	define DKCOMPILER_FULL 			STR(COSMOCC clang++ DKMAJOR.DKMINOR.DKPATCH)
#elif __clang__ && __COSMOCC__
#	define DKCOMPILER 				STR(COSMOCC clang)
#	define DKCOMPILER_FULL 			STR(COSMOCC clang DKMAJOR.DKMINOR.DKPATCH)
#elif __llvm__
#	define DKCOMPILER 				STR(llvm)
#	define DKCOMPILER_FULL 			STR(llvm DKMAJOR.DKMINOR.DKPATCH)
#elif __MINGW64__
#	define DKCOMPILER 				STR(Mingw64)
#	define DKCOMPILER_FULL 			STR(Mingw64 DKMAJOR.DKMINOR.DKPATCH)
#elif __MINGW32__
#	define DKCOMPILER 				STR(Mingw32)
#	define DKCOMPILER_FULL 			STR(Mingw32 DKMAJOR.DKMINOR.DKPATCH)
#elif _MSC_VER	// https://learn.microsoft.com/en-us/cpp/preprocessor/predefined-macros?view=msvc-170
#	define DKCOMPILER 				STR(Microsoft Visual C++)
#	define DKCOMPILER_FULL 			STR(Microsoft Visual C++ DKMAJOR.DKMINOR.DKPATCH)
#elif __GNUG__ && __COSMOCC__
#	define DKCOMPILER 				STR(COSMOCC GNU G++)
#	define DKCOMPILER_FULL 			STR(COSMOCC GNU G++ DKMAJOR.DKMINOR.DKPATCH)
#elif __GNUC__ && __COSMOCC__
#	define DKCOMPILER 				STR(COSMOCC GNU GCC)
#	define DKCOMPILER_FULL 			STR(COSMOCC GNU GCC DKMAJOR.DKMINOR.DKPATCH)
#elif __GNUG__
#	define DKCOMPILER 				STR(GNU G++)
#	define DKCOMPILER_FULL 			STR(GNU G++ DKMAJOR.DKMINOR.DKPATCH)
#elif __GNUC__
#	define DKCOMPILER 				STR(GNU GCC)
#	define DKCOMPILER_FULL 			STR(GNU GCC DKMAJOR.DKMINOR.DKPATCH)
#else
#	define DKCOMPILER 				STR(UNKNOWN)
#	define DKCOMPILER_FULL 			STR(UNKNOWN)
#endif



////// DKC_LANGUAGE_VERSION //////
#if __STDC_VERSION__ > 201710L
#	define DKC_LANGUAGE_VERSION 	STR(Greater then C18)
#elif __STDC_VERSION__ == 201710L
#	define DKC_LANGUAGE_VERSION 	STR(C18)
#elif __STDC_VERSION__ == 201112L
#	define DKC_LANGUAGE_VERSION 	STR(C11)
#elif __STDC_VERSION__ == 199901L
#	define DKC_LANGUAGE_VERSION 	STR(C99)
#elif __STDC_VERSION__ == 199409L
#	define DKC_LANGUAGE_VERSION 	STR(C94)
#elif __STDC__
#	define DKC_LANGUAGE_VERSION 	STR(C90)
#else
#	define DKC_LANGUAGE_VERSION 	STR(UNKNOWN)
#endif

////// DKCPP_LANGUAGE_VERSION //////
#if __cplusplus > 202110L
#	define DKCPP_LANGUAGE_VERSION 	STR(Grater then C++23)
#elif __cplusplus == 202110L
#	define DKCPP_LANGUAGE_VERSION 	STR(C++23)
#elif __cplusplus == 201902L
#	define DKCPP_LANGUAGE_VERSION 	STR(C++20)
#elif __cplusplus == 201703L
#	define DKCPP_LANGUAGE_VERSION 	STR(C++17)
#elif __cplusplus == 201402L
#	define DKCPP_LANGUAGE_VERSION 	STR(C++14)
#elif __cplusplus == 201103L
#	define DKCPP_LANGUAGE_VERSION 	STR(C++11)
#elif __cplusplus == 199711L
#	define DKCPP_LANGUAGE_VERSION 	STR(C++98)
#elif __cplusplus 
#	define DKCPP_LANGUAGE_VERSIOND 	STR(pre-C++98)
#else
#	define DKCPP_LANGUAGE_VERSION 	STR(UNKNOWN)
#endif

////// DKBUILD_TYPE //////
#if DEBUG
#	define DKBUILD_TYPE 			STR(DEBUG)
#else
#	define DKBUILD_TYPE 			STR(RELEASE)
#endif

// RTTI
#if defined(__clang__)
#	if __has_feature(cxx_rtti)
#		define RTTI_ENABLED 		1
#	endif
#elif defined(__GNUG__)
#	if defined(__GXX_RTTI)
#		define RTTI_ENABLED 		1
#	endif
#elif defined(_MSC_VER) //Visual Studio Compiler
#	if defined(_CPPRTTI)
#		define RTTI_ENABLED 		1
#	endif
#endif


// DK_UNUSED(arg) - supress unreferenced formal parameter warnings for unsed variables
#define DK_UNUSED(arg) (void)arg;



/////////////////////////////////////////////////////////////////////////
#ifndef DKTHROW
#define DKTHROW(x)      												\
    try{																\
		throw x; 														\
	}																	\
	catch(...){															\
		std::cerr << std::endl << x << std::endl;						\
		std::cerr << "Press any Enter to continue . . ." << std::endl;	\
		std::cin.get();													\
	}
#endif


/// ASSERT(condition) checks if the condition is met, and if not, calls
/// ABORT with an error message indicating the module and line where
/// the error occurred.
#ifndef DKASSERT
#define DKASSERT(x)                                                       	\
    if (!(x)) {                                                         	\
        char buf[2048];                                                 	\
        snprintf (buf, 2048, "Assertion (%s) failed in \"%s\", line %d\n",	\
                 #x, __FILE__, __LINE__);                                   \
        DKTHROW (buf);                                                    	\
    }                                                                   	\
    else   // This 'else' exists to catch the user's following semicolon
#endif
/////////////////////////////////////////////////////////////////////////



// https://en.cppreference.com/w/cpp/keyword
#ifdef __has_builtin
	#define DK__has_builtin 1
#else
	#define DK__has_builtin 0
	//static_assert(false, "__has_builtin not supported");
#endif

#ifdef __has_include
	//TODO
#else
	static_assert(false, "__has_include not supported");
#endif

// WARNING DISABLE / ENABLE
// https://www.fluentcpp.com/2019/08/30/how-to-disable-a-warning-in-cpp
#if defined(_MSC_VER)
    #define DISABLE_WARNING_PUSH							__pragma(warning( push ))
    #define DISABLE_WARNING_POP								__pragma(warning( pop )) 
    #define DISABLE_WARNING(warningNumber)					__pragma(warning( disable : warningNumber ))
    #define DISABLE_WARNING_UNREFERENCED_FORMAL_PARAMETER	DISABLE_WARNING(4100)
    #define DISABLE_WARNING_UNREFERENCED_FUNCTION			DISABLE_WARNING(4505)
    // other warnings you want to deactivate... 
#elif defined(__GNUC__) || defined(__clang__)
    #define DISABLE_WARNING_PUSH							DKPRAGMA(GCC diagnostic push)
    #define DISABLE_WARNING_POP								DKPRAGMA(GCC diagnostic pop) 
    #define DISABLE_WARNING(warningName)					DKPRAGMA(GCC diagnostic ignored #warningName)
    #define DISABLE_WARNING_UNREFERENCED_FORMAL_PARAMETER	DISABLE_WARNING(-Wunused-parameter)
    #define DISABLE_WARNING_UNREFERENCED_FUNCTION			DISABLE_WARNING(-Wunused-function)
   // other warnings you want to deactivate... 
#else
    #define DISABLE_WARNING_PUSH
    #define DISABLE_WARNING_POP
    #define DISABLE_WARNING_UNREFERENCED_FORMAL_PARAMETER
    #define DISABLE_WARNING_UNREFERENCED_FUNCTION
    // other warnings you want to deactivate... 
#endif
# define WARNING_DISABLE	DISABLE_WARNING_PUSH
# define WARNING_ENABLE		DISABLE_WARNING_POP







//#pragma message("\x1B[104m"   STR(DKCOMPILER_FULL))




/////////////////
#include "DK.hpp"


//static int PrintPreprocessor();


#endif //dk_preprocessor_hpp
