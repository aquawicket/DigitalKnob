#pragma once
#ifndef DKLog_H
#define DKLog_H

#include "DKString.h"
#include <stdio.h>
#include <iostream>
//#if defined (MAC) || defined(IOS)
//	#import <Foundation/Foundation.h>
//#endif
#if !defined(IOS)
    #include <fstream>
#endif
#ifdef ANDROID
	#include <android/log.h>
#endif

#ifdef WIN32
	#define DKNORMAL FOREGROUND_RED|FOREGROUND_GREEN|FOREGROUND_BLUE
	#define DKWHITE FOREGROUND_RED|FOREGROUND_GREEN|FOREGROUND_BLUE|FOREGROUND_INTENSITY
	#define DKRED FOREGROUND_RED|FOREGROUND_INTENSITY
	#define DKDRKRED FOREGROUND_RED
	#define DKBLUE FOREGROUND_BLUE|FOREGROUND_GREEN|FOREGROUND_INTENSITY
	#define DKDRKBLUE FOREGROUND_BLUE|FOREGROUND_GREEN
	#define DKGREEN FOREGROUND_GREEN|FOREGROUND_INTENSITY
	#define DKDRKGREEN FOREGROUND_GREEN
	#define DKYELLOW FOREGROUND_RED|FOREGROUND_GREEN|FOREGROUND_INTENSITY
	#define DKBROWN FOREGROUND_RED|FOREGROUND_GREEN

	#define DKASSERT_COLOR  FOREGROUND_RED|FOREGROUND_INTENSITY|BACKGROUND_INTENSITY
	#define DKFATAL_COLOR   FOREGROUND_RED|FOREGROUND_INTENSITY|BACKGROUND_INTENSITY
	#define DKERROR_COLOR   FOREGROUND_RED|FOREGROUND_INTENSITY
	#define DKWARN_COLOR    FOREGROUND_RED|FOREGROUND_GREEN|FOREGROUND_INTENSITY
	#define DKINFO_COLOR    FOREGROUND_RED|FOREGROUND_GREEN|FOREGROUND_BLUE|FOREGROUND_INTENSITY
	#define DKDEBUG_COLOR   FOREGROUND_BLUE|FOREGROUND_GREEN
	#define DKVERBOSE_COLOR FOREGROUND_BLUE|FOREGROUND_GREEN|BACKGROUND_BLUE|FOREGROUND_INTENSITY	
#else
	#define DKNORMAL  "\x1B[0m"
	#define DKRED     "\x1B[31m"
	#define DKGREEN   "\x1B[32m"
	#define DKYELLOW  "\x1B[33m"
	#define DKBLUE    "\x1B[34m"
	#define DKDRKBLUE "\x1B[34m"
	#define DKMAG     "\x1B[35m"
	#define DKCYN     "\x1B[36m"
	#define DKWHITE   "\x1B[37m"

	#define DKASSERT_COLOR   "\x1B[36m"
	#define DKFATAL_COLOR    "\x1B[36m"
	#define DKERROR_COLOR    "\x1B[31m"
	#define DKWARN_COLOR     "\x1B[33m"
	#define DKINFO_COLOR     "\x1B[37m"
	#define DKDEBUG_COLOR    "\x1B[34m"
	#define DKVERBOSE_COLOR  "\x1B[34m"	
#endif

#define DK_ASSERT 1
#define DK_FATAL 2
#define DK_ERROR 3
#define DK_WARN 4
#define DK_INFO 5
#define DK_DEBUG 6
#define DK_VERBOSE 7
#define DK_SHOW 8
#define DK_HIDE 9


class DKLog {
public:
	static bool Clear(int& rtnvalue);
	static bool ColorMap();
	static bool Log(const char* file, int line, const char* func, const DKString& input, const int lvl = DK_INFO, const int color_override = 0);
	static bool SetLog(const int lvl, const DKString& text);

