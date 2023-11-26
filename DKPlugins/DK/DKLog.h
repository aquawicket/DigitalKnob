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

#pragma once
#ifndef DKLog_H
#define DKLog_H

#include "DK/DKString.h"
#include "DK/DKTextColor.h"
#include "DK/DKUtil.h"

//WARNING_DISABLE
#include <stdio.h>
#include <iostream>
#if IOS
    #include <fstream>
#endif
#if ANDROID
	#include <android/log.h>
#endif
#if RTTI_ENABLED
	#include <type_traits>
#endif
//WARNING_ENABLE

//#define DK_ASSERT  1
#define DK_FATAL   2
#define DK_ERROR   3
#define DK_WARN    4
#define DK_INFO    5
#define DK_DEBUG   6
#define DK_VERBOSE 7
#define DK_SHOW    8
#define DK_HIDE    9

//#define  DKASSERT(message) DKLog::Log(__FILE__, __LINE__, __FUNCTION__, message, DK_ASSERT);//, DKASSERT_COLOR, false);
#define   DKFATAL(message) DKLog::Log(__FILE__, __LINE__, __FUNCTION__, message, DK_FATAL);//, DKFATAL_COLOR, false);
#define   DKERROR(message) DKLog::Log(__FILE__, __LINE__, __FUNCTION__, message, DK_ERROR);//, DKERROR_COLOR, false);
#define    DKWARN(message) DKLog::Log(__FILE__, __LINE__, __FUNCTION__, message, DK_WARN);
#define    DKINFO(message) DKLog::Log(__FILE__, __LINE__, __FUNCTION__, message, DK_INFO);
#define   DKDEBUG(message) DKLog::Log(__FILE__, __LINE__, __FUNCTION__, message, DK_DEBUG);
#define DKVERBOSE(message) DKLog::Log(__FILE__, __LINE__, __FUNCTION__, message, DK_VERBOSE);
#define DKREDINFO(message) DKLog::Log(__FILE__, __LINE__, __FUNCTION__, message, DK_INFO, DKERROR_COLOR);
#define    DKTODO() DKLog::Log(__FILE__, __LINE__, __FUNCTION__, DKString()+"TODO: "+__FUNCTION__+"()\n", DK_WARN);
#define    DKDEPRECATED() DKLog::Log(__FILE__, __LINE__, __FUNCTION__, DKString()+"DEPRECATED: "+__FUNCTION__+"()\n", DK_WARN);
//#define DKWARNRTN(message, rtnval) DKLog::Log(__FILE__, __LINE__, __FUNCTION__, message, DK_WARN, DKWARN_COLOR, rtnval);

#if WIN
#define DKDEBUGRETURN1(__FILE__, __LINE__, __FUNCTION__, ...) DebugReturn(__FILE__, __LINE__, __FUNCTION__, #__VA_ARGS__, __VA_ARGS__)
#define DKDEBUGRETURN(...) DKDEBUGRETURN1(__FILE__, __LINE__, __FUNCTION__, __VA_ARGS__)
#elif APPLE || LINUX || ANDROID || EMSCRIPTEN
#define DKDEBUGRETURN(...) DebugReturn(__FILE__, __LINE__, __FUNCTION__, #__VA_ARGS__, ##__VA_ARGS__)
#else
#define DKDEBUGRETURN(...) DKLog::Log(__FILE__, __LINE__, __FUNCTION__, "", DK_DEBUG)
#endif


