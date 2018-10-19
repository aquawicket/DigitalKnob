#include "DK/stdafx.h"
#include "DKUtil.h"
#include "DKLog.h"
#include "DKFile.h"
#include <iostream>

#ifdef WIN32
	#include "DKWindows.h"
#else
	#include "DKUnix.h"
#endif

#ifdef LINUX
	#include "DKLinux.h"
#endif 

#ifdef ANDROID
	#include "DKAndroid.h"
#endif 

#ifdef MAC
	#include "DKMac.h"
#endif
	
#include <boost/asio.hpp>

#include <iostream>
#ifndef MAC
#include <fstream>
#endif
#include <math.h>
#include <assert.h>


//Frame limiter
long DKUtil::lastSecond = 0;
long DKUtil::now = 0;
long DKUtil::lastFrame = 0; 
int DKUtil::_fps = 60;
int DKUtil::ticksPerFrame = 1000 / _fps;

//FPS Counter
unsigned long int DKUtil::mainThreadId = 0;
long DKUtil::frametimes[FRAME_VALUES]; // An array to store frame times:
long DKUtil::frametimelast = 0; // Last calculated DKUtil::GetTicks()
long DKUtil::framecount = 0; // total frames rendered
float DKUtil::framespersecond = 0;


///////////////////
bool DKUtil::Beep()
{
	DKDebug();
	std::cout << '\a' << std::flush;
	return true;
}

/////////////////////////////////////////////////////////////////
bool DKUtil::Bin2C(const DKString& input, const DKString& output)
{
	DKDebug(input, output);
#ifndef MAC
	char *buf;
	const char* ident  = "assets";
	unsigned int i, file_size, need_comma;
	FILE *f_input, *f_output;

	f_input = fopen(input.c_str(), "rb");
	if (f_input == NULL) {
		printf("can't open file for reading\n");
		return false;
	}

	// Get the file length
	fseek(f_input, 0, SEEK_END);
	file_size = ftell(f_input);
	fseek(f_input, 0, SEEK_SET);
	file_size++;

	buf = (char *)malloc(file_size);
	assert(buf);   

	fread(buf, file_size, 1, f_input);
	fclose(f_input);
	f_output = fopen(output.c_str(), "w");
	if (f_output == NULL){
		printf("can't open file for writing\n");
		return false;
	}

	//ident = "assets";
	need_comma = 0;
	fprintf (f_output, "const unsigned char %s[%i] = {", ident, file_size);

	for (i = 0; i < file_size; ++i){
		if (need_comma) fprintf(f_output, ", ");
		else need_comma = 1;
		if (( i % 11 ) == 0) fprintf(f_output, "\n\t");
		fprintf(f_output, "0x%.2x", buf[i] & 0xff);
	}
	fprintf(f_output, "\n};\n\n");
	fprintf(f_output, "const int %s_size = %i;\n", ident, file_size);

	fclose(f_output);
	return true;
#endif //!MAC
	return false;
}

////////////////////////////////////////////////////////////////////////////////////////////
bool DKUtil::C2Bin(const unsigned char* header, const long int size, const DKString& output)
{
	DKDebug(header, size, output);
#ifndef MAC
	std::basic_ofstream<unsigned char> file(output.c_str(), std::ios::binary);
	file.write(header, size);
	file.close();
	return true;
#endif //!MAC
	return false;
}

///////////////////////
bool DKUtil::CallExit()
{
	DKDebug();
#ifdef ANDROID
	CallJavaFunction("Exit","");
#endif
#ifdef WIN32
	if(GetCurrentThreadId() != DKUtil::mainThreadId){   //GetCurrentThreadId not available for android
		DKLog("DKApp::Exit(): attempting to call Exit() from another thread \n", DKWARN);
	}
#endif

	DKClass::CloseAll();
	return true;
}

///////////////////////////////
bool DKUtil::CpuUsed(int& cpu)
{
	DKDebug(cpu);
#ifdef WIN32
	return DKWindows::CpuUsed(cpu);
#endif
#ifdef MAC
	return DKMac::CpuUsed(cpu);
#endif
#ifdef LINUX
	return DKLinux::CpuUsed(cpu);
#endif
	DKLog("DKUtil::CpuUsed() not implemented on this OS \n", DKWARN);
	return false;
}

