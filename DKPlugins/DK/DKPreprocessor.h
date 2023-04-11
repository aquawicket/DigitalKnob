/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
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
#pragma once
#ifndef DKPreprocessor_H
#define DKPreprocessor_H

// https://developercommunity.visualstudio.com/t/error-c2872-byte-ambiguous-symbol/93889
// Fix for DKVncServer
#if HAVE_DKVncServer
	//#ifndef _HAS_STD_BYTE  //TESTME
		#define _HAS_STD_BYTE 0
	//#endif
#endif

#define STR(x) #x
#define STRS(str1,str2) str1 ## str2
//#define JOIN(a,b) a ## b
// https://stackoverflow.com/a/59157875/688352
//#define JOIN_TWO(_1, _2) STR(_1) "." STR(_2)
//#define JOIN_THREE(_1, _2, _3) STR(_1) "." STR(_2) "." STR(_3)


// DKMESSAGE(<string>): pass a message string to the compiler
#if defined(_MSC_VER)
    #define DKMESSAGE(x) __pragma(message(STR(x)))
#elif defined(__GNUC__) || defined(__clang__)
	#define DO_PRAGMA(x) _Pragma(#x)
	#define DKMESSAGE(x) DO_PRAGMA(message (#x))
#else
	#define DKMESSAGE(X)
#endif
//DKMESSAGE("test DKMESSAGE")

// DKWARNING(string): pass a warning string to the compiler
#if defined(_MSC_VER)
    #define DKWARNING(x) __pragma(warning(STR(x)))
#elif defined(__GNUC__) || defined(__clang__)
	#define DKWARNING(x) DO_PRAGMA(GCC warning #x)
#else
	#define DKWARNING(X)
#endif
//DKWARNING("test DKWARNING")

// NOTE: use #error instead 
// DKERR(string): pass a error string to the compiler 
#if defined(_MSC_VER)
    #define DKERR(x) static_assert(false, STR(x));
#elif defined(__GNUC__) || defined(__clang__)
	#define DKERR(x) DO_PRAGMA(GCC error #x)
#else
	#define DKERR(X)
#endif
//DKERR("test DKERR")



//#define TOSTRING(x) STR(x)
#define PRNT_NAME(x) printf("%s", #x)
#define PRNT_NAME_VALUE(x) printf("%s=%s", #x, STR(x))
#define PRNT_VALUE(x) printf(%s, STR(x))


// TODO: Cross-platform warnings
// https://stackoverflow.com/questions/471935/user-warnings-on-msvc-and-gcc
// https://stackoverflow.com/questions/171435/portability-of-warning-preprocessor-directive


#if __x86_64__ || _M_X64
#	define DKARCH "x86_64"
#	define DKBITS 64
#elif __i386 || _M_IX86
#	define DKARCH "x86_32"
#	define DKBITS 32
#elif __aarch64__
#	define DKARCH "ARM64"
#	define DKBITS 64
#elif __arm__
#	define DKARCH "ARM32"
#	define DKBITS 32
#else
#	define DKARCH "UNKNOWN"
#	define DKBITS "UNKNOWN"
#endif

