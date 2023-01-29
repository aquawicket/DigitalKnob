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

#include "DK/stdafx.h"
#if LINUX
#include "DK/DKLinux.h"
#include "DK/DKUnix.h"
#include "DK/DKLog.h"

//WARNING_DISABLE
#include <stdio.h>
#include <stdlib.h>
#include <X11/Xlib.h>
#include <X11/XKBlib.h>
#include <X11/extensions/XTest.h>  //requires libxtst-dev
#include <alsa/asoundlib.h>
#include <unistd.h>         
#include <termios.h>               //for system()
//WARNING_ENABLE


bool DKLinux::GetKey(int& key){
	DKDEBUGRETURN(key);
	return DKUnix::GetKey(key);
}

bool DKLinux::GetMousePos(int& x, int& y){
	DKDEBUGFUNC(x, y);
	//Compile with:
    //cc -Wall -I/usr/X11R6/include -L/usr/X11R6/lib -lXm -o xquerypointer xquerypointer.c
	//or on solaris:
    //cc -I/usr/openwin/include xquerypointer.c -L/usr/openwin/lib -lX11
	Display *dpy;
	Window root;
	Window ret_root;
	Window ret_child;
	int root_x;
	int root_y;
	int win_x;
	int win_y;
	unsigned int mask;
	dpy = XOpenDisplay(NULL);
	root = XDefaultRootWindow(dpy);
	if(XQueryPointer(dpy, root, &ret_root, &ret_child, &root_x, &root_y, &win_x, &win_y, &mask)){
		// original version
		//    printf("root loc: %4d,%4d win loc: %3d,%3d mask: 0x%08X\n", root_x, root_y, win_x, win_y, mask);
		// This returns in -geometry format
		// I added \n so it actually shows something so people who test it know it works.
		x = root_x;
		y = root_y;
		return true;
	}
	return false;
}

bool DKLinux::SetMousePos(const int& x, const int& y){
	DKDEBUGFUNC(x, y);
#if HAVE_libx11_dev
	Display *dpy = XOpenDisplay(0);
	Window root = XRootWindow(dpy, 0);
	XSelectInput(dpy, root, KeyReleaseMask);
	XWarpPointer(dpy, None, root, 0, 0, 0, 0, x, y);
	XFlush(dpy); // Flushes the output buffer, therefore updates the cursor's position.
	return true;
#else
	return DKERROR("!HAVE_libx11_dev");
#endif
}

bool DKLinux::LeftPress(){
	DKDEBUGFUNC();
#if HAVE_libx11_dev
	Display *display = XOpenDisplay(NULL);
	XTestFakeButtonEvent(display, 1, true, 0);
	XFlush(display);
	XCloseDisplay(display);
	return true;
#else
	return DKERROR("!HAVE_libx11_dev");
#endif
}

bool DKLinux::LeftRelease(){
	DKDEBUGFUNC();
#if HAVE_libx11_dev
	Display *display = XOpenDisplay(NULL);
	XTestFakeButtonEvent(display, 1, false, 0);
	XFlush(display);
	XCloseDisplay(display);
	return true;
#else
	return DKERROR("!HAVE_libx11_dev");
#endif
}

bool DKLinux::RightPress(){
	DKDEBUGFUNC();
#if HAVE_libx11_dev
	Display *display = XOpenDisplay(NULL);
	XTestFakeButtonEvent(display, 3, true, 0);
	XFlush(display);
	XCloseDisplay(display);
	return true;
#else
	return DKERROR("!HAVE_libx11_dev");
#endif
}

bool DKLinux::RightRelease(){
	DKDEBUGFUNC();
#if HAVE_libx11_dev
	Display *display = XOpenDisplay(NULL);
	XTestFakeButtonEvent(display, 3, false, 0);
	XFlush(display);
	XCloseDisplay(display);
	return true;
#else
	return DKERROR("!HAVE_libx11_dev");
#endif
}

bool DKLinux::MiddlePress(){
	DKDEBUGFUNC();
#if HAVE_libx11_dev
	Display *display = XOpenDisplay(NULL);
	XTestFakeButtonEvent(display, 2, true, 0);
	XFlush(display);
	XCloseDisplay(display);
	return true;
#else
	return DKERROR("!HAVE_libx11_dev");
#endif
}

