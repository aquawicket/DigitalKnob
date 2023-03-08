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

// https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent

#pragma once
#ifndef DKMouseEvent_H
#define DKMouseEvent_H

#include "DKDuktape/DKDuktape.h"


class DKMouseEvent : public DKObjectT<DKMouseEvent>
{
public:
	bool Init();
	
	// Properties
	static int altKey(duk_context* ctx);			//Read only
	static int button(duk_context* ctx);			//Read only
	static int buttons(duk_context* ctx);			//Read only
	static int clientX(duk_context* ctx);			//Read only
	static int clientY(duk_context* ctx);			//Read only
	static int ctrlKey(duk_context* ctx);			//Read only
	static int layerX(duk_context* ctx);			//Read only
	static int layerY(duk_context* ctx);			//Read only
	static int metaKey(duk_context* ctx);			//Read only
	static int movementX(duk_context* ctx);			//Read only
	static int movementY(duk_context* ctx);			//Read only
	static int offsetX(duk_context* ctx);			//Read only
	static int offsetY(duk_context* ctx);			//Read only
	static int pageX(duk_context* ctx);				//Read only
	static int pageY(duk_context* ctx);				//Read only
	//static int region(duk_context* ctx);			//Read only
	static int relatedTarget(duk_context* ctx);		//Read only
	static int screenX(duk_context* ctx);			//Read only
	static int screenY(duk_context* ctx);			//Read only
	static int shiftKey(duk_context* ctx);			//Read only
	static int mozPressure(duk_context* ctx);		//Read only
	static int mozInputSource(duk_context* ctx);	//Read only
	static int webkitForce(duk_context* ctx);		//Read only
	//static int which(duk_context* ctx);			//Read only
	static int x(duk_context* ctx);					//Read only
	static int y(duk_context* ctx);					//Read only

	// Methods
	static int getModifierState(duk_context* ctx);
	static int initMouseEvent(duk_context* ctx);
};


REGISTER_OBJECT(DKMouseEvent, true)

#endif //DKMouseEvent_H