class DKLog {
public:
	static bool Clear(int& rtnvalue);
	static bool Log(const char* file, int line, const char* func, const DKString& input, const int lvl = DK_INFO, const unsigned short color_override = 0/*, const bool rtnval = true*/);
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
bool GetBuildMonth(DKString& buildMonth);
bool GetBuildDay(DKString& buildDay);
bool GetBuildYear(DKString& buildYear);
bool GetBuildHour(DKString& buildHour);
bool GetBuildMinute(DKString& buildMinute);
bool GetBuildSecond(DKString& buildSecond);

template<typename S, typename T, typename = void>
struct is_streamable : std::false_type {};

template<typename S, typename T>
struct is_streamable<S, T, decltype(std::declval<S&>() << std::declval<T&>(), void())> : std::true_type {};

template<typename T, typename std::enable_if<is_streamable<std::ostream, T>::value>::type* = nullptr>
void printVariable(const DKString& name, T t, std::ostringstream& out){
	DKString type = "";
	DKString constant = "";
	std::ostringstream value;
	if (std::is_const<T>::value)
		constant = "const ";
	type = constant;
#	if RTTI_ENABLED
		if (typeid(t) == typeid(DKString))
			type += "DKString";
		else if (typeid(t) == typeid(char *))
			type += "char*";
		else
			type += typeid(t).name();
#	else
		type += "unknown";
#	endif
		value << "\"" << t << "\"";
	replace(type, " *", "*");
	if (same(value.str(), "\""))
		out << "<" << type << ">\"" << name << "\":";
	else
		out << "<" << type << ">\"" << name << "\":" << value.str();

}

template<typename T, typename std::enable_if<!is_streamable<std::ostream, T>::value>::type* = nullptr>
void printVariable(const DKString& name, T t, std::ostringstream& out){
	DKString type = "";
	DKString constant = "";
	std::ostringstream value;
	if (std::is_const<T>::value)
		constant = "const ";
	type = constant;
#	if RTTI_ENABLED
		if (typeid(t) == typeid(DKString))
			type += "DKString";
		else if (typeid(t) == typeid(char*))
			type += "char*";
		else
			type += typeid(t).name();
#	else
		type += "unknown";
#	endif
	value << "\"" << "[Object]" << "\"";
	replace(type, " *", "*");
	out << "<" << type << ">\"" << name << "\":" << value.str();
}

void getTemplateArgs(std::ostringstream& out);
void getTemplateArgs(std::ostringstream& out, DKStringArray& name_array);

template <typename A, typename... Args>
void getTemplateArgs(std::ostringstream& out, DKStringArray& name_array, A arg1, Args&&... args){
	printVariable(name_array[0], arg1, out); //use first name element
	name_array.erase(name_array.begin()); //remove first name element
	int arg_count = sizeof...(Args);
	if(arg_count){
		out << ",  ";
		getTemplateArgs(out, name_array, args...);
	}
}

template <typename... Args>
void DebugFunc(const char* file, int line, const char* func, const DKString& names, Args&&... args){
	if (!DKUtil::InMainThread())
		return;
	if(DKLog::log_show.empty() && !DKLog::log_debug)
		return;
	int arg_count = sizeof...(Args);	
	std::ostringstream out;
	DKStringArray name_array;
	toStringArray(name_array, names, ",");
	getTemplateArgs(out, name_array, args...);
	DKString func_string = func;
	func_string += "(";
	if(arg_count)
		func_string += "{ ";
	func_string += out.str();
	if (arg_count)
		func_string += " }";
	func_string += ")\n";
	DKLog::Log(file, line, "", func_string, DK_DEBUG);
}

template <typename... Args>
bool DebugReturn(const char* file, int line, const char* func, const DKString& names, Args&&... args){
	return true;
	if (!DKUtil::InMainThread())
		return true;
	if (DKLog::log_show.empty() && !DKLog::log_debug)
		return true;
	int arg_count = sizeof...(Args);
	std::ostringstream out;
	DKString func_string = func;
	func_string += "(";
	if(arg_count && !names.empty()){
		DKStringArray name_array;
		toStringArray(name_array, names, ","); 
		getTemplateArgs(out, name_array, args...);
		DKStringArray argArray;
		toStringArray(argArray, out.str(), ",");
		if (arg_count > 1){
			func_string += "{ ";
			for (int i = 0; i < arg_count; ++i){
				if (i < (arg_count - 1)){
					func_string += argArray[i];
					func_string += ", ";
				}
				else {
					if (arg_count > 1){
						func_string += " }";
						func_string += ")";
					}
					if (arg_count){
						func_string += " -> { ";
						func_string += argArray[i];
						func_string += " }";
					}
				}
			}
		}
	}
	//else{ //!arg_count
		func_string += ")";
	//}
	func_string += "\n";
	DKLog::Log(file, line, "", func_string, DK_DEBUG);
	return true;
}

/*
#include <csignal>
#include <iostream> 
namespace {
	volatile std::sig_atomic_t gSignalStatus;
}
void signal_handler(int signal);
*/




///////////////////// logy test code /////////////////////////////////////////////////
class logy {
public:
	template <typename... Args>
	logy(const char* file, int line, const char* func, const DKString& names, Args&&... args) : file(file), line(line), func(func), names(names), /*args(args...),*/ start_time(clock()){
		count++;
		if (!DKUtil::InMainThread())
			return;
		if (DKLog::log_show.empty() && !DKLog::log_debug)
			return;
		int arg_count = sizeof...(Args);
		std::ostringstream out;
		if(!names.empty()){
			DKStringArray name_array;
			toStringArray(name_array, names, ",");
			getTemplateArgs(out, name_array, args...);
		}
		DKString func_string = "";
		for (unsigned int i = 1; i < count; i++)
			func_string += "  ";
		func_string += "-> ";
		func_string += func;
		func_string += "(";
		if (arg_count)
			func_string += "{ ";
		func_string += out.str();
		if (arg_count)
			func_string += " }";
		func_string += ")\n";

		DKLog::Log(file, line, "", func_string, DK_DEBUG);
	};

	~logy(){
		count--;
		if (DKLog::log_show.empty() && !DKLog::log_debug)
			return;
		DKString func_string = "";
		for (unsigned int i = 0; i < count; i++)
			func_string += "  ";
		func_string += "<- ";
		func_string += toString(((double)(clock() - start_time) / CLOCKS_PER_SEC));
		func_string += "s \n";
		DKLog::Log(this->file.c_str(), this->line, "", func_string, DK_DEBUG);
	};

	static std::ostream* stream;
	static unsigned int count;
	const DKString file;
	const int line;
	const DKString func;
	const DKString names;
	const clock_t start_time;

	//https://stackoverflow.com/a/41201127
	//const Args&&... args;
};

//#if WIN
#if _MSC_VER
	#define DKDEBUGFUNC2(__FILE__, __LINE__, __FUNCTION__, ...) logy _logy(__FILE__, __LINE__, __FUNCTION__, #__VA_ARGS__, __VA_ARGS__)
	#define DKDEBUGFUNC(...) DKDEBUGFUNC2(__FILE__, __LINE__, __FUNCTION__, __VA_ARGS__)
#elif APPLE || LINUX || ANDROID || EMSCRIPTEN
	#define DKDEBUGFUNC(...) logy _logy(__FILE__, __LINE__, __FUNCTION__, #__VA_ARGS__, ##__VA_ARGS__)
#else
	#define DKDEBUGFUNC(...) DKLog::Log(__FILE__, __LINE__, __FUNCTION__, "", DK_DEBUG)
#endif
//////////////////////////////////////////////////////////////////////////////////////



#endif //DKLog_H
