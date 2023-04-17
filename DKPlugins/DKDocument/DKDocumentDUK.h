#if HAVE_DKDuktape

#pragma once
#ifndef DKDocumentDUK_H
#define DKDocumentDUK_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// [IDL] https://dom.spec.whatwg.org/#interface-document
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Document
class DKDocumentDUK : public DKObjectT<DKDocumentDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKDocumentDUK", DKDocumentDUK::constructor);
		
		
		////// Instance properties //////
		// [Document.activeElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/activeElement
		// [Document.adoptedStyleSheets] https://developer.mozilla.org/en-US/docs/Web/API/Document/adoptedStyleSheets
		// [Document.body] https://developer.mozilla.org/en-US/docs/Web/API/Document/body
		// [Document.characterSet](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/characterSet
		// [Document.childElementCount](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/childElementCount
		// [Document.children](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/children
		// [Document.compatMode](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/compatMode
		// [Document.contentType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/contentType
		// [Document.currentScript](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/currentScript
		// [Document.doctype](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/doctype
		// [Document.documentElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/documentElement
		// [Document.documentURI](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/documentURI
		// [Document.embeds](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/embeds
		// [Document.firstElementChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/firstElementChild
		// [Document.fonts] https://developer.mozilla.org/en-US/docs/Web/API/Document/fonts
		// [Document.forms](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/forms
		// [Document.fragmentDirective](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Document/fragmentDirective
		// [Document.fullscreenElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/fullscreenElement
		// [Document.head](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/head
		// [Document.hidden](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/hidden
		// [Document.images](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/images
		// [Document.implementation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/implementation
		// [Document.lastElementChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/lastElementChild
		// [Document.links](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/links
		// [Document.pictureInPictureElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/pictureInPictureElement
		// [Document.pictureInPictureEnabled](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/pictureInPictureEnabled
		// [Document.plugins](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/plugins
		// [Document.pointerLockElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/pointerLockElement
		// [Document.featurePolicy Experimental](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/featurePolicy
		// [Document.scripts](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/scripts
		// [Document.scrollingElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/scrollingElement
		// [Document.styleSheets](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/styleSheets
		// [Document.timeline](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/timeline
		// [Document.visibilityState](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/visibilityState
	
	
		////// Load .js files
		DKClass::DKCreate("DKDocument/DKDocumentDUK.js");
		
		return true;
	}
	
	static DKDocument* eventTarget(duk_context* ctx){
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKDocument*)addressToPointer(eventTargetAddress);
	}
	static bool GetBool(duk_context* ctx){
		if (duk_is_boolean(ctx, 1))
			return duk_to_boolean(ctx, 1);
		return false;
	}
	static double GetDouble(duk_context* ctx){
		if (duk_is_number(ctx, 1))
			return duk_to_number(ctx, 1);
		return 0.0;
	}
	static int GetInt(duk_context* ctx){
		if (duk_is_number(ctx, 1))
			return duk_to_int(ctx, 1);
		return 0;
	}
	static DKString GetString(duk_context* ctx){
		if (duk_is_string(ctx, 1))
			return duk_to_string(ctx, 1);
		return "";
	}
	static unsigned int GetUint(duk_context* ctx){
		if (duk_is_number(ctx, 1))
			return duk_to_uint(ctx, 1);
		return 0;
	}
	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKDocumentDUK()\n");
		DKDocument* _node = new DKDocument();
		DKString eventTargetAddress = pointerToAddress(_node);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	
	////// Instance properties //////
	// [Document.activeElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/activeElement
	// [Document.adoptedStyleSheets] https://developer.mozilla.org/en-US/docs/Web/API/Document/adoptedStyleSheets
	// [Document.body] https://developer.mozilla.org/en-US/docs/Web/API/Document/body
	// [Document.characterSet](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/characterSet
	// [Document.childElementCount](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/childElementCount
	// [Document.children](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/children
	// [Document.compatMode](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/compatMode
	// [Document.contentType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/contentType
	// [Document.currentScript](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/currentScript
	// [Document.doctype](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/doctype
	// [Document.documentElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/documentElement
	// [Document.documentURI](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/documentURI
	// [Document.embeds](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/embeds
	// [Document.firstElementChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/firstElementChild
	// [Document.fonts] https://developer.mozilla.org/en-US/docs/Web/API/Document/fonts
	// [Document.forms](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/forms
	// [Document.fragmentDirective](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Document/fragmentDirective
	// [Document.fullscreenElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/fullscreenElement
	// [Document.head](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/head
	// [Document.hidden](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/hidden
	// [Document.images](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/images
	// [Document.implementation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/implementation
	// [Document.lastElementChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/lastElementChild
	// [Document.links](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/links
	// [Document.pictureInPictureElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/pictureInPictureElement
	// [Document.pictureInPictureEnabled](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/pictureInPictureEnabled
	// [Document.plugins](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/plugins
	// [Document.pointerLockElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/pointerLockElement
	// [Document.featurePolicy Experimental](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/featurePolicy
	// [Document.scripts](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/scripts
	// [Document.scrollingElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/scrollingElement
	// [Document.styleSheets](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/styleSheets
	// [Document.timeline](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/timeline
	// [Document.visibilityState](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/visibilityState

};
REGISTER_OBJECT(DKDocumentDUK, true)


#endif //DKDocumentDUK_H
#endif //HAVE_DKDuktape