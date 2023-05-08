#if HAVE_DKDuktape

#pragma once
#ifndef DKElementDUK_H
#define DKElementDUK_H

#include "DKDuktape/DKDuktape.h"


// [IDL] https://dom.spec.whatwg.org/#interface-element
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Element
class DKElementDUK : public DKObjectT<DKElementDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKElementDUK", DKElementDUK::constructor);	// [Element()]
		
		
				////// Instance properties //////
		// [Element.assignedSlot](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/assignedSlot
		// [Element.attributes](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/attributes
		// [Element.childElementCount](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/childElementCount
		// [Element.children](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/children
		// [Element.classList](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/classList
		// [Element.className] https://developer.mozilla.org/en-US/docs/Web/API/Element/className
		// [Element.clientHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientHeight
		// [Element.clientLeft](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientLeft
		// [Element.clientTop](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientTop
		// [Element.clientWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientWidth
		// [Element.elementTiming](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Element/elementTiming
		// [Element.firstElementChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/firstElementChild
		// [Element.id] https://developer.mozilla.org/en-US/docs/Web/API/Element/id
		// [Element.innerHTML] https://developer.mozilla.org/en-US/docs/Web/API/Element/innerHTML
		// [Element.lastElementChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/lastElementChild
		// [Element.localName](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/localName
		// [Element.namespaceURI](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/namespaceURI
		// [Element.nextElementSibling](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/nextElementSibling
		// [Element.outerHTML] https://developer.mozilla.org/en-US/docs/Web/API/Element/outerHTML
		// [Element.part] https://developer.mozilla.org/en-US/docs/Web/API/Element/part
		// [Element.prefix](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/prefix
		// [Element.previousElementSibling](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/previousElementSibling
		// [Element.scrollHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollHeight
		// [Element.scrollLeft] https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollLeft
		// [Element.scrollLeftMax](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollLeftMax
		// [Element.scrollTop] https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollTop
		// [Element.scrollTopMax](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollTopMax
		// [Element.scrollWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollWidth
		// [Element.shadowRoot](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/shadowRoot
		// [Element.slot] https://developer.mozilla.org/en-US/docs/Web/API/Element/slot
		// [Element.tagName](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/tagName
		
		
		////// Instance properties included from ARIA //////
		// [Element.ariaAtomic] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaAtomic
		// [Element.ariaAutoComplete] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaAutoComplete
		// [Element.ariaBusy] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaBusy
		// [Element.ariaChecked] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaChecked
		// [Element.ariaColCount] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaColCount
		// [Element.ariaColIndex] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaColIndex
		// [Element.ariaColSpan] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaColSpan
		// [Element.ariaCurrent] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaCurrent
		// [Element.ariaDescription] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaDescription
		// [Element.ariaDisabled] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaDisabled
		// [Element.ariaExpanded] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaExpanded
		// [Element.ariaHasPopup] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaHasPopup
		// [Element.ariaHidden] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaHidden
		// [Element.ariaKeyShortcuts] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaKeyShortcuts
		// [Element.ariaLabel] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaLabel
		// [Element.ariaLevel] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaLevel
		// [Element.ariaLive] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaLive
		// [Element.ariaModal] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaModal
		// [Element.ariaMultiline] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaMultiLine
		// [Element.ariaMultiSelectable] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaMultiSelectable
		// [Element.ariaOrientation] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaOrientation
		// [Element.ariaPlaceholder] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaPlaceholder
		// [Element.ariaPosInSet] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaPosInSet
		// [Element.ariaPressed] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaPressed
		// [Element.ariaReadOnly] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaReadOnly
		// [Element.ariaRelevant](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaRelevant
		// [Element.ariaRequired] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaRequired
		// [Element.ariaRoleDescription] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaRoleDescription
		// [Element.ariaRowCount] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaRowCount
		// [Element.ariaRowIndex] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaRowIndex
		// [Element.ariaRowSpan] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaRowSpan
		// [Element.ariaSelected] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaSelected
		// [Element.ariaSetSize] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaSetSize
		// [Element.ariaSort] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaSort
		// [Element.ariaValueMax] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaValueMax
		// [Element.ariaValueMin] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaValueMin
		// [Element.ariaValueNow] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaValueNow
		// [Element.ariaValueText] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaValueText

		
		////// Instance methods //////
		// [Element.after()] https://developer.mozilla.org/en-US/docs/Web/API/Element/after
		// [Element.attachShadow()] https://developer.mozilla.org/en-US/docs/Web/API/Element/attachShadow
		// [Element.animate()] https://developer.mozilla.org/en-US/docs/Web/API/Element/animate
		// [Element.append()] https://developer.mozilla.org/en-US/docs/Web/API/Element/append
		// [Element.before()] https://developer.mozilla.org/en-US/docs/Web/API/Element/before
		// [Element.closest()] https://developer.mozilla.org/en-US/docs/Web/API/Element/closest
		// [Element.computedStyleMap()] https://developer.mozilla.org/en-US/docs/Web/API/Element/computedStyleMap
		// [Element.getAnimations()] https://developer.mozilla.org/en-US/docs/Web/API/Element/getAnimations
		// [Element.getAttribute()] https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttribute
		// [Element.getAttributeNames()] https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttributeNames
		// [Element.getAttributeNode()] https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttributeNode
		// [Element.getAttributeNodeNS()] https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttributeNodeNS
		// [Element.getAttributeNS()] https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttributeNS
		// [Element.getBoundingClientRect()] https://developer.mozilla.org/en-US/docs/Web/API/Element/getBoundingClientRect
		// [Element.getBoxQuads()](Experimental)
		// [Element.getClientRects()] https://developer.mozilla.org/en-US/docs/Web/API/Element/getClientRects
		// [Element.getElementsByClassName()] https://developer.mozilla.org/en-US/docs/Web/API/Element/getElementsByClassName
		// [Element.getElementsByTagName()] https://developer.mozilla.org/en-US/docs/Web/API/Element/getElementsByTagName
		// [Element.getElementsByTagNameNS()] https://developer.mozilla.org/en-US/docs/Web/API/Element/getElementsByTagNameNS
		// [Element.hasAttribute()] https://developer.mozilla.org/en-US/docs/Web/API/Element/hasAttribute
		// [Element.hasAttributeNS()] https://developer.mozilla.org/en-US/docs/Web/API/Element/hasAttributeNS
		// [Element.hasAttributes()] https://developer.mozilla.org/en-US/docs/Web/API/Element/hasAttributes
		// [Element.hasPointerCapture()] https://developer.mozilla.org/en-US/docs/Web/API/Element/hasPointerCapture
		// [Element.insertAdjacentElement()] https://developer.mozilla.org/en-US/docs/Web/API/Element/insertAdjacentElement
		// [Element.insertAdjacentHTML()] https://developer.mozilla.org/en-US/docs/Web/API/Element/insertAdjacentHTML
		// [Element.insertAdjacentText()] https://developer.mozilla.org/en-US/docs/Web/API/Element/insertAdjacentText
		// [Element.matches()] https://developer.mozilla.org/en-US/docs/Web/API/Element/matches
		// [Element.prepend()] https://developer.mozilla.org/en-US/docs/Web/API/Element/prepend
		// [Element.querySelector()] https://developer.mozilla.org/en-US/docs/Web/API/Element/querySelector
		// [Element.querySelectorAll()] https://developer.mozilla.org/en-US/docs/Web/API/Element/querySelectorAll
		// [Element.releasePointerCapture()] https://developer.mozilla.org/en-US/docs/Web/API/Element/releasePointerCapture
		// [Element.remove()] https://developer.mozilla.org/en-US/docs/Web/API/Element/remove
		// [Element.removeAttribute()] https://developer.mozilla.org/en-US/docs/Web/API/Element/removeAttribute
		// [Element.removeAttributeNode()] https://developer.mozilla.org/en-US/docs/Web/API/Element/removeAttributeNode
		// [Element.removeAttributeNS()] https://developer.mozilla.org/en-US/docs/Web/API/Element/removeAttributeNS
		// [Element.replaceChildren()] https://developer.mozilla.org/en-US/docs/Web/API/Element/replaceChildren
		// [Element.replaceWith()] https://developer.mozilla.org/en-US/docs/Web/API/Element/replaceWith
		// [Element.requestFullscreen()] https://developer.mozilla.org/en-US/docs/Web/API/Element/requestFullscreen
		// [Element.requestPointerLock()] https://developer.mozilla.org/en-US/docs/Web/API/Element/requestPointerLock
		// [Element.scroll()] https://developer.mozilla.org/en-US/docs/Web/API/Element/scroll
		// [Element.scrollBy()] https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollBy
		// [Element.scrollIntoView()] https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollIntoView
		// [Element.scrollIntoViewIfNeeded()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollIntoViewIfNeeded
		// [Element.scrollTo()] https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollTo
		// [Element.setAttribute()] https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttribute
		// [Element.setAttributeNode()] https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttributeNode
		// [Element.setAttributeNodeNS()] https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttributeNodeNS
		// [Element.setAttributeNS()] https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttributeNS
		// [Element.setCapture()](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/setCapture
		// [Element.setHTML()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Element/setHTML
		// [Element.setPointerCapture()] https://developer.mozilla.org/en-US/docs/Web/API/Element/setPointerCapture
		// [Element.toggleAttribute()] https://developer.mozilla.org/en-US/docs/Web/API/Element/toggleAttribute
		
		
		////// Events //////
		// TODO

		////// Load .js files
		DKClass::DKCreate("DKElement/DKElementDUK.js");
		
		return true;
	}
	
	static DKElement* eventTarget(duk_context* ctx){
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKElement*)addressToPointer(eventTargetAddress);
	}

	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKElementDUK()\n");
		DKElement* _element = new DKElement();
		DKString eventTargetAddress = pointerToAddress(_element);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	
			////// Instance properties //////
		// [Element.assignedSlot](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/assignedSlot
		// [Element.attributes](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/attributes
		// [Element.childElementCount](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/childElementCount
		// [Element.children](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/children
		// [Element.classList](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/classList
		// [Element.className] https://developer.mozilla.org/en-US/docs/Web/API/Element/className
		// [Element.clientHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientHeight
		// [Element.clientLeft](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientLeft
		// [Element.clientTop](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientTop
		// [Element.clientWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientWidth
		// [Element.elementTiming](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Element/elementTiming
		// [Element.firstElementChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/firstElementChild
		// [Element.id] https://developer.mozilla.org/en-US/docs/Web/API/Element/id
		// [Element.innerHTML] https://developer.mozilla.org/en-US/docs/Web/API/Element/innerHTML
		// [Element.lastElementChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/lastElementChild
		// [Element.localName](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/localName
		// [Element.namespaceURI](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/namespaceURI
		// [Element.nextElementSibling](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/nextElementSibling
		// [Element.outerHTML] https://developer.mozilla.org/en-US/docs/Web/API/Element/outerHTML
		// [Element.part] https://developer.mozilla.org/en-US/docs/Web/API/Element/part
		// [Element.prefix](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/prefix
		// [Element.previousElementSibling](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/previousElementSibling
		// [Element.scrollHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollHeight
		// [Element.scrollLeft] https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollLeft
		// [Element.scrollLeftMax](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollLeftMax
		// [Element.scrollTop] https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollTop
		// [Element.scrollTopMax](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollTopMax
		// [Element.scrollWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollWidth
		// [Element.shadowRoot](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/shadowRoot
		// [Element.slot] https://developer.mozilla.org/en-US/docs/Web/API/Element/slot
		// [Element.tagName](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/tagName
		
		
		////// Instance properties included from ARIA //////
		// [Element.ariaAtomic] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaAtomic
		// [Element.ariaAutoComplete] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaAutoComplete
		// [Element.ariaBusy] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaBusy
		// [Element.ariaChecked] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaChecked
		// [Element.ariaColCount] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaColCount
		// [Element.ariaColIndex] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaColIndex
		// [Element.ariaColSpan] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaColSpan
		// [Element.ariaCurrent] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaCurrent
		// [Element.ariaDescription] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaDescription
		// [Element.ariaDisabled] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaDisabled
		// [Element.ariaExpanded] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaExpanded
		// [Element.ariaHasPopup] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaHasPopup
		// [Element.ariaHidden] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaHidden
		// [Element.ariaKeyShortcuts] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaKeyShortcuts
		// [Element.ariaLabel] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaLabel
		// [Element.ariaLevel] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaLevel
		// [Element.ariaLive] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaLive
		// [Element.ariaModal] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaModal
		// [Element.ariaMultiline] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaMultiLine
		// [Element.ariaMultiSelectable] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaMultiSelectable
		// [Element.ariaOrientation] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaOrientation
		// [Element.ariaPlaceholder] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaPlaceholder
		// [Element.ariaPosInSet] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaPosInSet
		// [Element.ariaPressed] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaPressed
		// [Element.ariaReadOnly] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaReadOnly
		// [Element.ariaRelevant](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaRelevant
		// [Element.ariaRequired] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaRequired
		// [Element.ariaRoleDescription] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaRoleDescription
		// [Element.ariaRowCount] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaRowCount
		// [Element.ariaRowIndex] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaRowIndex
		// [Element.ariaRowSpan] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaRowSpan
		// [Element.ariaSelected] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaSelected
		// [Element.ariaSetSize] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaSetSize
		// [Element.ariaSort] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaSort
		// [Element.ariaValueMax] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaValueMax
		// [Element.ariaValueMin] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaValueMin
		// [Element.ariaValueNow] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaValueNow
		// [Element.ariaValueText] https://developer.mozilla.org/en-US/docs/Web/API/Element/ariaValueText

		
		////// Instance methods //////
		// [Element.after()] https://developer.mozilla.org/en-US/docs/Web/API/Element/after
		// [Element.attachShadow()] https://developer.mozilla.org/en-US/docs/Web/API/Element/attachShadow
		// [Element.animate()] https://developer.mozilla.org/en-US/docs/Web/API/Element/animate
		// [Element.append()] https://developer.mozilla.org/en-US/docs/Web/API/Element/append
		// [Element.before()] https://developer.mozilla.org/en-US/docs/Web/API/Element/before
		// [Element.closest()] https://developer.mozilla.org/en-US/docs/Web/API/Element/closest
		// [Element.computedStyleMap()] https://developer.mozilla.org/en-US/docs/Web/API/Element/computedStyleMap
		// [Element.getAnimations()] https://developer.mozilla.org/en-US/docs/Web/API/Element/getAnimations
		// [Element.getAttribute()] https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttribute
		// [Element.getAttributeNames()] https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttributeNames
		// [Element.getAttributeNode()] https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttributeNode
		// [Element.getAttributeNodeNS()] https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttributeNodeNS
		// [Element.getAttributeNS()] https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttributeNS
		// [Element.getBoundingClientRect()] https://developer.mozilla.org/en-US/docs/Web/API/Element/getBoundingClientRect
		// [Element.getBoxQuads()](Experimental)
		// [Element.getClientRects()] https://developer.mozilla.org/en-US/docs/Web/API/Element/getClientRects
		// [Element.getElementsByClassName()] https://developer.mozilla.org/en-US/docs/Web/API/Element/getElementsByClassName
		// [Element.getElementsByTagName()] https://developer.mozilla.org/en-US/docs/Web/API/Element/getElementsByTagName
		// [Element.getElementsByTagNameNS()] https://developer.mozilla.org/en-US/docs/Web/API/Element/getElementsByTagNameNS
		// [Element.hasAttribute()] https://developer.mozilla.org/en-US/docs/Web/API/Element/hasAttribute
		// [Element.hasAttributeNS()] https://developer.mozilla.org/en-US/docs/Web/API/Element/hasAttributeNS
		// [Element.hasAttributes()] https://developer.mozilla.org/en-US/docs/Web/API/Element/hasAttributes
		// [Element.hasPointerCapture()] https://developer.mozilla.org/en-US/docs/Web/API/Element/hasPointerCapture
		// [Element.insertAdjacentElement()] https://developer.mozilla.org/en-US/docs/Web/API/Element/insertAdjacentElement
		// [Element.insertAdjacentHTML()] https://developer.mozilla.org/en-US/docs/Web/API/Element/insertAdjacentHTML
		// [Element.insertAdjacentText()] https://developer.mozilla.org/en-US/docs/Web/API/Element/insertAdjacentText
		// [Element.matches()] https://developer.mozilla.org/en-US/docs/Web/API/Element/matches
		// [Element.prepend()] https://developer.mozilla.org/en-US/docs/Web/API/Element/prepend
		// [Element.querySelector()] https://developer.mozilla.org/en-US/docs/Web/API/Element/querySelector
		// [Element.querySelectorAll()] https://developer.mozilla.org/en-US/docs/Web/API/Element/querySelectorAll
		// [Element.releasePointerCapture()] https://developer.mozilla.org/en-US/docs/Web/API/Element/releasePointerCapture
		// [Element.remove()] https://developer.mozilla.org/en-US/docs/Web/API/Element/remove
		// [Element.removeAttribute()] https://developer.mozilla.org/en-US/docs/Web/API/Element/removeAttribute
		// [Element.removeAttributeNode()] https://developer.mozilla.org/en-US/docs/Web/API/Element/removeAttributeNode
		// [Element.removeAttributeNS()] https://developer.mozilla.org/en-US/docs/Web/API/Element/removeAttributeNS
		// [Element.replaceChildren()] https://developer.mozilla.org/en-US/docs/Web/API/Element/replaceChildren
		// [Element.replaceWith()] https://developer.mozilla.org/en-US/docs/Web/API/Element/replaceWith
		// [Element.requestFullscreen()] https://developer.mozilla.org/en-US/docs/Web/API/Element/requestFullscreen
		// [Element.requestPointerLock()] https://developer.mozilla.org/en-US/docs/Web/API/Element/requestPointerLock
		// [Element.scroll()] https://developer.mozilla.org/en-US/docs/Web/API/Element/scroll
		// [Element.scrollBy()] https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollBy
		// [Element.scrollIntoView()] https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollIntoView
		// [Element.scrollIntoViewIfNeeded()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollIntoViewIfNeeded
		// [Element.scrollTo()] https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollTo
		// [Element.setAttribute()] https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttribute
		// [Element.setAttributeNode()] https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttributeNode
		// [Element.setAttributeNodeNS()] https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttributeNodeNS
		// [Element.setAttributeNS()] https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttributeNS
		// [Element.setCapture()](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/setCapture
		// [Element.setHTML()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Element/setHTML
		// [Element.setPointerCapture()] https://developer.mozilla.org/en-US/docs/Web/API/Element/setPointerCapture
		// [Element.toggleAttribute()] https://developer.mozilla.org/en-US/docs/Web/API/Element/toggleAttribute
		
		
		////// Events //////
		// TODO
	
};
REGISTER_OBJECT(DKElementDUK, true)


#endif //DKElementDUK_H
#endif //HAVE_DKDuktape