///////////////////////////////////
bool DKUtil::CpuUsedByApp(int& cpu)
{
	DKDebug(cpu);
#ifdef WIN32
	return DKWindows::CpuUsedByApp(cpu);
#endif
#ifdef MAC
	return DKMac::CpuUsedByApp(cpu);
#endif
#ifdef LINUX
	return DKLinux::CpuUsedByApp(cpu);
#endif
	DKLog("DKUtil::CpuUsedByApp() not implemented on this OS \n", DKWARN);
	return false;
}

//////////////////////////
bool DKUtil::DoubleClick()
{
	DKDebug();
#ifdef WIN32
	DKWindows::LeftClick();
	return DKWindows::LeftClick();
#endif
	DKLog("DKUtil::DoubleClick() not implemented on this OS \n", DKWARN);
	return false;
}

///////////////////////////////////////////////////
bool DKUtil::DrawTextOnScreen(const DKString& text)
{
	DKDebug(text);
#ifdef WIN32
	return DKWindows::DrawTextOnScreen(text);
#endif
	DKLog("DKUtil::DrawTextOnScreen() not implemented on this OS \n", DKWARN);
	return false;
}

////////////////////////////////////////////////////////////
bool DKUtil::Execute(const DKString& command, DKString& rtn)
{
	DKDebug(command, rtn);
#ifdef WIN32
	FILE* pipe = _popen(command.c_str(), "r");
	if(!pipe){
		DKLog("DKUtil::Execute(): Error, pipe invalid.", DKERROR);
		return "ERROR";
	}
	char buffer[128];
	while(!feof(pipe)) {
		if(fgets(buffer, 128, pipe) != NULL)
			rtn += buffer;
		DKLog(buffer);
	}
	_pclose(pipe);
	return true;
#else
	FILE* pipe = popen(command.c_str(), "r");
	if(!pipe){
		DKLog("DKUtil::Execute(): Error, pipe invalid.", DKERROR);
		return "ERROR";
	}
	char buffer[128];
	while(!feof(pipe)) {
		if(fgets(buffer, 128, pipe) != NULL)
			rtn += buffer;
		DKLog(buffer);
	}
	pclose(pipe);
	return true;
#endif

	return "";
}

/////////////////////////////////////////////////////////////////////
bool DKUtil::FindImageOnScreen(const DKString& file, int& x, int& y)
{
	DKDebug(file, x, y);
#ifdef WIN32
	return DKWindows::FindImageOnScreen(file, x, y);
#endif
	DKLog("DKUtil::FindImageOnScreen() not implemented on this OS \n", DKWARN);
	return false;
}

/////////////////////////////////////////
bool DKUtil::GetClipboard(DKString& text)
{
	DKDebug(text);
#ifdef WIN32
	return DKWindows::GetClipboard(text);
#endif
#ifdef LINUX
	return DKLinux::GetClipboard(text);
#endif
	DKLog("DKUtil::GetClipboard() not implemented on this OS \n", DKWARN);
	return false;
}

////////////////////////////////////
bool DKUtil::GetDate(DKString& date)
{
	DKDebug(date);
	time_t t = time(0);   // get time now
	struct tm * now = localtime(&t);

	//int standard = now->tm_hour % 12;
	date = toString(now->tm_mon+1);
	date += "/";
	DKString day = toString(now->tm_mday);
	//Pad(2, '0', day);
	date += day;
	date += "/";
	date += toString(now->tm_year + 1900);

	return true;
}

//////////////////////////////////////
bool DKUtil::GetFps(unsigned int& fps)
{
	DKDebug(fps);
	fps = (unsigned int)framespersecond;
	return true;
}

/////////////////////////////////////////
bool DKUtil::GetFramerate(int& framerate)
{
	DKDebug(framerate);
	framerate = DKUtil::_fps;
	return true;
}

////////////////////////////////////
bool DKUtil::GetFrames(long& frames)
{
	DKDebug(frames);
	frames = framecount;
	return true;
}

