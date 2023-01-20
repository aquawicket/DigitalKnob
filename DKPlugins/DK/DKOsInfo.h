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

#pragma once
#ifndef DKOsInfo_H
#define DKOsInfo_H

//WARNING_DISABLE
#if WIN
	#include "windows.h"
	#include <sstream>
#endif
//WARNING_ENABLE
	
#if WIN
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
#endif

#include "DK/DKLog.h"


bool GetOSFlag(DKString& flag);
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