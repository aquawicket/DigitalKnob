// [IDL] https://dom.spec.whatwg.org/#interface-htmlcollection
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection
#pragma once
#ifndef DKHTMLCollection_H
#define DKHTMLCollection_H

#include "DKInterface/DKInterface.h"
#include "DKElement/DKElement.h"


// [Exposed=Window, LegacyUnenumerableNamedProperties]
// interface HTMLCollection {
class DKHTMLCollection : public DKInterface
{
public:
	std::vector<DKElement*> _element_list;
	
	DKHTMLCollection(std::vector<DKElement*> element_list) : DKInterface() {
		DKDEBUGFUNC(element_list);
		interfaceName = "HTMLCollection";
		interfaceAddress = pointerToAddress(this);
		_element_list = element_list;
		DKINFO("_element_list.size() = "+toString(_element_list.size())+"\n");
	}

	// readonly attribute unsigned long length;
	virtual const unsigned int length()				{		// getter
		DKINFO("_element_list.size() = "+toString(_element_list.size())+"\n");
		const unsigned int length = _element_list.size(); 
		return length; 
	}		
	//virtual void length(const unsigned int& length)	{  } 	// setter	(readonly)
	
	// getter Element? item(unsigned long index);
	virtual DKElement* item(const unsigned int& index){
		DKDEBUGFUNC(index);
		if(index >= _element_list.size())
			return NULL;	
		return _element_list[index];
	}
	
	// getter Element? namedItem(DOMString name);
	virtual DKElement* namedItem(const DOMString& name){
		DKDEBUGFUNC(name);
		DKTODO();
		return NULL;
	}
	
//};


	////// toString //////
	operator std::string() const { return "[object HTMLCollection]"; }
};


class DKNullHTMLCollection : public DKHTMLCollection
{
public:
	operator std::string() const { return "null"; }
};


#endif //DKHTMLCollection_H