#include "DK/stdafx.h"
#include "DKTextColor.h"

HANDLE DKTextColor::hConsole = NULL;
WORD DKTextColor::storedColorScheme = NULL;
std::ostringstream DKTextColor::out;

/* DKTextColor::GetConsoleHandle( &handle )
	Print text colors to the console/terminal
	https://www.lihaoyi.com/post/BuildyourownCommandLinewithANSIescapecodes.html
*/
bool DKTextColor::GetConsoleHandle(HANDLE& handle){
	if (!handle)
		handle = GetStdHandle(STD_OUTPUT_HANDLE);
	return true;
}


/* DKTextColor::PrintColors()
	Print text colors to the console/terminal
	https://www.lihaoyi.com/post/BuildyourownCommandLinewithANSIescapecodes.html
*/
bool DKTextColor::PrintColors(){
#	ifdef WIN
		StoreColor();
		for(int k = 1; k < 255; k++){
			RestoreColor((WORD&)k);
			std::cout << k << "   Pick This Color ! :D   " << std::endl;
		}
		RestoreColor();
		return true;
#	endif
	return DKERROR("not implemented on this system");
}


/* DKTextColor::StoreCurrentColor( &colorScheme )
	Stored the current color scheme into the given varaible
	colorSceme: <WORD&> Optional variable to store the color. If excluded, DKTextColor::storedColorScheme will be used 
*/
#ifdef WIN
bool DKTextColor::StoreColor(WORD& colorScheme){
	GetConsoleHandle();
	CONSOLE_SCREEN_BUFFER_INFO consoleInfo;
	GetConsoleScreenBufferInfo(hConsole, &consoleInfo);
	colorScheme = consoleInfo.wAttributes; 
	return true;
}
#endif //WIN


/* DKTextColor::RestoreStoredColor( &colorScheme )
	Restores a color scheme from variable
	colorSceme: <WORD&> Optional variable to restore the color from. If excluded, DKTextColor::storedColorScheme will be used
*/ 
#ifdef WIN
bool DKTextColor::RestoreColor(WORD& colorScheme){
	GetConsoleHandle();
	SetConsoleTextAttribute(hConsole, colorScheme);
	return true;
}
#endif //WIN