	static bool log_assert;
	static bool log_fatal;
	static bool log_errors;
	static bool log_warnings;
	static bool log_info;
	static bool log_debug;
	static bool log_verbose;
	static bool log_msvc;
	static bool log_xcode;
	static bool log_file;
	static bool log_gui_console;
	static bool log_thread;
	static bool log_lines;
	static bool log_funcs;
	static DKString log_show;
	static DKString log_hide;
	static bool stacktrace_on_errors;
	static bool exception_on_errors;
};


bool GetVersion(DKString& version);
bool GetBuildMonth(const char* buildDate, DKString& buildMonth);
bool GetBuildDay(const char* buildDate, DKString& buildDay);
bool GetBuildYear(const char* buildDate, DKString& buildYear);
bool GetBuildHour(const char* buildTime, DKString& buildHour);
bool GetBuildMinute(const char* buildTime, DKString& buildMinute);
bool GetBuildSecond(const char* buildTime, DKString& buildSecond);



//#ifndef ANDROID
void getTemplateArgs(std::ostringstream& out);

template <typename A, typename... Args>
void getTemplateArgs(std::ostringstream& out, A arg1, Args&&... args) {
	int arg_count = sizeof...(Args);
	std::ostringstream check_str;
	check_str << arg1;
	if(!check_str.str().empty())
		out << arg1;
	else
		out << "undefined";
	if(arg_count)
		out << ",";
    getTemplateArgs(out, args...);
}

template <typename... Args>
void DebugFunc(const char* file, int line, const char* func, const DKString& /*names*/, Args&&... args) {
	if(DKLog::log_show.empty() && !DKLog::log_debug)
		return;
	int arg_count = sizeof...(Args);
	//DKStringArray arg_names;
	//if(!names.empty())
	//	toStringArray(arg_names, names, ",");
	std::ostringstream out;
	getTemplateArgs(out, args...);
	DKStringArray arg_values;
	toStringArray(arg_values, out.str(), ",");
	DKString func_string = func;
	//if (arg_count)
	//	func_string += "( ";
	//else
		func_string += "(";
	for(int i=0; i<arg_count; ++i){
		//if(!names.empty()){
		//	func_string += arg_names[i];
		//	func_string += ":";
		//}
		func_string += arg_values[i];
		if(i < (arg_count-1))
			func_string += ", ";
	}
	//if (arg_count)
	//	func_string += " )\n";
	//else
		func_string += ")\n";
	DKLog::Log(file, line, "", func_string, DK_DEBUG);
}

template <typename... Args>
bool DebugReturn(const char* file, int line, const char* func, const DKString& /*names*/, Args&&... args) {
	if (DKLog::log_show.empty() && !DKLog::log_debug)
		return true;
	int arg_count = sizeof...(Args);
	//DKStringArray arg_names;
	//if (!names.empty())
	//	toStringArray(arg_names, names, ",");
	std::ostringstream out;
	getTemplateArgs(out, args...);
	DKStringArray arg_values;
	toStringArray(arg_values, out.str(), ",");
	DKString func_string = func;
	//if (arg_count)
	//	func_string += "( ";
	//else
		func_string += "(";
	for (int i = 0; i < arg_count; ++i) {
		if (i < (arg_count - 1)) {
			//if (!names.empty()) {
			//	func_string += arg_names[i];
			//	func_string += ":";
			//}
			func_string += arg_values[i];
			func_string += ", ";
		}
		else {
			func_string += ") -> ";
			//func_string += arg_names[i];
			//func_string += ":";
			func_string += arg_values[i];
		}
	}
	if (arg_count)
		func_string += "\n";
	else
		func_string += ")\n";
	DKLog::Log(file, line, "", func_string, DK_DEBUG);
	return true;
}
//#endif

class logy{
	public:
		logy(const std::string& context);
		~logy();
		static std::ostream* stream;
		const std::string context;
		const clock_t start_time;
};

