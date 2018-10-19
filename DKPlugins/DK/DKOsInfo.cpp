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
	DKString arch;
	GetOSArchitecture(arch);
	if (same(arch, "32-bit")){
		os = "Win32";
	}
	else if (same(arch, "64-bit")){
		os = "Win64";
	}
#endif
#if defined(MAC)
	os = "Mac";
#endif
#if defined(IOS)
	os = "iOS";
#endif
#if defined(LINUX)
	os = "Linux";
#endif
#if defined(ANDROID)
	os = "Android";
#endif
	if(os.empty()){
		DKLog("ERROR GetSystemOS() cound not get the OS\n", DKERROR);
		return false;
	}
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
	DKLog("GetOSCompany() not implemented on this OS \n", DKERROR);
	return false;
}

////////////////////////////////
bool GetOSName(DKString& osname)
{
#ifdef WIN32
	OSVERSIONINFOEX osvi;
	SYSTEM_INFO si;
	BOOL bOsVersionInfoEx;

	ZeroMemory(&si, sizeof(SYSTEM_INFO));
	ZeroMemory(&osvi, sizeof(OSVERSIONINFOEX)); 
	osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX);
	bOsVersionInfoEx = GetVersionEx((OSVERSIONINFO*) &osvi);

	if(bOsVersionInfoEx == 0){
		return false; // Call GetNativeSystemInfo if supported or GetSystemInfo otherwise.
	}
	PGNSI pGNSI = (PGNSI) GetProcAddress(GetModuleHandle(TEXT("kernel32.dll")), "GetNativeSystemInfo");
	if(NULL != pGNSI){
		pGNSI(&si);
	}
	else{ 
		GetSystemInfo(&si); // Check for unsupported OS
	}
	if(VER_PLATFORM_WIN32_NT != osvi.dwPlatformId || osvi.dwMajorVersion <= 4 ){
		return false;
	}
	std::wstringstream os;
	if ( osvi.dwMajorVersion == 6 ){
		if(osvi.dwMinorVersion == 0){
			if(osvi.wProductType == VER_NT_WORKSTATION){
				os << "Windows Vista";
			}
			else{
				os << "Windows Server 2008";
			}
		}  
		if (osvi.dwMinorVersion == 1){
			if(osvi.wProductType == VER_NT_WORKSTATION){
				os << "Windows 7";
			}
			else{
				os << "Windows Server 2008 R2";
			}
		}  
	}
	if (osvi.dwMajorVersion == 5 && osvi.dwMinorVersion == 2){
		if(GetSystemMetrics(SM_SERVERR2)){
			os <<  "Windows Server 2003 R2";
		}
		else if (osvi.wSuiteMask & VER_SUITE_STORAGE_SERVER){
			os <<  "Windows Storage Server 2003";
		}
		else if ( osvi.wSuiteMask & VER_SUITE_WH_SERVER ){
			os <<  "Windows Home Server";
		}
		else if( osvi.wProductType == VER_NT_WORKSTATION && si.wProcessorArchitecture==PROCESSOR_ARCHITECTURE_AMD64){
			os <<  "Windows XP Professional x64 Edition";
		}
		else{
			os << "Windows Server 2003";  // Test for the server type.
		}
	} 
	if(osvi.dwMajorVersion == 5 && osvi.dwMinorVersion == 1){
		os << "Windows XP";
	} 
	if(osvi.dwMajorVersion == 5 && osvi.dwMinorVersion == 0){
		os << "Windows 2000";  
	}
	
	osname = toString(os.str());
	return true;

#elif defined(MAC)
	osname = "Mac OSX";
	return true;
#elif defined(IOS)
	osname = "iOS";
	return true;
#elif defined(ANDROID)
	osname = "Android";
	return true;
#elif defined(LINUX)
	osname = "Unknown";
	return true;
#endif
	DKLog("GetOSName() not inplemented on this OS \n", DKERROR);
	return false;
}