/////////////////////////////
bool DKUtil::GetKey(int& key)
{
	DKDebug(key);
#if defined(WIN32)
	return DKWindows::GetKey(key);
#endif
#if defined(MAC)
	return DKUnix::GetKey(key);
#endif
#if defined(IOS)
	return DKUnix::GetKey(key);
#endif
#if defined(LINUX)
	return DKUnix::GetKey(key);
#endif
	DKLog("DKUtil::GetKey(): not implemented on this OS \n", DKWARN);
	return false;
}

/////////////////////////////////////
bool DKUtil::GetLocalIP(DKString& ip)
{
	DKDebug(ip);
	boost::asio::io_service io_service; 
	boost::asio::ip::tcp::resolver resolver(io_service); 
	boost::asio::ip::tcp::resolver::query query(boost::asio::ip::tcp::v4(), boost::asio::ip::host_name(), ""); 
	boost::asio::ip::tcp::resolver::iterator it = resolver.resolve(query);
	boost::asio::ip::tcp::endpoint endpoint = *it; 

	ip = endpoint.address().to_string();
	return true;
}

////////////////////////////////////////
bool DKUtil::GetMousePos(int& x, int& y)
{
	DKDebug(x, y);
#ifdef WIN32
	return DKWindows::GetMousePos(x, y);
#endif
#ifdef MAC
	return DKMac::GetMousePos(x, y);
#endif
#ifdef LINUX
	return DKLinux::GetMousePos(x, y);
#endif
#ifdef ANDROID
	return DKAndroid::GetMousePos(x, y);
#endif
	DKLog("DKUtil::GetMousePos() not implemented on this OS \n", DKWARN);
	return false;
}

///////////////////////////////////////////////////////////////////
bool DKUtil::GetPixelFromImage(const DKString& image, int x, int y)
{
	DKDebug(image, x, y);
#ifdef WIN32
	return DKWindows::GetPixelFromImage(image, x, y);
#endif
	DKLog("DKUtil::GetPixelFromImage() not implemented on this OS \n", DKWARN);
	return false;
}

/////////////////////////////////////////////////////////////////////
bool DKUtil::GetPixelFromScreen(int x, int y, int& r, int& g, int& b)
{
	DKDebug(x, y, r, g, b);
#ifdef WIN32
	return DKWindows::GetPixelFromScreen(x, y, r, g, b);
#endif
	DKLog("DKUtil::GetPixelFromScreen() not implemented on this OS \n", DKWARN);
	return false;
}

///////////////////////////////////////////
bool DKUtil::GetProcessList(DKString& list)
{
	DKDebug(list);
#ifdef WIN32
	return DKWindows::GetProcessList(list);
#endif
	DKLog("DKUtil::GetProcessList() not implemented on this OS. \n", DKWARN);
	return false;
}

////////////////////////////////////
bool DKUtil::GetScreenHeight(int& h)
{
	DKDebug(h);
#ifdef WIN32
	return DKWindows::GetScreenHeight(h);
#endif
#ifdef MAC
	return DKMac::GetScreenHeight(h);
#endif
#ifdef LINUX
	return DKLinux::GetScreenHeight(h);
#endif
	DKLog("DKUtil::GetScreenHeight() not implemented on this OS \n", DKWARN);
	return false;
}

///////////////////////////////////
bool DKUtil::GetScreenWidth(int& w)
{
	DKDebug(w);
#ifdef WIN32
	return DKWindows::GetScreenWidth(w);
#endif
#ifdef MAC
	return DKMac::GetScreenWidth(w);
#endif
#ifdef LINUX
	return DKLinux::GetScreenWidth(w);
#endif
	DKLog("DKUtil::GetScreenWidth() not implemented on this OS \n", DKWARN);
	return false;
}

///////////////////////////////////////////////
bool DKUtil::GetThreadId(unsigned long int& id)
{
	DKDebug(id);
#ifdef WIN32
	return DKWindows::GetThreadId(id);
#endif
#ifdef UNIX
	return DKUnix::GetThreadId(id);
#endif
	/*
	#if defined(MAC)
	//id = (unsigned long int)pthread_self();
	//return true;
	return DKMac::GetThreadId(id);
	#endif
	#if defined(LINUX) || defined (IOS)
	id = (unsigned long int)pthread_self();
	return true;
	#endif
	*/
	DKLog("DKUtil::GetThreadId() not implemented on this OS \n", DKWARN);
	return false;
}

