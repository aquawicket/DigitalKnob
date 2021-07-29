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


bool DKUtil::Beep(){
	DKDEBUGFUNC();
	std::cout << '\a' << std::flush;
	return true;
}

bool DKUtil::Bin2C(const DKString& input, const DKString& output){
	DKDEBUGFUNC(input, output);
#ifndef MAC
	char *buf;
	const char* ident  = "assets";
	unsigned int i, file_size, need_comma;
	FILE* f_input = fopen(input.c_str(), "rb");
	if (!f_input)
		return DKERROR("DKUtil::Bin2C(): can't open file for reading\n");
	// Get the file length
	fseek(f_input, 0, SEEK_END);
	file_size = ftell(f_input);
	fseek(f_input, 0, SEEK_SET);
	file_size++;
	buf = (char *)malloc(file_size);
	assert(buf);   
	fread(buf, file_size, 1, f_input);
	if(fclose(f_input))
		return DKERROR("DKUtil::Bin2C(): fclose(f_input) failed\n");
	FILE* f_output = fopen(output.c_str(), "w");
	if(!f_output)
		return DKERROR("DKUtil::Bin2C(): can't open file for writing\n");
	//ident = "assets";
	need_comma = 0;
	//fprintf (f_output, "const unsigned char %s[%i] = {", ident, file_size); //verbos
	for(i = 0; i < file_size; ++i){
		if (need_comma) fprintf(f_output, ", ");
		else need_comma = 1;
		if (( i % 11 ) == 0) fprintf(f_output, "\n\t");
		//fprintf(f_output, "0x%.2x", buf[i] & 0xff); //verbos
	}
	//fprintf(f_output, "\n};\n\n"); //verbos
	//fprintf(f_output, "const int %s_size = %i;\n", ident, file_size); //verbos
	if (fclose(f_output))
		return DKERROR("DKUtil::Bin2C(): fclose(f_output) failed\n");
	return true;
#endif //!MAC
	return DKERROR("DKUtil::Bin2C() is not implemented on Mac OSX\n");
}

bool DKUtil::C2Bin(const DKString hex, std::streamsize size, const char* fileOut){
	//DKDEBUGFUNC(header, size, "fileOut");
#ifndef MAC
	//NOTES: 
	//https://caiorss.github.io/C-Cpp-Notes/resources-executable.html
	//https://stackoverflow.com/questions/27878495/ofstream-not-working-on-linux
	//https://stackoverflow.com/questions/55444139/stdbasic-ofstreamstduint8-t-write-fails-at-check-facet
	
	//https://stackoverflow.com/a/49273626/688352
	std::basic_string<uint8_t> bytes;
	for(size_t i = 0; i < hex.length(); i += 2){
		uint16_t byte;
		// Get current pair and store in nextbyte
		std::string nextbyte = hex.substr(i, 2);
		// Put the pair into an istringstream and stream it through std::hex for
    	// conversion into an integer value.
    	// This will calculate the byte value of the string-represented hex value.
    	std::istringstream(nextbyte) >> std::hex >> byte;
		// As the stream above does not work with uint8 directly,
    	// we have to cast it now.
    	// As every pair can have a maximum value of "ff",
    	// which is "11111111" (8 bits), we will not lose any information during this cast.
    	// This line adds the current byte value to our final byte "array".
    	bytes.push_back(static_cast<uint8_t>(byte));	
	}
	
	// Generating a string obj from our bytes-"array"
	// Output it into a binary file
	std::string result(begin(bytes), end(bytes));
	std::ofstream output_file(fileOut, std::ios::binary | std::ios::out);
	if(output_file.is_open()){
    	output_file << result;
    	output_file.close();
	}
	else
    	return DKERROR("DKUtil::C2Bin() Error: could not create file\n");
	return true;

#endif //!MAC
	return DKERROR("DKUtil::C2Bin() is not implemented on Mac OSX yet\n");
}

bool DKUtil::CallExit(){
	DKDEBUGFUNC();
#ifdef ANDROID
	CallJavaFunction("Exit","");
#endif
#ifdef WIN32
	if(GetCurrentThreadId() != DKUtil::mainThreadId){   //GetCurrentThreadId not available for android
		DKWARN("DKApp::Exit(): Not call from the main thread\n");
	}
#endif
	DKClass::CloseAll();
	return true;
}

