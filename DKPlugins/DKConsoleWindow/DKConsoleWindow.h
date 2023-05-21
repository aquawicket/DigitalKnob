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
#include "DKWindow/DKWindow.h"

#if WIN
	#include <windows.h>
	#include <tchar.h>
	#include <stdio.h>
#endif


class DKConsoleWindow : public DKWindow, public DKObjectT<DKConsoleWindow>
{
public:
	DKConsoleWindow();
	~DKConsoleWindow();
	bool Init();
	bool End();
	
	bool outerHeight(unsigned int& _outerHeight, bool set = false) {
		if(set){
			return DKTODO();
		}
		else{
			#if WIN
				RECT rect;
				GetWindowRect(GetConsoleWindow(), &rect);
				_outerHeight = rect.bottom - rect.top;
			#endif
		}
		return true;
	}
	bool outerWidth(unsigned int& _outerWidth, bool set = false) {
		if(set){
			return DKTODO();
		}
		else{
			#if WIN
				RECT rect;
				GetWindowRect(GetConsoleWindow(), &rect);
				_outerWidth = rect.right - rect.left;
			#endif
		}
		return true;
	}
	bool blur() {
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
	bool moveBy(int& _deltaX, int& _deltaY) {
		DKDEBUGFUNC(_deltaX, _deltaY);
		#if WIN
			RECT rect;
			GetWindowRect(GetConsoleWindow(), &rect);
			int X = rect.left + _deltaX;
			int Y = rect.top + _deltaY;
			int nWidth = rect.right - rect.left;
			int nHeight = rect.bottom - rect.top;
			if (!MoveWindow(GetConsoleWindow(), X, Y, nWidth, nHeight, TRUE))
				return DKERROR("MoveWindow() failed");
		#endif
		return true;
	}
	bool moveTo(int& _x, int& _y){
		DKDEBUGFUNC(_x, _y);
		#if WIN
			RECT rect;
			GetWindowRect(GetConsoleWindow(), &rect);
			int nWidth = rect.right - rect.left;
			int nHeight = rect.bottom - rect.top;
			if (!MoveWindow(GetConsoleWindow(), _x, _y, nWidth, nHeight, TRUE)){
				return DKERROR("MoveWindow() failed");
			}
		#endif
		return true;
	}
	bool resizeBy(int& _xDelta, int& _yDelta) {
		DKDEBUGFUNC(_xDelta, _yDelta);
		#if WIN
			RECT rect;
			GetWindowRect(GetConsoleWindow(), &rect);
			int X = rect.left;
			int Y = rect.top;
			int nWidth = rect.right - rect.left + _xDelta;
			int nHeight = rect.bottom - rect.top + _yDelta;
			if (!MoveWindow(GetConsoleWindow(), X, Y, nWidth, nHeight, TRUE))
				return DKERROR("MoveWindow() failed");
		#endif
		return true;
	}
	bool resizeTo(int& _width, int& _height) {
		DKDEBUGFUNC(_width, _height);
		#if WIN
			RECT rect;
			GetWindowRect(GetConsoleWindow(), &rect);
			int X = rect.left;
			int Y = rect.top;
			int nWidth = _width;
			int nHeight = _height;
			if (!MoveWindow(GetConsoleWindow(), X, Y, nWidth, nHeight, TRUE))
				return DKERROR("MoveWindow() failed");
		#endif
		return true;
	}

	////// DK //////
	void Loop();

	// KeyboardEvent
	DOMString key;
	DOMString code;
	unsigned int location;
	bool ctrlKey;
	bool shiftKey;
	bool altKey;
	bool metaKey;
	bool repeat;
	bool isComposing;
	unsigned int charCode;
	unsigned int keyCode;
	
	// MouseEvent
	int screenX;
	int screenY;
	int clientX;
	int clientY;
	short button;
	unsigned short buttons;
	DKString relatedTarget;
	double pageX;
	double pageY;
	double x;
	double y;
	double offsetX;
	double offsetY;
	double movementX;
	double movementY;
	
	bool button_state[5];
	
	// WheelEvent
	double deltaX;
	double deltaY;
	double deltaZ;
	unsigned int deltaMode;

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
	
	static HANDLE hStdin;
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