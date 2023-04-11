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


class DKConsoleWindow : public DKWindow, public DKObjectT<DKConsoleWindow>
{
public:
	DKConsoleWindow();
	~DKConsoleWindow();
	bool Init();
	bool End();
	
	int blur() {
		DKDEBUGFUNC();
		#if WIN
			ShowWindow(GetConsoleWindow(), SW_SHOWMINNOACTIVE);
		#endif
		return true;
	}
	bool close() {
		DKDEBUGFUNC();
		#if WIN
			ShowWindow(GetConsoleWindow(), SW_HIDE);
		#endif
		return true;
	}
	bool focus() {
		DKDEBUGFUNC();
		#if WIN
			ShowWindow(GetConsoleWindow(), SW_SHOW);
		#endif
		return true;
	}
	bool moveBy(int deltaX, int deltaY) {
		DKDEBUGFUNC(deltaX, deltaY);
		#if WIN
			RECT rect;
			GetWindowRect(GetConsoleWindow(), &rect);
			int X = rect.left + deltaX;
			int Y = rect.top + deltaY;
			int nWidth = rect.right - rect.left;
			int nHeight = rect.bottom - rect.top;
			if (!MoveWindow(GetConsoleWindow(), X, Y, nWidth, nHeight, TRUE))
				return DKERROR("MoveWindow() failed");
		#endif
		return true;
	}
	bool moveTo(int x, int y){
		DKDEBUGFUNC(x, y);
		#if WIN
			RECT rect;
			GetWindowRect(GetConsoleWindow(), &rect);
			int nWidth = rect.right - rect.left;
			int nHeight = rect.bottom - rect.top;
			if (!MoveWindow(GetConsoleWindow(), x, y, nWidth, nHeight, TRUE)){
				return DKERROR("MoveWindow() failed");
			}
		#endif
		return true;
	}
	bool resizeBy(int xDelta, int yDelta) {
		DKDEBUGFUNC(xDelta, yDelta);
		#if WIN
			RECT rect;
			GetWindowRect(GetConsoleWindow(), &rect);
			int X = rect.left;
			int Y = rect.top;
			int nWidth = rect.right - rect.left + xDelta;
			int nHeight = rect.bottom - rect.top + yDelta;
			if (!MoveWindow(GetConsoleWindow(), X, Y, nWidth, nHeight, TRUE))
				return DKERROR("MoveWindow() failed");
		#endif
		return true;
	}
	bool resizeTo(int width, int height) {
		DKDEBUGFUNC(width, height);
		#if WIN
			RECT rect;
			GetWindowRect(GetConsoleWindow(), &rect);
			int X = rect.left;
			int Y = rect.top;
			int nWidth = width;
			int nHeight = height;
			if (!MoveWindow(GetConsoleWindow(), X, Y, nWidth, nHeight, TRUE))
				return DKERROR("MoveWindow() failed");
		#endif
		return true;
	}
	
	void Loop();

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
	//DKString _char;
	//unsigned int charCode;
	//unsigned int keyCode;
	//DKString keyIdentifier;
	//unsigned int keyLocation;
	//unsigned int which;
	
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
REGISTER_OBJECT(DKConsoleWindow, true);


#endif //DKConsoleWindow_H