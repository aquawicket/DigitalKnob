#pragma once
#ifndef DKOsInfo_H
#define DKOsInfo_H

#include "DKLog.h"

#ifdef WIN32
#include "windows.h"
#include <sstream>
typedef void (WINAPI *PGNSI)(LPSYSTEM_INFO);
typedef BOOL (WINAPI *PGPI)(DWORD, DWORD, DWORD, DWORD, PDWORD);
#define PRODUCT_PROFESSIONAL	0x00000030
#define VER_SUITE_WH_SERVER	0x00008000
#endif //WIN32

bool GetOSInfo(DKString& info);
bool GetSystemOS(DKString& os);
bool GetOSCompany(DKString& oscompany);
bool GetOSName(DKString& osname);
bool GetOSVersion(DKString& osversion);
bool GetOSServicePack(DKString& osservicepack);
bool GetOSBuild(DKString& osbuild);
bool GetOSArchitecture(DKString& osarchitecture);
bool getComputerName(DKString& computername);

#endif //DKOsInfo_H