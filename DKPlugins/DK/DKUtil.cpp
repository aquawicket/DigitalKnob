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

//WARNING_DISABLE
#include <iostream>
#include <cstring>
#include <math.h>
#include <assert.h>
//#include <boost/asio.hpp> //Boost deprecated in the DKCore library
#ifndef WIN32
	#include <sys/time.h>
#endif
#if WIN
	#include <shellapi.h> //DKFile::Execute()
#endif
#ifndef MAC
	#include <fstream>
#endif
//WARNING_ENABLE

#include "DK/DKUtil.h"
#include "DK/DKLog.h"
#include "DK/DKFile.h"
#if WIN32
	#include "DKWindows.h"
#else
	#include "DKUnix.h"
#endif
#if LINUX
	#include "DKLinux.h"
#endif 
#if ANDROID
	#include "DKAndroid.h"
#endif 
#if MAC
	#include "DKMac.h"
#endif
#if IOS
	#include "DKIos.h"
#endif
#if EMSCRIPTEN
	#include "DKEmscripten.h"
#endif
	

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
#	ifndef MAC
		char *buf;
		//const char* ident  = "assets";
		unsigned int i, need_comma;
		//long file_size;
		size_t file_size;
		FILE* f_input = fopen(input.c_str(), "rb");
		if (!f_input)
			return DKERROR("can't open file for reading\n");
		// Get the file length
		fseek(f_input, 0, SEEK_END);
		file_size = ftell(f_input);
		fseek(f_input, 0, SEEK_SET);
		file_size++;
		buf = (char *)malloc(file_size);
		assert(buf);   
		fread(buf, file_size, 1, f_input);
		if(fclose(f_input))
			return DKERROR("fclose(f_input) failed\n");
		FILE* f_output = fopen(output.c_str(), "w");
		if(!f_output)
			return DKERROR("can't open file for writing\n");
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
			return DKERROR("fclose(f_output) failed\n");
		return true;
#	else //!MAC
		return DKERROR("not implemented on Mac OSX\n");
#	endif
}

bool DKUtil::C2Bin(const DKString hex, std::streamsize size, const char* fileOut) {
	DKDEBUGFUNC(hex, size, fileOut);
#	ifndef MAC
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
			return DKERROR("could not create file\n");
		return true;
#	else //!MAC
		return DKERROR("not implemented on Mac OSX\n");
#	endif
}

bool DKUtil::CallExit(){
	DKDEBUGFUNC();
#	if ANDROID
		CallJavaFunction("Exit","");
#	endif
#	if WIN32
		if(GetCurrentThreadId() != DKUtil::mainThreadId){   //GetCurrentThreadId not available for android
			DKWARN("DKApp::Exit(): Not called from the main thread\n");
		}
#	endif
	DKClass::CloseAll();
	return true;
}

