#if HAVE_DKDuktape

#pragma once
#ifndef DKRmlDocumentDUK_H
#define DKRmlDocumentDUK_H

#include "DKRmlDocument/DKRmlDocument.h"
#include "DKDuktape/DKDuktape.h"


class DKRmlDocumentDUK : public DKObjectT<DKRmlDocumentDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKRmlDocumentDUK", DKRmlDocumentDUK::constructor);
			
			
		////// Load .js files
		DKClass::DKCreate("DKRmlDocument/DKRmlDocumentDUK.js");
		
		return true;
	}
	
	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKRmlDocumentDUK()\n");
		DKRmlDocument* _dkRmlDocument = (DKRmlDocument*)DKClass::DKCreate("DKRmlDocument");
		DKString eventTargetAddress = pointerToAddress(_dkRmlDocument);
		duk_push_string(ctx, eventTargetAddress.c_str());	
		return true;
	}
	
};
REGISTER_OBJECT(DKRmlDocumentDUK, true)


#endif //DKRmlDocumentDUK_H
#endif //HAVE_DKDuktape
