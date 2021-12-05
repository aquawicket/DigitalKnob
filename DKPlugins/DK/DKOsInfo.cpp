//https://stackoverflow.com/a/36545162/688352
//https://en.wikipedia.org/wiki/List_of_Microsoft_Windows_versions
#include "DK/stdafx.h"
#include "DKOsInfo.h"

#ifdef MAC
#import <CoreServices/CoreServices.h>
#endif

bool GetOSFlag(DKString& flag) {
#ifdef WIN32
	flag = "WIN32";
#endif
#ifdef WIN64
	flag = "WIN64";
#endif
#ifdef MAC32
	flag = "MAC32";
#endif
#ifdef MAC64
	flag = "MAC64";
#endif
#ifdef IOS32
	flag = "IOS32";
#endif
#ifdef IOS64
	flag = "IOS64";
#endif
#ifdef LINUX32
	flag = "LINUX32";
#endif
#ifdef LINUX64
	flag = "LINUX64";
#endif
#ifdef RASPBERRY32
	flag = "RASPBERRY32";
#endif
#ifdef RASPBERRY64
	flag = "RASPBERRY64";
#endif
#ifdef ANDROID32
	flag = "ANDROID32";
#endif
#ifdef ANDROID64
	flag = "ANDROID64";
#endif
	return true;
}

bool GetOSInfo(DKString& info){
	DKString oscompany;
	GetOSCompany(oscompany);
	DKString osname;
	GetOSName(osname);
	DKString osversion;
	GetOSVersion(osversion);
	DKString osservicepack;
	GetOSServicePack(osservicepack);
	DKString osbuild;
	GetOSBuild(osbuild);
	DKString osarchitecture;
	GetOSArchitecture(osarchitecture);
	info = (oscompany+" "+osname+" "+osversion+" "+osservicepack+" "+osbuild+" "+osarchitecture);
	return true;
	//DKString computername;
	//getComputerName(computername);
}

bool GetSystemOS(DKString& os){
#if defined(WIN32)
	os = "Windows";
#endif
#if defined(MAC)
	os = "Mac";
#endif
#if defined(IOS)
	os = "iOS";
#endif
#if defined(RASPBERRY)
	os = "Raspberry";
#elif defined(LINUX)
	os = "Linux";
#endif
#if defined(ANDROID)
	os = "Android";
#endif
	if(os.empty())
		return DKERROR("cound not get the OS\n");
	return true;
}

bool GetOSCompany(DKString& oscompany){ 
#ifdef WIN32
	oscompany = "Microsoft";
	return true;
#elif defined(MAC)
	oscompany = "Apple";
	return true;
#elif defined(IOS)
	oscompany = "Apple";
	return true;
#elif defined(ANDROID)
	oscompany = "Google";
	return true;
#elif defined(LINUX)
	oscompany = "Linux";
	return true;
#else
	return DKERROR("not implemented on this OS \n");
#endif
}

