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
#ifdef HAVE_DKDuktape
#include "DK/stdafx.h"
#include "DKRmlDocument/DKRmlDocument.h"
#include "DKRmlDocument/DKRmlJS.h"


bool DKRmlJS::Init() {
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKRml_DebuggerOff", DKRmlJS::DebuggerOff);
	DKDuktape::AttachFunction("CPP_DKRml_DebuggerOn", DKRmlJS::DebuggerOn);
	DKDuktape::AttachFunction("CPP_DKRml_DebuggerToggle", DKRmlJS::DebuggerToggle);
	DKDuktape::AttachFunction("CPP_DKRml_LoadUrl", DKRmlJS::LoadUrl);
	DKDuktape::AttachFunction("CPP_DKRml_PostProcess", DKRmlJS::PostProcess);
	return true;
}

int DKRmlJS::DebuggerOff(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	DKRmlDocument::Get()->DebuggerOff();
	return false;
}

int DKRmlJS::DebuggerOn(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	DKRmlDocument::Get()->DebuggerOn();
	return false;
}

int DKRmlJS::DebuggerToggle(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	DKRmlDocument::Get()->DebuggerToggle();
	return true;
}

int DKRmlJS::LoadUrl(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	DKString file = duk_require_string(ctx, 0);
	if (!DKRmlDocument::Get()->LoadUrl(file))
		return DKERROR("DKRmlDocument::Get()->LoadUrl() failed! \n");
	return true;
}

int DKRmlJS::PostProcess(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	Rml::ElementList elements;
	DKRmlDocument::Get()->document->GetElementsByTagName(elements, "body");
	if(!elements[0])
		return DKERROR("body element invalid\n");
	DKRmlDocument::Get()->dkRmlConverter.PostProcess(elements[0]);
	return true;
}

#endif //HAVE_DKDuktape
