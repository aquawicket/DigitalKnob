#include "stdafx.h"
#include "DKLog.h"
#include "DKFile.h"

extern bool log_errors = true;
extern bool log_warnings = true;
extern bool log_success = true;
extern bool log_info = true;
extern bool log_debug = true;
extern bool log_msvc = false;
extern bool log_xcode = false;
extern bool log_file = true;
extern bool log_gui_console = true;

//void DKLog(const DKString& text){ DKLog(text,DKINFO); }
//void DKLog(const int text){ DKLog(toString(text),DKINFO); }
//void DKLog(const long& text){ DKLog(toString(text),DKINFO); }
//void DKLog(const unsigned long long text){ DKLog(toString(text),DKINFO); }
//void DKLog(const float& text){ DKLog(toString(text),DKINFO); }

void DKLog(const int text, const int lvl){ DKLog(toString(text),lvl); }
void DKLog(const long& text, const int lvl){ DKLog(toString(text),lvl); }
void DKLog(const unsigned long long text, const int lvl){ DKLog(toString(text),lvl); }
void DKLog(const float& text, const int lvl){ DKLog(toString(text),lvl); }

///////////////////////////////////////////////
void DKLog(const DKString& text, const int lvl)
{
	if(log_errors == false && lvl == DKERROR){ return; }
	if(log_warnings == false && lvl == DKWARN){ return; }
	if(log_success == false && lvl == DKSUCCESS){ return; }
	if(log_info == false && lvl == DKINFO){ return; }
	if(log_debug == false && lvl == DKDEBUG){ return; }

	if(log_file && !DKFile::local_assets.empty()){
		std::ofstream file_log;
		file_log.open(DKString(DKFile::local_assets+"log.txt").c_str(), std::ofstream::out | std::ofstream::app);
		if(file_log.is_open()){
			file_log << text.c_str();
			file_log.close();
		}
	}

#if defined(WIN32)
	int color;
	if(lvl == DKERROR){ color = DKRED; }
	if(lvl == DKWARN){ color = DKYELLOW; }
	if(lvl == DKSUCCESS){ color = DKGREEN; }
    if(lvl == DKINFO){ color = DKWHITE; }
	if(lvl == DKDEBUG){ color = DKBLUE; }
#elif !defined(LINUX)
    char color[10];// = 0;
	if(lvl == DKERROR){ strcpy(color, DKRED); }
	if(lvl == DKWARN){ strcpy(color, DKYELLOW); }
	if(lvl == DKSUCCESS){ strcpy(color, DKGREEN); }
    if(lvl == DKINFO){ strcpy(color, DKWHITE); }
	if(lvl == DKDEBUG){ strcpy(color, DKBLUE); }
#endif	

#ifdef WIN32
	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
    CONSOLE_SCREEN_BUFFER_INFO consoleInfo;
    GetConsoleScreenBufferInfo(hConsole, &consoleInfo);
    WORD saved_attributes = consoleInfo.wAttributes;  // Save current attributes
	SetConsoleTextAttribute(hConsole, color);
	if(log_msvc){
		OutputDebugString(text.c_str()); //Output to Visual Studio
	}
#endif

#if defined(MAC) || defined (IOS)
	if(log_xcode){
		NSLog(@"%s", text.c_str()); //Output to XCode
	}
#endif

	printf("%s",text.c_str());
	
	if(log_gui_console && DKUtil::InMainThread() && DKApp::active){
		DKString clr = "black"; //default
		if(lvl == DKERROR){ clr = "red"; }
		if(lvl == DKWARN){ clr = "yellow"; }
		if(lvl == DKSUCCESS){ clr = "green"; }
		//if(lvl == DKINFO){ clr = "black"; }
		if(lvl == DKDEBUG){ clr = "blue"; }
		SendEvent("DKLog", "color", clr);
		SendEvent("DKLog", "notify", text);
	}

#ifdef WIN32
	SetConsoleTextAttribute(hConsole, saved_attributes);
#endif

#ifdef ANDROID
	if(lvl == DKERROR){
		__android_log_write(ANDROID_LOG_ERROR, "DKApp", text.c_str());
	}
	else if(lvl == DKWARN){
		__android_log_write(ANDROID_LOG_WARN, "DKApp", text.c_str());
	}
	else if(lvl == DKSUCCESS){
		__android_log_write(ANDROID_LOG_INFO, "DKApp", text.c_str());
	}
	else if(lvl == DKINFO){
		__android_log_write(ANDROID_LOG_INFO, "DKApp", text.c_str());
	}
	else if(lvl == DKDEBUG){
		__android_log_write(ANDROID_LOG_DEBUG, "DKApp", text.c_str());
	}
	else{
		__android_log_write(ANDROID_LOG_INFO, "DKApp", text.c_str());
	}
#endif

}