bool GetOSName(DKString& osname){
#ifdef WIN32
	RTL_OSVERSIONINFOEXW vi;
	if(!GetWinOSVersion(vi))
		return DKERROR("!GetWinOSVersion(vi)\n")
	SYSTEM_INFO si;
	GetWinSystemInfo(si);
	std::wstringstream os;
	if (vi.dwMajorVersion == 10) {
		if (vi.dwMinorVersion == 0) {
			if (vi.wProductType == VER_NT_WORKSTATION)
				os << "Windows 10";
			else
				os << "Windows Server 2019";
		}
	}
	if(vi.dwMajorVersion == 6) {
		if (vi.dwMinorVersion == 3) {
			if (vi.wProductType == VER_NT_WORKSTATION)
				os << "Windows 8.1";
			else
				os << "Windows Server 2012 R2";
		}
		if (vi.dwMinorVersion == 2) {
			if (vi.wProductType == VER_NT_WORKSTATION)
				os << "Windows 8";
			else
				os << "Windows Server 2012";
		}
		if (vi.dwMinorVersion == 1) {
			if (vi.wProductType == VER_NT_WORKSTATION)
				os << "Windows 7";
			else
				os << "Windows Server 2008 R2";
		}
		if (vi.dwMinorVersion == 0) {
			if (vi.wProductType == VER_NT_WORKSTATION)
				os << "Windows Vista";
			else
				os << "Windows Server 2008";
		}
	}
	if (vi.dwMajorVersion == 5 && vi.dwMinorVersion == 2) {
		if (GetSystemMetrics(SM_SERVERR2))
			os << "Windows Server 2003 R2";
		else if (vi.wSuiteMask & VER_SUITE_STORAGE_SERVER)
			os << "Windows Storage Server 2003";
		else if (vi.wSuiteMask & VER_SUITE_WH_SERVER)
			os << "Windows Home Server";
		else if (vi.wProductType == VER_NT_WORKSTATION && si.wProcessorArchitecture == PROCESSOR_ARCHITECTURE_AMD64)
			os << "Windows XP Professional x64 Edition";
		else
			os << "Windows Server 2003";  // Test for the server type.
	}
	if (vi.dwMajorVersion == 5 && vi.dwMinorVersion == 1)
		os << "Windows XP";
	if (vi.dwMajorVersion == 5 && vi.dwMinorVersion == 0)
		os << "Windows 2000";
	if (vi.dwMajorVersion == 4 && vi.dwMinorVersion == 10)
		os << "Windows 98";
	if (vi.dwMajorVersion == 4 && vi.dwMinorVersion == 0)
		os << "Windows NT 4.0";
	osname = toString(os.str());
	return true;
#elif defined(MAC)
	osname = "MacOSX";
	return true;
#elif defined(IOS)
	osname = "iOS";
	return true;
#elif defined(ANDROID)
	osname = "Android";
	return true;
#elif defined(LINUX)
	osname = "Linux";
	return true;
#else
	return DKERROR("not implemented on this OS \n");
#endif
}