// https://web.archive.org/web/20191012035921/http://nadeausoftware.com/articles/2012/01/c_c_tip_how_use_compiler_predefined_macros_detect_operating_system
#if _WIN32
#	ifndef DESKTOP
#		define DESKTOP 1
#	endif
#	ifndef WIN
#		define WIN 1
#	endif
#   ifndef WIN32
#		define WIN32 1
#	endif
#	if DKBITS == 32
#		define DKOS "WIN32"
#		define DKOS_VERSION "UNKNOWN"
#	endif
#	if DKBITS == 64
#		ifndef WIN64
#			define WIN64 1
#		endif
#		define DKOS "WIN64"
#		define DKOS_VERSION "UNKNOWN"
#	endif
#elif __APPLE__ && __MACH__
#   ifndef APPLE
#		define APPLE 1
#	endif
#	include <TargetConditionals.h>
#	if TARGET_IPHONE_SIMULATOR == 1
#		ifndef MOBILE
#			define MOBILE 1
#		endif
#		ifndef IOS
#			define IOS 1
#		endif
#		if DKBITS == 64
#			ifndef IOS64
#				define IOS64 1
#			endif
#			ifndef IOSSIM64
#				define IOSSIM64 1
#			endif
#			define DKOS "IOSSIM64"
#			define DKOS_VERSION "UNKNOWN"
#		endif
#		if DKBITS == 32
#			ifndef IOS32
#				define IOS32 1
#			endif
#			ifndef IOSSIM32
#				define IOSSIM32 1
#			endif
#			define DKOS "IOSSIM32"
#			define DKOS_VERSION "UNKNOWN"
#		endif
#	elif TARGET_OS_IPHONE == 1
#		ifndef MOBILE
#			define MOBILE 1
#		endif
#		ifndef IOS
#			define IOS 1
#		endif
#		if DKBITS == 64
#			ifndef IOS64
#				define IOS64 1
#			endif
#			define DKOS "IOS64"
#			define DKOS_VERSION "UNKNOWN"
#		endif
#		if DKBITS == 32
#			ifndef IOS32
#				define IOS32 1
#			endif
#			define DKOS "IOS32"
#			define DKOS_VERSION "UNKNOWN"
#		endif
#	elif TARGET_OS_MAC == 1
#		ifndef DESKTOP
#			define DESKTOP 1
#		endif
#		ifndef MAC
#			define MAC 1
#		endif
#		if DKBITS == 64
#			ifndef MAC64
#				define MAC64 1
#			endif
#			define DKOS "MAC64"
#			define DKOS_VERSION "UNKNOWN"
#		endif
#		if DKBITS == 32
#			ifndef MAC32
#				define MAC32 1
#			endif
#			define DKOS "MAC32"
#			define DKOS_VERSION "UNKNOWN"
#		endif
#	else
#	endif
#elif __ANDROID__
#	ifndef MOBILE
#		define MOBILE 1
#	endif
#	ifndef ANDROID
#		define ANDROID 1
#	endif
#	if DKBITS == 64
#		ifndef ANDROID64
#			define ANDROID64 1
#		endif
#		define DKOS "ANDROID64"
#		define DKOS_VERSION "UNKNOWN" //TOSTRING(__ANDROID_API__)  FIXME: defining from another macro
#	endif
#	if DKBITS == 32
#		ifndef ANDROID32
#			define ANDROID32 1
#		endif
#		define DKOS "ANDROID32"
#		define DKOS_VERSION "UNKNOWN" //TOSTRING(__ANDROID_API__)  FIXME: defining from another macro
#	endif
#elif __linux__
#	ifndef DESKTOP
#		define DESKTOP 1
#	endif
#	ifndef LINUX
#		define LINUX 1
#	endif
#	if DKBITS == 64
#		ifndef LINUX64
#			define LINUX64 1
#		endif
#		define DKOS "LINUX64"
#		define DKOS_VERSION "UNKNOWN"
#	endif
#	if DKBITS == 32
#		ifndef LINUX32
#			define LINUX32 1
#		endif
#		define DKOS "LINUX32"
#		define DKOS_VERSION "UNKNOWN"
#	endif
#elif MSDOS
#	define DKOS "MSDOS"
#	define DKOS_VERSION "UNKNOWN"
#else
#	define DKOS "UNKNOWN"
#	define DKOS_VERSION "UNKNOWN"
#endif




