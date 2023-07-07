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
		address[interfaceName] = pointerToAddress(this);
		DKINFO("DK"+interfaceName+"("+interfaceAddress+","+address[interfaceName]+") \n");
	}

	// [CEReactions] attribute DOMString alt;
	DOMString _alt = "";
	virtual const DOMString& alt()									{ return _alt; }						// getter
	virtual void alt(const DOMString& alt)							{ _alt = alt; } 						// setter
	
	// [CEReactions] attribute USVString src;
	USVString _src = "";
	virtual const USVString& src()									{ return _src; }						// getter
	virtual void src(const USVString& src)							{ _src = src; } 						// setter
	
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
	unsigned int _height = 0;
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
	virtual void complete(const bool& complete)						{ _complete = complete; } 				// setter
	
	// readonly attribute USVString currentSrc;
	USVString _currentSrc = "";
	virtual const USVString& currentSrc()							{ return _currentSrc; }					// getter
	virtual void currentSrc(const USVString& currentSrc)			{ _currentSrc = currentSrc; }			// setter
	
	// [CEReactions] attribute DOMString referrerPolicy;
	DOMString _referrerPolicy = "";
	virtual const DOMString& referrerPolicy()						{ return _referrerPolicy; }				// getter
	virtual void referrerPolicy(const DOMString& referrerPolicy)	{ _referrerPolicy = referrerPolicy; } 	// setter
	
	// [CEReactions] attribute DOMString decoding;
	DOMString _decoding = "";
	virtual const DOMString& decoding()								{ return _decoding; }					// getter
	virtual void decoding(const DOMString& decoding)				{ _decoding = decoding; } 				// setter
	
	// [CEReactions] attribute DOMString loading;
	DOMString _loading = "";
	virtual const DOMString& loading()								{ return _loading; }					// getter
	virtual void loading(const DOMString& loading)					{ _loading = loading; } 				// setter
	
	// [CEReactions] attribute DOMString fetchPriority;
	DOMString _fetchPriority = "";
	virtual const DOMString& fetchPriority()						{ return _fetchPriority; }				// getter
	virtual void fetchPriority(const DOMString& fetchPriority)		{ _fetchPriority = fetchPriority; } 	// setter
	
	// Promise<undefined> decode();
	virtual void decode() {
		DKDEBUGFUNC();
	}

	// also has obsolete members
//};

// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
// partial interface HTMLImageElement {
	// [CEReactions] attribute DOMString name;
	DOMString _name = "";
	virtual const DOMString& name()									{ return _name; }						// getter
	virtual void name(const DOMString& name)						{ _name = name; } 						// setter
	
	// [CEReactions] attribute USVString lowsrc;
	USVString _lowsrc = "";
	virtual const USVString& lowsrc()								{ return _lowsrc; }						// getter
	virtual void lowsrc(const USVString& lowsrc)					{ _lowsrc = lowsrc; } 					// setter
	
	// [CEReactions] attribute DOMString align;
	DOMString _align = "";
	virtual const DOMString& align()								{ return _align; }						// getter
	virtual void align(const DOMString& align)						{ _align = align; } 					// setter
	
	// [CEReactions] attribute unsigned long hspace;
	unsigned int _hspace = 0;
	virtual const unsigned int& hspace()							{ return _hspace; }						// getter
	virtual void hspace(const unsigned int& hspace)					{ _hspace = hspace; } 					// setter
	
	// [CEReactions] attribute unsigned long vspace;
	unsigned int _vspace = 0;
	virtual const unsigned int& vspace()							{ return _vspace; }						// getter
	virtual void vspace(const unsigned int& vspace)					{ _vspace = vspace; } 					// sette
	
	// [CEReactions] attribute USVString longDesc;
	USVString _longDesc = "";
	virtual const USVString& longDesc()								{ return _longDesc; }					// getter
	virtual void longDesc(const USVString& longDesc)				{ _longDesc = longDesc; } 				// setter
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString border;
	DOMString _border = "";
	virtual const DOMString& border()								{ return _border; }						// getter
	virtual void border(const DOMString& border)					{ _border = border; } 					// setter
// };

// Source: Attribution Reporting (https://wicg.github.io/attribution-reporting-api/)
// HTMLImageElement includes HTMLAttributionSrcElementUtils;

// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
// partial interface HTMLImageElement {
	// readonly attribute long x;
	int _x = 0;
	virtual const int& x()											{ return _x; }							// getter
	virtual void x(const int& x)									{ _x = x; } 							// setter
	
	// readonly attribute long y;
	int _y = 0;
	virtual const int& y()											{ return _y; }							// getter
	virtual void y(const int& y)									{ _y = y; } 							// setter
//};


	////// toString //////
	operator std::string() const { return "[object HTMLImageElement]"; }
};


class DKNullHTMLImageElement : public DKHTMLImageElement
{
public:
	operator std::string() const { return "null"; }
};


#endif //DKHTMLImageElement_H