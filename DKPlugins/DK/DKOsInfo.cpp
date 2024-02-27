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

//https://stackoverflow.com/a/36545162/688352
//https://en.wikipedia.org/wiki/List_of_Microsoft_Windows_versions
#include "DK/stdafx.h"
#include "DK/DKOsInfo.h"

//WARNING_DISABLE
#if MAC
#import <CoreServices/CoreServices.h>
#endif
//WARNING_ENABLE

bool GetOSFlag(DKString& flag){
#if WIN_X86
	flag = "WIN_X86";
#endif
#if WIN64
	flag = "WIN64";
#endif
#if MAC_X86
	flag = "MAC_X86";
#endif
#if MAC_X86_64
	flag = "MAC_X86_64";
#endif
#if IOS_ARM32
	flag = "IOS_ARM32";
#endif
#if IOS_ARM64
	flag = "IOS_ARM64";
#endif
#if LINUX_X86
	flag = "LINUX_X86";
#endif
#if LINUX_X86_64
	flag = "LINUX_X86_64";
#endif
#if RASPBERRY_ARM32
	flag = "RASPBERRY_ARM32";
#endif
#if RASPBERRY_ARM64
	flag = "RASPBERRY_ARM64";
#endif
#if ANDROID_ARM32
	flag = "ANDROID_ARM32";
#endif
#if ANDROID_ARM64
	flag = "ANDROID_ARM64";
#endif
#if EMSCRIPTEN
	flag = "EMSCRIPTEN";
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
#if WIN
	os = "Windows";
#endif
#if MAC
	os = "Mac";
#endif
#if IOS
	os = "iOS";
#endif
#if RASPBERRY
	os = "Raspberry";
#elif LINUX
	os = "Linux";
#endif
#if ANDROID
	os = "Android";
#endif
#if EMSCRIPTEN
	os = "Emscripten";
#endif
	if(os.empty())
		return DKERROR("cound not get the OS\n");
	return true;
}

bool GetOSCompany(DKString& oscompany){ 
#if WIN
	oscompany = "Microsoft";
	return true;
#elif MAC
	oscompany = "Apple";
	return true;
#elif IOS
	oscompany = "Apple";
	return true;
#elif ANDROID
	oscompany = "Google";
	return true;
#elif LINUX
	oscompany = "Linux";
	return true;
#elif EMSCRIPTEN
	oscompany = "Emscripten";
	return true;
#else
	return DKERROR("not implemented on this OS \n");
#endif
}