//////////////////////////////////////
bool GetOSVersion(DKString& osversion)
{
#ifdef WIN32
	OSVERSIONINFOEX osvi;
	SYSTEM_INFO si;
	BOOL bOsVersionInfoEx;
	DWORD dwType;

	ZeroMemory(&si, sizeof(SYSTEM_INFO));
	ZeroMemory(&osvi, sizeof(OSVERSIONINFOEX)); 
	osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX);
	bOsVersionInfoEx = GetVersionEx((OSVERSIONINFO*) &osvi); 

	if(bOsVersionInfoEx == 0){
		return false; // Call GetNativeSystemInfo if supported or GetSystemInfo otherwise.
	}
	PGNSI pGNSI = (PGNSI) GetProcAddress(GetModuleHandle(TEXT("kernel32.dll")), "GetNativeSystemInfo");
	if(NULL != pGNSI){
		pGNSI(&si);
	}
	else{ 
		GetSystemInfo(&si); // Check for unsupported OS
	}
	if(VER_PLATFORM_WIN32_NT != osvi.dwPlatformId || osvi.dwMajorVersion <= 4 ){
		return false;
	}
	std::wstringstream os;
	if ( osvi.dwMajorVersion == 6 ){
		if(osvi.dwMinorVersion == 0){
			if(osvi.wProductType == VER_NT_WORKSTATION){
				//os << "Windows Vista";
			}
			else{
				//os << "Windows Server 2008";
			}
		}  
		if (osvi.dwMinorVersion == 1){
			if(osvi.wProductType == VER_NT_WORKSTATION){
				//os << "Windows 7";
			}
			else{
				//os << "Windows Server 2008 R2";
			}
		}  
		PGPI pGPI = (PGPI) GetProcAddress(GetModuleHandle(TEXT("kernel32.dll")), "GetProductInfo");
		pGPI( osvi.dwMajorVersion, osvi.dwMinorVersion, 0, 0, &dwType);  
		
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
	}
	if (osvi.dwMajorVersion == 5 && osvi.dwMinorVersion == 2){
		if(GetSystemMetrics(SM_SERVERR2)){
			//os <<  "Windows Server 2003 R2";
		}
		else if (osvi.wSuiteMask & VER_SUITE_STORAGE_SERVER){
			//os <<  "Windows Storage Server 2003";
		}
		else if ( osvi.wSuiteMask & VER_SUITE_WH_SERVER ){
			//os <<  "Windows Home Server";
		}
		else if( osvi.wProductType == VER_NT_WORKSTATION && si.wProcessorArchitecture==PROCESSOR_ARCHITECTURE_AMD64){
			//os <<  "Windows XP Professional x64 Edition";
		}
		else{
			//os << "Windows Server 2003";  // Test for the server type.
		}
		if (osvi.wProductType != VER_NT_WORKSTATION){
			if(si.wProcessorArchitecture==PROCESSOR_ARCHITECTURE_IA64){
				if(osvi.wSuiteMask & VER_SUITE_DATACENTER){
					os <<  "Datacenter Edition for Itanium-based Systems";
				}
				else if(osvi.wSuiteMask & VER_SUITE_ENTERPRISE){
					os <<  "Enterprise Edition for Itanium-based Systems";
				}
			}   
			else if(si.wProcessorArchitecture==PROCESSOR_ARCHITECTURE_AMD64){
				if(osvi.wSuiteMask & VER_SUITE_DATACENTER){
					os <<  "Datacenter x64 Edition";
				}
				else if(osvi.wSuiteMask & VER_SUITE_ENTERPRISE){
					os <<  "Enterprise x64 Edition";
				}
				else{
					os <<  "Standard x64 Edition";
				}
			}
			else{
				if(osvi.wSuiteMask & VER_SUITE_COMPUTE_SERVER){
					os <<  "Compute Cluster Edition";
				}
				else if(osvi.wSuiteMask & VER_SUITE_DATACENTER){
					os <<  "Datacenter Edition";
				}
				else if(osvi.wSuiteMask & VER_SUITE_ENTERPRISE){
					os <<  "Enterprise Edition";
				}
				else if(osvi.wSuiteMask & VER_SUITE_BLADE){
					os <<  "Web Edition";
				}
				else{
					os <<  "Standard Edition";
				}
			}
		}
	} 
	if(osvi.dwMajorVersion == 5 && osvi.dwMinorVersion == 1){
		//os << "Windows XP ";
		if(osvi.wSuiteMask & VER_SUITE_PERSONAL){
			os <<  "Home Edition";
		}
		else{
			os <<  "Professional";
		}
	} 
	if(osvi.dwMajorVersion == 5 && osvi.dwMinorVersion == 0){
		//os << "Windows 2000 ";  
		if(osvi.wProductType == VER_NT_WORKSTATION){
			os <<  "Professional";
		}
		else{
			if(osvi.wSuiteMask & VER_SUITE_DATACENTER){
				os <<  "Datacenter Server";
			}
			else if(osvi.wSuiteMask & VER_SUITE_ENTERPRISE){
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
	//osversion = "Unknown";
    
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
	osversion = "Unknown";
	return true;
#elif defined(ANDROID)
	osversion = "Unknown";
	return true;
#elif defined(LINUX)
	osversion = "Unknown";
	return true;
#endif
	DKLog("GetOSVersion() not inplemented on this OS \n", DKERROR);
	return false;
}

//////////////////////////////////////////////
bool GetOSServicePack(DKString& osservicepack)
{
#ifdef WIN32
	OSVERSIONINFOEX osvi;
	SYSTEM_INFO si;
	BOOL bOsVersionInfoEx;

	ZeroMemory(&si, sizeof(SYSTEM_INFO));
	ZeroMemory(&osvi, sizeof(OSVERSIONINFOEX)); 
	osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX);
	bOsVersionInfoEx = GetVersionEx((OSVERSIONINFO*) &osvi); 

	if(bOsVersionInfoEx == 0){
		return false; // Call GetNativeSystemInfo if supported or GetSystemInfo otherwise.
	}
	PGNSI pGNSI = (PGNSI) GetProcAddress(GetModuleHandle(TEXT("kernel32.dll")), "GetNativeSystemInfo");
	if(NULL != pGNSI){
		pGNSI(&si);
	}
	else{ 
		GetSystemInfo(&si); // Check for unsupported OS
	}
	if(VER_PLATFORM_WIN32_NT != osvi.dwPlatformId || osvi.dwMajorVersion <= 4 ){
		return false;
	}
	std::wstringstream os;
	
	// Include service pack (if any). 
	if(wcslen((const wchar_t*)osvi.szCSDVersion) > 0){
		os << osvi.szCSDVersion;
	}
	else{
		os << L"Service Pack: none";
	}

	osservicepack = toString(os.str());
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
	DKLog("GetOSServicePack() not inplemented on this OS \n", DKERROR);
	return false;
}

//////////////////////////////////
bool GetOSBuild(DKString& osbuild)
{
#ifdef WIN32
	OSVERSIONINFOEX osvi;
	SYSTEM_INFO si;
	BOOL bOsVersionInfoEx;

	ZeroMemory(&si, sizeof(SYSTEM_INFO));
	ZeroMemory(&osvi, sizeof(OSVERSIONINFOEX)); 
	osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX);
	bOsVersionInfoEx = GetVersionEx((OSVERSIONINFO*) &osvi); 

	if(bOsVersionInfoEx == 0){
		return false; // Call GetNativeSystemInfo if supported or GetSystemInfo otherwise.
	}
	PGNSI pGNSI = (PGNSI) GetProcAddress(GetModuleHandle(TEXT("kernel32.dll")), "GetNativeSystemInfo");
	if(NULL != pGNSI){
		pGNSI(&si);
	}
	else{ 
		GetSystemInfo(&si); // Check for unsupported OS
	}
	if(VER_PLATFORM_WIN32_NT != osvi.dwPlatformId || osvi.dwMajorVersion <= 4 ){
		return false;
	}
	std::wstringstream os;
	
	os << L"build " << osvi.dwBuildNumber; //Get Build

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
	DKLog("GetOSBuild() not inplemented on this OS \n", DKERROR);
	return false;
}

