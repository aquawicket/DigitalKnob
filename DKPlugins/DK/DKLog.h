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

#define DK_ERROR 1      //Red
#define DK_WARN 2       //Yellow
#define DK_INFO 3       //White
#define DK_DEBUG 4      //Blue
#define DK_SHOW 5
#define DK_HIDE 6

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

void Log(const char* file, int line, const char* func, const DKString& text, const int lvl = DK_INFO);
void SetLog(const int lvl, const DKString& text);

#ifndef ANDROID
template <typename... Args>
void DebugFunc(const char* file, int line, const char* func, Args&&... args)
{
	if(log_show.empty() && !log_debug){ return; }
	std::ostringstream out;
	out << func;
	out << "(";
	using expander = int[];
	(void) expander { 0, (void(out << args << ", "), 0) ...};
	out << ")\n";
	std::string text = out.str();
	replace(text, ", )", ")");
	Log(file, line, "", text, DK_DEBUG);
}

template <typename... Args>
void DebugVars(const char* file, int line, const char* func, const DKString& names, Args&&... args)
{
	std::stringstream names_ss;
	for(const char& c : names){
		if(c == ','){
			names_ss << " ";
			continue;
		}
		names_ss << c;
	}

	std::string name;
	std::ostringstream ss;
	
	DKString filename = file;
	unsigned found = filename.find_last_of("/\\");
	if(found != std::string::npos && found < filename.length()){
		filename = filename.substr(found+1);
	}

	using expander = int[];
	(void) expander { 0, (
		names_ss >> name, ss << "**DEBUG** " << filename << ":" << line << " " << func << "()   " << name << ": " << args << "\n"
	,0) ...};

	if(!log_debug){
		log_debug = true;
		Log("", 0, "", ss.str(), DK_DEBUG);
		log_debug = false; 
	}
	else{
		Log("", 0, "", ss.str(), DK_DEBUG);
	}
}
#endif

//#define DKLOG(...) Log(__FILE__, __LINE__, __FUNCTION__, ##__VA_ARGS__)
#define DKINFO(message) Log(__FILE__, __LINE__, __FUNCTION__, message, DK_INFO);
#define DKWARN(message) Log(__FILE__, __LINE__, __FUNCTION__, message, DK_WARN);
#define DKERROR(message) Log(__FILE__, __LINE__, __FUNCTION__, message, DK_ERROR);
#define DKDEBUG(message) Log(__FILE__, __LINE__, __FUNCTION__, message, DK_DEBUG);
#ifndef ANDROID
	#define DKDEBUGFUNC(...) DebugFunc(__FILE__, __LINE__, __FUNCTION__, ##__VA_ARGS__) //can be no args
	#define DKDEBUGVARS(...) DebugVars(__FILE__, __LINE__, __FUNCTION__, #__VA_ARGS__, __VA_ARGS__) //must have args
#else
	#define DKDEBUGFUNC(...) NULL
	#define DKDEBUGVARS(...) NULL
#endif

#endif //DKLog_H
