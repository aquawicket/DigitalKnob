#pragma once
#ifndef DKOsInfo_H
#define DKOsInfo_H

#include "DKLog.h"

#ifdef WIN32
#include "windows.h"
#include <sstream>

typedef LONG NTSTATUS, * PNTSTATUS;
#define STATUS_SUCCESS (0x00000000)
typedef BOOL(WINAPI* LPFN_ISWOW64PROCESS)(HANDLE, PBOOL);
typedef BOOL(WINAPI* ProductInfoPtr)(DWORD, DWORD, DWORD, DWORD, PDWORD);
typedef NTSTATUS(WINAPI* RtlGetVersionPtr)(PRTL_OSVERSIONINFOEXW);
typedef NTSTATUS(WINAPI* SYSTEM_INFO_Ptr)(LPSYSTEM_INFO);
#define PRODUCT_PROFESSIONAL	0x00000030
#define VER_SUITE_WH_SERVER	0x00008000
bool GetWinOSVersion(RTL_OSVERSIONINFOEXW& vi);
bool GetWinSystemInfo(SYSTEM_INFO& si);
bool GetWinProductInfo(RTL_OSVERSIONINFOEXW& vi, DWORD& dwType);
#endif //WIN32

bool GetOSInfo(DKString& info);
bool GetSystemOS(DKString& os);
bool GetOSCompany(DKString& oscompany);
bool GetOSName(DKString& osname);
bool GetOSVersion(DKString& osversion);
bool GetOSServicePack(DKString& osservicepack);
bool GetOSBuild(DKString& osbuild);
bool GetOSArchitecture(DKString& osarchitecture);
bool GetComputerName(DKString& computername);

#endif //DKOsInfo_H