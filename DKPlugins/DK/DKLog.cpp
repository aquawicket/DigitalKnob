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
#include "DK/DKLog.h"
#include "DK/DKFile.h"

WARNING_DISABLE
#include <cstring>
#if HAVE_boxer
	#include <boxer/boxer.h>
#endif
#include <fstream>

#if WIN
	#include <debugapi.h> //OutputDebugString()
#endif
#if MAC || IOS
	#import <Foundation/Foundation.h>  //NSLog()
#endif
WARNING_ENABLE

bool DKLog::log_fatal = true;      //console.assert()
bool DKLog::log_errors = true;     //console.error()
bool DKLog::log_warnings = true;   //console.warn()
bool DKLog::log_info = true;       //console.info()
bool DKLog::log_debug = false;     //console.debug()
bool DKLog::log_verbose = false;   //console.verbose() //extra
bool DKLog::log_msvc = false;      //OutputDebugString()
bool DKLog::log_xcode = false;
bool DKLog::log_file = true;
bool DKLog::log_gui_console = true;
bool DKLog::log_thread = false;
bool DKLog::log_lines = false;
bool DKLog::log_funcs = false;
DKString DKLog::log_show = ""; //comma seperated 
DKString DKLog::log_hide = ""; //comma seperated
bool DKLog::stacktrace_on_errors = false;
bool DKLog::exception_on_errors = false;

bool GetVersion(DKString& version){
	DKString year;
	DKBUILDYEAR(year);
	version = year;
	DKString month;
	DKBUILDMONTH(month);
	version = version + "." + month;
	DKString day;
	DKBUILDDAY(day);
	version = version + "." + day;
	DKString hour;
	DKBUILDHOUR(hour);
	version = version + hour;
	/*
	DKString minute;
	DKBUILDMINUTE(minute);
	version = version + minute;
	DKString second;
	DKBUILDMINUTE(second);
	version = version + second;
	*/
	return true;
}

bool GetBuildMonth(const char* buildDate, DKString& buildMonth){
	buildMonth = buildDate;
	std::string::size_type found = buildMonth.find_first_of(" ");
	buildMonth = buildMonth.substr(0, found);
	if (buildMonth == "Jan")
		buildMonth = "01";
	if (buildMonth == "Feb")
		buildMonth = "02";
	if (buildMonth == "Mar")
		buildMonth = "03";
	if (buildMonth == "Apr")
		buildMonth = "04";
	if (buildMonth == "May")
		buildMonth = "05";
	if (buildMonth == "Jun")
		buildMonth = "06";
	if (buildMonth == "Jul")
		buildMonth = "07";
	if (buildMonth == "Aug")
		buildMonth = "08";
	if (buildMonth == "Sep")
		buildMonth = "09";
	if (buildMonth == "Oct")
		buildMonth = "10";
	if (buildMonth == "Nov")
		buildMonth = "11";
	if (buildMonth == "Dec")
		buildMonth = "12";
	return true;
}

bool GetBuildDay(const char* buildDate, DKString& buildDay){
	buildDay = buildDate;
	std::string::size_type foundA = buildDay.find_first_of(" ");
	std::string::size_type foundB = buildDay.find_first_of(" ", foundA);
	buildDay = buildDay.substr(foundA+1, foundB-1);
	return true;
}

bool GetBuildYear(const char* buildDate, DKString& buildYear){
	buildYear = buildDate;
	std::string::size_type found = buildYear.find_last_of(" ");
	buildYear = buildYear.substr(found+3);
	return true;
}

bool GetBuildHour(const char* buildTime, DKString& buildHour){
	buildHour = buildTime;
	std::string::size_type found = buildHour.find_first_of(":");
	buildHour = buildHour.substr(0, found);
	return true;
}

bool GetBuildMinute(const char* buildTime, DKString& buildMinute){
	buildMinute = buildTime;
	std::string::size_type foundA = buildMinute.find_first_of(":");
	std::string::size_type foundB = buildMinute.find_first_of(":", foundA);
	buildMinute = buildMinute.substr(foundA+1, foundB);
	return true;
}

bool GetBuildSecond(const char* buildTime, DKString& buildSecond){
	buildSecond = buildTime;
	std::string::size_type found = buildSecond.find_last_of(":");
	buildSecond = buildSecond.substr(found+1);
	return true;
}

bool DKLog::Clear(int& rtnvalue){
    return DKUtil::System("cls", rtnvalue);
}

/*
void signal_handler(int signal){
	gSignalStatus = signal;
}
*/

