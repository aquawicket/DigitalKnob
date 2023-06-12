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
	DKHTMLCollection(std::vector<DKElement*> element_list) : DKInterface() {
		DKDEBUGFUNC();
		interfaceName = "HTMLCollection";
		interfaceAddress = pointerToAddress(this);
		_element_list = element_list;
	}

	std::vector<DKElement*> _element_list;
	
	// readonly attribute unsigned long length;
	virtual const unsigned int& length()				{		// getter			
		return _element_list.size(); 
	}		
	//virtual void length(const unsigned int& length)	{  } 	// setter	(readonly)
	
	// getter Element? item(unsigned long index);
	virtual DKElement* item(const unsigned int& index){
		DKDEBUGFUNC(index);
		return _element_list[index];
	}
	
	// getter Element? namedItem(DOMString name);
	virtual DKElement* namedItem(const DOMString& name){
		DKDEBUGFUNC(name);
		DKTODO();
		return NULL;
	}
	
//};
};


#endif //DKHTMLCollection_H