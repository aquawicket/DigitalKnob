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
#if HAVE_DKDuktape 
#pragma once
#ifndef DKTrayJS_H
#define DKTrayJS_H

#include "DKDuktape/DKDuktape.h"


class DKTrayJS : public DKObjectT<DKTrayJS>
{
public:
	bool Init();
	
	static int AddItem(duk_context* ctx);
	static int GetIcon(duk_context* ctx);
	static int SetIcon(duk_context* ctx);
	static int SetTooltip(duk_context* ctx);
	static int ShowBalloon(duk_context* ctx);
	//static int Animate(duk_context* ctx); //TODO
	//static int GetMenuDefaultItem(duk_context* ctx); //TODO
	//static int GetTooltip(duk_context* ctx); // TODO
	//static int HideIcon(duk_context* ctx); //TODO
	//static int SetIconList(duk_context* ctx); //TODO
	//static int SetMenuDefaultItem(duk_context* ctx); //TODO
	//static int ShowIcon(duk_context* ctx); //TODO
	//static int StopAnimation(duk_context* ctx); //TODO
};
REGISTER_OBJECT(DKTrayJS, true)


#endif //DKTrayJS_H
#endif //HAVE_DKDuktape