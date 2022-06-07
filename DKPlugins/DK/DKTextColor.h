#pragma once
#ifndef DKTextColor_H
#define DKTextColor_H
#include <ostream>

#ifdef WIN32
	#define RESET    FOREGROUND_RED|FOREGROUND_GREEN|FOREGROUND_BLUE
	#define LTRED    FOREGROUND_RED|FOREGROUND_INTENSITY|BACKGROUND_INTENSITY
	#define RED      FOREGROUND_RED|FOREGROUND_INTENSITY
	#define DRKRED   FOREGROUND_RED
	#define GREEN    FOREGROUND_GREEN|FOREGROUND_INTENSITY
	#define DRKGREEN FOREGROUND_GREEN	
	#define YELLOW   FOREGROUND_RED|FOREGROUND_GREEN|FOREGROUND_INTENSITY	
	#define LTBLUE   FOREGROUND_BLUE|FOREGROUND_GREEN|BACKGROUND_BLUE|FOREGROUND_INTENSITY
	#define BLUE     FOREGROUND_BLUE|FOREGROUND_GREEN|FOREGROUND_INTENSITY
	#define DRKBLUE  FOREGROUND_BLUE|FOREGROUND_GREEN
	#define BROWN    FOREGROUND_RED|FOREGROUND_GREEN
	#define WHITE    FOREGROUND_RED|FOREGROUND_GREEN|FOREGROUND_BLUE|FOREGROUND_INTENSITY

	#define DKASSERT_COLOR  LTRED
	#define DKFATAL_COLOR   LTRED
	#define DKERROR_COLOR   RED
	#define DKWARN_COLOR    YELLOW
	#define DKINFO_COLOR    WHITE
	#define DKDEBUG_COLOR   DRKBLUE
	#define DKVERBOSE_COLOR LTBLUE

	//Desired Example
	// out << color(RED) << "hello world" << reset() << std::endl;
#else
	#define RESET		"\033[0m"			// RESET
	#define BLACK		"\033[30m"			// Black
	#define RED			"\033[31m"			// Red
	#define GREEN		"\033[32m"			// Green
	#define YELLOW		"\033[33m"			// Yellow
	#define BLUE		"\033[34m"			// Blue
	#define MAGENTA		"\033[35m"			// Magenta
	#define CYAN		"\033[36m"			// Cyan
	#define WHITE		"\033[37m"			// White
	#define BOLDBLACK   "\033[1m\033[30m"	// Bold Black
	#define BOLDRED     "\033[1m\033[31m"	// Bold Red
	#define BOLDGREEN   "\033[1m\033[32m"	// Bold Green
	#define BOLDYELLOW  "\033[1m\033[33m"	// Bold Yellow
	#define BOLDBLUE    "\033[1m\033[34m"	// Bold Blue
	#define BOLDMAGENTA "\033[1m\033[35m"	// Bold Magenta
	#define BOLDCYAN    "\033[1m\033[36m"	// Bold Cyan
	#define BOLDWHITE   "\033[1m\033[37m"	// Bold White

	#define DKASSERT_COLOR  CYAN
	#define DKFATAL_COLOR   CYAN
	#define DKERROR_COLOR   RED
	#define DKWARN_COLOR    YELLOW
	#define DKINFO_COLOR    WHITE
	#define DKDEBUG_COLOR   BLUE
	#define DKVERBOSE_COLOR BOLDBLUE

	//Desired Example
	// out << color(RED) << "hello world" << reset() << std::endl;
#endif

class DKTextColor{
public:
	static bool GetConsoleHandle(HANDLE& handle = hConsole);
	static bool PrintColors();
	static bool StoreColor(WORD& colorScheme = storedColorScheme);
	static bool RestoreColor(WORD& colorScheme = storedColorScheme);
	static HANDLE hConsole;
	static WORD storedColorScheme;
	static std::ostringstream out;
};

#endif //DKTextColor_H