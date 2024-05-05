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

#define STR_EXPAND(tok) #tok
#define STR(tok) STR_EXPAND(tok)
//#define STRS(str1,str2) str1 ## str2
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
#   ifndef WIN_X86
#		define WIN_X86 1
#	endif
#	if DKBITS == 32
#		define DKOS "WIN_X86"
#		define DKOS_VERSION "UNKNOWN"
#	endif
#	if DKBITS == 64
#		ifndef WIN_X86_64
#			define WIN_X86_64 1
#		endif
#		define DKOS "WIN_X86_64"
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
#			ifndef IOS_ARM64
#				define IOS_ARM64 1
#			endif
#			ifndef IOSSIM_X86_64
#				define IOSSIM_X86_64 1
#			endif
#			define DKOS "IOSSIM_X86_64"
#			define DKOS_VERSION "UNKNOWN"
#		endif
#		if DKBITS == 32
#			ifndef IOS_ARM32
#				define IOS_ARM32 1
#			endif
#			ifndef IOSSIM_X86
#				define IOSSIM_X86 1
#			endif
#			define DKOS "IOSSIM_X86"
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
#			ifndef IOS_ARM64
#				define IOS_ARM64 1
#			endif
#			define DKOS "IOS_ARM64"
#			define DKOS_VERSION "UNKNOWN"
#		endif
#		if DKBITS == 32
#			ifndef IOS_ARM32
#				define IOS_ARM32 1
#			endif
#			define DKOS "IOS_ARM32"
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
#			ifndef MAC_X86_64
#				define MAC_X86_64 1
#			endif
#			define DKOS "MAC_X86_64"
#			define DKOS_VERSION "UNKNOWN"
#		endif
#		if DKBITS == 32
#			ifndef MAC_X86
#				define MAC_X86 1
#			endif
#			define DKOS "MAC_X86"
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
#		ifndef ANDROID_ARM64
#			define ANDROID_ARM64 1
#		endif
#		define DKOS "ANDROID_ARM64"
#		define DKOS_VERSION "UNKNOWN" //TOSTRING(__ANDROID_API__)  FIXME: defining from another macro
#	endif
#	if DKBITS == 32
#		ifndef ANDROID_ARM32
#			define ANDROID_ARM32 1
#		endif
#		define DKOS "ANDROID_ARM32"
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
#		ifndef LINUX_X86_64
#			define LINUX_X86_64 1
#		endif
#		define DKOS "LINUX_X86_64"
#		define DKOS_VERSION "UNKNOWN"
#	endif
#	if DKBITS == 32
#		ifndef LINUX_X86
#			define LINUX_X86 1
#		endif
#		define DKOS "LINUX_X86"
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
#	define DKCOMPILER_VERSION STR(__clang_major__) "." STR(__clang_minor__) "." STR(__clang_patchlevel__)
#elif __clang__
#	define DKCOMPILER "clang"
#	define DKCOMPILER_VERSION STR(__clang_major__) "." STR(__clang_minor__) "." STR(__clang_patchlevel__)
#elif __llvm__
#	define DKCOMPILER "llvm"
#   define DKCOMPILER_VERSION "UNKNOWN" //STR(__llvm__)  FIXME: defining from another macro
#elif __MINGW64__
#	define DKCOMPILER "Mingw64"
#	define DKCOMPILER_VERSION STR(__MINGW64_VERSION_MAJOR) "." STR(__MINGW64_VERSION_MINOR) "." STR(__MINGW64_VERSION_BUGFIX)
#elif __MINGW32__
#	define DKCOMPILER "Mingw32"
#	define DKCOMPILER_VERSION STR(__MINGW32_VERSION_MAJOR) "." STR(__MINGW32_VERSION_MINOR) "." STR(__MINGW32_VERSION_BUGFIX)
#elif _MSC_VER	// https://learn.microsoft.com/en-us/cpp/preprocessor/predefined-macros?view=msvc-170
#	define DKCOMPILER "Microsoft Visual C++"
#   define DKCOMPILER_VERSION _MSC_FULL_VER
#elif __GNUG__
#	define DKCOMPILER "GNU G++"
#	define DKCOMPILER_VERSION STR(__GNUC__) "." STR(__GNUC_MINOR__) "." STR(__GNUC_PATCHLEVEL__)
#elif __GNUC__
#	define DKCOMPILER "GNU GCC"
#	define DKCOMPILER_VERSION STR(__GNUC__) "." STR(__GNUC_MINOR__) "." STR(__GNUC_PATCHLEVEL__)
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
#else
#	define DKBUILD_TYPE "RELEASE"
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
