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
#ifndef DKHook_H
#define DKHook_H

#include "DK/DK.h"


//Functions in DKHookDLL.dll
//typedef bool(*InstallHook)(unsigned long);
//typedef bool(*UnInstallHook)();

class DKHook : public DKObjectT<DKHook>
{
public:
	bool Init();
	bool End();

#if LINUX
	void LinuxHook();
	int fd, bytes;
	unsigned char _data[3];
	int left, middle, right;
	signed char x, y;
#endif

#if WIN
	void InstallHook(); // function to install our hook
	void UninstallHook(); // function to uninstall our hook
	int Messsages(); // function to "deal" with our messages 

	static HHOOK hook; // handle to the hook
	MSG msg; // struct with information about all messages in our queue
	//HMODULE hModule;  //dll module
#endif
};

#if WIN
LRESULT WINAPI MyMouseCallback(int nCode, WPARAM wParam, LPARAM lParam);
LRESULT WINAPI MyKeyboardCallback(int nCode, WPARAM wParam, LPARAM lParam);
#endif //WIN32

REGISTER_OBJECT(DKHook, true);
#endif //DKHook_H
