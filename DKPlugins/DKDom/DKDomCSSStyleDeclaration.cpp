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

// https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleDeclaration

#include "DK/DKApp.h"
#include "DKDom/DKDom.h"
#include "DKDom/DKDomCSSStyleDeclaration.h"


bool DKDomCSSStyleDeclaration::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKDomCSSStyleDeclaration_getPropertyPriority", DKDomCSSStyleDeclaration::getPropertyPriority);
	DKDuktape::AttachFunction("CPP_DKDomCSSStyleDeclaration_getPropertyValue", DKDomCSSStyleDeclaration::getPropertyValue);
	DKDuktape::AttachFunction("CPP_DKDomCSSStyleDeclaration_removeProperty", DKDomCSSStyleDeclaration::removeProperty);
	DKDuktape::AttachFunction("CPP_DKDomCSSStyleDeclaration_setProperty", DKDomCSSStyleDeclaration::setProperty);
	DKClass::DKCreate("DKDom/DKDomCSSStyleDeclaration.js");
	return true;
}

int DKDomCSSStyleDeclaration::getPropertyPriority(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	/*
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	DKString propertyName = duk_require_string(ctx, 1);
	const Rml::Property* property = element->GetProperty(propertyName.c_str());
	if (!property) {
		DKERROR("prop is invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	DKString propertyPriority = element->GetPropertyPriority(propertyName.c_str())->ToString();
	duk_push_string(ctx, propertyPriority.c_str());
	return true;
	*/
	return DKERROR("not implemented");
}

int DKDomCSSStyleDeclaration::getPropertyValue(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("DKDomCSSStyleDeclaration::getPropertyValue(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	DKString propertyName = duk_require_string(ctx, 1);
	const Rml::Property* prop = element->GetProperty(propertyName.c_str());
	if(!prop){ 
		DKERROR("DKDomCSSStyleDeclaration::getPropertyValue: prop is invalid\n");
		duk_push_boolean(ctx, false);
		return true; 
	}
	DKString propertyValue = element->GetProperty(propertyName.c_str())->ToString();
	duk_push_string(ctx, propertyValue.c_str());
	return true;
}

// returns a CSS property name from a CSSStyleDeclaration by index.
// https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleDeclaration/item
int DKDomCSSStyleDeclaration::item(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	/*
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	int propertyIndex = duk_require_int(ctx, 1);
	const propertyName = element->GetPropertyNameByIndex(propertyIndex);
	if (!propertyName) {
		DKERROR("propertyName is invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	DKString propertyValue = element->GetProperty(propertyName.c_str())->ToString();
	duk_push_string(ctx, propertyName.c_str());
	return true;
	*/
	return DKERROR("not implemented \n");
}

int DKDomCSSStyleDeclaration::removeProperty(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("DKDomCSSStyleDeclaration::getPropertyValue(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	DKString propertyName = duk_require_string(ctx, 1);
	const Rml::Property* prop = element->GetProperty(propertyName.c_str());
	if (!prop) {
		DKERROR("DKDomCSSStyleDeclaration::getPropertyValue: prop is invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	DKString oldValue; //TODO get the old value for a return value
	element->RemoveProperty(propertyName); //FIXME: RmlUi should return the old value if any
	DKWARN("DKDomCSSStyleDeclaration::removeProperty(): not tested. Warning removed after tests.\n");
	return false;
}

int DKDomCSSStyleDeclaration::setProperty(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString propertyName = duk_require_string(ctx, 1);
	DKString propertyValue;
	if(duk_is_string(ctx, 2))
		propertyValue = duk_require_string(ctx, 2);
	if(duk_is_boolean(ctx, 2))
		propertyValue = toString(duk_require_boolean(ctx, 2));
	//DKString priority = duk_require_string(ctx, 3); //TODO
	Rml::Element* element = DKRml::addressToElement(address);
	if(element){
		if(!propertyValue.empty()){
			element->SetProperty(propertyName.c_str(), propertyValue.c_str());
		}
		else{
			element->RemoveProperty(propertyName.c_str());
		}
	}
	return true;
}
