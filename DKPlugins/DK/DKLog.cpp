#include "DK/stdafx.h"
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
extern bool log_thread = false;
extern bool log_lines = false;
extern bool log_funcs = false;
extern DKString log_show = ""; //comma seperated 
extern DKString log_hide = ""; //comma seperated 


///////////////////////////////////////////////////////////////////////////////////////////
void Log(const char* file, int line, const char* func, const DKString& text, const int lvl)
{
	DKString string;
	if(log_thread){
		unsigned long int threadId;
		DKUtil::GetThreadId(threadId);
		string += "TID:";
		string += toString((unsigned int)threadId);
		string += "  ";
	}
	if(log_lines){
		DKString filename = file;
		unsigned found = filename.find_last_of("/\\");
		if(found != std::string::npos && found < filename.length()){
			string += filename.substr(found+1);
		}
		string += ":";
		string += toString(line);
		string += "  ";
	}
	if(log_funcs){
		if(strlen(func)){
			string += func;
			string += "()  ";
		}
	}

	string += text;
	int i=0;
	DKString value;

#ifdef WIN32
	//check for LOG_HIDE
	if(!log_hide.empty()){
		DKStringArray hides;
		toStringArray(hides, log_hide, ",");
		for(unsigned int i=0; i<hides.size(); ++i){
			if(has(string,hides[i]) && !hides[i].empty()){
				return;
			}
		}
	}
#endif

	//check for LOG_SHOW
	bool flag = false;
#ifdef WIN32
	if(!log_show.empty()){
		DKStringArray shows;
		toStringArray(shows, log_show, ",");
		for(unsigned int i=0; i<shows.size(); ++i){
			if(has(string,shows[i]) && !shows[i].empty()){
				flag = true;
				break;
			}
		}
	}
#endif
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
			file_log << string.c_str();
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
		OutputDebugString(string.c_str()); //Output to Visual Studio
	}
#endif

#if defined(MAC) || defined (IOS)
	if(log_xcode){
		NSLog(@"%s", string.c_str()); //Output to XCode
	}
#endif

	printf("%s",string.c_str()); //THIS IS WHERE WE ACTUALLY PRINT TO THE CONSOLE

#ifdef WIN32
	SetConsoleTextAttribute(hConsole, saved_attributes);
#endif

#ifdef ANDROID
	if(lvl == DKERROR){
		__android_log_write(ANDROID_LOG_ERROR, "DKApp", string.c_str());
	}
	else if(lvl == DKWARN){
		__android_log_write(ANDROID_LOG_WARN, "DKApp", string.c_str());
	}
	else if(lvl == DKINFO){
		__android_log_write(ANDROID_LOG_INFO, "DKApp", string.c_str());
	}
	else if(lvl == DKDEBUG){
		__android_log_write(ANDROID_LOG_DEBUG, "DKApp", string.c_str());
	}
	else{
		__android_log_write(ANDROID_LOG_INFO, "DKApp", string.c_str());
	}
#endif

	if(log_gui_console && DKUtil::InMainThread() && DKApp::active){
		DKEvent::SendEvent("DKLog", "level", toString(lvl));
		DKEvent::SendEvent("DKLog", "string", string);
	}

	//send errors to a message box.
	if(log_errors && (lvl == DKERROR/* || has(string,"Uncaught ")*/)){
		DKClass::CallFunc("DKDebug::ShowStackTrace", NULL, NULL);  //TODO
		//DKString in = string;
		//DKClass::CallFunc("DKWindow::MessageBox", &in, NULL);
	}

}

////////////////////////////////////////////////
void SetLog(const int lvl, const DKString& text)
{
	DKLog("SetLog("+toString(lvl)+","+text+")\n", DKINFO);

	if(lvl == DKERROR){
		if(same(text,"OFF")){
			log_errors = false;
			return;
		}
		log_errors = true;
		
	}
	if(lvl == DKWARN){
		if(same(text,"OFF")){
			log_warnings = false;
			return;
		}
		log_warnings = true;
	}
	if(lvl == DKINFO){
		if(same(text,"OFF")){
			log_info = false;
			return;
		}
		log_info = true;
	}
	if(lvl == DKDEBUG){
		if(same(text,"ON")){
			log_debug = true;
			return;
		}
		log_debug = false;
	}
	if(lvl == DKSHOW){
		log_show = text;
	}
	if(lvl == DKHIDE){
		log_hide = text;
	}
}
