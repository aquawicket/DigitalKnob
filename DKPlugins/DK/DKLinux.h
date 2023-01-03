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
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#ifdef LINUX
#pragma once
#ifndef DKLinux_H
#define DKLinux_H

#include "DK/DKString.h"

// http://xahlee.info/linux/linux_show_keycode_keysym.html
// https://github.com/depp/keycode
// https://eklitzke.org/blocking-io-nonblocking-io-and-epoll

class DKLinux{
public:
	static bool CpuInit();
	static bool CpuUsed(int& cpu);
	static bool CpuUsedByApp(int& cpu);
	static bool GetClipboard(DKString& text);
	static bool GetKey(int& key);
	static bool GetMousePos(int& x, int& y);
	static bool SetMousePos(const int& x, const int& y);
	static bool GetScreenWidth(int& w);
	static bool GetScreenHeight(int& h);
	static bool GetVolume(int& percent);
	static bool KeyIsDown(int& key);
	static bool LeftPress();
	static bool LeftRelease();
	static bool RightPress();
	static bool RightRelease();
	static bool MiddlePress();
	static bool MiddleRelease();
	static bool PressKey(int key);
	static bool ReleaseKey(int key);
	static bool LowPowerMonitor();
	static bool PhysicalMemory(unsigned long long& physicalMemory);
	static bool PhysicalMemoryUsed(unsigned long long& physicalMemory);
	static bool PhysicalMemoryUsedByApp(unsigned long long& physicalMemory);
	static bool Run(const DKString& command, int& rtnvalue);
	static bool SetClipboard(const DKString& text);
	static bool SetVolume(double nVolume);
	static bool StrokeKey(const int& key);
	static bool TurnOffMonitor(int& rtnvalue);
	static bool TurnOnMonitor();
	static bool VirtualMemory(unsigned long long& virtualMemory);
	static bool VirtualMemoryUsed(unsigned long long& virtualMemory);
	static bool VirtualMemoryUsedByApp(unsigned long long& virtualMemory);
};

#endif //DKLinux_H
#endif //LINUX
