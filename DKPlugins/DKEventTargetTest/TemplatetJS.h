#pragma once
#ifndef TemplateJS_H
#define TemplateJS_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// [W3C] ???
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Template
class TemplateJS : public DKObjectT<TemplateJS>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_Template", TemplateJS::constructor);
	
	
		////// Instance properties //////
		//DKDuktape::AttachFunction("CPP_Template_???", 		TemplateJS::???); 		// [Template.deltaX](Read only)

		
		////// Instance methods //////
		//DKDuktape::AttachFunction("CPP_Template_???", 		TemplateJS::???); 		// [Template.deltaX](Read only)


		////// Load .js files //////
		DKClass::DKCreate("DKEventTargetTest/Template.js");
		
		return true;
	}
	
	
	////// Constructor //////
	// [Template()] https://developer.mozilla.org/en-US/docs/Web/API/Template/Template
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = "";//duk_require_string(ctx, 1);
		DKINFO("CPP_Template("+type+","+options+")\n");
		Template* event = new Template(type, options);
		DKString eventAddress = DKDuktape::pointerToAddress(event);
		duk_push_string(ctx, eventAddress.c_str());	
		return true;
	}
	
	
	////// Instance properties //////
	// [Template.???](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Template/???
	/*
	static int ???(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		Template* event = (Template*)DKDuktape::addressToPointer(eventAddress);
		if (duk_is_number(ctx, 1))
			event->??? = duk_to_number(ctx, 1);
		duk_push_number(ctx, event->???);	
		return true;
	}
	*/
	
	////// Instance methods //////
	// [Template.???()] https://developer.mozilla.org/en-US/docs/Web/API/Template/???
	
};
REGISTER_OBJECT(TemplateJS, true)


#endif //TemplateJS_H