bool DKLinux::MiddleRelease(){
	DKDEBUGFUNC();
#if HAVE_libx11_dev
	Display *display = XOpenDisplay(NULL);
	XTestFakeButtonEvent(display, 2, false, 0);
	XFlush(display);
	XCloseDisplay(display);
	return true;
#else
	return DKERROR("!HAVE_libx11_dev");
#endif
}

bool DKLinux::PressKey(int key){
	DKDEBUGFUNC(key);
#if HAVE_libx11_dev
	Display *display = XOpenDisplay(NULL);
	XTestFakeKeyEvent(display, key, true, 0);
	XFlush(display);
	XCloseDisplay(display);
	return true;
#else
	return DKERROR("!HAVE_libx11_dev");
#endif
}

bool DKLinux::ReleaseKey(int key){
	DKDEBUGFUNC(key);
#if HAVE_libx11_dev
	Display *display = XOpenDisplay(NULL);
	XTestFakeKeyEvent(display, key, false, 0);
	XFlush(display);
	XCloseDisplay(display);
	return true;
#else
	return DKERROR("!HAVE_libx11_dev");
#endif
}

bool DKLinux::GetScreenWidth(int& w){
	DKDEBUGFUNC(w);
	Display* d = XOpenDisplay(NULL);
	Screen* s = DefaultScreenOfDisplay(d);
	w = s->width;
	return true;
}

bool DKLinux::GetScreenHeight(int& h){
	DKDEBUGFUNC(h);
	Display* d = XOpenDisplay(NULL);
	Screen* s = DefaultScreenOfDisplay(d);
	h = s->height;
	return true;
}

bool DKLinux::Run(const DKString& command, int& rtnvalue){
	DKDEBUGFUNC(command, rtnvalue);
	DKString cmd = command;
	cmd = "xdg-open "+cmd+" &";
	return DKUtil::System(cmd.c_str(), rtnvalue);
}

bool DKLinux::KeyIsDown(int& key){
	DKDEBUGFUNC(key);
#if HAVE_libx11_dev
	XkbStateRec r;
    Display* d = XOpenDisplay(NULL);
    XkbGetState(d, XkbUseCoreKbd, &r);
    //printf("mod: 0x%x\n", r.mods);
	if((r.mods & 0x01) && key == 16) //Shift
		return true;
	if((r.mods & 0x04) && key == 17) //Ctrl
		return true;
	if((r.mods & 0x08) && key == 18) //Alt
		return true;
    XCloseDisplay(d);
	return false;
#else
	return DKERROR("!HAVE_libx11_dev");
#endif
}

bool DKLinux::GetClipboard(DKString& text){
	DKDEBUGFUNC(text);
	//TODO
	return DKClass::CallFunc("DKSDLWindow::GetClipboard", NULL, &text);
}

bool DKLinux::SetClipboard(const DKString& text){
	DKDEBUGFUNC(text);
	//TODO
	return DKClass::CallFunc("DKSDLWindow::SetClipboard", &text);
}

bool DKLinux::SetVolume(double nVolume){
	DKDEBUGFUNC(nVolume);
#if HAVE_libasound2_dev
	long min, max;
	snd_mixer_t *handle;
	snd_mixer_selem_id_t *sid;
	const char *card = "default";
	const char *selem_name = "Master";
	snd_mixer_open(&handle, 0);
	snd_mixer_attach(handle, card);
	snd_mixer_selem_register(handle, NULL, NULL);
	snd_mixer_load(handle);
	snd_mixer_selem_id_alloca(&sid);
	snd_mixer_selem_id_set_index(sid, 0);
	snd_mixer_selem_id_set_name(sid, selem_name);
	snd_mixer_elem_t* elem = snd_mixer_find_selem(handle, sid);
	snd_mixer_selem_get_playback_volume_range(elem, &min, &max);
	snd_mixer_selem_set_playback_volume_all(elem, nVolume/* * max / 100*/);
	snd_mixer_close(handle);
	return true;
#else
	return DKERROR("!HAVE_libasound2_dev\n");
#endif
}


bool DKLinux::StrokeKey(const int& key){
	DKDEBUGFUNC(key);
	PressKey(key);
	return ReleaseKey(key);
}

