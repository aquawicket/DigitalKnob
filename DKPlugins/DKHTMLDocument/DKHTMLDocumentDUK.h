#if HAVE_DKDuktape

#pragma once
#ifndef DKHTMLDocumentDUK_H
#define DKHTMLDocumentDUK_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// [IDL] https://html.spec.whatwg.org/multipage/nav-history-apis.html#htmldocument
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLDocument
class DKHTMLDocumentDUK : public DKObjectT<DKHTMLDocumentDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKHTMLDocumentDUK", DKHTMLDocumentDUK::constructor);		// [HTMLDocument()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLDocument/HTMLDocument
		
		////// Instance properties //////
		// TODO

		////// Load .js files
		DKClass::DKCreate("DKHTMLDocument/DKHTMLDocumentDUK.js");
		
		return true;
	}
	
	static DKHTMLDocument* eventTarget(duk_context* ctx){
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKHTMLDocument*)addressToPointer(eventTargetAddress);
	}

	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKHTMLDocumentDUK()\n");
		DKHTMLDocument* _htmlelement = new DKHTMLDocument();
		DKString eventTargetAddress = pointerToAddress(_htmlelement);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	
	////// Instance properties //////
	// TODO
		
};
REGISTER_OBJECT(DKHTMLDocumentDUK, true)


#endif //DKHTMLDocumentDUK_H
#endif //HAVE_DKDuktape