#if __clang__ && __GNUG__
#	define DKCOMPILER "clang++"
#   define DKCOMPILER_VERSION "UNKNOWN" //STR(__clang_version__)  FIXME: defining from another macro
#elif __clang__
#	define DKCOMPILER "clang"
#   define DKCOMPILER_VERSION "UNKNOWN" //STR(__clang_version__)  FIXME: defining from another macro
#elif __llvm__
#	define DKCOMPILER "llvm"
#   define DKCOMPILER_VERSION "UNKNOWN" //STR(__llvm__)  FIXME: defining from another macro
#elif __MINGW64__
#	define DKCOMPILER "Mingw64"
#   define DKCOMPILER_VERSION "UNKNOWN" //JOIN_TWO(__MINGW64_MAJOR_VERSION, __MINGW64_MINOR_VERSION)  FIXME: defining from another macro
#elif __MINGW32__
#	define DKCOMPILER "Mingw32"
#   define DKCOMPILER_VERSION "UNKNOWN" //JOIN_TWO(__MINGW32_MAJOR_VERSION, __MINGW32_MINOR_VERSION)  FIXME: defining from another macro
#elif _MSC_VER
#	define DKCOMPILER "Microsoft Visual C++"
#   define DKCOMPILER_VERSION "UNKNOWN" //STR(_MSC_FULL_VER)  FIXME: defining from another macro
#elif __GNUG__
#	define DKCOMPILER "GNU G++"
#   define DKCOMPILER_VERSION "UNKNOWN" //JOIN_THREE(__GNUC__, __GNUC_MINOR_, __GNUC_PATCHLEVEL__)  FIXME: defining from another macro
#elif __GNUC__
#	define DKCOMPILER "GNU GCC"
#   define DKCOMPILER_VERSION "UNKNOWN" //JOIN_THREE(__GNUC__, __GNUC_MINOR__, __GNUC_PATCHLEVEL__)  FIXME: defining from another macro
#else
#	define DKCOMPILER "UNKNOWN"
#   define DKCOMPILER_VERSION "UNKNOWN"
#endif


#if __STDC_VERSION__ > 201710L
#	define DKC_LANGUAGE_VERSION "Greater then C18"
#elif __STDC_VERSION__ == 201710L
#	define DKC_LANGUAGE_VERSION "C18"
#elif __STDC_VERSION__ == 201112L
#	define DKC_LANGUAGE_VERSION "C11"
#elif __STDC_VERSION__ == 199901L
#	define DKC_LANGUAGE_VERSION "C99"
#elif __STDC_VERSION__ == 199409L
#	define DKC_LANGUAGE_VERSION "C94"
#elif __STDC__
#	define DKC_LANGUAGE_VERSION "C90"
#else
#	define DKC_LANGUAGE_VERSION "UNKNOWN"
#endif

#if __cplusplus > 202110L
#	define DKCPP_LANGUAGE_VERSION "Grater then C++23"
#elif __cplusplus == 202110L
#	define DKCPP_LANGUAGE_VERSION "C++23"
#elif __cplusplus == 201902L
#	define DKCPP_LANGUAGE_VERSION "C++20"
#elif __cplusplus == 201703L
#	define DKCPP_LANGUAGE_VERSION "C++17"
#elif __cplusplus == 201402L
#	define DKCPP_LANGUAGE_VERSION "C++14"
#elif __cplusplus == 201103L
#	define DKCPP_LANGUAGE_VERSION "C++11"
#elif __cplusplus == 199711L
#	define DKCPP_LANGUAGE_VERSION "C++98"
#elif __cplusplus 
#	define DKCPP_LANGUAGE_VERSIOND "pre-C++98"
#else
#	define DKCPP_LANGUAGE_VERSION "UNKNOWN"
#endif

// BUILD_TYPE
#if DEBUG
#	define DKBUILD_TYPE "DEBUG"
#elif NDEBUG
#	define DKBUILD_TYPE "RELEASE"
#else
#	define DKBUILD_TYPE "UNKNOWN"
#endif

// RTTI
#if defined(__clang__)
#	if __has_feature(cxx_rtti)
#		define RTTI_ENABLED 1
#	endif
#elif defined(__GNUG__)
#	if defined(__GXX_RTTI)
#		define RTTI_ENABLED 1
#	endif
#elif defined(_MSC_VER) //Visual Studio Compiler
#	if defined(_CPPRTTI)
#		define RTTI_ENABLED 1
#	endif
#endif


// DK_UNUSED(arg) - supress unreferenced formal parameter warnings for uused variables
#define DK_UNUSED(arg) (void)arg;


// https://en.cppreference.com/w/cpp/keyword
#ifdef __has_builtin
	//TODO
#else
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
   // #define DO_PRAGMA(X) _Pragma(#X)
    #define DISABLE_WARNING_PUSH							DO_PRAGMA(GCC diagnostic push)
    #define DISABLE_WARNING_POP								DO_PRAGMA(GCC diagnostic pop) 
    #define DISABLE_WARNING(warningName)					DO_PRAGMA(GCC diagnostic ignored #warningName)
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


class DKPreprocessor {
public:
	static bool PrintPreprocessor();
};

#endif //DKPreprocessor_H