// https://stackoverflow.com/a/9371717/688352  - The command is slow on windows, read this
bool DKLog::Log(const char* file, int line, const char* func, const DKString& input, const int lvl, const unsigned short color_override/*, const bool rtnval*/){
	if (!DKUtil::InMainThread()) {
		if (lvl <= DK_ERROR)
			return false;
		return true;
	}
	/*
	if(lvl == DK_ASSERT){
		// Install a signal handler
		std::signal(SIGINT, signal_handler);
		std::cout << "SignalValue: " << gSignalStatus << '\n';
		std::cout << "Sending signal " << SIGINT << '\n';
		std::raise(SIGINT);
		std::cout << "SignalValue: " << gSignalStatus << '\n';
	}
	*/

	///////// OUTPUT FILTERS /////////
	//if(!input.empty() && input.front() == '\n')
		//return DKASSERT("bad practice to start a string with \\n")

	//check LOG_HIDE strings
	if (!log_hide.empty()){
		DKStringArray hides;
		toStringArray(hides, log_hide, " ");
		for (unsigned int i = 0; i < hides.size(); ++i){
			if (!hides[i].empty() && has(input, hides[i]))
				return true;
		}
	}
	//check LOG_SHOW strings
	bool force = false;
	if (!log_show.empty()){
		DKStringArray shows;
		toStringArray(shows, log_show, ",");
		for (unsigned int i = 0; i < shows.size(); ++i){
			if (!shows[i].empty() && has(input, shows[i])){
				force = true;
				break;
			}
		}
	}
	if (!force){
		if (log_fatal == false && lvl == DK_FATAL)     { return false; }
		if (log_errors == false && lvl == DK_ERROR)    { return false; }
		if (log_warnings == false && lvl == DK_WARN)   { return true; }
		if (log_info == false && lvl == DK_INFO)       { return true; }
		if (log_debug == false && lvl == DK_DEBUG)     { return true; }
		if (log_verbose == false && lvl == DK_VERBOSE) { return true; }
	}

	DKString output;
	std::stringstream ss;

	///// ADD extra info if requested
	if (log_thread){
		unsigned long int threadId;
		DKUtil::GetThreadId(threadId);
		output = output + "TID: " + toString((unsigned int)threadId) + "  ";
		ss << std::left << std::setw(10) << "TID: " + toString((unsigned int)threadId);
	}
	if (log_lines || lvl <= DK_ERROR){
		DKString filename = file;
		std::string::size_type found = filename.find_last_of("/\\");
		if (found != std::string::npos && found < filename.length())
			output += filename.substr(found + 1);
		output = output + ":" + toString(line) + "  ";
		ss << std::right << std::setw(25) << filename.substr(found + 1) + ":" + toString(line) << "  ";
	}
	if (log_funcs || lvl <= DK_ERROR){
		if (strlen(func)){
			output = output + func + "() ";
			ss << func << "() ";
		}
	}
	output += input;
	ss << input;

	/////// Main Console Color Decorators ///////
#	if WIN32
		WORD color = 0;
		if (!color_override){
			if (lvl == DK_ASSERT)  { color = DKASSERT_COLOR; }
			if (lvl == DK_FATAL)   { color = DKFATAL_COLOR; }
			if (lvl == DK_ERROR)   { color = DKERROR_COLOR; }
			if (lvl == DK_WARN)    { color = DKWARN_COLOR; }
			if (lvl == DK_INFO)    { color = DKINFO_COLOR; }
			if (lvl == DK_DEBUG)   { color = DKDEBUG_COLOR; }
			if (lvl == DK_VERBOSE) { color = DKVERBOSE_COLOR; }
		}
		else {
			color = color_override;
		}
		DKTextColor::StoreColor();
		if (color)
			DKTextColor::RestoreColor(color);
#	elif !LINUX
		char color[10];
		/*
		if(lvl == DK_ASSERT) { strcpy(color, (char*)DKASSERT_COLOR); }
		if(lvl == DK_FATAL)  { strcpy(color, (char*)DKFATAL_COLOR); }
		if(lvl == DK_ERROR)  { strcpy(color, (char*)DKERROR_COLOR); }
		if(lvl == DK_WARN)   { strcpy(color, (char*)DKWARN_COLOR); }
		if(lvl == DK_INFO)   { strcpy(color, (char*)DKINFO_COLOR); }
		if(lvl == DK_DEBUG)  { strcpy(color, (char*)DKDEBUG_COLOR); }
		if(lvl == DK_VERBOSE){ strcpy(color, (char*)DKVERBOSE_COLOR); }
		*/
#	endif

	//CONSOLE/TERMINAL WINDOW OUTPUT
	//printf("%s", output.c_str());
	std::cout << ss.str();
					
	// File Output (log.txt)
	if(log_file && !DKFile::local_assets.empty()){
		std::ofstream file_log;
		file_log.open(DKString(DKFile::local_assets+"log.txt").c_str(), std::ofstream::out | std::ofstream::app);
		if(file_log.is_open()){
			file_log << output.c_str();
			file_log.close();
		}
	}

	// // // IDE Software Console Output
#	if WIN
		if(log_msvc)
			OutputDebugString(output.c_str()); //Output to Visual Studio
#	endif
#	if MAC || IOS
		if(log_xcode)
			NSLog(@"%s", output.c_str()); //Output to XCode
#	endif
#	ifdef ANDROID
		// https://developer.android.com/ndk/reference/group/logging
		if(lvl == DK_FATAL) //Android Studio 
			__android_log_write(ANDROID_LOG_FATAL, "DKAndroid", output.c_str());
		else if(lvl == DK_ERROR) //Android Studio 
			__android_log_write(ANDROID_LOG_ERROR, "DKAndroid", output.c_str());
		else if(lvl == DK_WARN)
			__android_log_write(ANDROID_LOG_WARN, "DKAndroid", output.c_str());
		else if(lvl == DK_INFO)
			__android_log_write(ANDROID_LOG_INFO, "DKAndroid", output.c_str()); //Default
		else if(lvl == DK_DEBUG)
			__android_log_write(ANDROID_LOG_DEBUG, "DKAndroid", output.c_str());
		else if(lvl == DK_VERBOSE)
			__android_log_write(ANDROID_LOG_VERBOSE, "DKAndroid", output.c_str());
		else //if(lvl == DK_INFO)
			__android_log_write(ANDROID_LOG_INFO, "DKAndroid", output.c_str());
#	endif

	// // // Restore Default Color Decorators
#	if WIN32
		DKTextColor::RestoreColor();
#	endif

//	if(log_gui_console && DKUtil::InMainThread() && DKApp::active){
//		DKEvents::SendEvent("DKLog", "level", toString(lvl));
//		DKEvents::SendEvent("DKLog", "string", string);
//	}
	
	//On errors, show the stack trace or open a message box
	if(lvl <= DK_ERROR){
		if(stacktrace_on_errors || lvl <= DK_ASSERT){
			DKClass::DKCreate("DKDebug");
			if(DKClass::HasFunc("DKDebug::ShowStackTrace"))
				DKClass::CallFunc("DKDebug::ShowStackTrace");
		}
		if(exception_on_errors || lvl <= DK_ASSERT){
#			ifndef ANDROID //FIXME: change to DKEXCEPTIONS		
				try{
					throw output; // throw an exception
				}
				//catch (const std::string& e){
				catch(...){
#			endif
#			ifdef HAVE_boxer
					output += "\n\n Would you like to exit the application?";
					boxer::Selection sel = boxer::show(output.c_str(), "EXCEPTION", boxer::Style::Error, boxer::Buttons::YesNo);
					if(sel == boxer::Selection::Yes){
						DKApp::Exit();
						return false;
					}
#			endif
#			ifndef ANDROID //FIXME: change to DKEXCEPTIONS
				}
#			endif
		}
		return false;
	}
	return true;
}

bool DKLog::SetLog(const int lvl, const DKString& text){
	DKDEBUGFUNC(lvl, text);
	((lvl == DK_ERROR) && same(text,"OFF")) ? log_errors = false : log_errors = true;
	((lvl == DK_WARN)  && same(text,"OFF")) ? log_warnings = false : log_warnings = true;
	((lvl == DK_INFO) && same(text,"OFF")) ? log_info = false : log_info = true;
	((lvl == DK_DEBUG) && same(text,"ON")) ? log_debug = true : log_debug = false;
	if(lvl == DK_SHOW)
		log_show = text;
	if(lvl == DK_HIDE)
		log_hide = text;
	return true;
}

void getTemplateArgs(std::ostringstream& /*out*/){}
void getTemplateArgs(std::ostringstream& /*out*/, DKStringArray& /*names*/){}

///////////////////// logy test code /////////////////////////////////////////////////
std::ostream* logy::stream = &std::cout;
unsigned int logy::count = 0;
