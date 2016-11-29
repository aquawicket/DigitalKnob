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
#include <fstream>

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

#define DKERROR 0      //Red
#define DKWARN 1       //Yellow
#define DKSUCCESS 2    //Green
#define DKINFO 3       //White
#define DKDEBUG 4      //Blue
#define DKFILTER 5      //Orange

extern bool log_errors;
extern bool log_warnings;
extern bool log_success;
extern bool log_info;
extern bool log_debug;
extern bool log_msvc;
extern bool log_xcode;
extern bool log_file;
extern bool log_gui_console;
extern bool log_filter_all;

//void DKLog(const DKString& text);
//void DKLog(const int text);
//void DKLog(const long& text);
//void DKLog(const unsigned long long& text);
//void DKLog(const float& text);

void DKLog(const DKString& text, const int lvl);
void DKLog(const int text, const int lvl);
void DKLog(const long& text, const int lvl);
void DKLog(const unsigned long long& text, const int lvl);
void DKLog(const float& text, const int lvl);

#endif //DKLog_H
