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
#ifndef DKConsoleWindow_H
#define DKConsoleWindow_H

#include "DK/DK.h"
#include "DKEventTargetTest/DKWindow.h"

#if WIN
	#include <windows.h>
	#include <tchar.h>
	#include <stdio.h>
#else	
	#include <curses.h>
#endif

class DKConsoleWindow : public DKWindow
{
public:
	DKConsoleWindow() : DKWindow() {
		DKDEBUGFUNC();
		//DKINFO("DKConsoleWindow::Init() \n");
		
		#if !WIN && !EMSCRIPTEN && !ANDROID
			SCREEN *screen = newterm((char *) 0, stdout, stdin);
			if(!screen){
				DKERROR("screen invalid! \n");
				return;
			}
		#endif

		#if WIN
			// Get the standard input handle. 
			hStdin = GetStdHandle(STD_INPUT_HANDLE);
			if (hStdin == INVALID_HANDLE_VALUE)
				ErrorExit("GetStdHandle");

			// Save the current input mode, to be restored on exit. 
			if (!GetConsoleMode(hStdin, &fdwSaveOldMode))
				ErrorExit("GetConsoleMode");

			// Enable the window and mouse input events. 
			DWORD fdwMode = ENABLE_WINDOW_INPUT | ENABLE_MOUSE_INPUT | ENABLE_INSERT_MODE | ENABLE_EXTENDED_FLAGS;
			if (!SetConsoleMode(hStdin, fdwMode))
				ErrorExit("SetConsoleMode");
			
			// fullScreen
			HWNDStyle = 0;
			HWNDStyleEx = 0;
		#endif
		
		// KeyboardEvent
		altKey = false;
		code = "";
		ctrlKey = false;
		isComposing = false;
		key = ' ';
		locale = "";
		location = 0;
		metaKey = false;
		repeat = false;
		shiftKey = false;
		
		// MouseEvent
		button_state[0] = false;
		button_state[1] = false;
		button_state[2] = false;
		button_state[3] = false;
		button_state[4] = false;
		button = 0;
		buttons = 0;
		clientX = 0;
		clientY = 0;
		layerX = 0;
		layerY = 0;
		movementX = 0;
		movementY = 0;
		offsetX = 0;
		offsetY = 0;
		pageX = 0;
		pageY = 0;
		relatedTarget = "";
		screenX = 0;
		screenY = 0;
		mozPressure = 0.0;
		mozInputSource = "";
		webkitForce = 0;
		x = 0;
		y = 0;

		// WheelEvent
		deltaX = 0;
		deltaY = 0;
		deltaZ = 0;
		deltaMode = 0;
		wheelDelta = 0;
		wheelDeltaX = 0;
		wheelDeltaY = 0;

		// FocusEvent
		//relatedTarget = "";

		//// Instance properties ////
		/*
		DKDuktape::AttachFunction("CPP_DKConsoleWindow_closed", DKConsoleWindow::closed);
		DKDuktape::AttachFunction("CPP_DKConsoleWindow_columns", DKConsoleWindow::Columns);
		DKDuktape::AttachFunction("CPP_DKConsoleWindow_fullScreen", DKConsoleWindow::fullScreen);
		DKDuktape::AttachFunction("CPP_DKConsoleWindow_innerHeight", DKConsoleWindow::innerHeight);
		DKDuktape::AttachFunction("CPP_DKConsoleWindow_innerWidth", DKConsoleWindow::innerWidth);
		DKDuktape::AttachFunction("CPP_DKConsoleWindow_name", DKConsoleWindow::name);
		DKDuktape::AttachFunction("CPP_DKConsoleWindow_outerHeight", DKConsoleWindow::outerHeight);
		DKDuktape::AttachFunction("CPP_DKConsoleWindow_outerWidth", DKConsoleWindow::outerWidth);
		DKDuktape::AttachFunction("CPP_DKConsoleWindow_rows", DKConsoleWindow::Rows);
		DKDuktape::AttachFunction("CPP_DKConsoleWindow_screenX", DKConsoleWindow::ScreenX);
		DKDuktape::AttachFunction("CPP_DKConsoleWindow_screenLeft", DKConsoleWindow::screenLeft);
		DKDuktape::AttachFunction("CPP_DKConsoleWindow_screenY", DKConsoleWindow::ScreenY);
		DKDuktape::AttachFunction("CPP_DKConsoleWindow_screenTop", DKConsoleWindow::screenTop);
		
		//// Instance methods ////
		DKDuktape::AttachFunction("CPP_DKConsoleWindow_blur", DKConsoleWindow::blur);
		DKDuktape::AttachFunction("CPP_DKConsoleWindow_close", DKConsoleWindow::close);
		DKDuktape::AttachFunction("CPP_DKConsoleWindow_focus", DKConsoleWindow::focus);
		DKDuktape::AttachFunction("CPP_DKConsoleWindow_moveBy", DKConsoleWindow::moveBy);
		DKDuktape::AttachFunction("CPP_DKConsoleWindow_moveTo", DKConsoleWindow::moveTo);
		DKDuktape::AttachFunction("CPP_DKConsoleWindow_resizeBy", DKConsoleWindow::resizeBy);
		DKDuktape::AttachFunction("CPP_DKConsoleWindow_resizeTo", DKConsoleWindow::resizeTo);
		*/

		DKApp::AppendLoopFunc(&DKConsoleWindow::Loop, this);
		
		DKString address = DKDuktape::pointerToAddress(this);
		DKINFO("CPP ConsoleWindow address = "+address+"\n");
	}
	
