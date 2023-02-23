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

//https://developer.mozilla.org/en-US/docs/Web/API/HTMLBodyElement

#include "DK/DKApp.h"
#include "DKDom/DKDom.h"
#include "DKDom/DKDomHTMLBodyElement.h"


bool DKDomHTMLBodyElement::Init(){
	DKDEBUGFUNC();
	DKClass::DKCreate("DKDom/DKDomHTMLBodyElement.js");
	
	/*
	//Create DOM javascript instance of the document using the documents element address
	if (DKClass::DKValid("DKRml,DKRml0")) {
		DKString rval;
		DKString document_address = DKDutape::pointerToAddress(DKRml::Get()->document);
		DKDuktape::RunDuktape("var document.body = new HTMLBodyElement(\"" + document_address + "\");", rval);
	}
	DKDuktape* dt = DKDuktape::Get();
	duk_eval_string(dt->ctx, "console.log('document.body = '+document.body)");
	*/
	return true;
}