bool DKUtil::CpuUsed(int& cpu){
	DKDEBUGFUNC(cpu);
#	if WIN32
		return DKWindows::CpuUsed(cpu);
#	elif MAC
		return DKMac::CpuUsed(cpu);
#	elif LINUX
		return DKLinux::CpuUsed(cpu);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::CpuUsedByApp(int& cpu){
	DKDEBUGFUNC(cpu);
#	if WIN32
		return DKWindows::CpuUsedByApp(cpu);
#	elif MAC
		return DKMac::CpuUsedByApp(cpu);
#	elif LINUX
		return DKLinux::CpuUsedByApp(cpu);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::DoubleClick(){
	DKDEBUGFUNC();
#	if WIN32
		DKWindows::LeftClick();
		return DKWindows::LeftClick();
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::DrawTextOnScreen(const DKString& text){
	DKDEBUGFUNC(text);
#	if WIN32
		return DKWindows::DrawTextOnScreen(text);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

// bool DKUTil::Execute(command, mode, stdouterr, rtncode)
// command:        The command to be executed
// mode:"r"        STDOUT_FILENO will be the writable, end of the pipe when the child process is started. 
//		           The file descriptor fileno(stream) in the calling process, where stream is the stream pointer returned by popen(), will be the writable end of the pipe.
// mode:"w"        STDIN_FILENO will be the readable, end of the pipe when the child process is started. 
//		           The file descriptor fileno(stream) in the calling process, where stream is the stream pointer returned by popen(), will be the writable end of the pipe.
// mode:any_other  A NULL pointer is returned and errno is set to EINVAL.
// stdouterr:      The returned error message if an error occures
// rtncode:        The return code of the command at exit. Default -1 is set and will evaluate the return error. May be overwritten. I.E. set to 0 to ignore errors 
bool DKUtil::Execute(const DKString& command, const DKString& mode, DKString& stdouterr, int& rtncode){
	DKDEBUGFUNC(command, mode, stdouterr, rtncode);
#	if WIN32
		auto& dk_popen = _popen;
		auto& dk_pclose = _pclose;
#	else
		auto& dk_popen = popen;
		auto& dk_pclose = pclose;
#	endif
	// https://stackoverflow.com/q/52164723/688352
	const DKString commandWithErr = command+" 2>&1"; //get stdout and stderr together
	FILE* pipe = dk_popen(commandWithErr.c_str(), mode.c_str());
	if(pipe == NULL)
		return DKERROR("pipe invalid: "+toString(strerror(errno))+"\n");
	char buffer[128]; //FIXME: do we need a bigger buffer?
	while(fgets(buffer, 128, pipe)){
		DKINFO(buffer); //print stdout and stderror to screen line by line
		stdouterr += buffer; //add the line to the output
	}
	if(!feof(pipe))
		DKERROR("feof(pipe) failed\n");
	if(rtncode == -1) //Skip if rtncode is overwritten, send in 0 to bypass error
		rtncode = dk_pclose(pipe);
	if(rtncode != 0)
		DKERROR("rtncode -> "+toString(rtncode)+": "+toString(strerror(errno))+"\n");
	trim(stdouterr);
	return true && DKDEBUGRETURN(command, mode, stdouterr, rtncode);
}

bool DKUtil::FindImageOnScreen(const DKString& file, int& x, int& y){
	DKDEBUGFUNC(file, x, y);
#	if WIN32
		return DKWindows::FindImageOnScreen(file, x, y);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::GetClipboard(DKString& text){
	DKDEBUGFUNC(text);
#	if WIN32
		return DKWindows::GetClipboard(text);
#	elif LINUX
		return DKLinux::GetClipboard(text);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::GetDate(DKString& date){
	DKDEBUGFUNC(date);
	time_t t = time(0);   // get time now
	struct tm* tm_now = localtime(&t);

	//int standard = now->tm_hour % 12;
	date = toString(tm_now->tm_mon+1);
	date += "/";
	DKString day = toString(tm_now->tm_mday);
	//Pad(2, '0', day);
	date += day;
	date += "/";
	date += toString(tm_now->tm_year + 1900);
	return true;
}

bool DKUtil::GetFps(unsigned int& fps){
	//DKDEBUGFUNC(fps);  //EXCESSIVE LOGGING
	fps = (unsigned int)framespersecond;
	return true;
}

bool DKUtil::GetFramerate(int& framerate){
	DKDEBUGFUNC(framerate);
	framerate = DKUtil::_fps;
	return true;
}

bool DKUtil::GetFrames(unsigned long& frames){
	DKDEBUGFUNC(frames);
	frames = framecount;
	return true;
}

bool DKUtil::GetKey(int& key){
	DKDEBUGFUNC("key");
#	if WIN32
		return DKWindows::GetKey(key);
#	elif !WIN32
		return DKUnix::GetKey(key);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::GetLocalIP(DKString& ip){
	DKDEBUGFUNC(ip);
	//https://www.tutorialspoint.com/how-to-get-the-ip-address-of-local-computer-using-c-cplusplus 
	/*
	boost::asio::io_service io_service; 
	boost::asio::ip::tcp::resolver resolver(io_service); 
	boost::asio::ip::tcp::resolver::query query(boost::asio::ip::tcp::v4(), boost::asio::ip::host_name(), ""); 
	boost::asio::ip::tcp::resolver::iterator it = resolver.resolve(query);
	boost::asio::ip::tcp::endpoint endpoint = *it; 
	ip = endpoint.address().to_string();
	*/
	ip = "boost depricated in the DKCore library";
	return true;
}

bool DKUtil::GetMousePos(int& x, int& y){
	DKDEBUGFUNC(x, y);
#	if WIN32
		return DKWindows::GetMousePos(x, y);
#	elif MAC
		return DKMac::GetMousePos(x, y);
#	elif LINUX
		return DKLinux::GetMousePos(x, y);
#	elif ANDROID
		return DKAndroid::GetMousePos(x, y);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::GetPixelFromImage(const DKString& image, int x, int y){
	DKDEBUGFUNC(image, x, y);
#	if WIN32
		return DKWindows::GetPixelFromImage(image, x, y);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::GetPixelFromScreen(int x, int y, int& r, int& g, int& b){
	DKDEBUGFUNC(x, y, r, g, b);
#	if WIN32
		return DKWindows::GetPixelFromScreen(x, y, r, g, b);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::GetProcessList(DKString& list){
#	if WIN32
		return DKWindows::GetProcessList(list) && DKDEBUGRETURN(list);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::GetScreenHeight(int& h){
#	if WIN32
		return DKWindows::GetScreenHeight(h) && DKDEBUGRETURN(h);
#	elif MAC
		return DKMac::GetScreenHeight(h) && DKDEBUGRETURN(h);
#	elif LINUX
		return DKLinux::GetScreenHeight(h);//&& DKDEBUGRETURN(h);
#	elif ANDROID
		return DKAndroid::GetScreenHeight(h);//&& DKDEBUGRETURN(h);
#	elif IOS
		return DKIos::GetScreenHeight(h);//&& DKDEBUGRETURN(h);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::GetScreenWidth(int& w){
#	if WIN32
		return DKWindows::GetScreenWidth(w) && DKDEBUGRETURN(w);
#	elif MAC
		return DKMac::GetScreenWidth(w) && DKDEBUGRETURN(w);
#	elif LINUX
		return DKLinux::GetScreenWidth(w);// && DKDEBUGRETURN(w);
#	elif ANDROID
		return DKAndroid::GetScreenWidth(w);// && DKDEBUGRETURN(w);
#	elif IOS
		return DKIos::GetScreenWidth(w);// && DKDEBUGRETURN(w);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::GetThreadId(unsigned long int& id){
	//DKDEBUGFUNC(id);  // DON'T DO THIS
	id = DKUtil::mainThreadId;
	return true;//&& DKDEBUGRETURN(id);
}

// https://people.cs.rutgers.edu/~pxk/416/notes/c-tutorials/gettime.html
// 1 second = 1000 milliseconds         1e+3
// 1 second = 1000000 microseconds      1e+6
// 1 second = 1000000000 nanoseconds    1e+9

bool DKUtil::GetTicks(long& ticks){
	//DKDEBUGFUNC(ticks);  //EXCESSIVE LOGGING
	//boost::posix_time::ptime tick = boost::posix_time::second_clock::local_time();
	//boost::posix_time::ptime now = boost::posix_time::second_clock::local_time();
	//boost::posix_time::time_duration diff = tick - now;
	//return (double)diff.total_milliseconds();
#	if WIN32
		ticks = GetTickCount();
		return true; //&& DKDEBUGRETURN(ticks)
#	else
		/*
		struct timeval tval;
		gettimeofday(&tval, NULL);
		ticks = ((tval.tv_sec * 1000) + (tval.tv_usec / 1000));
		return true;
		*/
		struct timespec ts;
		clock_gettime(CLOCK_MONOTONIC, &ts);
		ticks = ((ts.tv_sec * 1000) + (ts.tv_nsec / 1000000));
		return true; //&& DKDEBUGRETURN(ticks)
#	endif
}

bool DKUtil::GetTime(DKString& _time){
	DKDEBUGFUNC(_time);
	time_t t = time(0);   // get time now
	struct tm* tm_now = localtime(&t);
	int standard = tm_now->tm_hour % 12;
	if(standard == 0){ standard = 12; }
	_time = toString(standard);
	_time += ":";
	DKString minute = toString(tm_now->tm_min);
	Pad(2, '0', minute);
	_time += minute;
	if(tm_now->tm_hour > 12 || (tm_now->tm_hour % 12) == 0)
		_time += " PM";
	else
		_time += " AM";
	return true && DKDEBUGRETURN(_time);
}

bool DKUtil::GetUsername(DKString& username){
	DKDEBUGFUNC(username);
#	if WIN32
		return DKWindows::GetUsername(username) && DKDEBUGRETURN(username);
#	else
		return DKUnix::GetUsername(username) && DKDEBUGRETURN(username);
#	endif
}

bool DKUtil::GetVolume(int& percent){
	DKDEBUGFUNC(percent);
#	if WIN32
		return DKWindows::GetVolume(percent) && DKDEBUGRETURN(percent);
#	elif LINUX
		return DKLinux::GetVolume(percent) && DKDEBUGRETURN(percent);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::InMainThread(){
	//DKDEBUGFUNC(); // DON'T DO THIS
#	if WIN32
		return mainThreadId == GetCurrentThreadId();
#	elif MAC || IOS || ANDROID || LINUX || EMSCRIPTEN
		return mainThreadId == (unsigned long int)pthread_self(); //TODO: move this to DKUnix::InMainThread()
#	else 
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::InitFps(){
	DKDEBUGFUNC();
	memset(frametimes, 0, sizeof(frametimes)); // Set all frame times to 0ms
	return DKUtil::GetTicks(frametimelast);//&& DKDEBUGRETURN(frametimelast);
}

bool DKUtil::InitFramerate(){
	DKDEBUGFUNC();
	DKUtil::GetTicks(DKUtil::now);
	DKUtil::GetTicks(DKUtil::lastFrame);
	DKUtil::GetTicks(DKUtil::lastSecond);
	return true;
}

bool DKUtil::KeyIsDown(int& key){
	DKDEBUGFUNC(key);
#	if WIN32
		return DKWindows::KeyIsDown(key) && DKDEBUGRETURN(key);
#	elif LINUX
		return DKLinux::KeyIsDown(key) && DKDEBUGRETURN(key);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::LeftClick(){
	DKDEBUGFUNC();
#	if WIN32
		return DKWindows::LeftClick();
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::LeftPress(){
	DKDEBUGFUNC();
#	if WIN32
		return DKWindows::LeftPress();
#	elif MAC
		return DKMac::LeftPress();
#	elif LINUX
		return DKLinux::LeftPress();
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::LeftRelease(){
	DKDEBUGFUNC();
#	if WIN32
		return DKWindows::LeftRelease();
#	elif MAC
		return DKMac::LeftRelease();
#	elif LINUX
		return DKLinux::LeftRelease();
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::LimitFramerate(){
	//DKDEBUGFUNC();  //EXCESSIVE LOGGING
	if(!DKUtil::now)
		DKUtil::InitFramerate();
	//Framerate / cpu limiter
	DKUtil::GetTicks(DKUtil::now);
	long delta = DKUtil::now - DKUtil::lastFrame;
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
#	if WIN32
		return DKWindows::LowPowerMonitor();
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::MiddlePress(){
	DKDEBUGFUNC();
#	if WIN32
		return DKWindows::MiddlePress();
#	elif MAC
		return DKMac::MiddlePress();
#	elif LINUX
		return DKLinux::MiddlePress();
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::MiddleRelease(){
	DKDEBUGFUNC();
#	if WIN32
		return DKWindows::MiddleRelease();
#	elif MAC
		return DKMac::MiddleRelease();
#	elif LINUX
		return DKLinux::MiddleRelease();
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::PhysicalMemory(unsigned long long& physicalMemory){
	DKDEBUGFUNC(physicalMemory);
#	if WIN32
		return DKWindows::PhysicalMemory(physicalMemory) && DKDEBUGRETURN(physicalMemory);
#	elif MAC
		return DKMac::PhysicalMemory(physicalMemory) && DKDEBUGRETURN(physicalMemory);
#	elif LINUX
		return DKLinux::PhysicalMemory(physicalMemory) && DKDEBUGRETURN(physicalMemory);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::PhysicalMemoryUsed(unsigned long long& physicalMemory){
	DKDEBUGFUNC(physicalMemory);
#	if WIN32
		return DKWindows::PhysicalMemoryUsed(physicalMemory) && DKDEBUGRETURN(physicalMemory);
#	elif MAC
		return DKMac::PhysicalMemoryUsed(physicalMemory) && DKDEBUGRETURN(physicalMemory);
#	elif LINUX
		return DKLinux::PhysicalMemoryUsed(physicalMemory) && DKDEBUGRETURN(physicalMemory);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::PhysicalMemoryUsedByApp(unsigned long long& physicalMemory){
	DKDEBUGFUNC(physicalMemory);
#	if WIN32
		return DKWindows::PhysicalMemoryUsedByApp(physicalMemory) && DKDEBUGRETURN(physicalMemory);
#	elif MAC
		return DKMac::PhysicalMemoryUsedByApp(physicalMemory) && DKDEBUGRETURN(physicalMemory);
#	elif LINUX
		return DKLinux::PhysicalMemoryUsedByApp(physicalMemory) && DKDEBUGRETURN(physicalMemory);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::PressKey(const unsigned short& key){
	DKDEBUGFUNC(key);
#	if WIN32
		return DKWindows::PressKey(key);
#	elif MAC
		return DKMac::PressKey(key);
#	elif LINUX
		return DKLinux::PressKey(key);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::ReleaseKey(const unsigned short& key){
	DKDEBUGFUNC(key);
#	if WIN32
		return DKWindows::ReleaseKey(key);
#	elif MAC
		return DKMac::ReleaseKey(key);
#	elif LINUX
		return DKLinux::ReleaseKey(key);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::RightClick(){
	DKDEBUGFUNC();
#	if WIN32
		return DKWindows::RightClick();
//#	elif MAC
//		return DKMac::RightClick();
//#	elif LINUX
//		return DKLinux::RightClick();
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::RightPress(){
	DKDEBUGFUNC();
#	if WIN32
		return DKWindows::RightPress();
#	elif MAC
		return DKMac::RightPress();
#	elif LINUX
		return DKLinux::RightPress();
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::RightRelease(){
	DKDEBUGFUNC();
#	if WIN32
		return DKWindows::RightRelease();
#	elif MAC
		return DKMac::RightRelease();
#	elif LINUX
		return DKLinux::RightRelease();
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::Round(double& num){
	DKDEBUGFUNC(num);
	num = (num < 0.0 ? ceil(num - 0.5) : floor(num + 0.5));
	return true && DKDEBUGRETURN(num);
}

bool DKUtil::Run(const DKString& command, const DKString& params /*, rtnvalue*/) {
	DKDEBUGFUNC(command, params/*, rtnvalue*/);
#	if WIN32
		DKString error;
		PVOID OldValue = NULL;
		//  Disable redirection immediately prior to the native API function call.
		if(!Wow64DisableWow64FsRedirection(&OldValue)){
			DKWindows::GetLastError(error);
			return DKERROR("Wow64DisableWow64FsRedirection() failed: "+error+"\n");
		}
		//https://msdn.microsoft.com/en-us/library/windows/desktop/bb762153(v=vs.85).aspx
		if(ShellExecute(NULL, "open", command.c_str(), params.c_str(), NULL, SW_SHOWNORMAL) < (HINSTANCE)32){
			DKWindows::GetLastError(error);
			return DKERROR("ShellExecute() failed: "+error+"\n");
		}
		//  Immediately re-enable redirection. 
		if(Wow64RevertWow64FsRedirection(OldValue) == FALSE){
			DKWindows::GetLastError(error);
			return DKERROR("Wow64RevertWow64FsRedirection() failed: "+error+"\n");    
		}
		return true;
#	elif LINUX
		int rtnvalue;
		return DKLinux::Run(command, rtnvalue);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::SetBrightness(const int& percent){
	DKDEBUGFUNC(percent);
#	if WIN32
		return DKWindows::SetBrightness(percent);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

//TODO - This timer needs to be moved to DKRml
//       Duktape currently blocks when using timers, so we've placed it here for now.
//       Send a timer event every second
bool DKUtil::SendTick(){
	//DKDEBUGFUNC();  //EXCESSIVE LOGGING
	if(((lastFrame / 1000) - (lastSecond / 1000)) >= 1){ //1 second
		DKEvents::SendEvent("window", "second", "");
		DKUtil::GetTicks(lastSecond);
	}
	return true;
}

bool DKUtil::SetClipboard(const DKString& text){
	DKDEBUGFUNC(text);
#	if WIN32
		return DKWindows::SetClipboard(text);
//#	elif MAC
//		return DKMac::SetClipboard(text);
#	elif LINUX
		return DKLinux::SetClipboard(text);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::SetClipboardFiles(const DKString& filelist){
	DKDEBUGFUNC(filelist);
#	if WIN32
		return DKWindows::SetClipboardFiles(filelist);
//#	elif MAC
//		return DKMac::SetClipboardFiles(filelist);
//#	elif LINUX
//		return DKLinux::SetClipboardFiles(filelist);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::SetClipboardImage(const DKString& file){
	DKDEBUGFUNC(file);
#	if WIN32
		return DKWindows::SetClipboardImage(file);
//#	elif MAC
//		return DKMac::SetClipboardImage(file);
//#	elif LINUX
//		return DKLinux::SetClipboardImage(file);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::SetFramerate(const int& fps){
	DKDEBUGFUNC(fps);
	_fps = fps;
	if(_fps == 0){
		ticksPerFrame = 0; 
		return true;
	}
	ticksPerFrame = 1000 / _fps;
	return true;
}

bool DKUtil::SetMainThreadNow(){
	DKDEBUGFUNC();
	//ONLY SET THIS FROM THE MAIN THREAD ONCE
#	if WIN
		DKUtil::mainThreadId = GetCurrentThreadId();
		return true;
#	elif MAC || IOS || LINUX || ANDROID || EMSCRIPTEN
		DKUtil::mainThreadId = (unsigned long int)pthread_self();
		return true;
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::SetMousePos(const int& x, const int& y){
	DKDEBUGFUNC(x, y);
#	if WIN32
			return DKWindows::SetMousePos(x, y);
#	elif MAC
		return DKMac::SetMousePos(x, y);
#	elif LINUX
		return DKLinux::SetMousePos(x, y);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::SetVolume(int& percent){
	DKDEBUGFUNC(percent);
#	if WIN32
		return DKWindows::SetVolume(percent);
#	elif LINUX
		return DKLinux::SetVolume(percent);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::Sleep(const int& milliseconds){
	//DKDEBUGFUNC(milliseconds);  //EXCESSIVE LOGGING
#	if WIN32
		return DKWindows::Sleep(milliseconds);
#	elif MAC || IOS || ANDROID || LINUX || EMSCRIPTEN
		return DKUnix::Sleep(milliseconds);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::StrokeKey(const unsigned short& key){
	DKDEBUGFUNC(key);
#	if WIN32
		return DKWindows::StrokeKey(key);
#	elif LINUX
		return DKLinux::StrokeKey(key);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::System(const DKString& command, int& rtnvalue){
		DKDEBUGFUNC(command);
#	if !defined(IOS)
		rtnvalue = std::system(command.c_str());
		return true;
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::TurnOffMonitor(){
	DKDEBUGFUNC();
#	if WIN32
		return DKWindows::TurnOffMonitor();
#	elif MAC
		return DKMac::TurnOffMonitor();
#	elif LINUX
		int rtnvalue;
		return DKLinux::TurnOffMonitor(rtnvalue);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::TurnOnMonitor(){
	DKDEBUGFUNC();
#	if WIN32
		return DKWindows::TurnOnMonitor();
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::UpdateFps(){
	//DKDEBUGFUNC();  //EXCESSIVE LOGGING
	if(!frametimelast)
		DKUtil::InitFps();
	long frametimesindex;
	long getticks;
	long count;
	long i;
	// frametimesindex is the position in the array. It ranges from 0 to FRAME_VALUES.
	// This value rotates back to 0 after it hits FRAME_VALUES.
	frametimesindex = framecount % FRAME_VALUES;
	DKUtil::GetTicks(getticks);								// store the current time
	frametimes[frametimesindex] = getticks - frametimelast;	// save the frame time value
	frametimelast = getticks;								// save the last frame time for the next UpdateFps()
	framecount++;											// increment the frame count
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
#	if WIN32
		return DKWindows::VirtualMemory(virtualMemory) && DKDEBUGRETURN(virtualMemory);
#	elif MAC
		return DKMac::VirtualMemory(virtualMemory) && DKDEBUGRETURN(virtualMemory);
#	elif LINUX
		return DKLinux::VirtualMemory(virtualMemory) && DKDEBUGRETURN(virtualMemory);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::VirtualMemoryUsed(unsigned long long& virtualMemory){
	DKDEBUGFUNC(virtualMemory);
#	if WIN32
		return DKWindows::VirtualMemoryUsed(virtualMemory) && DKDEBUGRETURN(virtualMemory);
#	elif MAC
		return DKMac::VirtualMemoryUsed(virtualMemory) && DKDEBUGRETURN(virtualMemory);
#	elif LINUX
		return DKLinux::VirtualMemoryUsed(virtualMemory) && DKDEBUGRETURN(virtualMemory);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::VirtualMemoryUsedByApp(unsigned long long& virtualMemory){
	DKDEBUGFUNC(virtualMemory);
#	if WIN32
		return DKWindows::VirtualMemoryUsedByApp(virtualMemory) && DKDEBUGRETURN(virtualMemory);
#	elif MAC
		return DKMac::VirtualMemoryUsedByApp(virtualMemory) && DKDEBUGRETURN(virtualMemory);
#	elif LINUX
		return DKLinux::VirtualMemoryUsedByApp(virtualMemory) && DKDEBUGRETURN(virtualMemory);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::WaitForImage(const DKString& file, int timeout){
	DKDEBUGFUNC(file, timeout);
#	if WIN32
		return DKWindows::WaitForImage(file, timeout);
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::WheelDown(){
	DKDEBUGFUNC();
#	if WIN32
		return DKWindows::WheelDown();
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}

bool DKUtil::WheelUp(){
	DKDEBUGFUNC();
#	if WIN32
		return DKWindows::WheelUp();
#	else
		return DKERROR("not implemented on this OS\n");
#	endif
}