////////////////////////////////////
bool DKUtil::GetTicks(long& ticks)
{
	//DKDebug(ticks);
	
	//boost::posix_time::ptime tick = boost::posix_time::second_clock::local_time();
	//boost::posix_time::ptime now = boost::posix_time::second_clock::local_time();
	//boost::posix_time::time_duration diff = tick - now;
	//return (double)diff.total_milliseconds();
#ifdef WIN32
	ticks = GetTickCount();
	return true;
#else
	struct timeval tv;
	gettimeofday(&tv, 0);
	ticks = unsigned((tv.tv_sec * 1000) + (tv.tv_usec / 1000));
	return true;
#endif
}

/////////////////////////////////////
bool DKUtil::GetTime(DKString& _time)
{
	DKDebug(_time);
	time_t t = time(0);   // get time now
	struct tm * now = localtime(&t);

	int standard = now->tm_hour % 12;
	if(standard == 0){ standard = 12; }
	_time = toString(standard);
	_time += ":";
	DKString minute = toString(now->tm_min);
	Pad(2, '0', minute);
	_time += minute;
	//DKLog("DKUtil::GetTime(): now->tm_hour="+toString(now->tm_hour)+"\n");
	if(now->tm_hour > 12 || (now->tm_hour % 12) == 0){
		_time += " PM";
	}
	else{
		_time += " AM";
	}

	return true;
}

////////////////////////////////////
bool DKUtil::GetVolume(int& percent)
{
	DKDebug(percent);
#ifdef WIN32
	return DKWindows::GetVolume(percent);
#endif
#ifdef LINUX
	return DKLinux::GetVolume(volume);
#endif
	DKLog("DKUtil::GetVolume() not implemented on this OS \n", DKWARN);
	return false;
}

///////////////////////////
bool DKUtil::InMainThread()
{
	//DKDebug(); // DON'T DO THIS
#ifdef WIN32
	DKString tid = "GetCurrentThreadId()(): "+toString((int)GetCurrentThreadId())+"\n";
	//DKLog(tid); DO NOT DO THIS!
	return mainThreadId == GetCurrentThreadId();
#endif
#if defined(MAC) || defined(IOS)
	return mainThreadId == (unsigned long int)pthread_self();
#endif
#if defined (ANDROID) //|| defined(LINUX)
	DKString tid = "GetCurrentThreadId()(): "+toString((unsigned int)pthread_self())+"\n";
	//DKLog(tid); DO NOT DO THIS!
	return mainThreadId == (unsigned long int)pthread_self();
#endif
	return false;
}

//////////////////////
bool DKUtil::InitFps()
{
	DKDebug();
	memset(frametimes, 0, sizeof(frametimes)); // Set all frame times to 0ms
	return DKUtil::GetTicks(frametimelast);
}

////////////////////////////
bool DKUtil::InitFramerate()
{
	DKDebug();
	GetTicks(DKUtil::now);
	DKUtil::GetTicks(DKUtil::lastFrame);
	DKUtil::GetTicks(DKUtil::lastSecond);
	return true;
}

////////////////////////////////
bool DKUtil::KeyIsDown(int& key)
{
	DKDebug(key);
#ifdef WIN32
	return DKWindows::KeyIsDown(key);
#endif
#ifdef LINUX
	return DKLinux::KeyIsDown(key);
#endif	
	DKLog("DKUtil::KeyIsDown() not implemented on this OS. \n", DKWARN);
	return false;
}

////////////////////////
bool DKUtil::LeftClick()
{
	DKDebug();
#ifdef WIN32
	return DKWindows::LeftClick();
#endif
	DKLog("DKUtil::LeftClick() not implemented on this OS \n", DKWARN);
	return false;
}

////////////////////////
bool DKUtil::LeftPress()
{
	DKDebug();
#ifdef WIN32
	return DKWindows::LeftPress();
#endif
#ifdef MAC
	return DKMac::LeftPress();
#endif
#ifdef LINUX
	return DKLinux::LeftPress();
#endif
	DKLog("DKUtil::LeftPress() not implemented on this OS \n", DKWARN);
	return false;
}

