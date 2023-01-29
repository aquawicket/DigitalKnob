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
#ifndef DKTextColor_H
#define DKTextColor_H

WARNING_DISABLE
#include <ostream>
WARNING_ENABLE

#if WIN
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
	#define RESET		0  //"\033[0m"			// RESET
	#define BLACK		30 //"\033[30m"			// Black
	#define RED			31 //"\033[31m"			// Red
	#define GREEN		32 //"\033[32m"			// Green
	#define YELLOW		33 //"\033[33m"			// Yellow
	#define BLUE		34 //"\033[34m"			// Blue
	#define MAGENTA		35 //"\033[35m"			// Magenta
	#define CYAN		36 //"\033[36m"			// Cyan
	#define WHITE		37 //"\033[37m"			// White
	#define BOLDBLACK   40 //"\033[1m\033[30m"	// Bold Black
	#define BOLDRED     41 //"\033[1m\033[31m"	// Bold Red
	#define BOLDGREEN   42 //"\033[1m\033[32m"	// Bold Green
	#define BOLDYELLOW  43 //"\033[1m\033[33m"	// Bold Yellow
	#define BOLDBLUE    44 //"\033[1m\033[34m"	// Bold Blue
	#define BOLDMAGENTA 45 //"\033[1m\033[35m"	// Bold Magenta
	#define BOLDCYAN    46 //"\033[1m\033[36m"	// Bold Cyan
	#define BOLDWHITE   47 //"\033[1m\033[37m"	// Bold White

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
	static bool PrintColors();
#if WIN
	static bool GetConsoleHandle(HANDLE& handle = DKTextColor::hConsole);
	static bool StoreColor(WORD& colorScheme = DKTextColor::storedColorScheme);
	static bool RestoreColor(WORD& colorScheme = DKTextColor::storedColorScheme);
	static HANDLE hConsole;
	static WORD storedColorScheme;
#endif
	static std::ostringstream out;
};

#endif //DKTextColor_H