bool GetOSVersion(DKString& osversion){
#ifdef WIN32
	RTL_OSVERSIONINFOEXW vi;
	if (!GetWinOSVersion(vi))
		return DKERROR("GetWinOSVersion() failed\n");
	SYSTEM_INFO si;
	GetWinSystemInfo(si);
	DWORD dwType;
	if (!GetWinProductInfo(vi, dwType))
		return DKERROR("GetWinProductInfo() failed\n");
	std::wstringstream os;
#if defined(_MSC_VER)
	switch(dwType){
		case PRODUCT_ULTIMATE:
			os << "Ultimate Edition";
			break;
		case PRODUCT_PROFESSIONAL:
			os << "Professional";
			break;
		case PRODUCT_HOME_PREMIUM:
			os << "Home Premium Edition";
			break;
		case PRODUCT_HOME_BASIC:
			os << "Home Basic Edition";
			break;
		case PRODUCT_ENTERPRISE:
			os << "Enterprise Edition";
			break;
		case PRODUCT_BUSINESS:
			os << "Business Edition";
			break;
		case PRODUCT_STARTER:
			os << "Starter Edition";
			break;
		case PRODUCT_CLUSTER_SERVER:
			os << "Cluster Server Edition";
			break;
		case PRODUCT_DATACENTER_SERVER:
			os << "Datacenter Edition";
			break;
		case PRODUCT_DATACENTER_SERVER_CORE:
			os << "Datacenter Edition (core installation)";
			break;
		case PRODUCT_ENTERPRISE_SERVER:
			os << "Enterprise Edition";
			break;
		case PRODUCT_ENTERPRISE_SERVER_CORE:
			os << "Enterprise Edition (core installation)";
			break;
		case PRODUCT_ENTERPRISE_SERVER_IA64:
			os << "Enterprise Edition for Itanium-based Systems";
			break;
		case PRODUCT_SMALLBUSINESS_SERVER:
			os << "Small Business Server";
			break;
		case PRODUCT_SMALLBUSINESS_SERVER_PREMIUM:
			os << "Small Business Server Premium Edition";
			break;
		case PRODUCT_STANDARD_SERVER:
			os << "Standard Edition";
			break;
		case PRODUCT_STANDARD_SERVER_CORE:
			os << "Standard Edition (core installation)";
			break;
		case PRODUCT_WEB_SERVER:
			os << "Web Server Edition";
				break;
		}
#endif //(_MSC_VER)
	if (vi.dwMajorVersion == 5 && vi.dwMinorVersion == 2){
		if (vi.wProductType != VER_NT_WORKSTATION){
			if(si.wProcessorArchitecture==PROCESSOR_ARCHITECTURE_IA64){
				if(vi.wSuiteMask & VER_SUITE_DATACENTER)
					os <<  "Datacenter Edition for Itanium-based Systems";
				else if(vi.wSuiteMask & VER_SUITE_ENTERPRISE)
					os <<  "Enterprise Edition for Itanium-based Systems";
			}   
			else if(si.wProcessorArchitecture==PROCESSOR_ARCHITECTURE_AMD64){
				if(vi.wSuiteMask & VER_SUITE_DATACENTER)
					os <<  "Datacenter x64 Edition";
				else if(vi.wSuiteMask & VER_SUITE_ENTERPRISE)
					os <<  "Enterprise x64 Edition";
				else
					os <<  "Standard x64 Edition";
			}
			else{
				if(vi.wSuiteMask & VER_SUITE_COMPUTE_SERVER)
					os <<  "Compute Cluster Edition";
				else if(vi.wSuiteMask & VER_SUITE_DATACENTER)
					os <<  "Datacenter Edition";
				else if(vi.wSuiteMask & VER_SUITE_ENTERPRISE)
					os <<  "Enterprise Edition";
				else if(vi.wSuiteMask & VER_SUITE_BLADE)
					os <<  "Web Edition";
				else
					os <<  "Standard Edition";
			}
		}
	} 
	if(vi.dwMajorVersion == 5 && vi.dwMinorVersion == 1){
		if(vi.wSuiteMask & VER_SUITE_PERSONAL)
			os <<  "Home Edition";
		else
			os <<  "Professional";
	} 
	if(vi.dwMajorVersion == 5 && vi.dwMinorVersion == 0){
		if(vi.wProductType == VER_NT_WORKSTATION){
			os <<  "Professional";
		}
		else{
			if(vi.wSuiteMask & VER_SUITE_DATACENTER)
				os <<  "Datacenter Server";
			else if(vi.wSuiteMask & VER_SUITE_ENTERPRISE)
				os <<  "Advanced Server";
			else
				os <<  "Server";
		}
	} 
	osversion = toString(os.str());
	return true;
#elif defined(MAC)
    SInt32 majorVersion,minorVersion,bugFixVersion;
    Gestalt(gestaltSystemVersionMajor, &majorVersion);
    Gestalt(gestaltSystemVersionMinor, &minorVersion);
    Gestalt(gestaltSystemVersionBugFix, &bugFixVersion);
    osversion = toString(majorVersion);
    osversion += ".";
    osversion += toString(minorVersion);
    osversion += ".";
    osversion += toString(bugFixVersion);
	return true;
#elif defined(IOS)
	osversion = "";
	return true;
#elif defined(ANDROID)
	osversion = "";
	return true;
#elif defined(LINUX)
	osversion = "";
	return true;
#else
	return DKERROR("not inplemented on this OS \n");
#endif
}

bool GetOSServicePack(DKString& osservicepack){
#ifdef WIN32
	RTL_OSVERSIONINFOEXW vi;
	if (!GetWinOSVersion(vi))
		return DKERROR("GetWinOSVersion() failed\n");
	std::wstringstream os;
	// Include service pack (if any). 
	if(wcslen((const wchar_t*)vi.szCSDVersion) > 0){
		os << vi.szCSDVersion;
		osservicepack = toString(os.str());
	}
	return true;
#elif defined(MAC)
	osservicepack = "";
	return true;
#elif defined(IOS)
	osservicepack = "";
	return true;
#elif defined(ANDROID)
	osservicepack = "";
	return true;
#elif defined(LINUX)
	osservicepack = "";
	return true;
#else
	return DKERROR("not inplemented on this OS\n");
#endif
}