//////////////////////////
bool DKUtil::LeftRelease()
{
	DKDebug();
#ifdef WIN32
	return DKWindows::LeftRelease();
#endif
#ifdef MAC
	return DKMac::LeftRelease();
#endif
#ifdef LINUX
	return DKLinux::LeftRelease();
#endif
	DKLog("DKUtil::LeftRelease() not implemented on this OS \n", DKWARN);
	return false;
}

/////////////////////////////
bool DKUtil::LimitFramerate()
{
	//DKDebug();
	if(!DKUtil::now){ DKUtil::InitFramerate(); }
	//Framerate / cpu limiter
	DKUtil::GetTicks(DKUtil::now);
	int delta = DKUtil::now - DKUtil::lastFrame;
	if(delta < DKUtil::ticksPerFrame){
		long sleep = DKUtil::ticksPerFrame - delta;
		DKUtil::Sleep(sleep);
	}
	DKUtil::GetTicks(DKUtil::lastFrame);
	DKUtil::UpdateFps();
	return true;
}

//////////////////////////////
bool DKUtil::LowPowerMonitor()
{
	DKDebug();
#ifdef WIN32
	return DKWindows::LowPowerMonitor();
#endif
	DKLog("DKUtil::LowPowerMonitor() not implemented on this OS \n", DKWARN);
	return false;
}

//////////////////////////
bool DKUtil::MiddlePress()
{
	DKDebug();
#ifdef WIN32
	return DKWindows::MiddlePress();
#endif
#ifdef MAC
	return DKMac::MiddlePress();
#endif
#ifdef LINUX
	return DKLinux::MiddlePress();
#endif
	DKLog("DKUtil::MiddlePress() not implemented on this OS \n", DKWARN);
	return false;
}

////////////////////////////
bool DKUtil::MiddleRelease()
{
	DKDebug();
#ifdef WIN32
	return DKWindows::MiddleRelease();
#endif
#ifdef MAC
	return DKMac::MiddleRelease();
#endif
#ifdef LINUX
	return DKLinux::MiddleRelease();
#endif
	DKLog("DKUtil::MiddleRelease() not implemented on this OS \n", DKWARN);
	return false;
}

///////////////////////////////////////////////////////////////
bool DKUtil::PhysicalMemory(unsigned long long& physicalMemory)
{
	DKDebug(physicalMemory);
#ifdef WIN32
	return DKWindows::PhysicalMemory(physicalMemory);
#endif
#ifdef MAC
	return DKMac::PhysicalMemory(physicalMemory);
#endif
#ifdef LINUX
	return DKLinux::PhysicalMemory(physicalMemory);
#endif
	DKLog("DKUtil::PhysicalMemory() not implemented on this OS \n", DKWARN);
	return false;
}

///////////////////////////////////////////////////////////////////
bool DKUtil::PhysicalMemoryUsed(unsigned long long& physicalMemory)
{
	DKDebug(physicalMemory);
#ifdef WIN32
	return DKWindows::PhysicalMemoryUsed(physicalMemory);
#endif
#ifdef MAC
	return DKMac::PhysicalMemoryUsed(physicalMemory);
#endif
#ifdef LINUX
	return DKLinux::PhysicalMemoryUsed(physicalMemory);
#endif
	DKLog("DKUtil::PhysicalMemoryUsed() not implemented on this OS \n", DKWARN);
	return false;
}

//////////////////////////////////////////////////////////////////
bool DKUtil::PhysicalMemoryUsedByApp(unsigned int& physicalMemory)
{
	DKDebug(physicalMemory);
#ifdef WIN32
	return DKWindows::PhysicalMemoryUsedByApp(physicalMemory);
#endif
#ifdef MAC
	return DKMac::PhysicalMemoryUsedByApp(physicalMemory);
#endif
#ifdef LINUX
	return DKLinux::PhysicalMemoryUsedByApp(physicalMemory);
#endif
	DKLog("DKUtil::PhysicalMemoryUsedByApp() not implemented on this OS \n", DKWARN);
	return false;
}

/////////////////////////////////////
bool DKUtil::PressKey(const int& key)
{
	DKDebug(key);
#ifdef WIN32
	return DKWindows::PressKey(key);
#endif
#ifdef MAC
	return DKMac::PressKey(key);
#endif
#ifdef LINUX
	return DKLinux::PressKey(key);
#endif
	DKLog("DKUtil::PressKey(): not implemented on this OS \n", DKWARN);
	return false;
}