/*
#include <csignal>
#include <iostream> 
namespace {
	volatile std::sig_atomic_t gSignalStatus;
}
void signal_handler(int signal);
*/

#define DKBUILDMONTH(buildMonth) GetBuildMonth(__DATE__, buildMonth);
#define DKBUILDDAY(buildDay) GetBuildDay(__DATE__, buildDay);
#define DKBUILDYEAR(buildYear) GetBuildYear(__DATE__, buildYear);
#define DKBUILDHOUR(buildHour) GetBuildHour(__TIME__, buildHour);
#define DKBUILDMINUTE(buildMinute) GetBuildMinute(__TIME__, buildMinute);
#define DKBUILDSECOND(buildSecond) GetBuildSecond(__TIME__, buildSecond);
#define  DKASSERT(message) DKLog::Log(__FILE__, __LINE__, __FUNCTION__, message, DK_ASSERT);
#define   DKFATAL(message) DKLog::Log(__FILE__, __LINE__, __FUNCTION__, message, DK_FATAL);
#define   DKERROR(message) DKLog::Log(__FILE__, __LINE__, __FUNCTION__, message, DK_ERROR);
#define    DKWARN(message) DKLog::Log(__FILE__, __LINE__, __FUNCTION__, message, DK_WARN);
#define    DKINFO(message) DKLog::Log(__FILE__, __LINE__, __FUNCTION__, message, DK_INFO);
#define   DKDEBUG(message) DKLog::Log(__FILE__, __LINE__, __FUNCTION__, message, DK_DEBUG);
#define DKVERBOSE(message) DKLog::Log(__FILE__, __LINE__, __FUNCTION__, message, DK_VERBOSE);
#define DKREDINFO(message) DKLog::Log(__FILE__, __LINE__, __FUNCTION__, message, DK_INFO, DKERROR_COLOR);

#define DEBUG_METHOD() logy _logy(__FUNCTION__);

#ifdef WIN32
	#define DKDEBUGFUNC1(__FILE__, __LINE__, __FUNCTION__, ...) DebugFunc(__FILE__, __LINE__, __FUNCTION__, #__VA_ARGS__, __VA_ARGS__)
	#define DKDEBUGRETURN1(__FILE__, __LINE__, __FUNCTION__, ...) DebugReturn(__FILE__, __LINE__, __FUNCTION__, #__VA_ARGS__, __VA_ARGS__)
	#define DKDEBUGFUNC(...) DKDEBUGFUNC1(__FILE__, __LINE__, __FUNCTION__, __VA_ARGS__)
	#define DKDEBUGRETURN(...) DKDEBUGRETURN1(__FILE__, __LINE__, __FUNCTION__, __VA_ARGS__)
#elif defined(APPLE) || defined(LINUX)
	#define DKDEBUGFUNC(...) DebugFunc(__FILE__, __LINE__, __FUNCTION__, "", ##__VA_ARGS__)
	#define DKDEBUGRETURN(...) DebugReturn(__FILE__, __LINE__, __FUNCTION__, "", ##__VA_ARGS__)
#else
	#define DKDEBUGFUNC(...) DKLog::Log(__FILE__, __LINE__, __FUNCTION__, "", DK_DEBUG)
	#define DKDEBUGRETURN(...) DKLog::Log(__FILE__, __LINE__, __FUNCTION__, "", DK_DEBUG)
#endif

/*
template <typename... Args>
void Test(const char* file, int line, const char* func, const DKString& names, Args&&... args){
	DKString str = "test";
	DKLog::Log(file, line, func, str, DKDEBUG);
}
#define TEST1(__FILE__, __LINE__, __FUNCTION__, ...)  Test(__FILE__, __LINE__, __FUNCTION__, #__VA_ARGS__, __VA_ARGS__)
#define TEST(...) TEST1(__FILE__, __LINE__, __FUNCTION__, __VA_ARGS__)
void Runit(){
	TEST(123);
	TEST("123");
	TEST();
}
*/


#endif //DKLog_H
