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
#pragma once
#ifndef DKDomElement_H
#define DKDomElement_H

#include "DKDom/DKDomElement.h"
#include "DKDuktape/DKDuktape.h"

//https://developer.mozilla.org/en-US/docs/Web/API/Element
class DKDomElement : public DKObjectT<DKDomElement>
{
public:
	bool Init();
	
	////// Instance properties //////
	static int assignedSlot(duk_context* ctx);			// (Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/assignedSlot
	static int attributes(duk_context* ctx);			// (Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/attributes
	static int childElementCount(duk_context* ctx);		// (Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/childElementCount
	static int children(duk_context* ctx);				// (Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/children
	static int classList(duk_context* ctx);				// (Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/classList
	static int className(duk_context* ctx);				// https://developer.mozilla.org/en-US/docs/Web/API/Element/className
	static int clientHeight(duk_context* ctx);			// (Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientHeight
	static int clientLeft(duk_context* ctx);			// (Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientLeft
	static int clientTop(duk_context* ctx);				// (Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientTop
	static int clientWidth(duk_context* ctx);			// (Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientWidth
	static int elementTiming(duk_context* ctx);			// (Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Element/elementTiming
	static int firstElementChild(duk_context* ctx);		// (Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/firstElementChild
	static int id(duk_context* ctx);					// https://developer.mozilla.org/en-US/docs/Web/API/Element/id
	static int innerHTML(duk_context* ctx);				// https://developer.mozilla.org/en-US/docs/Web/API/Element/innerHTML
	static int lastElementChild(duk_context* ctx);		// (Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/lastElementChild
	static int localName(duk_context* ctx);				// (Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/localName
	static int namespaceURI(duk_context* ctx);			// (Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/namespaceURI
	static int nextElementSibling(duk_context* ctx);	// (Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/nextElementSibling
	static int outerHTML(duk_context* ctx);				// https://developer.mozilla.org/en-US/docs/Web/API/Element/outerHTML
	static int part(duk_context* ctx);					// https://developer.mozilla.org/en-US/docs/Web/API/Element/part
	static int prefix(duk_context* ctx);				// (Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/prefix
	static int previousElementSibling(duk_context* ctx);// (Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/previousElementSibling
	static int scrollHeight(duk_context* ctx);			// (Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollHeight
	static int scrollLeft(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollLeft
	static int scrollLeftMax(duk_context* ctx);			// (Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollLeftMax
	static int scrollTop(duk_context* ctx);				// https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollTop
	static int scrollTopMax(duk_context* ctx);			// (Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollTopMax
	static int scrollWidth(duk_context* ctx);			// (Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollWidth
	static int shadowRoot(duk_context* ctx);			// (Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/shadowRoot
	static int slot(duk_context* ctx);					// https://developer.mozilla.org/en-US/docs/Web/API/Element/slot
	static int tagName(duk_context* ctx);				// (Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/tagName
	
	////// Instance properties included from ARIA //////
	static int ariaAtomic(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaAtomic
	static int ariaAutoComplete(duk_context* ctx);		// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaAutoComplete
	static int ariaBusy(duk_context* ctx);				// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaBusy
	static int ariaChecked(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaChecked
	static int ariaColCount(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaColCount
	static int ariaColIndex(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaColIndex
	static int ariaColSpan(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaColSpan
	static int ariaCurrent(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaCurrent
	static int ariaDescription(duk_context* ctx);		// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaDescription
	static int ariaDisabled(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaDisabled
	static int ariaExpanded(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaExpanded
	static int ariaHasPopup(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaHasPopup
	static int ariaHidden(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaHidden
	static int ariaKeyShortcuts(duk_context* ctx);		// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaKeyShortcuts
	static int ariaLabel(duk_context* ctx);				// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaLabel
	static int ariaLevel(duk_context* ctx);				// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaLevel
	static int ariaLive(duk_context* ctx);				// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaLive
	static int ariaModal(duk_context* ctx);				// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaModal
	static int ariaMultiline(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaMultiline
	static int ariaMultiSelectable(duk_context* ctx);	// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaMultiSelectable
	static int ariaOrientation(duk_context* ctx);		// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaOrientation
	static int ariaPlaceholder(duk_context* ctx);		// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaPlaceholder
	static int ariaPosInSet(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaPosInSet
	static int ariaPressed(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaPressed
	static int ariaReadOnly(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaReadOnly
	static int ariaRelevant(duk_context* ctx);			// (Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaRelevant
	static int ariaRequired(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaRequired
	static int ariaRoleDescription(duk_context* ctx);	// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaRoleDescription
	static int ariaRowCount(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaRowCount
	static int ariaRowIndex(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaRowIndex
	static int ariaRowSpan(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaRowSpan
	static int ariaSelected(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaSelected
	static int ariaSetSize(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaSetSize
	static int ariaSort(duk_context* ctx);				// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaSort
	static int ariaValueMax(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaValueMax
	static int ariaValueMin(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaValueMin
	static int ariaValueNow(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaValueNow
	static int ariaValueText(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaValueText

	////// Instance methods //////
	static int after(duk_context* ctx);					// https://developer.mozilla.org/en-US/docs/Web/API/Element/after
	static int attachShadow(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/attachShadow
	static int animate(duk_context* ctx);				// https://developer.mozilla.org/en-US/docs/Web/API/Element/animate
	static int append(duk_context* ctx);				// https://developer.mozilla.org/en-US/docs/Web/API/Element/append
	static int before(duk_context* ctx);				// https://developer.mozilla.org/en-US/docs/Web/API/Element/before
	static int closest(duk_context* ctx);				// https://developer.mozilla.org/en-US/docs/Web/API/Element/closest
	static int computedStyleMap(duk_context* ctx);		// https://developer.mozilla.org/en-US/docs/Web/API/Element/computedStyleMap
	static int getAnimations(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/getAnimations
	static int getAttribute(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttribute
	static int getAttributeNames(duk_context* ctx);		// https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttributeNames
	static int getAttributeNode(duk_context* ctx);		// https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttributeNode
	static int getAttributeNodeNS(duk_context* ctx);	// https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttributeNodeNS
	static int getAttributeNS(duk_context* ctx);		// https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttributeNS
	static int getBoundingClientRect(duk_context* ctx);	// https://developer.mozilla.org/en-US/docs/Web/API/Element/getBoundingClientRect
	static int getBoxQuads(duk_context* ctx); 			// (Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Element/getBoxQuads
	static int getClientRects(duk_context* ctx);		// https://developer.mozilla.org/en-US/docs/Web/API/Element/getClientRects
	static int getElementsByClassName(duk_context* ctx);// https://developer.mozilla.org/en-US/docs/Web/API/Element/getElementsByClassName
	static int getElementsByTagName(duk_context* ctx);	// https://developer.mozilla.org/en-US/docs/Web/API/Element/getElementsByTagName
	static int getElementsByTagNameNS(duk_context* ctx);// https://developer.mozilla.org/en-US/docs/Web/API/Element/getElementsByTagNameNS
	static int hasAttribute(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/hasAttribute
	static int hasAttributeNS(duk_context* ctx);		// https://developer.mozilla.org/en-US/docs/Web/API/Element/hasAttributeNS
	static int hasAttributes(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/hasAttributes
	static int hasPointerCapture(duk_context* ctx);		// https://developer.mozilla.org/en-US/docs/Web/API/Element/hasPointerCapture
	static int insertAdjacentElement(duk_context* ctx);	// https://developer.mozilla.org/en-US/docs/Web/API/Element/insertAdjacentElement
	static int insertAdjacentHTML(duk_context* ctx);	// https://developer.mozilla.org/en-US/docs/Web/API/Element/insertAdjacentHTML
	static int insertAdjacentText(duk_context* ctx);	// https://developer.mozilla.org/en-US/docs/Web/API/Element/insertAdjacentText
	static int matches(duk_context* ctx);				// https://developer.mozilla.org/en-US/docs/Web/API/Element/matches
	static int prepend(duk_context* ctx);				// https://developer.mozilla.org/en-US/docs/Web/API/Element/prepend
	static int querySelector(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/querySelector
	static int querySelectorAll(duk_context* ctx);		// https://developer.mozilla.org/en-US/docs/Web/API/Element/querySelectorAll
	static int releasePointerCapture(duk_context* ctx);	// https://developer.mozilla.org/en-US/docs/Web/API/Element/releasePointerCapture
	static int remove(duk_context* ctx);				// https://developer.mozilla.org/en-US/docs/Web/API/Element/remove
	static int removeAttribute(duk_context* ctx);		// https://developer.mozilla.org/en-US/docs/Web/API/Element/removeAttribute
	static int removeAttributeNode(duk_context* ctx);	// https://developer.mozilla.org/en-US/docs/Web/API/Element/removeAttributeNode
	static int removeAttributeNS(duk_context* ctx);		// https://developer.mozilla.org/en-US/docs/Web/API/Element/removeAttributeNS
	static int replaceChildren(duk_context* ctx);		// https://developer.mozilla.org/en-US/docs/Web/API/Element/replaceChildren
	static int replaceWith(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/replaceWith
	static int requestFullscreen(duk_context* ctx);		// https://developer.mozilla.org/en-US/docs/Web/API/Element/requestFullscreen
	static int requestPointerLock(duk_context* ctx);	// https://developer.mozilla.org/en-US/docs/Web/API/Element/requestPointerLock
	static int scroll(duk_context* ctx);				// https://developer.mozilla.org/en-US/docs/Web/API/Element/scroll
	static int scrollBy(duk_context* ctx);				// https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollBy
	static int scrollIntoView(duk_context* ctx);		// https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollIntoView
	static int scrollIntoViewIfNeeded(duk_context* ctx);// (Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollIntoViewIfNeeded
	static int scrollTo(duk_context* ctx);				// https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollTo
	static int setAttribute(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttribute
	static int setAttributeNode(duk_context* ctx);		// https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttributeNode
	static int setAttributeNodeNS(duk_context* ctx);	// https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttributeNodeNS
	static int setAttributeNS(duk_context* ctx);		// https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttributeNS
	static int setCapture(duk_context* ctx);			// (Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/setCapture
	static int setHTML(duk_context* ctx);				// (Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Element/setHTML
	static int setPointerCapture(duk_context* ctx);		// https://developer.mozilla.org/en-US/docs/Web/API/Element/setPointerCapture
	static int toggleAttribute(duk_context* ctx);		// https://developer.mozilla.org/en-US/docs/Web/API/Element/toggleAttribute
};
REGISTER_OBJECT(DKDomElement, true)


#endif //DKDomElement_H