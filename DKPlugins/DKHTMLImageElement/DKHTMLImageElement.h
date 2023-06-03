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
	DOMString _alt = "";
	virtual const DOMString& alt()									{ return _alt; }						// getter
	virtual void alt(const DOMString& alt)							{ _alt = alt; } 						// setter
	
	// [CEReactions] attribute USVString src;
	USVString _src = "";
	virtual const USVString& src()									{ return _src; }						// getter
	virtual void src(const USVString& src)							{ _src = _rc; } 						// setter
	
	// [CEReactions] attribute USVString srcset;
	USVString _srcset = "";
	virtual const USVString& srcset()								{ return _srcset; }						// getter
	virtual void srcset(const USVString& srcset)					{ _srcset = srcset; } 					// setter
	
	// [CEReactions] attribute DOMString sizes;
	DOMString _sizes = "";
	virtual const DOMString& sizes()								{ return _sizes; }						// getter
	virtual void sizes(const DOMString& sizes)						{ _sizes = sizes; } 					// setter
	
	// [CEReactions] attribute DOMString? crossOrigin;
	DOMString _crossOrigin = "";
	virtual const DOMString& crossOrigin()							{ return _crossOrigin; }				// getter
	virtual void crossOrigin(const DOMString& crossOrigin)			{ _crossOrigin = crossOrigin;} 			// setter
	
	// [CEReactions] attribute DOMString useMap;
	DOMString _useMap = "";
	virtual const DOMString& useMap()								{ return _useMap; }						// getter
	virtual void useMap(const DOMString& useMap)					{ _useMap = useMap; } 					// setter
	
	// [CEReactions] attribute boolean isMap;
	bool _isMap = false;
	virtual const bool& isMap()										{ return _isMap; }						// getter
	virtual void isMap(const bool& isMap)							{ _isMap = isMap; } 					// setter
	
	// [CEReactions] attribute unsigned long width;
	unsigned int _width = 0;
	virtual const unsigned int& width()								{ return _width; }						// getter
	virtual void width(const unsigned int& width)					{ _width = width; } 					// setter
	
	// [CEReactions] attribute unsigned long height;
	unsigned int _height = ""
	virtual const unsigned int& height()							{ return _height; }						// getter
	virtual void height(const unsigned int& height)					{ _height = height; } 					// setter
	
	// readonly attribute unsigned long naturalWidth;
	unsigned int _naturalWidth = 0;
	virtual const unsigned int& naturalWidth()						{ return _naturalWidth; }				// getter
	virtual void naturalWidth(const unsigned int& naturalWidth)		{ _naturalWidth = naturalWidth; } 		// setter
	
	// readonly attribute unsigned long naturalHeight;
	unsigned int _naturalHeight = 0;
	virtual const unsigned int& naturalHeight()						{ return _naturalHeight; }				// getter
	virtual void naturalHeight(const unsigned int& naturalHeight)	{ _naturalHeight = naturalHeight; } 	// setter
	
	// readonly attribute boolean complete;
	bool _complete = false;
	virtual const bool& complete()									{ return _complete; }					// getter
	virtual void complete(const bool& complete)						{ _complete = _complete; } 				// setter
	
	// readonly attribute USVString currentSrc;
	USVString _currentSrc = "";
	virtual const USVString& currentSrc()							{ return _currentSrc; }					// getter
	virtual void currentSrc(const USVString& currentSrc)			{ _currentSrc = _currentSrc; }			// setter
	
	// [CEReactions] attribute DOMString referrerPolicy;
	DOMString _referrerPolicy = "";
	virtual const DOMString& referrerPolicy()						{ return _referrerPolicy; }				// getter
	virtual void referrerPolicy(const DOMString& referrerPolicy)	{ _referrerPolicy = referrerPolicy; } 	// setter
	
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
	virtual bool decode() {
		DKDEBUGFUNC();
		return DKTODO();
	}

	// also has obsolete members
//};

// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
// partial interface HTMLImageElement {
	// [CEReactions] attribute DOMString name;
	virtual DOMString name()						{ return ""; }		// getter
	virtual void name(const DOMString&)				{ } 				// setter
	
	// [CEReactions] attribute USVString lowsrc;
	virtual USVString lowsrc()						{ return ""; }		// getter
	virtual void lowsrc(const USVString&)				{ } 				// setter
	
	// [CEReactions] attribute DOMString align;
	virtual DOMString align()						{ return ""; }		// getter
	virtual void align(const DOMString&)			{ } 				// setter
	
	// [CEReactions] attribute unsigned long hspace;
	virtual unsigned int hspace()					{ return 0; }		// getter
	virtual void hspace(const unsigned int&)		{ } 				// setter
	
	// [CEReactions] attribute unsigned long vspace;
	virtual unsigned int vspace()					{ return 0; }		// getter
	virtual void vspace(const unsigned int&)		{ } 				// sette
	
	// [CEReactions] attribute USVString longDesc;
	virtual USVString longDesc()					{ return ""; }		// getter
	virtual void longDesc(const USVString&)			{ } 				// setter
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString border;
	virtual DOMString border()						{ return ""; }		// getter
	virtual void border(const DOMString&)			{ } 				// setter
// };

// Source: Attribution Reporting (https://wicg.github.io/attribution-reporting-api/)
// HTMLImageElement includes HTMLAttributionSrcElementUtils;

// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
// partial interface HTMLImageElement {
	// readonly attribute long x;
	virtual int x()									{ return 0; }		// getter
	virtual void x(const int&)						{ } 				// setter
	
	// readonly attribute long y;
	virtual int y()									{ return 0; }		// getter
	virtual void y(const int&)						{ } 				// setter
//};
};


#endif //DKHTMLImageElement_H