////////////////////////////////////////////////
bool GetOSArchitecture(DKString& osarchitecture)
{
#ifdef WIN32
	OSVERSIONINFOEX osvi;
	SYSTEM_INFO si;
	BOOL bOsVersionInfoEx;

	ZeroMemory(&si, sizeof(SYSTEM_INFO));
	ZeroMemory(&osvi, sizeof(OSVERSIONINFOEX)); 
	osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX);
	bOsVersionInfoEx = GetVersionEx((OSVERSIONINFO*) &osvi); 

	if(bOsVersionInfoEx == 0){
		return false; // Call GetNativeSystemInfo if supported or GetSystemInfo otherwise.
	}
	PGNSI pGNSI = (PGNSI) GetProcAddress(GetModuleHandle(TEXT("kernel32.dll")), "GetNativeSystemInfo");
	if(NULL != pGNSI){
		pGNSI(&si);
	}
	else{ 
		GetSystemInfo(&si); // Check for unsupported OS
	}
	if(VER_PLATFORM_WIN32_NT != osvi.dwPlatformId || osvi.dwMajorVersion <= 4 ){
		return false;
	}
	std::wstringstream os;
	
	if(osvi.dwMajorVersion >= 6){
		if(si.wProcessorArchitecture==PROCESSOR_ARCHITECTURE_AMD64){
			os <<  "64-bit";
		}
		else if (si.wProcessorArchitecture==PROCESSOR_ARCHITECTURE_INTEL){
			os << "32-bit";
		}
	}
	else{
		os << "32-bit";
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
	DKLog("GetOSArchitecture() not inplemented on this OS \n", DKERROR);
	return false;
}

////////////////////////////////////////////
bool getComputerName(DKString& computername)
{
#ifdef WIN32
	TCHAR computerName[MAX_COMPUTERNAME_LENGTH + 1];
	DWORD size = sizeof(computerName) / sizeof(computerName[0]);
	GetComputerName(computerName, &size);
	computername = (DKString)computerName;
	return true;
#endif
	DKLog("getComputerName() not implemented on this OS \n", DKERROR);
	return false;
}