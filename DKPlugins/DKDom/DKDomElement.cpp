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

//https://developer.mozilla.org/en-US/docs/Web/API/Element

#include "DK/DKApp.h"
#include "DKDom/DKDom.h"
#include "DKDom/DKDomElement.h"


bool DKDomElement::Init(){
	DKDEBUGFUNC();

	////// Instance properties //////
	DKDuktape::AttachFunction("CPP_DKDomElement_assignedSlot",				DKDomElement::assignedSlot);
	DKDuktape::AttachFunction("CPP_DKDomElement_attributes",				DKDomElement::attributes);
	DKDuktape::AttachFunction("CPP_DKDomElement_childElementCount",			DKDomElement::childElementCount);
	DKDuktape::AttachFunction("CPP_DKDomElement_children",					DKDomElement::children);
	DKDuktape::AttachFunction("CPP_DKDomElement_classList",					DKDomElement::classList);
	DKDuktape::AttachFunction("CPP_DKDomElement_className",					DKDomElement::className);
	DKDuktape::AttachFunction("CPP_DKDomElement_clientHeight",				DKDomElement::clientHeight);
	DKDuktape::AttachFunction("CPP_DKDomElement_clientLeft",				DKDomElement::clientLeft);
	DKDuktape::AttachFunction("CPP_DKDomElement_clientTop",					DKDomElement::clientTop);
	DKDuktape::AttachFunction("CPP_DKDomElement_clientWidth",				DKDomElement::clientWidth);
	DKDuktape::AttachFunction("CPP_DKDomElement_elementTiming",				DKDomElement::elementTiming);
	DKDuktape::AttachFunction("CPP_DKDomElement_firstElementChild",			DKDomElement::firstElementChild);
	DKDuktape::AttachFunction("CPP_DKDomElement_id",						DKDomElement::id);
	DKDuktape::AttachFunction("CPP_DKDomElement_innerHTML",					DKDomElement::innerHTML);
	DKDuktape::AttachFunction("CPP_DKDomElement_lastElementChild",			DKDomElement::lastElementChild);
	DKDuktape::AttachFunction("CPP_DKDomElement_localName",					DKDomElement::localName);
	DKDuktape::AttachFunction("CPP_DKDomElement_namespaceURI",				DKDomElement::namespaceURI);
	DKDuktape::AttachFunction("CPP_DKDomElement_nextElementSibling",		DKDomElement::nextElementSibling);
	DKDuktape::AttachFunction("CPP_DKDomElement_outerHTML",					DKDomElement::outerHTML);
	DKDuktape::AttachFunction("CPP_DKDomElement_part",						DKDomElement::part);
	DKDuktape::AttachFunction("CPP_DKDomElement_prefix",					DKDomElement::prefix);
	DKDuktape::AttachFunction("CPP_DKDomElement_previousElementSibling",	DKDomElement::previousElementSibling);
	DKDuktape::AttachFunction("CPP_DKDomElement_scrollHeight",				DKDomElement::scrollHeight);
	DKDuktape::AttachFunction("CPP_DKDomElement_scrollLeft",				DKDomElement::scrollLeft);
	DKDuktape::AttachFunction("CPP_DKDomElement_scrollLeftMax",				DKDomElement::scrollLeftMax);
	DKDuktape::AttachFunction("CPP_DKDomElement_scrollTop",					DKDomElement::scrollTop);
	DKDuktape::AttachFunction("CPP_DKDomElement_scrollTopMax",				DKDomElement::scrollTopMax);
	DKDuktape::AttachFunction("CPP_DKDomElement_scrollWidth",				DKDomElement::scrollWidth);
	DKDuktape::AttachFunction("CPP_DKDomElement_shadowRoot",				DKDomElement::shadowRoot);
	DKDuktape::AttachFunction("CPP_DKDomElement_slot",						DKDomElement::slot);
	DKDuktape::AttachFunction("CPP_DKDomElement_tagName",					DKDomElement::tagName);
	
	////// Instance properties included from ARIA //////
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaAtomic",				DKDomElement::ariaAtomic);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaAutoComplete",			DKDomElement::ariaAutoComplete);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaBusy",					DKDomElement::ariaBusy);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaChecked",				DKDomElement::ariaChecked);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaColCount",				DKDomElement::ariaColCount);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaColIndex",				DKDomElement::ariaColIndex);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaColSpan",				DKDomElement::ariaColSpan);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaCurrent",				DKDomElement::ariaCurrent);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaDescription",			DKDomElement::ariaDescription);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaDisabled",				DKDomElement::ariaDisabled);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaExpanded",				DKDomElement::ariaExpanded);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaHasPopup",				DKDomElement::ariaHasPopup);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaHidden",				DKDomElement::ariaHidden);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaKeyShortcuts",			DKDomElement::ariaKeyShortcuts);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaLabel",					DKDomElement::ariaLabel);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaLevel",					DKDomElement::ariaLevel);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaLive",					DKDomElement::ariaLive);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaModal",					DKDomElement::ariaModal);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaMultiline",				DKDomElement::ariaMultiline);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaMultiSelectable",		DKDomElement::ariaMultiSelectable);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaOrientation",			DKDomElement::ariaOrientation);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaPlaceholder",			DKDomElement::ariaPlaceholder);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaPosInSet",				DKDomElement::ariaPosInSet);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaPressed",				DKDomElement::ariaPressed);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaReadOnly",				DKDomElement::ariaReadOnly);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaRelevant",				DKDomElement:: ariaRelevant);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaRequired",				DKDomElement::ariaRequired);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaRoleDescription",		DKDomElement::ariaRoleDescription);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaRowCount",				DKDomElement::ariaRowCount);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaRowIndex",				DKDomElement::ariaRowIndex);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaRowSpan",				DKDomElement::ariaRowSpan);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaSelected",				DKDomElement::ariaSelected);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaSetSize",				DKDomElement::ariaSetSize);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaSort",					DKDomElement::ariaSort);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaValueMax",				DKDomElement::ariaValueMax);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaValueMin",				DKDomElement::ariaValueMin);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaValueNow",				DKDomElement::ariaValueNow);
	DKDuktape::AttachFunction("CPP_DKDomElement_ariaValueText",				DKDomElement::ariaValueText);

	////// Instance methods //////
	DKDuktape::AttachFunction("CPP_DKDomElement_after", 					DKDomElement::after);
	DKDuktape::AttachFunction("CPP_DKDomElement_attachShadow",				DKDomElement::attachShadow);
	DKDuktape::AttachFunction("CPP_DKDomElement_animate",					DKDomElement::animate);
	DKDuktape::AttachFunction("CPP_DKDomElement_append",					DKDomElement::append);
	DKDuktape::AttachFunction("CPP_DKDomElement_before",					DKDomElement::before);
	DKDuktape::AttachFunction("CPP_DKDomElement_closest",					DKDomElement::closest);
	DKDuktape::AttachFunction("CPP_DKDomElement_computedStyleMap",			DKDomElement::computedStyleMap);
	DKDuktape::AttachFunction("CPP_DKDomElement_getAnimations",				DKDomElement::getAnimations);
	DKDuktape::AttachFunction("CPP_DKDomElement_getAttribute",				DKDomElement::getAttribute);
	DKDuktape::AttachFunction("CPP_DKDomElement_getAttributeNames",			DKDomElement::getAttributeNames);
	DKDuktape::AttachFunction("CPP_DKDomElement_getAttributeNode",			DKDomElement::getAttributeNode);
	DKDuktape::AttachFunction("CPP_DKDomElement_getAttributeNodeNS",		DKDomElement::getAttributeNodeNS);
	DKDuktape::AttachFunction("CPP_DKDomElement_getAttributeNS",			DKDomElement::getAttributeNS);
	DKDuktape::AttachFunction("CPP_DKDomElement_getBoundingClientRect",		DKDomElement::getBoundingClientRect);
	DKDuktape::AttachFunction("CPP_DKDomElement_getBoxQuads",				DKDomElement::getBoxQuads);
	DKDuktape::AttachFunction("CPP_DKDomElement_getClientRects",			DKDomElement::getClientRects);
	DKDuktape::AttachFunction("CPP_DKDomElement_getElementsByClassName",	DKDomElement::getElementsByClassName);
	DKDuktape::AttachFunction("CPP_DKDomElement_getElementsByTagName",		DKDomElement::getElementsByTagName);
	DKDuktape::AttachFunction("CPP_DKDomElement_getElementsByTagNameNS",	DKDomElement::getElementsByTagNameNS);
	DKDuktape::AttachFunction("CPP_DKDomElement_hasAttribute",				DKDomElement::hasAttribute);
	DKDuktape::AttachFunction("CPP_DKDomElement_hasAttributeNS",			DKDomElement::hasAttributeNS);
	DKDuktape::AttachFunction("CPP_DKDomElement_hasAttributes",				DKDomElement::hasAttributes);
	DKDuktape::AttachFunction("CPP_DKDomElement_hasPointerCapture",			DKDomElement::hasPointerCapture);
	DKDuktape::AttachFunction("CPP_DKDomElement_insertAdjacentElement",		DKDomElement::insertAdjacentElement);
	DKDuktape::AttachFunction("CPP_DKDomElement_insertAdjacentHTML",		DKDomElement::insertAdjacentHTML);
	DKDuktape::AttachFunction("CPP_DKDomElement_insertAdjacentText",		DKDomElement::insertAdjacentText);
	DKDuktape::AttachFunction("CPP_DKDomElement_matches",					DKDomElement::matches);
	DKDuktape::AttachFunction("CPP_DKDomElement_prepend",					DKDomElement::prepend);
	DKDuktape::AttachFunction("CPP_DKDomElement_querySelector",				DKDomElement::querySelector);
	DKDuktape::AttachFunction("CPP_DKDomElement_querySelectorAll",			DKDomElement::querySelectorAll);
	DKDuktape::AttachFunction("CPP_DKDomElement_releasePointerCapture",		DKDomElement::releasePointerCapture);
	DKDuktape::AttachFunction("CPP_DKDomElement_remove",					DKDomElement::remove);
	DKDuktape::AttachFunction("CPP_DKDomElement_removeAttribute",			DKDomElement::removeAttribute);
	DKDuktape::AttachFunction("CPP_DKDomElement_removeAttributeNode",		DKDomElement::removeAttributeNode);
	DKDuktape::AttachFunction("CPP_DKDomElement_removeAttributeNS",			DKDomElement::removeAttributeNS);
	DKDuktape::AttachFunction("CPP_DKDomElement_replaceChildren",			DKDomElement::replaceChildren);
	DKDuktape::AttachFunction("CPP_DKDomElement_replaceWith",				DKDomElement::replaceWith);
	DKDuktape::AttachFunction("CPP_DKDomElement_requestFullscreen",			DKDomElement::requestFullscreen);
	DKDuktape::AttachFunction("CPP_DKDomElement_requestPointerLock",		DKDomElement::requestPointerLock);
	DKDuktape::AttachFunction("CPP_DKDomElement_scroll",					DKDomElement::scroll);
	DKDuktape::AttachFunction("CPP_DKDomElement_scrollBy",					DKDomElement::scrollBy);
	DKDuktape::AttachFunction("CPP_DKDomElement_scrollIntoView",			DKDomElement::scrollIntoView);
	DKDuktape::AttachFunction("CPP_DKDomElement_scrollIntoViewIfNeeded",	DKDomElement::scrollIntoViewIfNeeded);
	DKDuktape::AttachFunction("CPP_DKDomElement_scrollTo",					DKDomElement::scrollTo);
	DKDuktape::AttachFunction("CPP_DKDomElement_setAttribute",				DKDomElement::setAttribute);
	DKDuktape::AttachFunction("CPP_DKDomElement_setAttributeNode",			DKDomElement::setAttributeNode);
	DKDuktape::AttachFunction("CPP_DKDomElement_setAttributeNodeNS",		DKDomElement::setAttributeNodeNS);
	DKDuktape::AttachFunction("CPP_DKDomElement_setAttributeNS",			DKDomElement::setAttributeNS);
	DKDuktape::AttachFunction("CPP_DKDomElement_setCapture",				DKDomElement::setCapture);
	DKDuktape::AttachFunction("CPP_DKDomElement_setHTML",					DKDomElement::setHTML);
	DKDuktape::AttachFunction("CPP_DKDomElement_setPointerCapture",			DKDomElement::setPointerCapture);
	DKDuktape::AttachFunction("CPP_DKDomElement_toggleAttribute",			DKDomElement::toggleAttribute);
	
	DKClass::DKCreate("DKDom/DKDomElement.js");
	return true;
}

