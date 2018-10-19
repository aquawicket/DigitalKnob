#pragma once
#ifndef DKLog_H
#define DKLog_H

#if defined (MAC) || defined(IOS)
	#import <Foundation/Foundation.h>
#endif

#ifdef ANDROID
	#include <android/log.h>
#endif

#include "DKString.h"
#include <stdio.h>
#if !defined(IOS)
    #include <fstream>
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
#else
#define DKNORMAL  "\x1B[0m"
#define DKRED  "\x1B[31m"
#define DKGREEN  "\x1B[32m"
#define DKYELLOW  "\x1B[33m"
#define DKBLUE  "\x1B[34m"
#define DKDRKBLUE  "\x1B[34m"
#define DKMAG  "\x1B[35m"
#define DKCYN  "\x1B[36m"
#define DKWHITE  "\x1B[37m"
#endif

#define DKERROR 1      //Red
#define DKWARN 2       //Yellow
#define DKINFO 3       //White
#define DKDEBUG 4      //Blue
#define DKSHOW 5
#define DKHIDE 6

extern bool log_errors;
extern bool log_warnings;
extern bool log_info;
extern bool log_debug;
extern bool log_msvc;
extern bool log_xcode;
extern bool log_file;
extern bool log_gui_console;
extern bool log_thread;
extern bool log_lines;
extern bool log_funcs;
extern DKString log_show;
extern DKString log_hide;

void Log(const char* file, int line, const char* func, const DKString& text, const int lvl = DKINFO);
void SetLog(const int lvl, const DKString& text);

template <typename... Args>
void DEBUG_VARS(const char* file, int line, const char* func, Args&&... args)
{
	std::ostringstream out;
	out << func;
	out << "(";
	using expander = int[];
	(void) expander { 0, (void(out << args << ", "), 0) ...};
	out << ")\n";
	std::string text = out.str();
	replace(text, ", )", ")");
	Log(file, line, "", text);
}

#define DKLog(...) Log(__FILE__, __LINE__, __FUNCTION__, __VA_ARGS__)
#define DKDebug(...) DEBUG_VARS(__FILE__, __LINE__, __FUNCTION__, __VA_ARGS__)

/*
#ifdef WIN32
#define DKLog(...) Log(__FILE__, __LINE__, __FUNCTION__, __VA_ARGS__)
#define DKDebug(...) DEBUG_VARS(__FILE__, __LINE__, __FUNCTION__, __VA_ARGS__)
#else
#define DKLog(...) Log(__FILE__, __LINE__, __PRETTY_FUNCTION__, __VA_ARGS__)
#endif
//#define DKCHECK(_bool) {if(!_bool){DKLog("FAILURE: ", DKERROR);}}
*/

#endif //DKLog_H