bool GetOSName(DKString& osname){
#if WIN
	RTL_OSVERSIONINFOEXW vi;
	if(!GetWinOSVersion(vi))
		return DKERROR("!GetWinOSVersion(vi)\n")
	SYSTEM_INFO si;
	GetWinSystemInfo(si);
	std::wstringstream os;
	if (vi.dwMajorVersion == 10){
		if (vi.dwMinorVersion == 0){
			if (vi.wProductType == VER_NT_WORKSTATION)
				os << "Windows 10";
			else
				os << "Windows Server 2019";
		}
	}
	if(vi.dwMajorVersion == 6){
		if (vi.dwMinorVersion == 3){
			if (vi.wProductType == VER_NT_WORKSTATION)
				os << "Windows 8.1";
			else
				os << "Windows Server 2012 R2";
		}
		if (vi.dwMinorVersion == 2){
			if (vi.wProductType == VER_NT_WORKSTATION)
				os << "Windows 8";
			else
				os << "Windows Server 2012";
		}
		if (vi.dwMinorVersion == 1){
			if (vi.wProductType == VER_NT_WORKSTATION)
				os << "Windows 7";
			else
				os << "Windows Server 2008 R2";
		}
		if (vi.dwMinorVersion == 0){
			if (vi.wProductType == VER_NT_WORKSTATION)
				os << "Windows Vista";
			else
				os << "Windows Server 2008";
		}
	}
	if (vi.dwMajorVersion == 5 && vi.dwMinorVersion == 2){
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
#elif MAC
	osname = "MacOSX";
	return true;
#elif IOS
	osname = "iOS";
	return true;
#elif ANDROID
	osname = "Android";
	return true;
#elif LINUX
	osname = "Linux";
	return true;
#elif EMSCRIPTEN
	osname = "Emscripten";
	return true;
#else
	return DKERROR("not implemented on this OS \n");
#endif
}

bool GetOSVersion(DKString& osversion){
#if WIN
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
#elif MAC
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
#elif IOS
	osversion = "";
	return true;
#elif ANDROID
	osversion = "";
	return true;
#elif LINUX
	osversion = "";
	return true;
#elif EMSCRIPTEN
	osversion = "";
	return true;
#else
	return DKERROR("not inplemented on this OS \n");
#endif
}

bool GetOSServicePack(DKString& osservicepack){
#if WIN
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
#elif MAC
	osservicepack = "";
	return true;
#elif IOS
	osservicepack = "";
	return true;
#elif ANDROID
	osservicepack = "";
	return true;
#elif LINUX
	osservicepack = "";
	return true;
#elif EMSCRIPTEN
	osservicepack = "";
	return true;
#else
	return DKERROR("not inplemented on this OS\n");
#endif
}

bool GetOSBuild(DKString& osbuild){
#if WIN
	RTL_OSVERSIONINFOEXW vi;
	if (!GetWinOSVersion(vi))
		return DKERROR("GetWinOSVersion() failed\n");
	std::wstringstream os;
	os << L"build " << vi.dwMajorVersion << "." << vi.dwMinorVersion << "." << vi.dwBuildNumber;
	osbuild = toString(os.str());
	return true;
#elif MAC
	osbuild = "";
	return true;
#elif IOS
	osbuild = "";
	return true;
#elif ANDROID
	osbuild = "";
	return true;
#elif LINUX
	osbuild = "";
	return true;
#elif EMSCRIPTEN
	osbuild = "";
	return true;
#else
	return DKERROR("not inplemented on this OS \n");
#endif
}

bool GetOSArchitecture(DKString& osarchitecture){
#if WIN
	RTL_OSVERSIONINFOEXW vi;
	if (!GetWinOSVersion(vi))
		return DKERROR("GetWinOSVersion() failed\n");
	SYSTEM_INFO si;
	GetWinSystemInfo(si);
	std::wstringstream os;
	if((vi.dwMajorVersion == 5 && vi.dwMinorVersion >= 2) || vi.dwMajorVersion >= 6){
		if (si.wProcessorArchitecture == PROCESSOR_ARCHITECTURE_AMD64){
			os << "64";
		}
		else {
			BOOL bIsWow64 = FALSE;
			LPFN_ISWOW64PROCESS fnIsWow64Process;
			fnIsWow64Process = (LPFN_ISWOW64PROCESS)GetProcAddress(GetModuleHandle(TEXT("kernel32")), "IsWow64Process");
			if (NULL != fnIsWow64Process){
				if (!fnIsWow64Process(GetCurrentProcess(), &bIsWow64)){
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
#elif MAC
	osarchitecture = "";
	return true;
#elif IOS
	osarchitecture = "";
	return true;
#elif ANDROID
	osarchitecture = "";
	return true;
#elif LINUX
	osarchitecture = "";
	return true;
#elif EMSCRIPTEN
	osarchitecture = "";
	return true;
#else
	return DKERROR("not inplemented on this OS \n");
#endif
}

////////////////////////////////////////////
bool GetComputerName(DKString& computername){
#if WIN
	TCHAR computerName[MAX_COMPUTERNAME_LENGTH + 1];
	DWORD size = sizeof(computerName) / sizeof(computerName[0]);
	GetComputerName(computerName, &size);
	computername = (DKString)computerName;
	return true;
#else
	return DKERROR("not implemented on this OS \n");
#endif
}

#if WIN
bool GetWinOSVersion(RTL_OSVERSIONINFOEXW& vi){
	ZeroMemory(&vi, sizeof(RTL_OSVERSIONINFOEXW));
	HMODULE hMod = ::GetModuleHandleW(L"ntdll.dll");
	if(hMod){
		RtlGetVersionPtr fxPtr = (RtlGetVersionPtr)::GetProcAddress(hMod, "RtlGetVersion");
		if(fxPtr != nullptr){
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

bool GetWinSystemInfo(SYSTEM_INFO& si){
	ZeroMemory(&si, sizeof(SYSTEM_INFO));
	HMODULE hMod = ::GetModuleHandleW(L"kernel32.dll");
	if (hMod){
		SYSTEM_INFO_Ptr fxPtr = (SYSTEM_INFO_Ptr)::GetProcAddress(hMod, "GetNativeSystemInfo");
		if (fxPtr != nullptr){
			si = { 0 };
			if (STATUS_SUCCESS == fxPtr(&si)){
				return true;
			}
		}
	}
	si = { 0 };
	return false;
}

bool GetWinProductInfo(RTL_OSVERSIONINFOEXW& vi, DWORD& dwType){
	HMODULE hMod = ::GetModuleHandleW(L"kernel32.dll");
	if (hMod){
		ProductInfoPtr fxPtr = (ProductInfoPtr)::GetProcAddress(hMod, "GetProductInfo");
		if (fxPtr != nullptr){
			fxPtr(vi.dwMajorVersion, vi.dwMinorVersion, 0, 0, &dwType);
			return true;
		}
	}
	return false;
}

#endif //WIN