////// Instance properties //////
int DKDomElement::assignedSlot(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::attributes(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::childElementCount(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::children(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::classList(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::className(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::clientHeight(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = (Rml::Element*)DKDuktape::addressToPointer(address);
	if(!element){
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	int clientHeight = 0;
	if(element == DKRml::Get()->document->GetFirstChild()) //html node, get context size
		clientHeight = DKRml::Get()->context->GetDimensions().y; 
	else
		clientHeight = (int)element->GetClientHeight();
	duk_push_int(ctx, clientHeight);
	return true;
}

int DKDomElement::clientLeft(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = (Rml::Element*)DKDuktape::addressToPointer(address);
	if(!element){
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	int clientLeft = 0;
	if(element != DKRml::Get()->document->GetFirstChild()) //not html node
		clientLeft = (int)element->GetClientLeft();
	duk_push_int(ctx, clientLeft);
	return true;
}

int DKDomElement::clientTop(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = (Rml::Element*)DKDuktape::addressToPointer(address);
	if(!element){
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	int clientTop = 0;
	if(element != DKRml::Get()->document->GetFirstChild()) //not html node
		clientTop = (int)element->GetClientTop();
	duk_push_int(ctx, clientTop);
	return true;
}

int DKDomElement::clientWidth(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = (Rml::Element*)DKDuktape::addressToPointer(address);
	if(!element){
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	int clientWidth = 0;
	if(element == DKRml::Get()->document->GetFirstChild()) //html node, get context size
		clientWidth = DKRml::Get()->context->GetDimensions().x; 
	else
		clientWidth = (int)element->GetClientWidth();
	duk_push_int(ctx, clientWidth);
	return true;
}

int DKDomElement::elementTiming(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::firstElementChild(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::id(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::innerHTML(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = (Rml::Element*)DKDuktape::addressToPointer(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	//get
	if (!duk_is_string(ctx, 1)) {
		DKString innerHtml = element->GetInnerRML();
		duk_push_string(ctx, innerHtml.c_str());
	}
	//set
	else {
		DKString innerHTML = duk_require_string(ctx, 1);
		element->SetInnerRML(innerHTML.c_str());
	}
	return true;
}

int DKDomElement::lastElementChild(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::localName(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::namespaceURI(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::nextElementSibling(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::outerHTML(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = (Rml::Element*)DKDuktape::addressToPointer(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	//get
	if (!duk_is_string(ctx, 1)) {
		DKString outerHtml;
		DKRml::GetOuterHTML(element, outerHtml);
		duk_push_string(ctx, outerHtml.c_str());
	}
	//set
	else {
		DKString outerHTML = duk_require_string(ctx, 1);
		DKRml::SetOuterHTML(element, outerHTML.c_str());
	}
	return true;
}

int DKDomElement::part(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::prefix(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::previousElementSibling(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::scrollHeight(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = (Rml::Element*)DKDuktape::addressToPointer(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	float scrollHeight = element->GetScrollHeight();
	duk_push_number(ctx, scrollHeight);
	return true;
}

int DKDomElement::scrollLeft(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = (Rml::Element*)DKDuktape::addressToPointer(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	float scrollLeft = element->GetScrollLeft();
	duk_push_number(ctx, scrollLeft);
	return true;
}

int DKDomElement::scrollLeftMax(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::scrollTop(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = (Rml::Element*)DKDuktape::addressToPointer(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	float scrollTop = element->GetScrollTop();
	duk_push_number(ctx, scrollTop);
	return true;
}

int DKDomElement::scrollTopMax(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::scrollWidth(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = (Rml::Element*)DKDuktape::addressToPointer(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	float scrollWidth = element->GetScrollWidth();
	duk_push_number(ctx, scrollWidth);
	return true;
}

int DKDomElement::shadowRoot(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::slot(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::tagName(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = (Rml::Element*)DKDuktape::addressToPointer(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	duk_push_string(ctx, element->GetTagName().c_str());
	return true;
}


////// Instance properties included from ARIA //////
int DKDomElement::ariaAtomic(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaAutoComplete(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaBusy(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaChecked(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaColCount(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaColIndex(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaColSpan(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaCurrent(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaDescription(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaDisabled(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaExpanded(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaHasPopup(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaHidden(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaKeyShortcuts(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaLabel(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaLevel(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaLive(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaModal(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaMultiline(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaMultiSelectable(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaOrientation(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaPlaceholder(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaPosInSet(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaPressed(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaReadOnly(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaRelevant(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaRequired(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaRoleDescription(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaRowCount(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaRowIndex(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaRowSpan(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaSelected(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaSetSize(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaSort(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaValueMax(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaValueMin(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaValueNow(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::ariaValueText(duk_context* ctx) {
	//TODO
	return true;
}


////// Instance methods //////
int DKDomElement::after(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::attachShadow(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::animate(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::append(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::before(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::closest(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString selector = duk_require_string(ctx, 1);
	Rml::Element* element = (Rml::Element*)DKDuktape::addressToPointer(address);
	if(!element){
		duk_push_undefined(ctx);
		return DKERROR("DKDomElement::closest("+address+","+selector+"): element invalid\n");
	}
	Rml::Element* closestElement = element->Closest(selector);
	if(!closestElement){
		duk_push_undefined(ctx);
		return DKERROR("DKDomElement::closest("+address+","+selector+"): closestElement invalid\n");
	}
	DKString elementAddress = DKDuktape::pointerToAddress(closestElement);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

int DKDomElement::computedStyleMap(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::getAnimations(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::getAttribute(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString attribute = duk_require_string(ctx, 1);
	Rml::Element* element = (Rml::Element*)DKDuktape::addressToPointer(address);
	if(!element){
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	Rml::Variant* variant = element->GetAttribute(attribute.c_str());
	if(!variant){ 
		//DKERROR("variant invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	Rml::String temp = element->GetAttribute(attribute.c_str())->Get<Rml::String>();
	DKString value = temp;
	duk_push_string(ctx, value.c_str());
	return true;
}

int DKDomElement::getAttributeNames(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::getAttributeNode(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::getAttributeNodeNS(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::getAttributeNS(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::getBoundingClientRect(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::getBoxQuads(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::getClientRects(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::getElementsByClassName(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString name = duk_require_string(ctx, 1);
	Rml::Element* element = (Rml::Element*)DKDuktape::addressToPointer(address);
	if(!element){
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	Rml::ElementList elements;
	element->GetElementsByClassName(elements, name.c_str());
	if(elements.empty()){
		duk_push_null(ctx);
		return true;
	}
	DKString str;
	for(unsigned int i=0; i<elements.size(); i++){
		DKString elementAddress = DKDuktape::pointerToAddress(elements[i]);
		str += elementAddress;
		if(i < elements.size()-1)
			str += ",";
	}
	duk_push_string(ctx, str.c_str());
	return true;
}

int DKDomElement::getElementsByTagName(duk_context* ctx){
	DKString address = duk_require_string(ctx, 0);
	DKString name = duk_require_string(ctx, 1);
	Rml::Element* element = (Rml::Element*)DKDuktape::addressToPointer(address);
	if(!element){
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	Rml::ElementList elements;
	element->GetElementsByTagName(elements, name.c_str());
	if(same(name, "html"))
		elements.push_back(DKRml::Get()->document); //html tag
	if(elements.empty()){
		duk_push_null(ctx);
		return true;
	}
	DKString str;
	for(unsigned int i=0; i<elements.size(); i++){
		DKString elementAddress = DKDuktape::pointerToAddress(elements[i]);
		str += elementAddress;
		if(i < elements.size()-1)
			str += ",";
	}
	duk_push_string(ctx, str.c_str());
	return true;
}

int DKDomElement::getElementsByTagNameNS(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::hasAttribute(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString attribute = duk_require_string(ctx, 1);
	Rml::Element* element = (Rml::Element*)DKDuktape::addressToPointer(address);
	if(!element){
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	if(!element->HasAttribute(attribute.c_str())){ 
		duk_push_boolean(ctx, false);
		return true;
	}
	duk_push_boolean(ctx, true);
	return true;
}

int DKDomElement::hasAttributeNS(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::hasAttributes(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::hasPointerCapture(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::insertAdjacentElement(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::insertAdjacentHTML(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::insertAdjacentText(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::matches(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::prepend(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::querySelector(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString selectors = duk_require_string(ctx, 1);
	Rml::Element* element = (Rml::Element*)DKDuktape::addressToPointer(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	Rml::Element* queryElement = element->QuerySelector(selectors.c_str());
	if (!queryElement) {
		duk_push_null(ctx);
		DKERROR("queryElement invalid\n");
		return true;
	}
	DKString elementAddress = DKDuktape::pointerToAddress(queryElement);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

int DKDomElement::querySelectorAll(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString selectors = duk_require_string(ctx, 1);
	Rml::Element* element = (Rml::Element*)DKDuktape::addressToPointer(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	Rml::ElementList elements;
	element->QuerySelectorAll(elements, selectors.c_str());
	if (elements.empty()) {
		duk_push_null(ctx);
		return true;
	}
	DKString str;
	for (unsigned int i = 0; i < elements.size(); i++) {
		DKString elementAddress = DKDuktape::pointerToAddress(elements[i]);
		str += elementAddress;
		if (i < elements.size() - 1)
			str += ",";
	}
	duk_push_string(ctx, str.c_str());
	return true;
}

int DKDomElement::releasePointerCapture(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::remove(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::removeAttribute(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString attribute = duk_require_string(ctx, 1);
	Rml::Element* element = (Rml::Element*)DKDuktape::addressToPointer(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	element->RemoveAttribute(attribute);
	duk_push_boolean(ctx, true);
	return true;
}

int DKDomElement::removeAttributeNode(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::removeAttributeNS(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::replaceChildren(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::replaceWith(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::requestFullscreen(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::requestPointerLock(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::scroll(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::scrollBy(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::scrollIntoView(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = (Rml::Element*)DKDuktape::addressToPointer(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	if (duk_is_boolean(ctx, 1)) {
		bool alignWithTop = duk_require_boolean(ctx, 1);
		element->ScrollIntoView(alignWithTop);
	}
	else {
		element->ScrollIntoView();
	}
	return true;
}

int DKDomElement::scrollIntoViewIfNeeded(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::scrollTo(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::setAttribute(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString attribute = duk_require_string(ctx, 1);
	DKString value;
	if (duk_is_string(ctx, 2)) {
		value = duk_require_string(ctx, 2);
	}
	else if (duk_is_boolean(ctx, 2)) {
		value = toString(duk_require_boolean(ctx, 2));
	}
	else {
		DKERROR("value invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	Rml::Element* element = (Rml::Element*)DKDuktape::addressToPointer(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	element->SetAttribute(attribute.c_str(), value.c_str());
	duk_push_boolean(ctx, true);
	//if the attribute is "src", then post process to load scripts or iframes
	//if(same(attribute,"src")){
	//	DKRml::Get()->dkRmlToRML.PostProcess(element);
	//}
	return true;
}

int DKDomElement::setAttributeNode(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::setAttributeNodeNS(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::setAttributeNS(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::setCapture(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::setHTML(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::setPointerCapture(duk_context* ctx) {
	//TODO
	return true;
}

int DKDomElement::toggleAttribute(duk_context* ctx) {
	//TODO
	return true;
}