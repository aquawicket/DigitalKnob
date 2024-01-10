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
#include "DK/DKTextColor.h"

#if WIN
	HANDLE DKTextColor::hConsole = NULL;
	WORD DKTextColor::storedColorScheme = nullptr;
#endif
std::ostringstream DKTextColor::out;

/* DKTextColor::GetConsoleHandle( &handle )
	Print text colors to the console/terminal
	https://www.lihaoyi.com/post/BuildyourownCommandLinewithANSIescapecodes.html
*/
#if WIN
bool DKTextColor::GetConsoleHandle(HANDLE& handle){
	if (!handle)
		handle = GetStdHandle(STD_OUTPUT_HANDLE);
	return true;
}
#endif


/* DKTextColor::PrintColors()
	Print text colors to the console/terminal
	https://www.lihaoyi.com/post/BuildyourownCommandLinewithANSIescapecodes.html
*/
bool DKTextColor::PrintColors(){
	DKDEBUGFUNC();
#if WIN
	StoreColor();
	for(int k = 1; k < 255; k++){
		RestoreColor((WORD&)k);
		std::cout << k << "   Pick This Color ! :D   " << std::endl;
	}
	RestoreColor();
	return true;
#else
	return DKERROR("not implemented on this system");
#endif
}


/* DKTextColor::StoreCurrentColor( &colorScheme )
	Stored the current color scheme into the given varaible
	colorSceme: <WORD&> Optional variable to store the color. If excluded, DKTextColor::storedColorScheme will be used 
*/
#if WIN
bool DKTextColor::StoreColor(WORD& colorScheme){
	GetConsoleHandle();
	CONSOLE_SCREEN_BUFFER_INFO consoleInfo;
	GetConsoleScreenBufferInfo(hConsole, &consoleInfo);
	colorScheme = consoleInfo.wAttributes; 
	return true;
}
#endif


/* DKTextColor::RestoreStoredColor( &colorScheme )
	Restores a color scheme from variable
	colorSceme: <WORD&> Optional variable to restore the color from. If excluded, DKTextColor::storedColorScheme will be used
*/ 
#if WIN
bool DKTextColor::RestoreColor(WORD& colorScheme){
	GetConsoleHandle();
	SetConsoleTextAttribute(hConsole, colorScheme);
	return true;
}
#endif