bool GetOSBuild(DKString& osbuild){
#ifdef WIN32
	RTL_OSVERSIONINFOEXW vi;
	if (!GetWinOSVersion(vi))
		return DKERROR("GetWinOSVersion() failed\n");
	std::wstringstream os;
	os << L"build " << vi.dwMajorVersion << "." << vi.dwMinorVersion << "." << vi.dwBuildNumber;
	osbuild = toString(os.str());
	return true;
#elif defined(MAC)
	osbuild = "";
	return true;
#elif defined(IOS)
	osbuild = "";
	return true;
#elif defined(ANDROID)
	osbuild = "";
	return true;
#elif defined(LINUX)
	osbuild = "";
	return true;
#else
	return DKERROR("not inplemented on this OS \n");
#endif
}

bool GetOSArchitecture(DKString& osarchitecture){
#ifdef WIN32
	RTL_OSVERSIONINFOEXW vi;
	if (!GetWinOSVersion(vi))
		return DKERROR("GetWinOSVersion() failed\n");
	SYSTEM_INFO si;
	GetWinSystemInfo(si);
	std::wstringstream os;
	if((vi.dwMajorVersion == 5 && vi.dwMinorVersion >= 2) || vi.dwMajorVersion >= 6) {
		if (si.wProcessorArchitecture == PROCESSOR_ARCHITECTURE_AMD64){
			os << "64";
		}
		else {
			BOOL bIsWow64 = FALSE;
			LPFN_ISWOW64PROCESS fnIsWow64Process;
			fnIsWow64Process = (LPFN_ISWOW64PROCESS)GetProcAddress(GetModuleHandle(TEXT("kernel32")), "IsWow64Process");
			if (NULL != fnIsWow64Process) {
				if (!fnIsWow64Process(GetCurrentProcess(), &bIsWow64)) {
					os << "32";
					return DKERROR("GetOSArchitecture(): failed at: fnIsWow64Process(GetCurrentProcess(), &bIsWow64)");
				}
				if (bIsWow64) 
					os << "64";
				else
					os << "32";
			}
			
		}
	}
	else{
		os << "32";
	}
	osarchitecture = toString(os.str());
	return true;
#elif defined(MAC)
	osarchitecture = "";
	return true;
#elif defined(IOS)
	osarchitecture = "";
	return true;
#elif defined(ANDROID)
	osarchitecture = "";
	return true;
#elif defined(LINUX)
	osarchitecture = "";
	return true;
#else
	return DKERROR("not inplemented on this OS \n");
#endif
}

////////////////////////////////////////////
bool GetComputerName(DKString& computername){
#ifdef WIN32
	TCHAR computerName[MAX_COMPUTERNAME_LENGTH + 1];
	DWORD size = sizeof(computerName) / sizeof(computerName[0]);
	GetComputerName(computerName, &size);
	computername = (DKString)computerName;
	return true;
#else
	return DKERROR("not implemented on this OS \n");
#endif
}

#ifdef WIN32
bool GetWinOSVersion(RTL_OSVERSIONINFOEXW& vi){
	ZeroMemory(&vi, sizeof(RTL_OSVERSIONINFOEXW));
	HMODULE hMod = ::GetModuleHandleW(L"ntdll.dll");
	if(hMod){
		RtlGetVersionPtr fxPtr = (RtlGetVersionPtr)::GetProcAddress(hMod, "RtlGetVersion");
		if(fxPtr != nullptr) {
			vi = { 0 };
			vi.dwOSVersionInfoSize = sizeof(vi);
			if (STATUS_SUCCESS == fxPtr(&vi)){
				if (VER_PLATFORM_WIN32_NT != vi.dwPlatformId || vi.dwMajorVersion <= 4)
					return DKERROR("Not WinNT and Version < 4");
				return true;
			}
		}
	}
	vi = { 0 };
	return false;
}

