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
		DKDuktape::AttachFunction("CPP_DKRmlDocumentDUK_constructor", DKRmlDocumentDUK::constructor);
			
			
		////// Load .js files
		DKClass::DKCreate("DKRmlDocument/DKRmlDocumentDUK.js");
		
		return true;
	}
	
	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString dkRmlInterfaceAddress = duk_require_string(ctx, 0);
		DKRmlInterface* dkRmlInterface = (DKRmlInterface*)addressToPointer(dkRmlInterfaceAddress);
		DKString dkRmlEventListenerAddress = duk_require_string(ctx, 1);
		DKRmlEventListener* dkRmlEventListener = (DKRmlEventListener*)addressToPointer(dkRmlEventListenerAddress);
		DKINFO("CPP_DKRmlDocumentDUK_constructor("+dkRmlInterfaceAddress+","+dkRmlEventListenerAddress+")\n");
		DKRmlDocument* dkRmlDocument = new DKRmlDocument(dkRmlInterface, dkRmlEventListener);
		DKString dkRmlDocumentAddress = pointerToAddress(dkRmlDocument);
		duk_push_string(ctx, dkRmlDocumentAddress.c_str());	
		return true;
	}
	
};
REGISTER_OBJECT(DKRmlDocumentDUK, true)


#endif //DKRmlDocumentDUK_H
#endif //HAVE_DKDuktape