bool DKUtil::CpuUsed(int& cpu){
	DKDEBUGFUNC(cpu);
#ifdef WIN32
	return DKWindows::CpuUsed(cpu);
#endif
#ifdef MAC
	return DKMac::CpuUsed(cpu);
#endif
#ifdef LINUX
	return DKLinux::CpuUsed(cpu);
#endif
	return DKERROR("DKUtil::CpuUsed() not implemented on this OS\n");
}

bool DKUtil::CpuUsedByApp(int& cpu){
	DKDEBUGFUNC(cpu);
#ifdef WIN32
	return DKWindows::CpuUsedByApp(cpu);
#endif
#ifdef MAC
	return DKMac::CpuUsedByApp(cpu);
#endif
#ifdef LINUX
	return DKLinux::CpuUsedByApp(cpu);
#endif
	return DKERROR("DKUtil::CpuUsedByApp() not implemented on this OS\n");
}

bool DKUtil::DoubleClick(){
	DKDEBUGFUNC();
#ifdef WIN32
	DKWindows::LeftClick();
	return DKWindows::LeftClick();
#endif
	return DKERROR("DKUtil::DoubleClick() not implemented on this OS\n");
}

bool DKUtil::DrawTextOnScreen(const DKString& text){
	DKDEBUGFUNC(text);
#ifdef WIN32
	return DKWindows::DrawTextOnScreen(text);
#endif
	return DKERROR("DKUtil::DrawTextOnScreen() not implemented on this OS\n");
}

bool DKUtil::Execute(const DKString& command, const DKString& mode, DKString& result){
	DKDEBUGFUNC(command, mode);
	DKINFO("DKUtil::Execute("+command+","+mode+")\n");
#ifdef WIN32
	auto& dk_popen = _popen;
	auto& dk_pclose = _pclose;
#else
	auto& dk_popen = popen;
	auto& dk_pclose = pclose;
#endif
	FILE* pipe = dk_popen(command.c_str(), mode.c_str());
	if(pipe == NULL)
		return DKERROR("DKUtil::Execute(): pipe invalid: "+toString(strerror(errno))+"\n");
	char buffer[128];
	while(fgets(buffer, 128, pipe)){
		DKINFO(buffer);
		result += buffer;
	}
	if(!feof(pipe))
		DKERROR("DKUtil::Execute(): feof(pipe) failed\n");
	if(dk_pclose(pipe) == -1)
		return DKERROR("DKUtil::Execute(): dk_pclose(pipe) failed\n");
	if (!trim(result))
		return DKERROR("DKUtil::Execute(): trim(result) failed\n");
	return true;
}

bool DKUtil::FindImageOnScreen(const DKString& file, int& x, int& y){
	DKDEBUGFUNC(file, x, y);
#ifdef WIN32
	return DKWindows::FindImageOnScreen(file, x, y);
#endif
	return DKERROR("DKUtil::FindImageOnScreen() not implemented on this OS\n");
}

bool DKUtil::GetClipboard(DKString& text){
	DKDEBUGFUNC(text);
#ifdef WIN32
	return DKWindows::GetClipboard(text);
#endif
#ifdef LINUX
	return DKLinux::GetClipboard(text);
#endif
	return DKERROR("DKUtil::GetClipboard() not implemented on this OS\n");
}

