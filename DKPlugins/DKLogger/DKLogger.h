#pragma once
#ifndef DKLogger_H
#define DKLogger_H

/*
#include <stdio.h>
#include <iostream>
#ifdef MAC
	#import <Foundation/Foundation.h>
#endif
#ifdef IOS
	#import <Foundation/Foundation.h>
#else 
	#include <fstream>
#endif
#ifdef ANDROID
	#include <android/log.h>
#endif
#include "DKString.h"


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

	#define DKFATAL_COLOR   FOREGROUND_RED|BACKGROUND_RED|FOREGROUND_INTENSITY|BACKGROUND_INTENSITY
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

	#define DKFATAL_COLOR    "\x1B[36m"
	#define DKERROR_COLOR    "\x1B[31m"
	#define DKWARN_COLOR     "\x1B[33m"
	#define DKINFO_COLOR     "\x1B[37m"
	#define DKDEBUG_COLOR    "\x1B[34m"
	#define DKVERBOSE_COLOR  "\x1B[34m"	
#endif


//    DKLogger values
//                      = blank aquals default setting for the corosponding variable
//                  1	= enabled all log traffic will be shown for the corosponding level
//                  0	= disabled all log traffic will be excluded for the corosponding level
//            strings   = (space seperated) will be shown for the corosponding level
//           -strings   = (space seperated) will be excluded for the corosponding level
//   "quoted strings"	= exact matches will be shown for the corosponding level
//  -"quoted strings"	= exact matches will be excluded for the corosponding level
 

extern enum DKLOG_LEVEL{ 
	DK_ASSERT,
	DK_FATAL,
	DK_ERROR,
	DK_WARN,
	DK_INFO,
	DK_DEBUG,
	DK_VERBOSE,
	DK_CONSOLE,
	DK_FILE,
	DK_GUI,
	DK_DEBUGGER,
	DK_DATE,
	DK_TIME,
	DK_FUNCION,
	DK_LINE,
	DK_THREAD,
	DK_TRACE
};


DKString& getLogSetting(DKLOG_LEVEL);
bool setLogSetting(DKLOG_LEVEL, const DKString&);

DKString logSettings[ sizeof(DKLOG_LEVEL) ];



// Log levels
extern DKString log_assert;
extern DKString log_fatal;
extern DKString log_errors;
extern DKString log_warnings;
extern DKString log_info;
extern DKString log_debug;
extern DKString log_verbose;  

// Log outputs
extern DKString log_console;
extern DKString log_file;
extern DKString log_gui;
extern DKString log_debugger;

// Log extra data
extern DKString log_date;
extern DKString log_time;
extern DKString log_functions;
extern DKString log_lines;
extern DKString log_threads;
extern DKString log_trace;

// OBSOLETE Log variables
//extern DKString log_msvc;  //OBSOLETE: now log_debugger
//extern DKString log_xcode; //OBSOLETE: now log_debugger
//extern DKString log_show;  //OBSOLETE: all levels can be shown by search parameters now
//extern DKString log_hide;  //OBSOLETE: all levels can be excluded by search parameters now


bool Clear();
bool ColorMap();
bool Log(const char* file, int line, const char* func, const DKString& text, const int lvl = DK_INFO);
bool SetLog(const int lvl, const DKString& text);
bool Trace();

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


#endif //DKLogger_H
