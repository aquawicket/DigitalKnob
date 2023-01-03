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
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

// https://developer.mozilla.org/en-US/docs/Web/API/DocumentOrShadowRoot
// https://javascript.info/mixins

#pragma once
#ifndef DKDomDocumentOrShadowRootOrShadowRoot_H
#define DKDomDocumentOrShadowRoot_H

#include "DKDuktape/DKDuktape.h"

class DKDomDocumentOrShadowRoot : public DKObjectT<DKDomDocumentOrShadowRoot>
{
public:
	bool Init();
	
	// Properties
	static int activeElement(duk_context* ctx);
	static int fullscreenElement(duk_context* ctx);
	static int pictureInPictureElement(duk_context* ctx);
	static int pointerLockElement(duk_context* ctx);
	static int styleSheets(duk_context* ctx);
	
	// Methods
	static int caretPositionFromPoint(duk_context* ctx);
	static int elementFromPoint(duk_context* ctx);
	static int elementsFromPoint(duk_context* ctx);
	static int getSelection(duk_context* ctx);
	static int nodeFromPoint(duk_context* ctx);
	static int nodesFromPoint(duk_context* ctx);
};


REGISTER_OBJECT(DKDomDocumentOrShadowRoot, true)

#endif //DKDomDocumentOrShadowRoot_H