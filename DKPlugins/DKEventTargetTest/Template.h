#pragma once
#ifndef Template_H
#define Template_H

#include "DKEventTargetTest/DKEvent.h"


// [W3C] ???
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Template
class Template : public DKEvent
{
public:
	////// Constructor //////
	// [Template()] https://developer.mozilla.org/en-US/docs/Web/API/Template/Template
	Template(DKString _type, DKString _options) : DKEvent(_type, _options) {
		DKINFO("Template("+_type+", "+_options+") \n");
		
		eventClass = "Template";
		
		////// Instance properties //////
		//??? = 0;
	}
	
	
	////// Instance properties //////
	// [Template.???](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Template/???
	//unsigned int ???;


	////// Instance methods //////
	// [Template.???()] https://developer.mozilla.org/en-US/docs/Web/API/Template/???
	/*
	void ???(){
		DKTODO();
	}
	*/
	
	
	////// Events //////
	// [???] https://developer.mozilla.org/en-US/docs/Web/API/Element/???_event

};


#endif //Template_H