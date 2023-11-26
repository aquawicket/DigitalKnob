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
		DKString rmlInterfaceAddress = duk_require_string(ctx, 0);
		DKInterface* rmlInterface = (DKInterface*)addressToPointer(rmlInterfaceAddress);
		DKASSERT(rmlInterface);
		
		DKString dkRmlInterfaceAddress = rmlInterface->address["RmlInterface"];
		DKRmlInterface* dkRmlInterface = (DKRmlInterface*)addressToPointer(dkRmlInterfaceAddress);
		DKASSERT(dkRmlInterface);
		
		DKString rmlEventListenerInterfaceAddress = duk_require_string(ctx, 1);
		DKInterface* rmlEventListenerInterface = (DKInterface*)addressToPointer(rmlEventListenerInterfaceAddress);
		DKASSERT(rmlEventListenerInterface);
		
		DKString dkRmlEventListenerAddress = rmlEventListenerInterface->address["RmlEventListener"];
		DKRmlEventListener* dkRmlEventListener = (DKRmlEventListener*)addressToPointer(dkRmlEventListenerAddress);
		DKASSERT(dkRmlEventListener);
		
		DKINFO("CPP_DKRmlDocumentDUK_constructor("+dkRmlInterfaceAddress+","+dkRmlEventListenerAddress+")\n");
		DKRmlDocument* dkRmlDocument = DKRmlDocument::instance(dkRmlInterface, dkRmlEventListener);
		DKASSERT(dkRmlDocument);
		
		dukglue_push(ctx, dkRmlDocument->interfaceAddress);
		return true;
	}
	
};
REGISTER_OBJECT(DKRmlDocumentDUK, true)


#endif //DKRmlDocumentDUK_H
#endif //HAVE_DKDuktape
