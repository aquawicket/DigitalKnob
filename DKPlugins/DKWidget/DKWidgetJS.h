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

#ifdef HAVE_DKRocket
#ifdef HAVE_DKDuktape 
#pragma once
#ifndef DKWidgetJS_H
#define DKWidgetJS_H

#include "DKDuktape/DKDuktape.h"
#include "DKWidget/DKWidget.h"

///////////////////////////////////////////////
class DKWidgetJS : public DKObjectT<DKWidgetJS>
{
public:
	bool Init();
	
	static int AddDragHandle(duk_context* ctx);
	static int AddResizeHandle(duk_context* ctx);
	static int AppendChild(duk_context* ctx);
	static int Copy(duk_context* ctx);
	static int CreateElement(duk_context* ctx);
	static int CreateElementBefore(duk_context* ctx);
	static int Cut(duk_context* ctx);
	static int ElementExists(duk_context* ctx);
	static int GetAttribute(duk_context* ctx);
	static int GetAvailableId(duk_context* ctx);
	static int GetClientHeight(duk_context* ctx);
	static int GetClientWidth(duk_context* ctx);
	static int GetElements(duk_context* ctx);
	static int GetFile(duk_context* ctx);
	static int GetFirstChild(duk_context* ctx);
	static int GetFocusElement(duk_context* ctx);
	static int GetHoverElement(duk_context* ctx);
	static int GetInnerHtml(duk_context* ctx);
	static int GetInnerHtmlString(duk_context* ctx);
	static int GetLastChild(duk_context* ctx);
	static int GetMouseElementX(duk_context* ctx);
	static int GetMouseElementY(duk_context* ctx);
	static int GetMouseWindowX(duk_context* ctx);
	static int GetMouseWindowY(duk_context* ctx);
	static int GetOffsetHeight(duk_context* ctx);
	static int GetOffsetLeft(duk_context* ctx);
	static int GetOffsetTop(duk_context* ctx);
	static int GetOffsetWidth(duk_context* ctx);
	static int GetOption(duk_context* ctx);
	static int GetOuterHtml(duk_context* ctx);
	static int GetParent(duk_context* ctx);
	static int GetProperty(duk_context* ctx);
	static int GetScale(duk_context* ctx);
	static int GetTagName(duk_context* ctx);
	static int GetValue(duk_context* ctx);
	static int HasAttribute(duk_context* ctx);
	static int HasProperty(duk_context* ctx);
	static int Hide(duk_context* ctx);
	static int InsertBefore(duk_context* ctx);
	static int IsChildOf(duk_context* ctx);
	static int NewWidget(duk_context* ctx);
	static int OpenLink(duk_context* ctx);
	static int Paste(duk_context* ctx);
	static int PrependChild(duk_context* ctx);
	static int RemoveAttribute(duk_context* ctx);
	static int RemoveDragHandle(duk_context* ctx);
	static int RemoveElement(duk_context* ctx);
	static int RemoveProperty(duk_context* ctx);
	static int RemoveResizeHandle(duk_context* ctx);
	static int ScrollToBottom(duk_context* ctx);
	static int ScrollToTop(duk_context* ctx);
	static int SetAttribute(duk_context* ctx);
	static int SetFile(duk_context* ctx);
	static int SetFocus(duk_context* ctx);
	static int SetInnerHtml(duk_context* ctx);
	static int SetInnerHtmlString(duk_context* ctx);
	static int SetOption(duk_context* ctx);
	static int SetProperty(duk_context* ctx);
	static int SetScale(duk_context* ctx);
	static int SetValue(duk_context* ctx);
	static int Show(duk_context* ctx);
	static int Toggle(duk_context* ctx);
	static int ValidateColor(duk_context* ctx);
	static int Visible(duk_context* ctx);
	static int WindowHeight(duk_context* ctx);
	static int WindowWidth(duk_context* ctx);
	
	static DKString htmlfile;
};


REGISTER_OBJECT(DKWidgetJS, true)

#endif //DKWidgetJS_H
#endif //HAVE_DKDuktape
#endif //HAVE_DKRocket