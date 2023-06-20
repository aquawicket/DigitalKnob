#pragma once
#ifndef TEST_DKRmlElement_H
#define TEST_DKRmlElement_H

#include "DKRmlElement/DKRmlElement.h"


class TEST_DKRmlElement //: public DKObjectT<TEST_DKRmlElement>
{
public:
	DKRmlElement* dkRmlElement;
	
	TEST_DKRmlElement() {
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlElement.h //////");
		
		dkRmlElement = new DKRmlElement(TEST_DKRmlEventListener::_dkRmlEventListener, NULL);
		
		printDKRmlElementProperties(*dkRmlElement);
	}
	
	~TEST_DKRmlElement() {
		delete dkRmlElement;
	}
	
	static void printDKRmlElementProperties(DKRmlElement& dkRmlElement){
		DKDEBUGFUNC(dkRmlElement);
		
		console.log("dkRmlElement = "				+toString(dkRmlElement));
		
		TEST_Element::printElementProperties(dkRmlElement);
	}
};
//REGISTER_OBJECT(TEST_DKRmlElement, true);


#endif //TEST_DKRmlElement_H