///////////////////////////////////////
bool DKUtil::ReleaseKey(const int& key)
{
	DKDebug(key);
#ifdef WIN32
	return DKWindows::ReleaseKey(key);
#endif
#ifdef MAC
	return DKMac::ReleaseKey(key);
#endif
#ifdef LINUX
	return DKLinux::ReleaseKey(key);
#endif
	DKLog("DKUtil::ReleaseKey(): not implemented on this OS \n", DKWARN);
	return false;
}

/////////////////////////
bool DKUtil::RightClick()
{
	DKDebug();
#ifdef WIN32
	return DKWindows::RightClick();
#endif
	DKLog("DKUtil::RightClick() not implemented on this OS \n", DKWARN);
	return false;
}

/////////////////////////
bool DKUtil::RightPress()
{
	DKDebug();
#ifdef WIN32
	return DKWindows::RightPress();
#endif
#ifdef MAC
	return DKMac::RightPress();
#endif
#ifdef LINUX
	return DKLinux::RightPress();
#endif
	DKLog("DKUtil::RightPress() not implemented on this OS \n", DKWARN);
	return false;
}

///////////////////////////
bool DKUtil::RightRelease()
{
	DKDebug();
#ifdef WIN32
	return DKWindows::RightRelease();
#endif
#ifdef MAC
	return DKMac::RightRelease();
#endif
#ifdef LINUX
	return DKLinux::RightRelease();
#endif
	DKLog("DKUtil::RightRelease() not implemented on this OS \n", DKWARN);
	return false;
}

///////////////////////////////
bool DKUtil::Round(double& num)
{
	DKDebug(num);
	num = (num < 0.0 ? ceil(num - 0.5) : floor(num + 0.5));
	return true;
}

/////////////////////////////////////////////////////////////////
bool DKUtil::Run(const DKString& command, const DKString& params)
{
	DKDebug(command, params);
#ifdef WIN32
	DKString error;
	PVOID OldValue = NULL;
	//  Disable redirection immediately prior to the native API function call.
	if(!Wow64DisableWow64FsRedirection(&OldValue)){
		DKWindows::GetLastError(error);
		DKLog("DKUtil::Run("+command+","+params+"): Disable redirection failed: "+error+"\n", DKERROR);
		return false;
	}

	//https://msdn.microsoft.com/en-us/library/windows/desktop/bb762153(v=vs.85).aspx
	if(ShellExecute(NULL, "open", command.c_str(), params.c_str(), NULL, SW_SHOWNORMAL) < (HINSTANCE)32){
		DKWindows::GetLastError(error);
		DKLog("DKUtil::Run("+command+","+params+"): "+error+"\n", DKERROR);
		return false;
	}

	//  Immediately re-enable redirection. 
	if(Wow64RevertWow64FsRedirection(OldValue) == FALSE){
		DKWindows::GetLastError(error);
		DKLog("DKUtil::Run("+command+","+params+"): Enable redirection failed: "+error+"\n", DKERROR);    
		return false;
	}
	return true;
#endif
#ifdef LINUX
	return DKLinux::Run(command);
#endif
	DKLog("DKUtil::Run() not implemented on this OS. \n", DKWARN);
	return false;
}

//////////////////////////////////////////////
bool DKUtil::SetBrightness(const int& percent)
{
	DKDebug(percent);
#ifdef WIN32
	return DKWindows::SetBrightness(percent);
#endif
	DKLog("DKUtil::SetBrightness() not implemented on this OS \n", DKWARN);
	return false;
}

//TODO - This timer needs to be moved to DKRocket/DKRocket.js
//       Duktape currently blocks when using timers, so we've placed it here for now.
//       Send a timer event every second
///////////////////////
bool DKUtil::SendTick()
{
	DKDebug();
	if(((lastFrame / 1000) - (lastSecond / 1000)) >= 1){ //1 second
		DKEvent::SendEvent("GLOBAL", "second", "");
		DKUtil::GetTicks(lastSecond);
	}
	return true;
}