bool GetWinSystemInfo(SYSTEM_INFO& si) {
	ZeroMemory(&si, sizeof(SYSTEM_INFO));
	HMODULE hMod = ::GetModuleHandleW(L"kernel32.dll");
	if (hMod) {
		SYSTEM_INFO_Ptr fxPtr = (SYSTEM_INFO_Ptr)::GetProcAddress(hMod, "GetNativeSystemInfo");
		if (fxPtr != nullptr) {
			si = { 0 };
			if (STATUS_SUCCESS == fxPtr(&si)) {
				return true;
			}
		}
	}
	si = { 0 };
	return false;
}

bool GetWinProductInfo(RTL_OSVERSIONINFOEXW& vi, DWORD& dwType) {
	HMODULE hMod = ::GetModuleHandleW(L"kernel32.dll");
	if (hMod) {
		ProductInfoPtr fxPtr = (ProductInfoPtr)::GetProcAddress(hMod, "GetProductInfo");
		if (fxPtr != nullptr) {
			fxPtr(vi.dwMajorVersion, vi.dwMinorVersion, 0, 0, &dwType);
			return true;
		}
	}
	return false;
}

// https://sourceforge.net/p/predef/wiki/Compilers/
bool GetCompilerName(DKString& compilerName) {
#ifdef __clang__ //place before __GNUC__
	compilerName = "clang++";
#elif __llvm__
	compilerName = "llvm";
#elif __MINGW32__ //place before __GNUC__
	compilerName = "Mingw32";
#elif __MINGW64__ //place before __GNUC__
	compilerName = "Mingw64";
#elif _MSC_VER
	compilerName = "Microsoft Visual C++";
#elif __GNUC__
	compilerName = "GNU GCC";
#else
	compilerName = "UNKNOWN COMPILER";
#endif
}

bool GetCompilerVersion(DKString& compilerVersion) {
#ifdef __clang__ //place before __GNUC__
	compilerVersion = __clang_version__;
#elif __llvm__
	compilerVersion = __llvm__;
#elif __MINGW32__ //place before __GNUC__
	compilerVersion = __MINGW32_MAJOR_VERSION + "." + __MINGW32_MINOR_VERSION";
#elif __MINGW64__ //place before __GNUC__
	compilerVersion = __MINGW64_MAJOR_VERSION + "." + __MINGW64_MINOR_VERSION";
#elif _MSC_VER
	compilerVersion = _MSC_FULL_VER;
#elif __GNUC__
	compilerVersion = __GNUC__ + "." + __GNUC_MINOR__ + "." + __GNUC_PATCHLEVEL__;
#else
	compilerVersion = "UNKNOWN COMPILER VERSION";
#endif
}

bool GetCorCpp(DKString& cOrCpp) {
#ifdef __cplusplus
	cOrCpp = "C++";
#else
	cOrCpp = "C";
#endif
}

// https://sourceforge.net/p/predef/wiki/Standards/
bool GetCVersion(DKString& cVersion) {
#if defined(__STDC__)
#	if __STDC_VERSION__ > 201710L
		cVersion = "Grater then C18";
#	elif __STDC_VERSION__ == 201710L
		cVersion = "C18";
#	elif __STDC_VERSION__ == 201112L
		cVersion = "C11";
#	elif __STDC_VERSION__ == 199901L
		cVersion = "C99";
#	elif __STDC_VERSION__ == 199409L
		cVersion = "C94";
#	else
		cVersion = "C90";
#	endif
#else
	DKERROR("__STDC__ is not defined");
#endif
}

bool GetCppVersion(DKString& cppVersion) {
#ifdef __cplusplus
#	if __cplusplus > 202110L
		cppVersion = "Grater then C++23";
#	elif __cplusplus == 202110L
		cppVersion = "C++23";
#	elif __cplusplus == 201902L
		cppVersion = "C++20";
#	elif __cplusplus == 201703L
		cppVersion = "C++17";
#	elif __cplusplus == 201402L
		cppVersion = "C++14";
#	elif __cplusplus == 201103L
		cppVersion = "C++11";
#	elif __cplusplus == 199711L
		cppVersion = "C++98";
#	else
		cppVersion = "pre-C++98";
#	endif
#else
	DKERROR("__cplusplus is not defined");
#endif
}

#endif //WIN32
