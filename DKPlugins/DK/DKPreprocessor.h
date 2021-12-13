// https://sourceforge.net/p/predef/wiki/Home/
// https://github.com/nemequ/pre-defined-macros
// https://stackoverflow.com/a/3672331/688352


#define STR(x) #x
#define TOSTRING(x) STR(x)
#define PRNT_NAME(x) printf("%s", #x)
#define PRNT_NAME_VALUE(x) printf("%s=%s", #x, STR(x))
#define PRNT_VALUE(x) printf(%s, STR(x))
//#define JOIN(a,b) a ## b
// https://stackoverflow.com/a/59157875/688352
#define JOIN_TWO(_1, _2) STR(_1) "." STR(_2)
#define JOIN_THREE(_1, _2, _3) STR(_1) "." STR(_2) "." STR(_3)



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
#endif

// https://web.archive.org/web/20191012035921/http://nadeausoftware.com/articles/2012/01/c_c_tip_how_use_compiler_predefined_macros_detect_operating_system
#ifdef _WIN32
#	ifndef WIN
#		define WIN
#	endif
#	if DKBITS == 64
#		ifndef WIN64
#			define WIN64
#		endif
#		define DKOS "WIN64"
#		define DKOS_VERSION "UNKNOWN"
#	endif
#	if DKBITS == 32
#		ifndef WIN32
#			define WIN32
#		endif
#		define DKOS "WIN32"
#		define DKOS_VERSION "UNKNOWN"
#	endif
#elif __APPLE__ && __MACH__
#	include <TargetConditionals.h>
#	if TARGET_IPHONE_SIMULATOR == 1
#		ifndef IOS
#			define IOS
#		endif
#		if DKBITS == 64
#			ifndef IOS64
#				define IOS64
#			endif
#			ifndef IOSSIM64
#				define IOSSIM64
#			endif
#			define DKOS "IOSSIM64"
#			define DKOS_VERSION "UNKNOWN"
#		endif
#		if DKBITS == 32
#			ifndef IOS32
#				define IOS32
#			endif
#			ifndef IOSSIM32
#				define IOSSIM32
#			endif
#			define DKOS "IOSSIM32"
#			define DKOS_VERSION "UNKNOWN"
#		endif
#	elif TARGET_OS_IPHONE == 1
#		ifndef IOS
#			define IOS
#		endif
#		if DKBITS == 64
#			ifndef IOS64
#				define IOS64
#			endif
#			define DKOS "IOS64"
#			define DKOS_VERSION "UNKNOWN"
#		endif
#		if DKBITS == 32
#			ifndef IOS32
#				define IOS32
#			endif
#			define DKOS "IOS32"
#			define DKOS_VERSION "UNKNOWN"
#		endif
#	elif TARGET_OS_MAC == 1
#		ifndef MAC
#			define MAC
#		endif
#		if DKBITS == 64
#			ifndef MAC64
#				define MAC64
#			endif
#			define DKOS "MAC64"
#			define DKOS_VERSION "UNKNOWN"
#		endif
#		if DKBITS == 32
#			ifndef MAC32
#				define MAC32
#			endif
#			define DKOS "MAC32"
#			define DKOS_VERSION "UNKNOWN"
#		endif
#	else
#	endif
#elif __ANDROID__
#	ifndef ANDROID
#		define ANDROID
#	endif
#	if DKBITS == 64
#		ifndef ANDROID64
#			define ANDROID64
#		endif
#		define DKOS "ANDROID64"
#		define DKOS_VERSION TOSTRING(__ANDROID_API__)
#	endif
#	if DKBITS == 32
#		ifndef ANDROID32
#			define ANDROID32
#		endif
#		define DKOS "ANDROID32"
#		define DKOS_VERSION TOSTRING(__ANDROID_API__)
#	endif
#elif __linux__
#	ifndef LINUX
#		define LINUX
#	endif
#	if DKBITS == 64
#		ifndef LINUX64
#			define LINUX64
#		endif
#		define DKOS "LINUX64"
#		define DKOS_VERSION "UNKNOWN"
#	endif
#	if DKBITS == 32
#		ifndef LINUX32
#			define LINUX32
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
#   define DKCOMPILER_VERSION STR(__clang_version__)
#elif __clang__
#	define DKCOMPILER "clang"
#   define DKCOMPILER_VERSION STR(__clang_version__)
#elif __llvm__
#	define DKCOMPILER "llvm"
#   define DKCOMPILER_VERSION STR(__llvm__)
#elif __MINGW64__
#	define DKCOMPILER "Mingw64"
#   define DKCOMPILER_VERSION JOIN_TWO(__MINGW64_MAJOR_VERSION, __MINGW64_MINOR_VERSION)
#elif __MINGW32__
#	define DKCOMPILER "Mingw32"
#   define DKCOMPILER_VERSION JOIN_TWO(__MINGW32_MAJOR_VERSION, __MINGW32_MINOR_VERSION)
#elif _MSC_VER
#	define DKCOMPILER "Microsoft Visual C++"
#   define DKCOMPILER_VERSION STR(_MSC_FULL_VER)
#elif __GNUG__
#	define DKCOMPILER "GNU G++"
#   define DKCOMPILER_VERSION JOIN_THREE(__GNUC__, __GNUC_MINOR_, __GNUC_PATCHLEVEL__)
#elif __GNUC__
#	define DKCOMPILER "GNU GCC"
#   define DKCOMPILER_VERSION JOIN_THREE(__GNUC__, __GNUC_MINOR__, __GNUC_PATCHLEVEL__)
#else
#	define DKCOMPILER "UNKNOWN"
#   define DKCOMPILER_VERSION "UNKNOWN"
#endif


#if __STDC_VERSION__ > 201710L
#	define DKC_LANGUAGE_VERSION "Grater then C18"
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


#if DEBUG
#	define DKBUILD_TYPE "DEBUG"
#elif RELEASE
#	define DKBUILD_TYPE "RELEASE"
#else
#	define DKBUILD_TYPE "UNKNOWN"
#endif