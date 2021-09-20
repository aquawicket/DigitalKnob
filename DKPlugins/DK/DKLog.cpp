#include "DK/stdafx.h"
#include "DKLog.h"
#include "DKFile.h"
#include <cstring>

extern bool log_fatal = true;      //console.assert()
extern bool log_errors = true;     //console.error()
extern bool log_warnings = true;   //console.warn()
extern bool log_info = true;       //console.info()
extern bool log_debug = false;     //console.debug()
extern bool log_verbose = false;   //console.verbose() //extra
extern bool log_msvc = false;
extern bool log_xcode = false;
extern bool log_file = true;
extern bool log_gui_console = true;
extern bool log_thread = false;
extern bool log_lines = false;
extern bool log_funcs = false;
extern DKString log_show = ""; //comma seperated 
extern DKString log_hide = ""; //comma seperated 

bool Clear(){
#ifdef WIN32
    system("cls");
    //clrscr(); // #include conio.h
#elif defined (LINUX)
    system("clear");
    //std::cout<< u8"\033[2J\033[1;1H"; //Escape Sequences Clear 
#elif defined (APPLE)
    system("clear");
#endif
	return true;
}

bool ColorMap(){
#ifdef WIN32
	// Save Current Colors
	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
	CONSOLE_SCREEN_BUFFER_INFO consoleInfo;
	GetConsoleScreenBufferInfo(hConsole, &consoleInfo);
	WORD saved_attributes = consoleInfo.wAttributes;  
	for(int k = 1; k < 255; k++){
		SetConsoleTextAttribute(hConsole, k);
		std::cout << k << "   Pick This Color ! :D   " << std::endl;
		//printf("   Pick This Color ! :D   ");
	}
	// Restore Original Colors
	SetConsoleTextAttribute(hConsole, saved_attributes); 
#endif
	return DKERROR("not implemented on this system");
}