///////////////////////////////////////////////
bool DKUtil::SetClipboard(const DKString& text)
{
	DKDebug(text);
#ifdef WIN32
	return DKWindows::SetClipboard(text);
#endif
#ifdef LINUX
	return DKLinux::SetClipboard(text);
#endif
	DKLog("DKUtil::SetClipboard() not implemented on this OS \n", DKWARN);
	return false;
}

////////////////////////////////////////////////////////
bool DKUtil::SetClipboardFiles(const DKString& filelist)
{
	DKDebug(filelist);
#ifdef WIN32
	return DKWindows::SetClipboardFiles(filelist);
#endif
	DKLog("DKUtil::SetClipboardFiles() not implemented on this OS \n", DKWARN);
	return false;
}

////////////////////////////////////////////////////
bool DKUtil::SetClipboardImage(const DKString& file)
{
	DKDebug(file);
#ifdef WIN32
	return DKWindows::SetClipboardImage(file);
#endif
	DKLog("DKUtil::SetClipboardImage() not implemented on this OS \n", DKWARN);
	return false;
}

/////////////////////////////////////////
bool DKUtil::SetFramerate(const int& fps)
{
	DKDebug(fps);
	_fps = fps;
	if(_fps == 0){ ticksPerFrame = 0; return true; }
	ticksPerFrame = 1000 / _fps;
	return true;
}

///////////////////////////////
bool DKUtil::SetMainThreadNow()
{
	DKDebug();
	//ONLY SET THIS FROM THE MAIN THREAD ONCE
#ifdef WIN32
	return DKWindows::SetMainThreadNow(DKUtil::mainThreadId);
#endif
#ifdef UNIX
	return DKUnix::::SetMainThreadNow(DKUtil::mainThreadId);
#endif
	/*/
	#if defined(MAC)
	//DKUtil::mainThreadId = (unsigned long int)pthread_self();
	return DKMac::::SetMainThreadNow(DKUtil::mainThreadId);
	#endif
	#if defined(LINUX) || defined (IOS)
	DKUtil::mainThreadId = (unsigned long int)pthread_self();
	#endif
	*/
	DKLog("DKUtil::SetMainThreadNow() not implemented on this OS \n", DKWARN);
	return false;
}

////////////////////////////////////////////////////
bool DKUtil::SetMousePos(const int& x, const int& y)
{
	DKDebug(x, y);
#ifdef WIN32
	return DKWindows::SetMousePos(x, y);
#endif
#ifdef MAC
	return DKMac::SetMousePos(x, y);
#endif
#ifdef LINUX
	return DKLinux::SetMousePos(x, y);
#endif
	DKLog("DKUtil::SetMousePos() not implemented on this OS \n", DKWARN);
	return false;
}

////////////////////////////////////
bool DKUtil::SetVolume(int& percent)
{
	DKDebug(percent);
#ifdef WIN32
	return DKWindows::SetVolume(percent);
#endif
#ifdef LINUX
	return DKLinux::SetVolume(percent);
#endif
	DKLog("DKUtil::SetVolume() not implemented on this OS\n", DKWARN);
	return false;
}

///////////////////////////////////////////
bool DKUtil::Sleep(const int& milliseconds)
{
	DKDebug(milliseconds);
#ifdef WIN32
	return DKWindows::Sleep(milliseconds);
#else
	return DKUnix::Sleep(milliseconds);
#endif
	return false;
}

//////////////////////////////////////
bool DKUtil::StrokeKey(const int& key)
{
	DKDebug(key);
#ifdef WIN32
	DKWindows::PressKey(key);
	return DKWindows::ReleaseKey(key);
#endif
	DKLog("DKUtil::StrokeKey(): not implemented on this OS \n", DKWARN);
	return false;
}

////////////////////////////////////////////
bool DKUtil::System(const DKString& command)
{
	DKDebug(command);
#if !defined(IOS)
	int rval = system(command.c_str());
	//DKLog("DKUtil::System(): returned "+toString(rval)+"\n");
	return true;
#endif
	return false;
}

/////////////////////////////
bool DKUtil::TurnOffMonitor()
{
	DKDebug();
#ifdef WIN32
	return DKWindows::TurnOffMonitor();
#endif
#ifdef MAC
	return DKMac::TurnOffMonitor();
#endif
#ifdef LINUX
	return DKLinux::TurnOffMonitor();
#endif
	DKLog("DKUtil::TurnOffMonitor() not implemented on this OS \n", DKWARN);
	return false;
}

