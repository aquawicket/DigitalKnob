#include "DK/stdafx.h"
#ifdef LINUX
#include "DKLinux.h"
#include "DKLog.h"
#include <stdio.h>
#include <stdlib.h>
#include <X11/Xlib.h>
#include <X11/XKBlib.h>
#include <X11/extensions/XTest.h>  //requires  libxtst-dev
#include <alsa/asoundlib.h>
#include <unistd.h>         
#include <termios.h>  //for system("stty raw") in GetKey()

/*
#include <unistd.h> 
#include "getch.h"
t_key keys[] = {
  {"[A", K_UP},
  {"[B", K_DOWN},
  {"[D", K_LEFT},
  {"[C", K_RIGHT},
  {NULL, K_UNK},
};
*/

bool DKLinux::GetKey(int& key){
	DKDEBUGFUNC("key");
	//Method 1
	//system("stty raw"); // Set terminal to raw mode, (no wait for enter) 
	key = getchar();       
	//system("stty cooked"); // Reset terminal to normal "cooked" mode
	/*
	//Method 2
	if(!getch(key))
		return DKERROR("get_ch(key) failed\n");
	return true;
	*/
	//Method 3
	//key = ch_get(keys);
	return true;
}

// https://eklitzke.org/blocking-io-nonblocking-io-and-epoll
bool DKLinux::getch(int& key){
	DKDEBUGFUNC("key");
    int stored;
	int buffer[128];
	struct termios old = {0};
    fflush(stdout);
    if(tcgetattr(0, &old) < 0)
        return DKERROR("tcsetattr(0, &old) failed");
    old.c_lflag &= ~ICANON;
    old.c_lflag &= ~ECHO;
    old.c_cc[VMIN] = 1;
    old.c_cc[VTIME] = 0;
    if(tcsetattr(0, TCSANOW, &old) < 0)
        return DKERROR("tcsetattr(0, TCSANOW, &old) ICANON failed");
    if(read(0, &buffer, sizeof(buffer)) < 0)
		return DKERROR("read(0, &buffer, sizeof(buffer)) failed");
	// fetch the current flags
	int flags;
    if((flags = fcntl(STDIN_FILENO, F_GETFL, 0)) == -1)
		return DKERROR("fcntl(STDIN_FILENO, F_GETFL, 0) failed");
	int stored_flags = flags; //store the old flags to recall later
    // now set the flags to what they are + non-blocking
    if ((flags = fcntl(STDIN_FILENO, F_SETFL, flags | O_NONBLOCK)) == -1)
        return DKERROR("fcntl(STDIN_FILENO, F_SETFL, f | O_NONBLOCK) failed");
	// read the buffer until we run out of data
	/*
	while(buffer){
		stored = buffer;
		int arrayLength = sizeof(buffer)/sizeof(buffer[0]);
		if(read(0, &buffer, arrayLength) < 0)
			return DKERROR("2nd read(0 &buffer, sizeof(buffer) failed");
	}
	*/
	if(!buffer[0])
		return DKERROR("buffer invalid");
    int i=0;
    while(i < (sizeof(buffer)/sizeof(buffer[0])) && buffer[i])
        i++;
    if(!buffer[i-1])
		return DKERROR("buffer invalid");
    key = buffer[i-1];
	if ((flags = fcntl(STDIN_FILENO, F_SETFL, stored_flags)) == -1)
		DKERROR("fcntl(STDIN_FILENO, F_SETFL, stored_flags)) failed");
    old.c_lflag |= ICANON;
    old.c_lflag |= ECHO;
    if(tcsetattr(0, TCSADRAIN, &old) < 0)
        return DKERROR("tcsetattr(0, TCSADRAIN, &old) failed");	
	/*
	if(!stored)
		return DKERROR("stored has no data, and it should");
	if(buffer)
		return DKERROR("buffer has data and it shouldn't");
	key = stored;
	*/
	//int c;
	//while((c = getc(stdin) != EOF && c != '\n')){} //clear out stdin 
	//DKINFO("DKLinux::getch(): key = "+key+"\n");
	return true;
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
	Display *dpy = XOpenDisplay(0);
	Window root = XRootWindow(dpy, 0);
	XSelectInput(dpy, root, KeyReleaseMask);
	XWarpPointer(dpy, None, root, 0, 0, 0, 0, x, y);
	XFlush(dpy); // Flushes the output buffer, therefore updates the cursor's position.
	return true;
}

bool DKLinux::LeftPress(){
	DKDEBUGFUNC();
	Display *display = XOpenDisplay(NULL);
	XTestFakeButtonEvent(display, 1, true, 0);
	XFlush(display);
	XCloseDisplay(display);
	return true;
}

bool DKLinux::LeftRelease(){
	DKDEBUGFUNC();
	Display *display = XOpenDisplay(NULL);
	XTestFakeButtonEvent(display, 1, false, 0);
	XFlush(display);
	XCloseDisplay(display);
	return true;
}

bool DKLinux::RightPress(){
	DKDEBUGFUNC();
	Display *display = XOpenDisplay(NULL);
	XTestFakeButtonEvent(display, 3, true, 0);
	XFlush(display);
	XCloseDisplay(display);
	return true;
}

bool DKLinux::RightRelease(){
	DKDEBUGFUNC();
	Display *display = XOpenDisplay(NULL);
	XTestFakeButtonEvent(display, 3, false, 0);
	XFlush(display);
	XCloseDisplay(display);
	return true;
}

bool DKLinux::MiddlePress(){
	DKDEBUGFUNC();
	Display *display = XOpenDisplay(NULL);
	XTestFakeButtonEvent(display, 2, true, 0);
	XFlush(display);
	XCloseDisplay(display);
	return true;
}

bool DKLinux::MiddleRelease(){
	DKDEBUGFUNC();
	Display *display = XOpenDisplay(NULL);
	XTestFakeButtonEvent(display, 2, false, 0);
	XFlush(display);
	XCloseDisplay(display);
	return true;
}

bool DKLinux::PressKey(int key){
	DKDEBUGFUNC(key);
	Display *display = XOpenDisplay(NULL);
	XTestFakeKeyEvent(display, key, true, 0);
	XFlush(display);
	XCloseDisplay(display);
	return true;
}

bool DKLinux::ReleaseKey(int key){
	DKDEBUGFUNC(key);
	Display *display = XOpenDisplay(NULL);
	XTestFakeKeyEvent(display, key, false, 0);
	XFlush(display);
	XCloseDisplay(display);
	return true;
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

bool DKLinux::Run(const DKString& command){
	DKDEBUGFUNC(command);
	DKString cmd = command;
	cmd = "xdg-open "+cmd+" &";
	int rtn = system(cmd.c_str());
	//execl(cmd.c_str(), (char*)0);
	return true;
}

bool DKLinux::KeyIsDown(int& key){
	DKDEBUGFUNC(key);
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
}

bool DKLinux::StrokeKey(const int& key){
	DKDEBUGFUNC(key);
	PressKey(key);
	return ReleaseKey(key);
}

bool DKLinux::GetVolume(int& percent){
	DKDEBUGFUNC(percent);
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

bool DKLinux::VirtualMemoryUsedByApp(unsigned int& virtualMemory){
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

bool DKLinux::PhysicalMemoryUsedByApp(unsigned int& physicalMemory){
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

bool DKLinux::TurnOffMonitor(){
	DKDEBUGFUNC();
	DKString rtn;
	return DKUtil::System("xset dpms force off", rtn);
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