bool Log(const char* file, int line, const char* func, const DKString& text, const int lvl){
	
	///  /// /// MESSAGE BUILDING /// /// ///
	DKString string;
	if(log_thread){
		unsigned long int threadId;
		DKUtil::GetThreadId(threadId);
		string = string + "TID:" + toString((unsigned int)threadId) + "  ";
	}
	if(log_lines || lvl == DK_ERROR || lvl == DK_FATAL) {
		DKString filename = file;
		unsigned found = filename.find_last_of("/\\");
		if(found != std::string::npos && found < filename.length())
			string += filename.substr(found+1);
		string = string + ":" + toString(line) + "  ";
	}
	if(log_funcs || lvl == DK_ERROR || lvl == DK_FATAL) {
		if(strlen(func))
			string = string + func + "() ";
	}
	string += text; 

	/// /// /// OUTPUT FILTERS /// /// ///
	int i=0;
	DKString value;
//#ifdef WIN32
	if(!log_hide.empty()){ //check for LOG_HIDE
		DKStringArray hides;
		toStringArray(hides, log_hide, ",");
		for(unsigned int i=0; i<hides.size(); ++i){
			if(has(string,hides[i]) && !hides[i].empty())
				return true;
		}
	}
//#endif
	//check for LOG_SHOW
	bool flag = false;
//#ifdef WIN32
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
//#endif
	if(!flag){
		if(log_fatal == false && lvl == DK_FATAL){ return false; }
		if(log_errors == false && lvl == DK_ERROR){ return false; }
		if(log_warnings == false && lvl == DK_WARN){ return true; }
		if(log_info == false && lvl == DK_INFO){ return true; }
		if(log_debug == false && lvl == DK_DEBUG){ return true; }
		if(log_verbose == false && lvl == DK_VERBOSE){ return true; }
	}

	/// /// Main Console Color Decorators /// ///
#ifdef WIN32
	int color;
	if(lvl == DK_FATAL){ color = DKFATAL_COLOR; }
	if(lvl == DK_ERROR){ color = DKERROR_COLOR; }
	if(lvl == DK_WARN){ color = DKWARN_COLOR; }
    if(lvl == DK_INFO){ color = DKINFO_COLOR; }
	if(lvl == DK_DEBUG){ color = DKDEBUG_COLOR; }
	if(lvl == DK_VERBOSE){ color = DKVERBOSE_COLOR; }
#elif !defined(LINUX)
    char color[10];
	if(lvl == DK_FATAL){ strcpy(color, DKFATAL_COLOR; }
	if(lvl == DK_ERROR){ strcpy(color, DKERROR_COLOR; }
	if(lvl == DK_WARN){ strcpy(color, DKWARN_COLOR; }
    if(lvl == DK_INFO){ strcpy(color, DKINFO_COLOR; }
	if(lvl == DK_DEBUG){ strcpy(color, DKDEBUG_COLOR; }
	if(lvl == DK_VERBOSE){ strcpy(color, DKVERBOSE_COLOR; }
#endif
#ifdef WIN32
	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
    CONSOLE_SCREEN_BUFFER_INFO consoleInfo;
    GetConsoleScreenBufferInfo(hConsole, &consoleInfo);
    WORD saved_attributes = consoleInfo.wAttributes;  // Save current attributes
	SetConsoleTextAttribute(hConsole, color);
#endif
	/// /// ///  OUTPUTS /// /// ///

	// MAIN CONSOLE Output
	printf("%s",string.c_str()); //APP CONSOLE OUT
						
	// File Output (log.txt)
	if(log_file && !DKFile::local_assets.empty()){
		std::ofstream file_log;
		file_log.open(DKString(DKFile::local_assets+"log.txt").c_str(), std::ofstream::out | std::ofstream::app);
		if(file_log.is_open()){
			file_log << string.c_str();
			file_log.close();
		}
	}

	// // // IDE Software Output
#if(log_msvc)
	OutputDebugString(string.c_str()); //Output to Visual Studio
#endif
#if defined(MAC) || defined (IOS)
	if(log_xcode)
		NSLog(@"%s", string.c_str()); //Output to XCode
#endif
#ifdef ANDROID
	// https://developer.android.com/ndk/reference/group/logging
	if(lvl == DK_FATAL) //Android Studio 
		__android_log_write(ANDROID_LOG_FATAL, "DKAndroid", string.c_str());
	else if(lvl == DK_ERROR) //Android Studio 
		__android_log_write(ANDROID_LOG_ERROR, "DKAndroid", string.c_str());
	else if(lvl == DK_WARN)
		__android_log_write(ANDROID_LOG_WARN, "DKAndroid", string.c_str());
	else if(lvl == DK_INFO)
		__android_log_write(ANDROID_LOG_INFO, "DKAndroid", string.c_str()); //Default
	else if(lvl == DK_DEBUG)
		__android_log_write(ANDROID_LOG_DEBUG, "DKAndroid", string.c_str());
	else if(lvl == DK_VERBOSE)
		__android_log_write(ANDROID_LOG_VERBOSE, "DKAndroid", string.c_str());
	else //if(lvl == DK_INFO)
		__android_log_write(ANDROID_LOG_INFO, "DKAndroid", string.c_str());
#endif

	// // // Restore Default Color Decorators
#ifdef WIN32
	SetConsoleTextAttribute(hConsole, saved_attributes);
#endif

	if (text.find('\n') == std::string::npos) //check for new line \n
		 return DKERROR("<------ \nText does not contain a new line character   \\n  \n");

	if(log_gui_console && DKUtil::InMainThread() && DKApp::active){
		DKEvents::SendEvent("DKLog", "level", toString(lvl));
		DKEvents::SendEvent("DKLog", "string", string);
	}
	//On errors show the stack trace or open a message box
	if(log_errors && (lvl == DK_ERROR)){
		//DKClass::CallFunc("DKDebug::ShowStackTrace", NULL, NULL);
		//DKString in = string;
		//DKClass::CallFunc("DKWindow::MessageBox", &in, NULL);
	}
	if(lvl == DK_ERROR)
		return false;
	return true;
}

bool SetLog(const int lvl, const DKString& text){
	DKDEBUGFUNC(lvl, text);
	((lvl == DK_ERROR) && same(text,"OFF")) ? log_errors = false :  log_errors = true;
	((lvl == DK_WARN)  && same(text,"OFF")) ? log_warnings = false : log_warnings = true;
	((lvl == DK_INFO) && same(text,"OFF")) ? log_info = false : log_info = true;
	((lvl == DK_DEBUG) && same(text,"ON")) ? log_debug = true : log_debug = false;
	if(lvl == DK_SHOW)
		log_show = text;
	if(lvl == DK_HIDE)
		log_hide = text;
	return true;
}


std::ostream* logy::stream = &std::cout;
logy::logy(const std::string& ctx) : context(ctx), start_time(clock()){
	*stream << "--> " << context << std::endl;
	stream->flush();
}
logy::~logy(){
	*stream << "<-- " << context;
	*stream << " in " << ((double)(clock() - start_time) / CLOCKS_PER_SEC) << "s";
	*stream << std::endl;
	stream->flush();
}

void getTemplateArgs(std::ostringstream& out){}