////////////////////////////
bool DKUtil::TurnOnMonitor()
{
	DKDebug();
#ifdef WIN32
	return DKWindows::TurnOnMonitor();
#endif
	DKLog("DKUtil::TurnOnMonitor() not implemented on this OS \n", DKWARN);
	return false;
}

////////////////////////
bool DKUtil::UpdateFps()
{
	//DKDebug();
	if(!frametimelast){ DKUtil::InitFps(); }
	long frametimesindex;
	long getticks;
	long count;
	long i;

	// frametimesindex is the position in the array. It ranges from 0 to FRAME_VALUES.
	// This value rotates back to 0 after it hits FRAME_VALUES.
	frametimesindex = framecount % FRAME_VALUES;

	DKUtil::GetTicks(getticks);// store the current time
	frametimes[frametimesindex] = getticks - frametimelast; // save the frame time value
	frametimelast = getticks; // save the last frame time for the next UpdateFps()
	framecount++; // increment the frame count

	if(framecount < FRAME_VALUES){
		count = framecount;
	}
	else{
		count = FRAME_VALUES;
	}

	framespersecond = 0;
	for(i = 0; i < count; i++){
		framespersecond += frametimes[i];
	}
	framespersecond /= count;
	framespersecond = 1000.f / framespersecond;
	return true;
}

//https://stackoverflow.com/questions/63166/how-to-determine-cpu-and-memory-consumption-from-inside-a-process
////////////////////////////////////////////////
bool DKUtil::VirtualMemory(unsigned long long& virtualMemory)
{
	DKDebug(virtualMemory);
#ifdef WIN32
	return DKWindows::VirtualMemory(virtualMemory);
#endif
#ifdef MAC
	return DKMac::VirtualMemory(virtualMemory);
#endif
#ifdef LINUX
	return DKLinux::VirtualMemory(virtualMemory);
#endif
	DKLog("DKUtil::VirtualMemory() not implemented on this OS \n", DKWARN);
	return false;
}

/////////////////////////////////////////////////////////////////
bool DKUtil::VirtualMemoryUsed(unsigned long long& virtualMemory)
{
	DKDebug(virtualMemory);
#ifdef WIN32
	return DKWindows::VirtualMemoryUsed(virtualMemory);
#endif
#ifdef MAC
	return DKMac::VirtualMemoryUsed(virtualMemory);
#endif
#ifdef LINUX
	return DKLinux::VirtualMemoryUsed(virtualMemory);
#endif
	DKLog("DKUtil::VirtualMemoryUsed() not implemented on this OS \n", DKWARN);
	return false;
}

////////////////////////////////////////////////////////////////
bool DKUtil::VirtualMemoryUsedByApp(unsigned int& virtualMemory)
{
	DKDebug(virtualMemory);
#ifdef WIN32
	return DKWindows::VirtualMemoryUsedByApp(virtualMemory);
#endif
#ifdef MAC
	return DKMac::VirtualMemoryUsedByApp(virtualMemory);
#endif
#ifdef LINUX
	return DKLinux::VirtualMemoryUsedByApp(virtualMemory);
#endif
	DKLog("DKUtil::VirtualMemoryUsedByApp() not implemented on this OS \n", DKWARN);
	return false;
}

////////////////////////////////////////////////////////////
bool DKUtil::WaitForImage(const DKString& file, int timeout)
{
	DKDebug(file, timeout);
#ifdef WIN32
	return DKWindows::WaitForImage(file, timeout);
#endif
	DKLog("DKUtil::WaitForImage() not implemented on this OS \n", DKWARN);
	return false;
}

////////////////////////
bool DKUtil::WheelDown()
{
	DKDebug();
#ifdef WIN32
	return DKWindows::WheelDown();
#endif
	DKLog("DKUtil::WheelDown() not implemented on this OS \n", DKWARN);
	return false;
}

//////////////////////
bool DKUtil::WheelUp()
{
	DKDebug();
#ifdef WIN32
	return DKWindows::WheelUp();
#endif
	DKLog("DKUtil::WheelUp() not implemented on this OS \n", DKWARN);
	return false;
}