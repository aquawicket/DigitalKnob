//https://stackoverflow.com/a/36545162/688352
//https://en.wikipedia.org/wiki/List_of_Microsoft_Windows_versions
#include "DK/stdafx.h"
#include "DKOsInfo.h"

//////////////////////////////
bool GetOSInfo(DKString& info)
{
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

//////////////////////////////
bool GetSystemOS(DKString& os)
{
#if defined(WIN32)
	//FIXME: GetSystemOS askes strictly for the OS, this should return Windows
	os = "Windows";
	/*
	DKString arch;
	GetOSArchitecture(arch);
	if (same(arch, "32-bit")){
		os = "Win32";
	}
	else if (same(arch, "64-bit")){
		os = "Win64";
	}*/
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
		return DKERROR("ERROR GetSystemOS() cound not get the OS\n");
	return true;
}

//////////////////////////////////////
bool GetOSCompany(DKString& oscompany)
{ 
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
#endif
	return DKERROR("GetOSCompany() not implemented on this OS \n");
}

////////////////////////////////
bool GetOSName(DKString& osname)
{
#ifdef WIN32
	RTL_OSVERSIONINFOEXW vi;
	if(!GetWinOSVersion(vi))
		return DKERROR("!GetWinOSVersion(vi)\n")
	SYSTEM_INFO si;
	GetWinSystemInfo(si);
	std::wstringstream os;
	
	if (vi.dwMajorVersion == 10) {
		if (vi.dwMinorVersion == 0) {
			if (vi.wProductType == VER_NT_WORKSTATION) {
				os << "Windows 10";
			}
			else {
				os << "Windows Server 2019";
			}
		}
	}
	if(vi.dwMajorVersion == 6) {
		if (vi.dwMinorVersion == 3) {
			if (vi.wProductType == VER_NT_WORKSTATION) {
				os << "Windows 8.1";
			}
			else {
				os << "Windows Server 2012 R2";
			}
		}
		if (vi.dwMinorVersion == 2) {
			if (vi.wProductType == VER_NT_WORKSTATION) {
				os << "Windows 8";
			}
			else {
				os << "Windows Server 2012";
			}
		}
		if (vi.dwMinorVersion == 1) {
			if (vi.wProductType == VER_NT_WORKSTATION) {
				os << "Windows 7";
			}
			else {
				os << "Windows Server 2008 R2";
			}
		}
		if (vi.dwMinorVersion == 0) {
			if (vi.wProductType == VER_NT_WORKSTATION) {
				os << "Windows Vista";
			}
			else {
				os << "Windows Server 2008";
			}
		}
	}
	if (vi.dwMajorVersion == 5 && vi.dwMinorVersion == 2) {
		if (GetSystemMetrics(SM_SERVERR2)) {
			os << "Windows Server 2003 R2";
		}
		else if (vi.wSuiteMask & VER_SUITE_STORAGE_SERVER) {
			os << "Windows Storage Server 2003";
		}
		else if (vi.wSuiteMask & VER_SUITE_WH_SERVER) {
			os << "Windows Home Server";
		}
		else if (vi.wProductType == VER_NT_WORKSTATION && si.wProcessorArchitecture == PROCESSOR_ARCHITECTURE_AMD64) {
			os << "Windows XP Professional x64 Edition";
		}
		else {
			os << "Windows Server 2003";  // Test for the server type.
		}
	}
	if (vi.dwMajorVersion == 5 && vi.dwMinorVersion == 1) {
		os << "Windows XP";
	}
	if (vi.dwMajorVersion == 5 && vi.dwMinorVersion == 0) {
		os << "Windows 2000";
	}
	if (vi.dwMajorVersion == 4 && vi.dwMinorVersion == 10) {
		os << "Windows 98";
	}
	if (vi.dwMajorVersion == 4 && vi.dwMinorVersion == 0) {
		os << "Windows NT 4.0";
	}
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
	osname = "";
	return true;
#endif
	return DKERROR("GetOSName() not implemented on this OS \n");
}

//////////////////////////////////////
bool GetOSVersion(DKString& osversion)
{
#ifdef WIN32
	RTL_OSVERSIONINFOEXW vi;
	if (!GetWinOSVersion(vi)) {
		return false;
	}
	SYSTEM_INFO si;
	GetWinSystemInfo(si);
	DWORD dwType;
	if (!GetWinProductInfo(vi, dwType)) {
		return false;
	}
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
				if(vi.wSuiteMask & VER_SUITE_DATACENTER){
					os <<  "Datacenter Edition for Itanium-based Systems";
				}
				else if(vi.wSuiteMask & VER_SUITE_ENTERPRISE){
					os <<  "Enterprise Edition for Itanium-based Systems";
				}
			}   
			else if(si.wProcessorArchitecture==PROCESSOR_ARCHITECTURE_AMD64){
				if(vi.wSuiteMask & VER_SUITE_DATACENTER){
					os <<  "Datacenter x64 Edition";
				}
				else if(vi.wSuiteMask & VER_SUITE_ENTERPRISE){
					os <<  "Enterprise x64 Edition";
				}
				else{
					os <<  "Standard x64 Edition";
				}
			}
			else{
				if(vi.wSuiteMask & VER_SUITE_COMPUTE_SERVER){
					os <<  "Compute Cluster Edition";
				}
				else if(vi.wSuiteMask & VER_SUITE_DATACENTER){
					os <<  "Datacenter Edition";
				}
				else if(vi.wSuiteMask & VER_SUITE_ENTERPRISE){
					os <<  "Enterprise Edition";
				}
				else if(vi.wSuiteMask & VER_SUITE_BLADE){
					os <<  "Web Edition";
				}
				else{
					os <<  "Standard Edition";
				}
			}
		}
	} 
	if(vi.dwMajorVersion == 5 && vi.dwMinorVersion == 1){
		if(vi.wSuiteMask & VER_SUITE_PERSONAL){
			os <<  "Home Edition";
		}
		else{
			os <<  "Professional";
		}
	} 
	if(vi.dwMajorVersion == 5 && vi.dwMinorVersion == 0){
		if(vi.wProductType == VER_NT_WORKSTATION){
			os <<  "Professional";
		}
		else{
			if(vi.wSuiteMask & VER_SUITE_DATACENTER){
				os <<  "Datacenter Server";
			}
			else if(vi.wSuiteMask & VER_SUITE_ENTERPRISE){
				os <<  "Advanced Server";
			}
			else{
				os <<  "Server";
			}
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
#endif
	return DKERROR("GetOSVersion() not inplemented on this OS \n");
}

//////////////////////////////////////////////
bool GetOSServicePack(DKString& osservicepack)
{
#ifdef WIN32
	RTL_OSVERSIONINFOEXW vi;
	if (!GetWinOSVersion(vi)) {
		return false;
	}
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
#endif
	return DKERROR("GetOSServicePack() not inplemented on this OS \n");
}

//////////////////////////////////
bool GetOSBuild(DKString& osbuild)
{
#ifdef WIN32
	RTL_OSVERSIONINFOEXW vi;
	if (!GetWinOSVersion(vi)) {
		return false;
	}
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
#endif
	return DKERROR("GetOSBuild() not inplemented on this OS \n");
}

////////////////////////////////////////////////
bool GetOSArchitecture(DKString& osarchitecture)
{
#ifdef WIN32
	RTL_OSVERSIONINFOEXW vi;
	if (!GetWinOSVersion(vi)) {
		return false;
	}
	SYSTEM_INFO si;
	GetWinSystemInfo(si);
	std::wstringstream os;

	if((vi.dwMajorVersion == 5 && vi.dwMinorVersion >= 2) || vi.dwMajorVersion >= 6) {
		if (si.wProcessorArchitecture == PROCESSOR_ARCHITECTURE_AMD64) {
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
				if (bIsWow64) {
					os << "64";
				}
				else {
					os << "32";
				}
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
#endif
	return DKERROR("GetOSArchitecture() not inplemented on this OS \n");
}

////////////////////////////////////////////
bool GetComputerName(DKString& computername)
{
#ifdef WIN32
	TCHAR computerName[MAX_COMPUTERNAME_LENGTH + 1];
	DWORD size = sizeof(computerName) / sizeof(computerName[0]);
	GetComputerName(computerName, &size);
	computername = (DKString)computerName;
	return true;
#endif
	return DKERROR("GetComputerName() not implemented on this OS \n");
}

#ifdef WIN32
bool GetWinOSVersion(RTL_OSVERSIONINFOEXW& vi)
{
	ZeroMemory(&vi, sizeof(RTL_OSVERSIONINFOEXW));
	HMODULE hMod = ::GetModuleHandleW(L"ntdll.dll");
	if(hMod){
		RtlGetVersionPtr fxPtr = (RtlGetVersionPtr)::GetProcAddress(hMod, "RtlGetVersion");
		if(fxPtr != nullptr) {
			vi = { 0 };
			vi.dwOSVersionInfoSize = sizeof(vi);
			if (STATUS_SUCCESS == fxPtr(&vi)){
				if (VER_PLATFORM_WIN32_NT != vi.dwPlatformId || vi.dwMajorVersion <= 4)
					return DKERROR("GetRealOSVersion(): Not WinNT and Version < 4");
				return true;
			}
		}
	}
	vi = { 0 };
	return false;
}

bool GetWinSystemInfo(SYSTEM_INFO& si) 
{
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

bool GetWinProductInfo(RTL_OSVERSIONINFOEXW& vi, DWORD& dwType) 
{
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

#endif 