	~DKConsoleWindow(){
		DKDEBUGFUNC();
		#if WIN
			SetConsoleMode(hStdin, fdwSaveOldMode); // Restore input mode on exit.
		#endif
	}
	
	void Loop();
	
	/*
	//// Instance properties ////
	static int closed(duk_context* ctx);
	static int Columns(duk_context* ctx);
	static int fullScreen(duk_context* ctx);
	static int innerHeight(duk_context* ctx);
	static int innerWidth(duk_context* ctx);
	static int name(duk_context* ctx);
	static int outerHeight(duk_context* ctx);
	static int outerWidth(duk_context* ctx);
	static int Rows(duk_context* ctx);
	static int ScreenX(duk_context* ctx);
	static int screenLeft(duk_context* ctx);
	static int ScreenY(duk_context* ctx);
	static int screenTop(duk_context* ctx);
	
	//// Instance methods ////
	static int blur(duk_context* ctx);
	static int close(duk_context* ctx);
	static int focus(duk_context* ctx);
	static int moveBy(duk_context* ctx);
	static int moveTo(duk_context* ctx);
	static int resizeBy(duk_context* ctx);
	static int resizeTo(duk_context* ctx);
	*/

	// KeyboardEvent
	bool altKey;
	DKString code;
	bool ctrlKey;
	bool isComposing;
	char key;
	DKString locale;
	unsigned int location;
	bool metaKey;
	bool repeat;
	bool shiftKey;
	
	// MouseEvent
	bool button_state[5];
	unsigned int button;
	unsigned int buttons;
	unsigned int clientX;
	unsigned int clientY;
	int layerX;
	int layerY;
	int movementX;
	int movementY;
	int offsetX;
	int offsetY;
	int pageX;
	int pageY;
	DKString relatedTarget;
	unsigned int screenX;
	unsigned int screenY;
	float mozPressure;
	DKString mozInputSource;
	unsigned int webkitForce;
	unsigned int x;
	unsigned int y;

	// WheelEvent
	int deltaX;
	int deltaY;
	int deltaZ;
	unsigned long deltaMode;
	int wheelDelta;
	int wheelDeltaX;
	int wheelDeltaY;

	// FocusEvent
	//DKString relatedTarget;

	// ResizeEvent
	unsigned int columns;
	unsigned int rows;

#if WIN
	// fullScreen
	static WINDOWPLACEMENT wpc;
	static LONG HWNDStyle;
	static LONG HWNDStyleEx;
	
	HANDLE hStdin;
	DWORD fdwSaveOldMode;
	void ErrorExit(LPCSTR);
	void FocusEventProc(FOCUS_EVENT_RECORD);
	void KeyboardEventProc(KEY_EVENT_RECORD);
	void MenuEventProc(MENU_EVENT_RECORD);
	void MouseEventProc(MOUSE_EVENT_RECORD);
	void ResizeEventProc(WINDOW_BUFFER_SIZE_RECORD);
#endif
};


#endif //DKConsoleWindow_H