// [IDL] https://drafts.csswg.org/cssom/#the-cssstyledeclaration-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleDeclaration
#pragma once
#ifndef DKCSSStyleDeclaration_H
#define DKCSSStyleDeclaration_H

#include "DKInterface/DKInterface.h"


// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
// [Exposed=Window]
// interface CSSStyleDeclaration {
class DKCSSStyleDeclaration : public DKInterface
{
public:
	DKCSSStyleDeclaration() : DKInterface() {
		DKDEBUGFUNC();
		interfaceName = "CSSStyleDeclaration";
		interfaceAddress = pointerToAddress(this);
	}
	
	// [CEReactions] attribute CSSOMString cssText;
	CSSOMString _cssText = "";
	virtual const CSSOMString& cssText()					{ return _cssText; }			// getter
	virtual void cssText(const CSSOMString& cssText)		{ _cssText = cssText; } 		// setter
	
	// readonly attribute unsigned long length;
	unsigned int _length = 0;
	virtual const unsigned int& length()					{ return _length; }				// getter
	virtual void length(const unsigned int& length)			{ _length = length; } 			// setter
	
	// getter CSSOMString item(unsigned long index);
	CSSOMString _item = "";
	virtual const CSSOMString& item(const unsigned int& index){
		DKDEBUGFUNC(index);
		return _item;
	}
	
	// CSSOMString getPropertyValue(CSSOMString property);
	CSSOMString _getPropertyValue = "";
	virtual const CSSOMString& getPropertyValue(const CSSOMString& property){
		DKDEBUGFUNC(property);
		return _getPropertyValue;
	}
	
	// CSSOMString getPropertyPriority(CSSOMString property);
	CSSOMString _getPropertyPriority = "";
	virtual const CSSOMString& getPropertyPriority(const CSSOMString& property){
		DKDEBUGFUNC(property);
		return _getPropertyPriority;
	}
	
	// [CEReactions] undefined setProperty(CSSOMString property, [LegacyNullToEmptyString] CSSOMString value, optional [LegacyNullToEmptyString] CSSOMString priority = "");
	virtual void setProperty(const CSSOMString& property, const CSSOMString& value, const CSSOMString& priority = ""){
		DKDEBUGFUNC(property, value, priority);
	}
	
	// [CEReactions] CSSOMString removeProperty(CSSOMString property);
	CSSOMString _removeProperty = "";
	virtual const CSSOMString& removeProperty(const CSSOMString& property){
		DKDEBUGFUNC(property);
		return _removeProperty;
	}
	
	// readonly attribute CSSRule? parentRule;
	DKString _parentRule = "";
	virtual const DKString& parentRule()					{ return _parentRule; }				// getter
	virtual void cssFloat(const DKString& parentRule)		{ _parentRule = parentRule; } 		// setter
	
	// [CEReactions] attribute [LegacyNullToEmptyString] CSSOMString cssFloat;
	CSSOMString _cssFloat = "";
	virtual const CSSOMString& cssFloat()					{ return _cssFloat; }				// getter
	virtual void cssFloat(const CSSOMString& cssFloat)		{ _cssFloat = cssFloat; } 			// setter
	
// };


	////// toString //////
	operator std::string() const { return "[object CSSStyleDeclaration]"; }
};
	
class DKNullCSSStyleDeclaration : public DKCSSStyleDeclaration
{
public:
	operator std::string() const { return "null"; }
};
	
#endif // DKCSSStyleDeclaration_H
