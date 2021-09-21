#pragma once
#ifndef DKLog_H
#define DKLog_H

#include "DKString.h"
#include <stdio.h>
#include <iostream>
#if defined (MAC) || defined(IOS)
	#import <Foundation/Foundation.h>
#endif
#if !defined(IOS)
    #include <fstream>
#endif
#ifdef ANDROID
	#include <android/log.h>
#endif

#ifdef WIN32
	#define DKFATAL_COLOR   FOREGROUND_RED|BACKGROUND_RED|FOREGROUND_INTENSITY|BACKGROUND_INTENSITY
	#define DKERROR_COLOR   FOREGROUND_RED|FOREGROUND_INTENSITY
	#define DKWARN_COLOR    FOREGROUND_RED|FOREGROUND_GREEN
	#define DKINFO_COLOR    0
	#define DKDEBUG_COLOR   FOREGROUND_BLUE|FOREGROUND_GREEN
	#define DKVERBOSE_COLOR FOREGROUND_BLUE|FOREGROUND_GREEN|BACKGROUND_BLUE|FOREGROUND_INTENSITY
#else
	#define DKFATAL_COLOR    "\x1B[31m"
	#define DKERROR_COLOR    "\x1B[33m"
	#define DKWARN_COLOR     "\x1B[35m"
	#define DKINFO_COLOR     "\x1B[0m"
	#define DKDEBUG_COLOR    "\x1B[37m"
	#define DKVERBOSE_COLOR  "\x1B[34m"
#endif
#define DK_FATAL 1
#define DK_ERROR 2
#define DK_WARN 3
#define DK_INFO 4
#define DK_DEBUG 5
#define DK_VERBOSE 6
#define DK_SHOW 7
#define DK_HIDE 8


extern bool log_fatal;
extern bool log_errors;
extern bool log_warnings;
extern bool log_info;
extern bool log_debug;
extern bool log_verbose;
extern bool log_msvc;
extern bool log_xcode;
extern bool log_file;
extern bool log_gui_console;
extern bool log_thread;
extern bool log_lines;
extern bool log_funcs;
extern DKString log_show;
extern DKString log_hide;


bool Log(const char* file, int line, const char* func, const DKString& text, const int lvl = DK_INFO);
void SetLog(const int lvl, const DKString& text);

#ifndef ANDROID
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
void DebugFunc(const char* file, int line, const char* func, const DKString& names, Args&&... args) {
	if(log_show.empty() && !log_debug)
		return;
	int arg_count = sizeof...(Args);
	DKStringArray arg_names;
	if(!names.empty())
		toStringArray(arg_names, names, ",");
	std::ostringstream out;
	getTemplateArgs(out, args...);
	DKStringArray arg_values;
	toStringArray(arg_values, out.str(), ",");
	DKString func_string = func;
	func_string += "( ";
	for(int i=0; i<arg_count; ++i){
		if(!names.empty()){
			func_string += arg_names[i];
			func_string += ":";
		}
		func_string += arg_values[i];
		if(i < (arg_count-1))
			func_string += ", ";
	}
	func_string += " )\n";
	Log(file, line, "", func_string, DK_DEBUG);
}
#endif

class logy{
	public:
		logy(const std::string& context);
		~logy();
		static std::ostream* stream;
		const std::string context;
		const clock_t start_time;
};

#define   DKFATAL(message) Log(__FILE__, __LINE__, __FUNCTION__, message, DK_FATAL);
#define   DKERROR(message) Log(__FILE__, __LINE__, __FUNCTION__, message, DK_ERROR);
#define    DKWARN(message) Log(__FILE__, __LINE__, __FUNCTION__, message, DK_WARN);
#define    DKINFO(message) Log(__FILE__, __LINE__, __FUNCTION__, message, DK_INFO);
#define   DKDEBUG(message) Log(__FILE__, __LINE__, __FUNCTION__, message, DK_DEBUG);
#define DKVERBOSE(message) Log(__FILE__, __LINE__, __FUNCTION__, message, DK_VERBOSE);
#define DEBUG_METHOD() logy _logy(__FUNCTION__);

#ifndef ANDROID
	#define DKDEBUGFUNC1(__FILE__, __LINE__, __FUNCTION__, ...) DebugFunc(__FILE__, __LINE__, __FUNCTION__, #__VA_ARGS__, __VA_ARGS__)
#ifdef WIN32
	#define DKDEBUGFUNC(...) DKDEBUGFUNC1(__FILE__, __LINE__, __FUNCTION__, __VA_ARGS__)
#else
	#define DKDEBUGFUNC(...) DebugFunc(__FILE__, __LINE__, __FUNCTION__, "", ##__VA_ARGS__)	
#endif
#else
	#define DKDEBUGFUNC(...) NULL
#endif

/*
template <typename... Args>
void Test(const char* file, int line, const char* func, const DKString& names, Args&&... args){
	DKString str = "test";
	Log(file, line, func, str, DKDEBUG);
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
