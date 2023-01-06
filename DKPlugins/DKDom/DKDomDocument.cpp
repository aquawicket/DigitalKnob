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

// https://developer.mozilla.org/en-US/docs/Web/API/Document

#include "DK/DKApp.h"
#include "DKDom/DKDom.h"
#include "DKDom/DKDomDocument.h"
#include "DKDom/DKDomElement.h"


bool DKDomDocument::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKDomDocument_body", DKDomDocument::body);
	DKDuktape::AttachFunction("CPP_DKDomDocument_createElement", DKDomDocument::createElement);
	DKDuktape::AttachFunction("CPP_DKDomDocument_documentElement", DKDomDocument::documentElement);
	DKDuktape::AttachFunction("CPP_DKDomDocument_getElementById", DKDomDocument::getElementById);
	DKDuktape::AttachFunction("CPP_DKDomDocument_getElementsByTagName", DKDomDocument::getElementsByTagName);
	DKClass::DKCreate("DKDom/DKDomDocument.js");

	//Create DOM javascript instance of the document using the documents element address
	if (DKClass::DKValid("DKRml,DKRml0")) {
		DKString rval;
		DKString document_address = DKRml::Get()->elementToAddress(DKRml::Get()->document);
		DKDuktape::RunDuktape("var document = new Document(\"" + document_address + "\");", rval);
	}

	return true;
}

int DKDomDocument::body(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	Rml::ElementList elements;
	DKRml::Get()->document->GetElementsByTagName(elements, "body");
	if(!elements[0]){
		duk_push_null(ctx);
		return DKERROR("DKDomDocument::body(): element invalid\n");
	}
	DKString elementAddress = DKRml::elementToAddress(elements[0]);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

int DKDomDocument::createElement(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString tag = duk_require_string(ctx, 0);
	Rml::Element* doc = DKRml::Get()->document;
	Rml::Element* element = doc->AppendChild(DKRml::Get()->document->CreateElement(tag.c_str()), true);
	if(!element)
		return DKERROR("DKDomDocument::createElement(): element invalid\n");
	DKString elementAddress = DKRml::elementToAddress(element);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

int DKDomDocument::documentElement(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	Rml::Element* element = DKRml::Get()->document;
	if(!element){
		duk_push_null(ctx);
		return DKERROR("DKDomDocument::documentElement(): element invalid\n");
	}
	DKString elementAddress = DKRml::elementToAddress(element);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

int DKDomDocument::getElementById(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString id = duk_require_string(ctx, 0);
	if(!DKRml::Get()){
		duk_push_null(ctx);
		DKERROR("DKDomDocument::getElementById(): DKRml::Get() invalid\n");
		return true;
	}
	Rml::Element* element = DKRml::Get()->document->GetElementById(id.c_str()); //FIXME - Crash: invalid DKRml
	if(!element){
		duk_push_null(ctx);
		//DKERROR("DKDomDocument::getElementById(): element invalid\n");
		return true;
	}
	DKString elementAddress = DKRml::elementToAddress(element);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

int DKDomDocument::getElementsByTagName(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString tag = duk_require_string(ctx, 0);
	Rml::ElementList elements;
	DKRml::Get()->document->GetElementsByTagName(elements, tag.c_str());
	if(elements.empty()){
		//DKERROR("DKDomDocument::getElementsByTagName(): element list invalid\n");
		duk_push_null(ctx);
		return true;
	}
	DKStringArray elementAddresses;
	for(unsigned int i = 0; i<elements.size(); i++)
		elementAddresses.push_back(DKRml::elementToAddress(elements[i]));
	DKString list = toString(elementAddresses, ",");
	duk_push_string(ctx, list.c_str());
	return true;
}
