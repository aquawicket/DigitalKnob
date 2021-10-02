#include "DK/stdafx.h"
#include "DKLog.h"
#include "DKFile.h"
#include <cstring>
#ifdef WIN32
	#include <boxer/boxer.h>
#endif
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
extern bool stacktrace_on_errors = false;
extern bool exception_on_errors = false;

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

/*
void signal_handler(int signal) {
	gSignalStatus = signal;
}
*/

bool Log(const char* file, int line, const char* func, const DKString& input, const int lvl){
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
	if(!input.empty() && input.front() == '\n')
		//return DKASSERT("log text should never start with \\n")

	//check LOG_HIDE strings
	if(!log_hide.empty()){
		DKStringArray hides;
		toStringArray(hides, log_hide, ",");
		for(unsigned int i=0; i<hides.size(); ++i){
			if(!hides[i].empty() && has(input, hides[i]))
				return true;
		}
	}
	//check LOG_SHOW strings
	bool force = false;
	if(!log_show.empty()){
		DKStringArray shows;
		toStringArray(shows, log_show, ",");
		for(unsigned int i=0; i<shows.size(); ++i){
			if(!shows[i].empty() && has(input, shows[i])){
				force = true;
				break;
			}
		}
	}
	if(!force){
		if(log_fatal == false && lvl == DK_FATAL){ return false; }
		if(log_errors == false && lvl == DK_ERROR){ return false; }
		if(log_warnings == false && lvl == DK_WARN){ return true; }
		if(log_info == false && lvl == DK_INFO){ return true; }
		if(log_debug == false && lvl == DK_DEBUG){ return true; }
		if(log_verbose == false && lvl == DK_VERBOSE){ return true; }
	}

	DKString output;

	///// ADD extra info if requested
	if(log_thread){
		unsigned long int threadId;
		DKUtil::GetThreadId(threadId);
		output = output + "THREAD: " + toString((unsigned int)threadId) + "  ";
	}
	if(log_lines || lvl <= DK_ERROR) {
		DKString filename = file;
		unsigned found = filename.find_last_of("/\\");
		if(found != std::string::npos && found < filename.length())
			output += filename.substr(found+1);
		output = output + ":" + toString(line) + "  ";
	}
	if(log_funcs || lvl <= DK_ERROR) {
		if(strlen(func))
			output = output + func + "() ";
	}
	output += input; 

	/////// Main Console Color Decorators ///////
#ifdef WIN32
	WORD color;
	if(lvl == DK_ASSERT){ color = DKASSERT_COLOR; }
	if(lvl == DK_FATAL){ color = DKFATAL_COLOR; }
	if(lvl == DK_ERROR){ color = DKERROR_COLOR; }
	if(lvl == DK_WARN){ color = DKWARN_COLOR; }
    if(lvl == DK_INFO){ color = DKINFO_COLOR; }
	if(lvl == DK_DEBUG){ color = DKDEBUG_COLOR; }
	if(lvl == DK_VERBOSE){ color = DKVERBOSE_COLOR; }
	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
	CONSOLE_SCREEN_BUFFER_INFO consoleInfo;
	GetConsoleScreenBufferInfo(hConsole, &consoleInfo);
	WORD saved_attributes = consoleInfo.wAttributes;  // Save current attributes
	if(color)
		SetConsoleTextAttribute(hConsole, color);
#elif !defined(LINUX)
    char color[10];
	if(lvl == DK_ASSERT){ strcpy(color, DKASSERT_COLOR; }
	if(lvl == DK_FATAL){ strcpy(color, DKFATAL_COLOR; }
	if(lvl == DK_ERROR){ strcpy(color, DKERROR_COLOR; }
	if(lvl == DK_WARN){ strcpy(color, DKWARN_COLOR; }
    if(lvl == DK_INFO){ strcpy(color, DKINFO_COLOR; }
	if(lvl == DK_DEBUG){ strcpy(color, DKDEBUG_COLOR; }
	if(lvl == DK_VERBOSE){ strcpy(color, DKVERBOSE_COLOR; }
#endif

	/// /// ///  OUTPUTS /// /// ///

	//CONSOLE WINDOW OUTPUT
	printf("%s", output.c_str()); 
	//stdout << string;
						
	// File Output (log.txt)
	if(log_file && !DKFile::local_assets.empty()){
		std::ofstream file_log;
		file_log.open(DKString(DKFile::local_assets+"log.txt").c_str(), std::ofstream::out | std::ofstream::app);
		if(file_log.is_open()){
			file_log << output.c_str();
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

	//if(log_gui_console && DKUtil::InMainThread() && DKApp::active){
	//	DKEvents::SendEvent("DKLog", "level", toString(lvl));
	//	DKEvents::SendEvent("DKLog", "string", string);
	//}
	
	//On errors, show the stack trace or open a message box
	if(lvl <= DK_ERROR){
		if(stacktrace_on_errors || lvl <= DK_ASSERT){
			DKClass::DKCreate("DKDebug");
			if(DKClass::HasFunc("DKDebug::ShowStackTrace"))
				DKClass::CallFunc("DKDebug::ShowStackTrace");
		}
		if(exception_on_errors || lvl <= DK_ASSERT){	
			try{
				throw output; // throw an exception
			}
			//catch (const std::string& e){
			catch(...){
			#ifdef WIN32
				output += "\n\n Would you like to exit the application?";
				boxer::Selection sel = boxer::show(output.c_str(), "EXCEPTION", boxer::Style::Error, boxer::Buttons::YesNo);
				if(sel == boxer::Selection::Yes){
					DKApp::Exit();
					return false;
				}
			#endif
			}
		}
		return false;
	}
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
