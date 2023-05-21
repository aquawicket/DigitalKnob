// [IDL] https://html.spec.whatwg.org/multipage/sections.html#htmlbodyelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement
#pragma once
#ifndef DKHTMLImageElement_H
#define DKHTMLImageElement_H

#include "DKHTMLElement/DKHTMLElement.h"


// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
// [Exposed=Window,
// LegacyFactoryFunction=Image(optional unsigned long width, optional unsigned long height)]
// interface HTMLImageElement : HTMLElement {
class DKHTMLImageElement : public DKHTMLElement
{
public:
	// [HTMLConstructor] constructor();
	DKHTMLImageElement() : DKHTMLElement() {
		DKDEBUGFUNC();
		interfaceName = "HTMLImageElement";
		interfaceAddress = pointerToAddress(this);
	}

	// [CEReactions] attribute DOMString alt;
	virtual DOMString alt()							{ return ""; }		// getter
	virtual void alt(const DOMString&)				{ } 				// setter
	
	// [CEReactions] attribute USVString src;
	virtual USVString src()							{ return ""; }		// getter
	virtual void src(const USVString&)				{ } 				// setter
	
	// [CEReactions] attribute USVString srcset;
	virtual USVString srcset()						{ return ""; }		// getter
	virtual void srcset(const USVString&)			{ } 				// setter
	
	// [CEReactions] attribute DOMString sizes;
	virtual DOMString sizes()						{ return ""; }		// getter
	virtual void sizes(const DOMString&)			{ } 				// setter
	
	// [CEReactions] attribute DOMString? crossOrigin;
	virtual DOMString crossOrigin()					{ return ""; }		// getter
	virtual void crossOrigin(const DOMString&)		{ } 				// setter
	
	// [CEReactions] attribute DOMString useMap;
	virtual DOMString useMap()						{ return ""; }		// getter
	virtual void useMap(const DOMString&)			{ } 				// setter
	
	// [CEReactions] attribute boolean isMap;
	virtual bool isMap()							{ return false; }	// getter
	virtual void isMap(const bool&)					{ } 				// setter
	
	// [CEReactions] attribute unsigned long width;
	virtual unsigned int width()					{ return 0; }		// getter
	virtual void width(const unsigned int&)			{ } 				// setter
	
	// [CEReactions] attribute unsigned long height;
	virtual unsigned int height()					{ return 0; }		// getter
	virtual void height(const unsigned int&)		{ } 				// setter
	
	// readonly attribute unsigned long naturalWidth;
	virtual unsigned int naturalWidth()				{ return 0; }		// getter
	virtual void naturalWidth(const unsigned int&)	{ } 				// setter
	
	// readonly attribute unsigned long naturalHeight;
	virtual unsigned int naturalHeight()			{ return 0; }		// getter
	virtual void naturalHeight(const unsigned int&)	{ } 				// setter
	
	// readonly attribute boolean complete;
	virtual bool complete()							{ return false; }	// getter
	virtual void complete(const bool&)				{ } 				// setter
	
	// readonly attribute USVString currentSrc;
	virtual USVString currentSrc()					{ return ""; }		// getter
	virtual void currentSrc(const USVString&)		{ } 				// setter
	
	// [CEReactions] attribute DOMString referrerPolicy;
	virtual DOMString referrerPolicy()				{ return ""; }		// getter
	virtual void referrerPolicy(const DOMString&)	{ } 				// setter
	
	// [CEReactions] attribute DOMString decoding;
	virtual DOMString decoding()					{ return ""; }		// getter
	virtual void decoding(const DOMString&)			{ } 				// setter
	
	// [CEReactions] attribute DOMString loading;
	virtual DOMString loading()						{ return ""; }		// getter
	virtual void loading(const DOMString&)			{ } 				// setter
	
	// [CEReactions] attribute DOMString fetchPriority;
	virtual DOMString fetchPriority()				{ return ""; }		// getter
	virtual void fetchPriority(const DOMString&)	{ } 				// setter
	
	// Promise<undefined> decode();
	// TODO

	// also has obsolete members
//};

};


#endif //DKHTMLImageElement_H