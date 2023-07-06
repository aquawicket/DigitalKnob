// [IDL] https://drafts.csswg.org/cssom/#the-cssstyledeclaration-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleDeclaration
#pragma once
#ifndef DKRmlCSSStyleDeclaration_H
#define DKRmlCSSStyleDeclaration_H

#include "DKRmlInterface/DKRmlInterface.h"
#include "DKCSSStyleDeclaration/DKCSSStyleDeclaration.h"


// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
// [Exposed=Window]
// interface CSSStyleDeclaration {
class DKRmlCSSStyleDeclaration : public DKCSSStyleDeclaration
{
public:
	static std::vector<DKRmlCSSStyleDeclaration*> list;
	static DKRmlCSSStyleDeclaration* instance(Rml::Element* rmlElement){
		for(unsigned int i=0; i<list.size(); ++i){
			if(rmlElement == list[i]->_rmlElement)
				return list[i];
		}
		return new DKRmlCSSStyleDeclaration(rmlElement);
	}
	
	Rml::Element* _rmlElement;
	
	DKRmlCSSStyleDeclaration(Rml::Element* rmlElement) : DKCSSStyleDeclaration() {
		DKDEBUGFUNC();
		DKASSERT(rmlElement);
		
		interfaceName = "RmlCSSStyleDeclaration";
		address[interfaceName] = pointerToAddress(this);
		DKINFO("DK"+interfaceName+"("+interfaceAddress+","+address[interfaceName]+") \n");
		
		_rmlElement = rmlElement;
	}
	
	// [CEReactions] attribute CSSOMString cssText;
	const CSSOMString& cssText() override					{ return _cssText; }			// getter
	void cssText(const CSSOMString& cssText) override		{ _cssText = cssText; } 		// setter
	
	// readonly attribute unsigned long length;
	const unsigned int& length() override					{ return _length; }				// getter
	void length(const unsigned int& length)	override		{ _length = length; } 			// setter
	
	// getter CSSOMString item(unsigned long index);
	const CSSOMString& item(const unsigned int& index) override {
		DKDEBUGFUNC(index);
		return _item;
	}
	
	// CSSOMString getPropertyValue(CSSOMString property);
	const CSSOMString& getPropertyValue(const CSSOMString& property) override {
		DKDEBUGFUNC(property);
		return _getPropertyValue;
	}
	
	// CSSOMString getPropertyPriority(CSSOMString property);
	const CSSOMString& getPropertyPriority(const CSSOMString& property) override {
		DKDEBUGFUNC(property);
		return _getPropertyPriority;
	}
	
	// [CEReactions] undefined setProperty(CSSOMString property, [LegacyNullToEmptyString] CSSOMString value, optional [LegacyNullToEmptyString] CSSOMString priority = "");
	void setProperty(const CSSOMString& property, const CSSOMString& value, const CSSOMString& priority = "") override {
		DKDEBUGFUNC(property, value, priority);
		_rmlElement->SetProperty(property, value);//, priority);
	}
	
	// [CEReactions] CSSOMString removeProperty(CSSOMString property);
	const CSSOMString& removeProperty(const CSSOMString& property) override {
		DKDEBUGFUNC(property);
		return _removeProperty;
	}
	
	// readonly attribute CSSRule? parentRule;
	// TODO
	
	// [CEReactions] attribute [LegacyNullToEmptyString] CSSOMString cssFloat;
	const CSSOMString& cssFloat() override					{ return _cssFloat; }			// getter
	void cssFloat(const CSSOMString& cssFloat) override		{ _cssFloat = cssFloat; } 		// setter
	
// };

	
	////// toString //////
	operator std::string() const { return "[object DKRmlCSSStyleDeclaration]"; }
};
	
	
#endif // DKCSSStyleDeclaration_H