bool DKLinux::GetVolume(int& percent){
	DKDEBUGFUNC(percent);
#if HAVE_libasound2_dev
	long min, max;
	snd_mixer_t *handle;
	snd_mixer_selem_id_t *sid;
	const char *card = "default";
	const char *selem_name = "Master";
	snd_mixer_open(&handle, 0);
	snd_mixer_attach(handle, card);
	snd_mixer_selem_register(handle, NULL, NULL);
	snd_mixer_load(handle);
	snd_mixer_selem_id_alloca(&sid);
	snd_mixer_selem_id_set_index(sid, 0);
	snd_mixer_selem_id_set_name(sid, selem_name);
	snd_mixer_elem_t* elem = snd_mixer_find_selem(handle, sid);
	snd_mixer_selem_get_playback_volume_range(elem, &min, &max);
	DKINFO("DKLinux::GetVolume(): min="+toString(min)+" max="+toString(max)+"\n");
	long int vol;
	snd_mixer_selem_get_playback_volume(elem, SND_MIXER_SCHN_FRONT_LEFT, &vol);
	percent = vol * 100;
	DKINFO("DKLinux::GetVolume(): returned "+toString(percent)+"\n");
	snd_mixer_close(handle);
	return true;
#else
	return DKERROR("!HAVE_libasound2_dev\n");
#endif
}


bool DKLinux::VirtualMemory(unsigned long long& virtualMemory){
	DKDEBUGFUNC(virtualMemory);
	//TODO
	/*
	#include "sys/types.h"
	#include "sys/sysinfo.h"
	struct sysinfo memInfo;
	sysinfo (&memInfo);
	long long totalVirtualMem = memInfo.totalram;
	//Add other values in next statement to avoid int overflow on right hand side...
	totalVirtualMem += memInfo.totalswap;
	totalVirtualMem *= memInfo.mem_unit;
	virtualMemory = totalVirtualMem;
	*/
	return DKERROR("not implemented\n");
}

bool DKLinux::VirtualMemoryUsed(unsigned long long& virtualMemory){
	DKDEBUGFUNC(virtualMemory);
	//TODO
	/*
	long long virtualMemUsed = memInfo.totalram - memInfo.freeram;
	//Add other values in next statement to avoid int overflow on right hand side...
	virtualMemUsed += memInfo.totalswap - memInfo.freeswap;
	virtualMemUsed *= memInfo.mem_unit;
	virtualMemory = virtualMemUsed;
	*/
	return DKERROR("not implemented\n");
}

bool DKLinux::VirtualMemoryUsedByApp(unsigned long long& virtualMemory){
	DKDEBUGFUNC(virtualMemory);
	//TODO
	/*
	#include "stdlib.h"
	#include "stdio.h"
	#include "string.h"
	int parseLine(char* line){
	    // This assumes that a digit will be found and the line ends in " Kb".
	    int i = strlen(line);
	    const char* p = line;
	    while (*p <'0' || *p > '9') p++;
	    line[i-3] = '\0';
	    i = atoi(p);
	    return i;
	}
	int getValue(){ //Note: this value is in KB!
		FILE* file = fopen("/proc/self/status", "r");
		int result = -1;
		char line[128];
		while (fgets(line, 128, file) != NULL){
		    if (strncmp(line, "VmSize:", 7) == 0){
		        result = parseLine(line);
		        break;
		    }
		}
		fclose(file);
		return result;
	}
	*/
	return DKERROR("not implemented\n");
}

bool DKLinux::PhysicalMemory(unsigned long long& physicalMemory){
	DKDEBUGFUNC(physicalMemory);
	//TODO
	/*
	long long totalPhysMem = memInfo.totalram;
	//Multiply in next statement to avoid int overflow on right hand side...
	totalPhysMem *= memInfo.mem_unit;
	physicalMemory = totalPhysMem;
	*/
	return DKERROR("not implemented\n");
}

bool DKLinux::PhysicalMemoryUsed(unsigned long long& physicalMemory){
	DKDEBUGFUNC(physicalMemory);
	//TODO
	/*
	long long physMemUsed = memInfo.totalram - memInfo.freeram;
	//Multiply in next statement to avoid int overflow on right hand side...
	physMemUsed *= memInfo.mem_unit;
	physicalMemory = physMemUsed;
	*/
	return DKERROR("not implemented\n");
}

