// [IDL] https://html.spec.whatwg.org/multipage/system-state.html#the-navigator-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Navigator
#if HAVE_DKDuktape

#pragma once
#ifndef DKNavigatorDUK_H
#define DKNavigatorDUK_H

#include "DKDuktape/DKDuktape.h"


class DKNavigatorDUK : public DKObjectT<DKNavigatorDUK>
{
public:
	bool Init(){
		
		DKDuktape::AttachFunction("CPP_DKNavigatorDUK_constructor", DKNavigatorDUK::constructor);
		

		////// Load .js files
		DKClass::DKCreate("DKNavigator/DKNavigatorDUK.js");
		
		return true;
	}
	
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKNavigatorDUK_constructor()\n");
		DKNavigator* _navigator = new DKNavigator();
		DKString eventTargetAddress = pointerToAddress(_navigator);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
};
REGISTER_OBJECT(DKNavigatorDUK, true)


#endif //DKNavigatorDUK_H
#endif //HAVE_DKDuktape