bool DKUtil::GetDate(DKString& date){
	DKDEBUGFUNC(date);
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

bool DKUtil::GetFps(unsigned int& fps){
	DKDEBUGFUNC(fps);
	fps = (unsigned int)framespersecond;
	return true;
}

bool DKUtil::GetFramerate(int& framerate){
	DKDEBUGFUNC(framerate);
	framerate = DKUtil::_fps;
	return true;
}

bool DKUtil::GetFrames(long& frames){
	DKDEBUGFUNC(frames);
	frames = framecount;
	return true;
}

bool DKUtil::GetKey(int& key){
	DKDEBUGFUNC(key);
#ifdef WIN32
	return DKWindows::GetKey(key);
#endif
#if defined(MAC) || defined(IOS) || defined(LINUX)
	return DKUnix::GetKey(key);
#endif
	return DKERROR("DKUtil::GetKey(): not implemented on this OS\n");
}

bool DKUtil::GetLocalIP(DKString& ip){
	DKDEBUGFUNC(ip);
	boost::asio::io_service io_service; 
	boost::asio::ip::tcp::resolver resolver(io_service); 
	boost::asio::ip::tcp::resolver::query query(boost::asio::ip::tcp::v4(), boost::asio::ip::host_name(), ""); 
	boost::asio::ip::tcp::resolver::iterator it = resolver.resolve(query);
	boost::asio::ip::tcp::endpoint endpoint = *it; 
	ip = endpoint.address().to_string();
	return true;
}

bool DKUtil::GetMousePos(int& x, int& y){
	DKDEBUGFUNC(x, y);
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
	return DKERROR("DKUtil::GetMousePos() not implemented on this OS\n");
}

bool DKUtil::GetPixelFromImage(const DKString& image, int x, int y){
	DKDEBUGFUNC(image, x, y);
#ifdef WIN32
	return DKWindows::GetPixelFromImage(image, x, y);
#endif
	return DKERROR("DKUtil::GetPixelFromImage() not implemented on this OS\n");
}

bool DKUtil::GetPixelFromScreen(int x, int y, int& r, int& g, int& b){
	DKDEBUGFUNC(x, y, r, g, b);
#ifdef WIN32
	return DKWindows::GetPixelFromScreen(x, y, r, g, b);
#endif
	return DKERROR("DKUtil::GetPixelFromScreen() not implemented on this OS\n");
}

bool DKUtil::GetProcessList(DKString& list){
	DKDEBUGFUNC(list);
#ifdef WIN32
	return DKWindows::GetProcessList(list);
#endif
	return DKERROR("DKUtil::GetProcessList() not implemented on this OS\n");
}

bool DKUtil::GetScreenHeight(int& h){
	DKDEBUGFUNC(h);
#ifdef WIN32
	return DKWindows::GetScreenHeight(h);
#endif
#ifdef MAC
	return DKMac::GetScreenHeight(h);
#endif
#ifdef LINUX
	return DKLinux::GetScreenHeight(h);
#endif
	return DKERROR("DKUtil::GetScreenHeight() not implemented on this OS\n");
}

bool DKUtil::GetScreenWidth(int& w){
	DKDEBUGFUNC(w);
#ifdef WIN32
	return DKWindows::GetScreenWidth(w);
#endif
#ifdef MAC
	return DKMac::GetScreenWidth(w);
#endif
#ifdef LINUX
	return DKLinux::GetScreenWidth(w);
#endif
	return DKERROR("DKUtil::GetScreenWidth() not implemented on this OS\n");
}

bool DKUtil::GetThreadId(unsigned long int& id){
	DKDEBUGFUNC(id);
	id = DKUtil::mainThreadId;
	return true;
}

bool DKUtil::GetTicks(long& ticks){
	//DKDEBUGFUNC(ticks);
	
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

bool DKUtil::GetTime(DKString& _time){
	DKDEBUGFUNC(_time);
	time_t t = time(0);   // get time now
	struct tm * now = localtime(&t);

	int standard = now->tm_hour % 12;
	if(standard == 0){ standard = 12; }
	_time = toString(standard);
	_time += ":";
	DKString minute = toString(now->tm_min);
	Pad(2, '0', minute);
	_time += minute;
	//DKINFO("DKUtil::GetTime(): now->tm_hour="+toString(now->tm_hour)+"\n");
	if(now->tm_hour > 12 || (now->tm_hour % 12) == 0)
		_time += " PM";
	else
		_time += " AM";
	return true;
}

bool DKUtil::GetUsername(DKString& username){
	DKDEBUGFUNC(username);
#ifdef WIN32
	return DKWindows::GetUsername(username);
#else
	return DKUnix::GetUsername(username);
#endif
	return DKERROR("DKUtil::GetUsername() not implemented on this OS\n");
}

bool DKUtil::GetVolume(int& percent){
	DKDEBUGFUNC(percent);
#ifdef WIN32
	return DKWindows::GetVolume(percent);
#endif
#ifdef LINUX
	return DKLinux::GetVolume(percent);
#endif
	return DKERROR("DKUtil::GetVolume() not implemented on this OS\n");
}

bool DKUtil::InMainThread(){
	//DKDEBUGFUNC(); // DON'T DO THIS
#ifdef WIN32
	return mainThreadId == GetCurrentThreadId();
#endif
#if defined(MAC) || defined(IOS) || defined(ANDROID) || defined(LINUX)
	return mainThreadId == (unsigned long int)pthread_self(); //TODO: move this to DKUnix::InMainThread()
#endif
	return DKERROR("DKUtil::InMainThread() not implemented on this OS\n");
}

bool DKUtil::InitFps(){
	DKDEBUGFUNC();
	memset(frametimes, 0, sizeof(frametimes)); // Set all frame times to 0ms
	return DKUtil::GetTicks(frametimelast);
}

bool DKUtil::InitFramerate(){
	DKDEBUGFUNC();
	GetTicks(DKUtil::now);
	DKUtil::GetTicks(DKUtil::lastFrame);
	DKUtil::GetTicks(DKUtil::lastSecond);
	return true;
}

bool DKUtil::KeyIsDown(int& key){
	DKDEBUGFUNC(key);
#ifdef WIN32
	return DKWindows::KeyIsDown(key);
#endif
#ifdef LINUX
	return DKLinux::KeyIsDown(key);
#endif	
	return DKERROR("DKUtil::KeyIsDown() not implemented on this OS\n");
}

bool DKUtil::LeftClick(){
	DKDEBUGFUNC();
#ifdef WIN32
	return DKWindows::LeftClick();
#endif
	return DKERROR("DKUtil::LeftClick() not implemented on this OS\n");
}

bool DKUtil::LeftPress(){
	DKDEBUGFUNC();
#ifdef WIN32
	return DKWindows::LeftPress();
#endif
#ifdef MAC
	return DKMac::LeftPress();
#endif
#ifdef LINUX
	return DKLinux::LeftPress();
#endif
	return DKERROR("DKUtil::LeftPress() not implemented on this OS\n");
}

bool DKUtil::LeftRelease(){
	DKDEBUGFUNC();
#ifdef WIN32
	return DKWindows::LeftRelease();
#endif
#ifdef MAC
	return DKMac::LeftRelease();
#endif
#ifdef LINUX
	return DKLinux::LeftRelease();
#endif
	return DKERROR("DKUtil::LeftRelease() not implemented on this OS\n");
}

bool DKUtil::LimitFramerate(){
	//DKDEBUGFUNC();
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

bool DKUtil::LowPowerMonitor(){
	DKDEBUGFUNC();
#ifdef WIN32
	return DKWindows::LowPowerMonitor();
#endif
	return DKERROR("DKUtil::LowPowerMonitor() not implemented on this OS\n");
}

bool DKUtil::MiddlePress(){
	DKDEBUGFUNC();
#ifdef WIN32
	return DKWindows::MiddlePress();
#endif
#ifdef MAC
	return DKMac::MiddlePress();
#endif
#ifdef LINUX
	return DKLinux::MiddlePress();
#endif
	return DKERROR("DKUtil::MiddlePress() not implemented on this OS\n");
}

bool DKUtil::MiddleRelease(){
	DKDEBUGFUNC();
#ifdef WIN32
	return DKWindows::MiddleRelease();
#endif
#ifdef MAC
	return DKMac::MiddleRelease();
#endif
#ifdef LINUX
	return DKLinux::MiddleRelease();
#endif
	return DKERROR("DKUtil::MiddleRelease() not implemented on this OS\n");
}

bool DKUtil::PhysicalMemory(unsigned long long& physicalMemory){
	DKDEBUGFUNC(physicalMemory);
#ifdef WIN32
	return DKWindows::PhysicalMemory(physicalMemory);
#endif
#ifdef MAC
	return DKMac::PhysicalMemory(physicalMemory);
#endif
#ifdef LINUX
	return DKLinux::PhysicalMemory(physicalMemory);
#endif
	return DKERROR("DKUtil::PhysicalMemory() not implemented on this OS\n");
}

bool DKUtil::PhysicalMemoryUsed(unsigned long long& physicalMemory){
	DKDEBUGFUNC(physicalMemory);
#ifdef WIN32
	return DKWindows::PhysicalMemoryUsed(physicalMemory);
#endif
#ifdef MAC
	return DKMac::PhysicalMemoryUsed(physicalMemory);
#endif
#ifdef LINUX
	return DKLinux::PhysicalMemoryUsed(physicalMemory);
#endif
	return DKERROR("DKUtil::PhysicalMemoryUsed() not implemented on this OS\n");
}

bool DKUtil::PhysicalMemoryUsedByApp(unsigned int& physicalMemory){
	DKDEBUGFUNC(physicalMemory);
#ifdef WIN32
	return DKWindows::PhysicalMemoryUsedByApp(physicalMemory);
#endif
#ifdef MAC
	return DKMac::PhysicalMemoryUsedByApp(physicalMemory);
#endif
#ifdef LINUX
	return DKLinux::PhysicalMemoryUsedByApp(physicalMemory);
#endif
	return DKERROR("DKUtil::PhysicalMemoryUsedByApp() not implemented on this OS\n");
}

bool DKUtil::PressKey(const int& key){
	DKDEBUGFUNC(key);
#ifdef WIN32
	return DKWindows::PressKey(key);
#endif
#ifdef MAC
	return DKMac::PressKey(key);
#endif
#ifdef LINUX
	return DKLinux::PressKey(key);
#endif
	return DKERROR("DKUtil::PressKey(): not implemented on this OS\n");
}

bool DKUtil::ReleaseKey(const int& key){
	DKDEBUGFUNC(key);
#ifdef WIN32
	return DKWindows::ReleaseKey(key);
#endif
#ifdef MAC
	return DKMac::ReleaseKey(key);
#endif
#ifdef LINUX
	return DKLinux::ReleaseKey(key);
#endif
	return DKERROR("DKUtil::ReleaseKey(): not implemented on this OS\n");
}

bool DKUtil::RightClick(){
	DKDEBUGFUNC();
#ifdef WIN32
	return DKWindows::RightClick();
#endif
	return DKERROR("DKUtil::RightClick() not implemented on this OS\n");
}

bool DKUtil::RightPress(){
	DKDEBUGFUNC();
#ifdef WIN32
	return DKWindows::RightPress();
#endif
#ifdef MAC
	return DKMac::RightPress();
#endif
#ifdef LINUX
	return DKLinux::RightPress();
#endif
	return DKERROR("DKUtil::RightPress() not implemented on this OS\n");
}

bool DKUtil::RightRelease(){
	DKDEBUGFUNC();
#ifdef WIN32
	return DKWindows::RightRelease();
#endif
#ifdef MAC
	return DKMac::RightRelease();
#endif
#ifdef LINUX
	return DKLinux::RightRelease();
#endif
	return DKERROR("DKUtil::RightRelease() not implemented on this OS\n");
}

bool DKUtil::Round(double& num){
	DKDEBUGFUNC(num);
	num = (num < 0.0 ? ceil(num - 0.5) : floor(num + 0.5));
	return true;
}

bool DKUtil::Run(const DKString& command, const DKString& params){
	DKDEBUGFUNC(command, params);
#ifdef WIN32
	DKString error;
	PVOID OldValue = NULL;
	//  Disable redirection immediately prior to the native API function call.
	if(!Wow64DisableWow64FsRedirection(&OldValue)){
		DKWindows::GetLastError(error);
		return DKERROR("DKUtil::Run("+command+","+params+"): Disable redirection failed: "+error+"\n");
	}

	//https://msdn.microsoft.com/en-us/library/windows/desktop/bb762153(v=vs.85).aspx
	if(ShellExecute(NULL, "open", command.c_str(), params.c_str(), NULL, SW_SHOWNORMAL) < (HINSTANCE)32){
		DKWindows::GetLastError(error);
		return DKERROR("DKUtil::Run("+command+","+params+"): "+error+"\n");
	}

	//  Immediately re-enable redirection. 
	if(Wow64RevertWow64FsRedirection(OldValue) == FALSE){
		DKWindows::GetLastError(error);
		return DKERROR("DKUtil::Run("+command+","+params+"): Enable redirection failed: "+error+"\n");    
	}
	return true;
#endif
#ifdef LINUX
	return DKLinux::Run(command);
#endif
	return DKERROR("DKUtil::Run() not implemented on this OS\n");
}

bool DKUtil::SetBrightness(const int& percent){
	DKDEBUGFUNC(percent);
#ifdef WIN32
	return DKWindows::SetBrightness(percent);
#endif
	return DKERROR("DKUtil::SetBrightness() not implemented on this OS\n");
}

//TODO - This timer needs to be moved to DKRml
//       Duktape currently blocks when using timers, so we've placed it here for now.
//       Send a timer event every second
bool DKUtil::SendTick(){
	//DKDEBUGFUNC();
	if(((lastFrame / 1000) - (lastSecond / 1000)) >= 1){ //1 second
		DKEvents::SendEvent("window", "second", "");
		DKUtil::GetTicks(lastSecond);
	}
	return true;
}

bool DKUtil::SetClipboard(const DKString& text){
	DKDEBUGFUNC(text);
#ifdef WIN32
	return DKWindows::SetClipboard(text);
#endif
#ifdef LINUX
	return DKLinux::SetClipboard(text);
#endif
	return DKERROR("DKUtil::SetClipboard() not implemented on this OS\n");
}

bool DKUtil::SetClipboardFiles(const DKString& filelist){
	DKDEBUGFUNC(filelist);
#ifdef WIN32
	return DKWindows::SetClipboardFiles(filelist);
#endif
	return DKERROR("DKUtil::SetClipboardFiles() not implemented on this OS\n");
}

bool DKUtil::SetClipboardImage(const DKString& file){
	DKDEBUGFUNC(file);
#ifdef WIN32
	return DKWindows::SetClipboardImage(file);
#endif
	return DKERROR("DKUtil::SetClipboardImage() not implemented on this OS\n");
}

bool DKUtil::SetFramerate(const int& fps){
	DKDEBUGFUNC(fps);
	_fps = fps;
	if(_fps == 0)
		ticksPerFrame = 0; return true;
	ticksPerFrame = 1000 / _fps;
	return true;
}

bool DKUtil::SetMainThreadNow(){
	DKDEBUGFUNC();
	//ONLY SET THIS FROM THE MAIN THREAD ONCE
#ifdef WIN32
	DKUtil::mainThreadId = GetCurrentThreadId();
	return true;
#endif
#if defined(MAC) || defined(IOS) || defined(LINUX)
	DKUtil::mainThreadId = (unsigned long int)pthread_self();
	return true;
#endif
#ifdef ANDROID
	DKUtil::mainThreadId = (int)pthread_self();
	return true;
#endif
	return DKERROR("DKUtil::SetMainThreadNow() not implemented on this OS\n");
}

bool DKUtil::SetMousePos(const int& x, const int& y){
	DKDEBUGFUNC(x, y);
#ifdef WIN32
	return DKWindows::SetMousePos(x, y);
#endif
#ifdef MAC
	return DKMac::SetMousePos(x, y);
#endif
#ifdef LINUX
	return DKLinux::SetMousePos(x, y);
#endif
	return DKERROR("DKUtil::SetMousePos() not implemented on this OS\n");
}

bool DKUtil::SetVolume(int& percent){
	DKDEBUGFUNC(percent);
#ifdef WIN32
	return DKWindows::SetVolume(percent);
#endif
#ifdef LINUX
	return DKLinux::SetVolume(percent);
#endif
	return DKERROR("DKUtil::SetVolume() not implemented on this OS\n");
}

bool DKUtil::Sleep(const int& milliseconds){
	//DKDEBUGFUNC(milliseconds);
#ifdef WIN32
	return DKWindows::Sleep(milliseconds);
#endif
#if defined(MAC) || defined(IOS) || defined(ANDROID) || defined(LINUX)
	return DKUnix::Sleep(milliseconds);
#endif
	return DKERROR("DKUtil::Sleep(): not implemented on this OS\n");
}

bool DKUtil::StrokeKey(const int& key){
	DKDEBUGFUNC(key);
#ifdef WIN32
	DKWindows::PressKey(key);
	return DKWindows::ReleaseKey(key);
#endif
	return DKERROR("DKUtil::StrokeKey(): not implemented on this OS\n");
}

bool DKUtil::System(const DKString& command, DKString& out){
	DKDEBUGFUNC(command);
#if !defined(IOS)
	int ret = system(command.c_str());
	std::stringstream buffer;
	buffer << ret;
	out = buffer.str();
	return true;
#endif
	return DKERROR("DKUtil::System(): not implemented on this OS\n");
}

bool DKUtil::TurnOffMonitor(){
	DKDEBUGFUNC();
#ifdef WIN32
	return DKWindows::TurnOffMonitor();
#endif
#ifdef MAC
	return DKMac::TurnOffMonitor();
#endif
#ifdef LINUX
	return DKLinux::TurnOffMonitor();
#endif
	return DKERROR("DKUtil::TurnOffMonitor() not implemented on this OS\n");
}

bool DKUtil::TurnOnMonitor(){
	DKDEBUGFUNC();
#ifdef WIN32
	return DKWindows::TurnOnMonitor();
#endif
	return DKERROR("DKUtil::TurnOnMonitor() not implemented on this OS\n");
}

bool DKUtil::UpdateFps(){
	//DKDEBUGFUNC();
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

	if(framecount < FRAME_VALUES)
		count = framecount;
	else
		count = FRAME_VALUES;

	framespersecond = 0;
	for(i = 0; i < count; i++)
		framespersecond += frametimes[i];
	framespersecond /= count;
	framespersecond = 1000.f / framespersecond;
	return true;
}

//https://stackoverflow.com/questions/63166/how-to-determine-cpu-and-memory-consumption-from-inside-a-process
bool DKUtil::VirtualMemory(unsigned long long& virtualMemory){
	DKDEBUGFUNC(virtualMemory);
#ifdef WIN32
	return DKWindows::VirtualMemory(virtualMemory);
#endif
#ifdef MAC
	return DKMac::VirtualMemory(virtualMemory);
#endif
#ifdef LINUX
	return DKLinux::VirtualMemory(virtualMemory);
#endif
	return DKERROR("DKUtil::VirtualMemory() not implemented on this OS\n");
}

bool DKUtil::VirtualMemoryUsed(unsigned long long& virtualMemory){
	DKDEBUGFUNC(virtualMemory);
#ifdef WIN32
	return DKWindows::VirtualMemoryUsed(virtualMemory);
#endif
#ifdef MAC
	return DKMac::VirtualMemoryUsed(virtualMemory);
#endif
#ifdef LINUX
	return DKLinux::VirtualMemoryUsed(virtualMemory);
#endif
	return DKERROR("DKUtil::VirtualMemoryUsed() not implemented on this OS\n");
}

bool DKUtil::VirtualMemoryUsedByApp(unsigned int& virtualMemory){
	DKDEBUGFUNC(virtualMemory);
#ifdef WIN32
	return DKWindows::VirtualMemoryUsedByApp(virtualMemory);
#endif
#ifdef MAC
	return DKMac::VirtualMemoryUsedByApp(virtualMemory);
#endif
#ifdef LINUX
	return DKLinux::VirtualMemoryUsedByApp(virtualMemory);
#endif
	return DKERROR("DKUtil::VirtualMemoryUsedByApp() not implemented on this OS\n");
}

bool DKUtil::WaitForImage(const DKString& file, int timeout){
	DKDEBUGFUNC(file, timeout);
#ifdef WIN32
	return DKWindows::WaitForImage(file, timeout);
#endif
	return DKERROR("DKUtil::WaitForImage() not implemented on this OS\n");
}

bool DKUtil::WheelDown(){
	DKDEBUGFUNC();
#ifdef WIN32
	return DKWindows::WheelDown();
#endif
	return DKERROR("DKUtil::WheelDown() not implemented on this OS\n");
}

bool DKUtil::WheelUp(){
	DKDEBUGFUNC();
#ifdef WIN32
	return DKWindows::WheelUp();
#endif
	return DKERROR("DKUtil::WheelUp() not implemented on this OS\n");
}
