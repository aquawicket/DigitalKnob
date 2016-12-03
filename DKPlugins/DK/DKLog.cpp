#include "stdafx.h"
#include "DKLog.h"
#include "DKFile.h"

extern bool log_errors = true;
extern bool log_warnings = true;
extern bool log_info = true;
extern bool log_debug = false;
extern bool log_msvc = false;
extern bool log_xcode = false;
extern bool log_file = true;
extern bool log_gui_console = true;
extern DKString log_show = ""; //comma seperated 
extern DKString log_hide = ""; //comma seperated 

void DKLog(const int text, const int lvl){ DKLog(toString(text),lvl); }
void DKLog(const long& text, const int lvl){ DKLog(toString(text),lvl); }
void DKLog(const unsigned long long text, const int lvl){ DKLog(toString(text),lvl); }
void DKLog(const float& text, const int lvl){ DKLog(toString(text),lvl); }

///////////////////////////////////////////////
void DKLog(const DKString& text, const int lvl)
{
	//FIXME: this is a file hog and slow. Do this in DKAssets and store the LOG_SHOW, LOG_HIDE variables.
	
	int i=0;
	DKString value;

	//check for LOG_HIDE
	DKStringArray hides;
	toStringArray(hides, log_hide, ",");
	for(int i=0; i<hides.size(); ++i){
		if(has(text,hides[i]) && !hides[i].empty()){
			return;
		}
	}

	/*
	while(DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_HIDE_"+toString(i)+"]", value)){
		if(has(text,value)){
			return;
		}
		i++;
	}
	*/

	//check for LOG_SHOW_n
	bool flag = false;
	DKStringArray shows;
	toStringArray(shows, log_show, ",");
	for(int i=0; i<shows.size(); ++i){
		if(has(text,shows[i]) && !shows[i].empty()){
			flag = true;
			break;
		}
	}

	/*
	i = 0;
	bool flag = false;
	while(DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_SHOW_"+toString(i)+"]", value)){
		if(has(text,value)){
			flag = true;
			break;
		}
		i++;
	}
	*/
	if(!flag){
		if(log_debug == false && lvl == DKDEBUG){ return; }
		if(log_info == false && lvl == DKINFO){ return; }
		if(log_warnings == false && lvl == DKWARN){ return; }
		if(log_errors == false && lvl == DKERROR){ return; }
	}
	
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
    if(lvl == DKINFO){ color = DKWHITE; }
	if(lvl == DKDEBUG){ color = DKBLUE; }
#elif !defined(LINUX)
    char color[10];// = 0;
	if(lvl == DKERROR){ strcpy(color, DKRED); }
	if(lvl == DKWARN){ strcpy(color, DKYELLOW); }
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
		SendEvent("DKLog", "level", toString(lvl));
		SendEvent("DKLog", "string", text);
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
