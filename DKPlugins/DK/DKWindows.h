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

#if WIN
#pragma once
#ifndef DKWindows_H
#define DKWindows_H

#define WIN32_LEAN_AND_MEAN

WARNING_DISABLE
#include <windows.h>
#include "pdh.h"
WARNING_ENABLE

#include "DK/DKString.h"


const int MB = 1048576; // A megabyte is 1,048,576 bytes
static PDH_HQUERY cpuQuery;
static PDH_HCOUNTER cpuTotal;
static ULARGE_INTEGER lastCPU, lastSysCPU, lastUserCPU;
static int numProcessors;
static HANDLE _self;
static bool cpuInit = false;

class DKWindows{
public:
	static bool WINAPI ConsoleHandler(DWORD type);
	static bool CpuInit();
	static bool CpuUsed(int& cpu);
	static bool CpuUsedByApp(int& cpu);
	static bool CreateConsoleHandler();
	static bool DrawTextOnScreen(const DKString& text);
	static bool FindImageOnScreen(const DKString& file, int& x, int& y);
	static bool GetClipboard(DKString& text);
	static bool GetKey(int& key);
	static bool GetLastError(DKString& error);
	static bool GetLocalIP(DKString& ip);
	static bool GetMousePos(int& x, int& y);
	static bool GetPixelFromImage(const DKString& image, int x, int y);
	static bool GetPixelFromScreen(int x, int y, int& r, int& g, int& b);
	static bool GetProcessList(DKString& list);
	static bool GetScreenWidth(int& w);
	static bool GetScreenHeight(int& h);
	static bool GetUsername(DKString& username);
	static bool GetVolume(int& percent);
	static bool KeyIsDown(const int& key);
	static bool LeftClick();
	static bool LeftPress();
	static bool LeftRelease();
	static bool LowPowerMonitor();
	static bool MiddlePress();
	static bool MiddleRelease();
	static bool PhysicalMemory(unsigned long long& physicalMemory);
	static bool PhysicalMemoryUsed(unsigned long long& physicalMemory);
	static bool PhysicalMemoryUsedByApp(unsigned long long& physicalMemory);
	static bool PressKey(WORD key);
	static bool RefreshWindowsEnvironment();
	static bool ReleaseKey(WORD key);
	static bool RightClick();
	static bool RightPress();
	static bool RightRelease();
	static bool Run(const DKString& command);
	static bool SetBrightness(const int& percent);
	static bool SetClipboard(const DKString& text);
	static bool SetClipboardFiles(const DKString& filelist);
	static bool SetClipboardImage(const DKString& file);
	static bool SetMousePos(const int& x, const int& y);
	static bool SetTitle(const DKString& title);
	static bool SetVolume(int& percent);
	static bool Sleep(int milliseconds);
	static bool StrokeKey(const WORD& key);
	static bool TurnOffMonitor();
	static bool TurnOnMonitor();
	static bool VirtualMemory(unsigned long long& virtualMemory);
	static bool VirtualMemoryUsed(unsigned long long& virtualMemory);
	static bool VirtualMemoryUsedByApp(unsigned long long& virtualMemory);
	static bool WaitForImage(const DKString& file, int timeout);
	static bool WheelDown();
	static bool WheelUp();
	
	static HINSTANCE hInstance;
	static HWND consoleWindow;
};

#endif //DKWindows_H
#endif //WIN32
