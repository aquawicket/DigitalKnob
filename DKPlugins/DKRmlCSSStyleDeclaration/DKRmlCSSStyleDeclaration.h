// [IDL] https://drafts.csswg.org/cssom/#the-cssstyledeclaration-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleDeclaration
#pragma once
#ifndef DKRmlCSSStyleDeclaration_H
#define DKRmlCSSStyleDeclaration_H

#include "DKCSSStyleDeclaration/DKCSSStyleDeclaration.h"


// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
// [Exposed=Window]
// interface CSSStyleDeclaration {
class DKRmlCSSStyleDeclaration : public DKCSSStyleDeclaration
{
public:
	DKRmlCSSStyleDeclaration() : DKCSSStyleDeclaration() {
		DKDEBUGFUNC();
		interfaceName = "DKRmlCSSStyleDeclaration";
		interfaceAddress = pointerToAddress(this);
	}
	
	// [CEReactions] attribute CSSOMString cssText;
	CSSOMString _cssText = "";
	virtual const CSSOMString& cssText() override				{ return _cssText; }			// getter
	virtual void cssText(const CSSOMString& cssText) override	{ _cssText = cssText; } 		// setter
	
	// readonly attribute unsigned long length;
	unsigned int _length = 0;
	virtual const unsigned int& length() override				{ return _length; }				// getter
	virtual void length(const unsigned int& length)	override	{ _length = length; } 			// setter
	
	// getter CSSOMString item(unsigned long index);
	CSSOMString _item = "";
	virtual const CSSOMString& item(const unsigned int& index) override {
		DKDEBUGFUNC(index);
		return _item;
	}
	
	// CSSOMString getPropertyValue(CSSOMString property);
	CSSOMString _getPropertyValue = "";
	virtual const CSSOMString& getPropertyValue(const CSSOMString& property) override {
		DKDEBUGFUNC(property);
		return _getPropertyValue;
	}
	
	// CSSOMString getPropertyPriority(CSSOMString property);
	CSSOMString _getPropertyPriority = "";
	virtual const CSSOMString& getPropertyPriority(const CSSOMString& property) override {
		DKDEBUGFUNC(property);
		return _getPropertyPriority;
	}
	
	// [CEReactions] undefined setProperty(CSSOMString property, [LegacyNullToEmptyString] CSSOMString value, optional [LegacyNullToEmptyString] CSSOMString priority = "");
	virtual void setProperty(const CSSOMString& property, const CSSOMString& value, const CSSOMString& priority = "") override {
		DKDEBUGFUNC(property, value, priority);
	}
	
	// [CEReactions] CSSOMString removeProperty(CSSOMString property);
	CSSOMString _removeProperty = "";
	virtual const CSSOMString& removeProperty(const CSSOMString& property) override {
		DKDEBUGFUNC(property);
		return _removeProperty;
	}
	
	// readonly attribute CSSRule? parentRule;
	// TODO
	
	// [CEReactions] attribute [LegacyNullToEmptyString] CSSOMString cssFloat;
	CSSOMString _cssFloat = "";
	virtual const CSSOMString& cssFloat() override					{ return _cssFloat; }				// getter
	virtual void cssFloat(const CSSOMString& cssFloat) override		{ _cssFloat = cssFloat; } 			// setter
	
// };
};
	
	
#endif // DKCSSStyleDeclaration_H