bool DKLinux::PhysicalMemoryUsedByApp(unsigned long long& physicalMemory){
	DKDEBUGFUNC(physicalMemory);
	//TODO
	/*
	#include "stdlib.h"
	#include "stdio.h"
	#include "string.h"
	int parseLine(char* line){
		// This assumes that a digit will be found and the line ends in " Kb".
		int i = strlen(line);
		const char* p = line;
		while (*p <'0' || *p > '9') p++;
		line[i-3] = '\0';
		i = atoi(p);
		return i;
	}
	int getValue(){ //Note: this value is in KB!
		FILE* file = fopen("/proc/self/status", "r");
		int result = -1;
		char line[128];
		while (fgets(line, 128, file) != NULL){
			if (strncmp(line, "VmRSS:", 6) == 0){
				result = parseLine(line);
				break;
			}
		}
		fclose(file);
		return result;
	}
	*/
	return DKERROR("not implemented\n");
}

bool DKLinux::CpuInit(){
	DKDEBUGFUNC();
	//TODO
	return DKERROR("not implemented\n");
}

bool DKLinux::CpuUsed(int& cpu){
	DKDEBUGFUNC(cpu);
	//TODO
	/*
	#include "stdlib.h"
	#include "stdio.h"
	#include "string.h"
	static unsigned long long lastTotalUser, lastTotalUserLow, lastTotalSys, lastTotalIdle;
	void init(){
		FILE* file = fopen("/proc/stat", "r");
		fscanf(file, "cpu %llu %llu %llu %llu", &lastTotalUser, &lastTotalUserLow, &lastTotalSys, &lastTotalIdle);
		fclose(file);
	}
	double getCurrentValue(){
		double percent;
		FILE* file;
		unsigned long long totalUser, totalUserLow, totalSys, totalIdle, total;
		file = fopen("/proc/stat", "r");
		fscanf(file, "cpu %llu %llu %llu %llu", &totalUser, &totalUserLow, &totalSys, &totalIdle);
		fclose(file);
		if(totalUser < lastTotalUser || totalUserLow < lastTotalUserLow || totalSys < lastTotalSys || totalIdle < lastTotalIdle){
			//Overflow detection. Just skip this value.
			percent = -1.0;
		}
		else{
			total = (totalUser - lastTotalUser) + (totalUserLow - lastTotalUserLow) + (totalSys - lastTotalSys);
			percent = total;
			total += (totalIdle - lastTotalIdle);
			percent /= total;
			percent *= 100;
		}
		lastTotalUser = totalUser;
		lastTotalUserLow = totalUserLow;
		lastTotalSys = totalSys;
		lastTotalIdle = totalIdle;
		return percent;
	}
	*/
	return DKERROR("not implemented\n");
}

bool DKLinux::CpuUsedByApp(int& cpu){
	DKDEBUGFUNC(cpu);
	//TODO
	/*
	#include "stdlib.h"
	#include "stdio.h"
	#include "string.h"
	#include "sys/times.h"
	#include "sys/vtimes.h"
	static clock_t lastCPU, lastSysCPU, lastUserCPU;
	static int numProcessors;
	void init(){
		FILE* file;
		struct tms timeSample;
		char line[128];
		lastCPU = times(&timeSample);
		lastSysCPU = timeSample.tms_stime;
		lastUserCPU = timeSample.tms_utime;
		file = fopen("/proc/cpuinfo", "r");
		numProcessors = 0;
		while(fgets(line, 128, file) != NULL){
			if(strncmp(line, "processor", 9) == 0) numProcessors++;
		}
		fclose(file);
	}
	double getCurrentValue(){
		struct tms timeSample;
		clock_t now;
		double percent;
		now = times(&timeSample);
		if(now <= lastCPU || timeSample.tms_stime < lastSysCPU || timeSample.tms_utime < lastUserCPU){
			//Overflow detection. Just skip this value.
			percent = -1.0;
		}
		else{
			percent = (timeSample.tms_stime - lastSysCPU) + (timeSample.tms_utime - lastUserCPU);
			percent /= (now - lastCPU);
			percent /= numProcessors;
			percent *= 100;
		}
		lastCPU = now;
		lastSysCPU = timeSample.tms_stime;
		lastUserCPU = timeSample.tms_utime;

		return percent;
	}
	*/
	return DKERROR("not implemented\n");
}

bool DKLinux::TurnOffMonitor(int& rtnvalue){
	DKDEBUGFUNC(rtnvalue);
	return DKUtil::System("xset dpms force off", rtnvalue);
}

bool DKLinux::TurnOnMonitor(){
	DKDEBUGFUNC();
	return DKERROR("not implemented\n");
}

bool DKLinux::LowPowerMonitor(){
	DKDEBUGFUNC();
	return DKERROR("not implemented\n");
}

#endif //LINUX
