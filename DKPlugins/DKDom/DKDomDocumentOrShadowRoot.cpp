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

// https://developer.mozilla.org/en-US/docs/Web/API/DocumentOrShadowRoot
// https://javascript.info/mixins

#include "DK/DKApp.h"
#include "DKDom/DKDom.h"
#include "DKDom/DKDomDocumentOrShadowRoot.h"
#include "DKDom/DKDomElement.h"


bool DKDomDocumentOrShadowRoot::Init(){
	DKDEBUGFUNC();
	// Properties
	DKDuktape::AttachFunction("CPP_DKDomDocumentOrShadowRoot_activeElement", DKDomDocumentOrShadowRoot::activeElement);
	DKDuktape::AttachFunction("CPP_DKDomDocumentOrShadowRoot_fullscreenElement", DKDomDocumentOrShadowRoot::fullscreenElement);
	DKDuktape::AttachFunction("CPP_DKDomDocumentOrShadowRoot_pictureInPictureElement", DKDomDocumentOrShadowRoot::pictureInPictureElement);
	DKDuktape::AttachFunction("CPP_DKDomDocumentOrShadowRoot_pointerLockElement", DKDomDocumentOrShadowRoot::pointerLockElement);
	DKDuktape::AttachFunction("CPP_DKDomDocumentOrShadowRoot_styleSheets", DKDomDocumentOrShadowRoot::styleSheets);
	// Methods
	DKDuktape::AttachFunction("CPP_DKDomDocumentOrShadowRoot_caretPositionFromPoint", DKDomDocumentOrShadowRoot::caretPositionFromPoint);
	DKDuktape::AttachFunction("CPP_DKDomDocumentOrShadowRoot_elementFromPoint", DKDomDocumentOrShadowRoot::elementFromPoint);
	DKDuktape::AttachFunction("CPP_DKDomDocumentOrShadowRoot_elementsFromPoint", DKDomDocumentOrShadowRoot::elementsFromPoint);
	DKDuktape::AttachFunction("CPP_DKDomDocumentOrShadowRoot_getSelection", DKDomDocumentOrShadowRoot::getSelection);
	DKDuktape::AttachFunction("CPP_DKDomDocumentOrShadowRoot_nodeFromPoint", DKDomDocumentOrShadowRoot::nodeFromPoint);
	DKDuktape::AttachFunction("CPP_DKDomDocumentOrShadowRoot_nodesFromPoint", DKDomDocumentOrShadowRoot::nodesFromPoint);
	DKClass::DKCreate("DKDom/DKDomDocumentOrShadowRoot.js");
	return true;
}


// Properties
int DKDomDocumentOrShadowRoot::activeElement(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	Rml::Element* element = DKRml::Get()->document->GetFocusLeafNode(); //TODO: test
	if(!element){
		duk_push_null(ctx);
		return DKERROR("DKDomDocumentOrShadowRoot::activeElement(): element invalid\n");
	}
	DKString elementAddress = DKRml::elementToAddress(element);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

int DKDomDocumentOrShadowRoot::fullscreenElement(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return false;
}

int DKDomDocumentOrShadowRoot::pictureInPictureElement(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return false;
}

int DKDomDocumentOrShadowRoot::pointerLockElement(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return false;
}

int DKDomDocumentOrShadowRoot::styleSheets(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return false;
}


// Methods
int DKDomDocumentOrShadowRoot::caretPositionFromPoint(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return false;
}

int DKDomDocumentOrShadowRoot::elementFromPoint(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//DKINFO("DKDomDocumentOrShadowRoot::elementFromPoint()\n");
	Rml::Element* hoverElement = DKRml::Get()->document->GetContext()->GetHoverElement();
	if(!hoverElement)
		return false;
	DKString elementAddress = DKRml::elementToAddress(hoverElement);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

int DKDomDocumentOrShadowRoot::elementsFromPoint(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return false;
}

int DKDomDocumentOrShadowRoot::getSelection(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return false;
}

int DKDomDocumentOrShadowRoot::nodeFromPoint(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return false;
}

int DKDomDocumentOrShadowRoot::nodesFromPoint(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return false;
}
