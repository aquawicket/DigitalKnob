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
#ifndef DKUtil_H
#define DKUtil_H

#include "DK/DKString.h"

//WARNING_DISABLE
#ifndef WIN
	#include <limits.h>
	#include <stdlib.h>
#endif
//WARNING_ENABLE

#define FRAME_VALUES 30

class DKUtil{
public:
	//PC speaker beep
	static bool Beep();
	static bool Bin2C(const DKString& input, const DKString& output);
	static bool C2Bin(const DKString hex, std::streamsize size, const char* fileOut);
	static bool CallExit();
	static bool CpuUsed(int& cpu);
	static bool CpuUsedByApp(int& cpu);
	static bool DoubleClick();
	static bool DrawTextOnScreen(const DKString& text);
	
	//Basically popen. Takes same parameters along with a return result value for pipes. 
	static bool Execute(const DKString& command, const DKString& mode, DKString& stdouterr, int& rtncode);
	static bool FindImageOnScreen(const DKString& file, int& x, int& y);
	static bool GetClipboard(DKString& text);
	static bool GetDate(DKString& date);
	static bool GetFps(unsigned int& fps);
	static bool GetFramerate(int& framerate);
	static bool GetFrames(unsigned long& frames);
	static bool GetKey(int& key);
	static bool GetLocalIP(DKString& ip);
	static bool GetMousePos(int& x, int& y);
	static bool GetPixelFromImage(const DKString& image, int x, int y);
	static bool GetPixelFromScreen(int x, int y, int& r, int& g, int& b);
	static bool GetProcessList(DKString& list);
	static bool GetScreenHeight(int& h);
	static bool GetScreenWidth(int& w);
	static bool GetThreadId(unsigned long int& id);
	static bool GetTicks(long& ticks);
	static bool GetTime(DKString& _time);
	static bool GetUsername(DKString& username);
	static bool GetVolume(int& percent);
	static bool InMainThread();
	static bool InitFps();
	static bool InitFramerate();
	static bool KeyIsDown(int& key);
	static bool LeftClick();
	static bool LeftPress();
	static bool LeftRelease();
	static bool LimitFramerate();
	static bool LowPowerMonitor();
	static bool MiddlePress();
	static bool MiddleRelease();
	static bool PhysicalMemory(unsigned long long& physicalMemory);
	static bool PhysicalMemoryUsed(unsigned long long& physicalMemory);
	static bool PhysicalMemoryUsedByApp(unsigned long long& physicalMemory);
	static bool PressKey(const unsigned short& key);
	static bool ReleaseKey(const unsigned short& key);
	static bool RightClick();
	static bool RightPress();
	static bool RightRelease();
	static bool Round(double& num);
	static bool Run(const DKString& command, const DKString& params);
	static bool SetBrightness(const int& percent);
	static bool SendTick();
	static bool SetClipboard(const DKString& text);
	static bool SetClipboardFiles(const DKString& filelist);
	static bool SetClipboardImage(const DKString& file);
	static bool SetFramerate(const int& fps);
	static bool SetMainThreadNow(); //ONLY SET THIS FROM THE MAIN THREAD ONCE
	static bool SetMousePos(const int& x, const int& y);
	static bool SetVolume(int& percent);
	static bool Sleep(const int& milliseconds);
	static bool StrokeKey(const unsigned short& key);
	static bool System(const DKString& command, int& rtnvalue);
	static bool TurnOffMonitor();
	static bool TurnOnMonitor();
	static bool UpdateFps();
	static bool VirtualMemory(unsigned long long& virtualMemory);
	static bool VirtualMemoryUsed(unsigned long long& virtualMemory);
	static bool VirtualMemoryUsedByApp(unsigned long long& virtualMemory);
	static bool WaitForImage(const DKString& file, int timeout);
	static bool WheelDown();
	static bool WheelUp();

	static unsigned long int mainThreadId;

	//Frame limiter
	static long now;
	static long lastFrame;
	static int _fps;
	static int ticksPerFrame;
	static long lastSecond;

	static long frametimes[FRAME_VALUES]; // An array to store frame times:
	static long frametimelast; // Last calculated SDL_GetTicks
	static long framecount; // total frames rendered
	static float framespersecond;
};

#endif //DKUtil_H
