#pragma once
#ifndef DKHTMLElement_H
#define DKHTMLElement_H

#include "DKNode/DKNode.h"


// [IDL] https://html.spec.whatwg.org/multipage/dom.html#htmlelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement
class DKHTMLElement : public DKElement
{
public:
	////// Constructor //////
	// [HTMLElement()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/HTMLElement
	DKHTMLElement() : DKElement() {
		DKDEBUGFUNC();
		eventTargetClass = "HTMLElement";
		eventTargetAddress = pointerToAddress(this);
		
		
		////// Instance properties //////
		// [HTMLElement.accessKey] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/accessKey
		// [HTMLElement.accessKeyLabel](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/accessKeyLabel
		// [HTMLElement.attributeStyleMap](Read only)
		// [HTMLElement.contentEditable] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/contentEditable
		// [HTMLElement.isContentEditable](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/isContentEditable
		// [HTMLElement.dataset](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dataset
		// [HTMLElement.dir] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dir
		// [HTMLElement.draggable]
		// [HTMLElement.enterKeyHint] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/enterKeyHint
		// [HTMLElement.hidden] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/hidden
		// [HTMLElement.inert] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/inert
		// [HTMLElement.innerText] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/innerText
		// [HTMLElement.inputMode] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/inputMode
		// [HTMLElement.popover](Experimental)
		// [HTMLElement.lang] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/lang
		// [HTMLElement.noModule] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/nonce
		// [HTMLElement.nonce] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/nonce
		// [HTMLElement.offsetHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/offsetHeight
		// [HTMLElement.offsetLeft](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/offsetLeft
		// [HTMLElement.offsetParent](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/offsetParent
		// [HTMLElement.offsetTop](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/offsetTop
		// [HTMLElement.offsetWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/offsetWidth
		// [HTMLElement.outerText] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/outerText
		// [HTMLElement.properties](Experimental)(Read only)
		// [HTMLElement.spellcheck]
		// [HTMLElement.style] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/style
		// [HTMLElement.tabIndex] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/tabIndex
		// [HTMLElement.title] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/title
		// [HTMLElement.translate]


		////// Instance methods //////
		// [HTMLElement.attachInternals()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/attachInternals
		// [HTMLElement.blur()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/blur
		// [HTMLElement.click()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/click
		// [HTMLElement.focus()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/focus
		// [HTMLElement.hidePopover()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/hidePopover
		// [HTMLElement.showPopover()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/showPopover
		// [HTMLElement.togglePopover()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/togglePopover
		
		
		////// Events //////
		// TODO
		
	}
	
	
	////// Instance properties //////
	// [HTMLElement.accessKey] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/accessKey
	// [HTMLElement.accessKeyLabel](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/accessKeyLabel
	// [HTMLElement.attributeStyleMap](Read only)
	// [HTMLElement.contentEditable] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/contentEditable
	// [HTMLElement.isContentEditable](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/isContentEditable
	// [HTMLElement.dataset](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dataset
	// [HTMLElement.dir] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dir
	// [HTMLElement.draggable]
	// [HTMLElement.enterKeyHint] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/enterKeyHint
	// [HTMLElement.hidden] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/hidden
	// [HTMLElement.inert] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/inert
	// [HTMLElement.innerText] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/innerText
	// [HTMLElement.inputMode] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/inputMode
	// [HTMLElement.popover](Experimental)
	// [HTMLElement.lang] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/lang
	// [HTMLElement.noModule] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/nonce
	// [HTMLElement.nonce] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/nonce
	// [HTMLElement.offsetHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/offsetHeight
	// [HTMLElement.offsetLeft](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/offsetLeft
	// [HTMLElement.offsetParent](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/offsetParent
	// [HTMLElement.offsetTop](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/offsetTop
	// [HTMLElement.offsetWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/offsetWidth
	// [HTMLElement.outerText] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/outerText
	// [HTMLElement.properties](Experimental)(Read only)
	// [HTMLElement.spellcheck]
	// [HTMLElement.style] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/style
	// [HTMLElement.tabIndex] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/tabIndex
	// [HTMLElement.title] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/title
	// [HTMLElement.translate]


	////// Instance methods //////
	// [HTMLElement.attachInternals()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/attachInternals
	// [HTMLElement.blur()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/blur
	// [HTMLElement.click()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/click
	// [HTMLElement.focus()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/focus
	// [HTMLElement.hidePopover()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/hidePopover
	// [HTMLElement.showPopover()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/showPopover
	// [HTMLElement.togglePopover()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/togglePopover
		
		
	////// Events //////
	// TODO
};


#endif //DKHTMLElement_H