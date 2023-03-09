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
#ifndef ConsoleWindow_H
#define ConsoleWindow_H

#include "DK/DK.h"
#include "DKDuktape/DKDuktape.h"

#if WIN
	#include <windows.h>
	#include <tchar.h>
	#include <stdio.h>
#endif

class ConsoleWindow : public DKObjectT<ConsoleWindow>
{
public:
	bool Init();
	bool End();
	void Loop();
	
	//// Instance properties ////
	static int innerHeight(duk_context* ctx);
	static int innerWidth(duk_context* ctx);
	static int outerHeight(duk_context* ctx);
	static int outerWidth(duk_context* ctx);
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
	
#if WIN
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
	DKString relativeTarget;
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
	//int wheelDelta;
	//int wheelDeltaX;
	//int wheelDeltaY;

	// FocusEvent
	DKString relatedTarget;

	HANDLE hStdin;
	DWORD fdwSaveOldMode;
	void ErrorExit(LPCSTR);
	void FocusEventProc(FOCUS_EVENT_RECORD);
	void KeyboardEventProc(KEY_EVENT_RECORD);
	void MouseEventProc(MOUSE_EVENT_RECORD);
	void ResizeEventProc(WINDOW_BUFFER_SIZE_RECORD);
#endif
};
REGISTER_OBJECT(ConsoleWindow, false);


#endif //ConsoleWindow_H