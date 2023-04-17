#if HAVE_DKDuktape

#pragma once
#ifndef DKNodeDUK_H
#define DKNodeDUK_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// [IDL] https://dom.spec.whatwg.org/#interface-node
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Node
class DKNodeDUK : public DKObjectT<DKNodeDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKNodeDUK", DKNodeDUK::constructor);
		
		
		////// Instance properties //////
		// [Node.baseURI](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/baseURI
		// [Node.childNodes](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/childNodes
		// [Node.firstChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/firstChild
		// [Node.isConnected](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/isConnected
		// [Node.lastChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/lastChild
		// [Node.nextSibling](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/nextSibling
		// [Node.nodeName](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeName
		// [Node.nodeType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeType
		// [Node.nodeValue] https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeValue
		// [Node.ownerDocument](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/ownerDocument
		// [Node.parentNode](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/parentNode
		// [Node.parentElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/parentElement
		// [Node.previousSibling](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/previousSibling
		// [Node.textContent] https://developer.mozilla.org/en-US/docs/Web/API/Node/textContent
		
		
		////// Instance methods //////
		// [Node.appendChild()] https://developer.mozilla.org/en-US/docs/Web/API/Node/appendChild
		// [Node.cloneNode()] https://developer.mozilla.org/en-US/docs/Web/API/Node/cloneNode
		// [Node.compareDocumentPosition()] https://developer.mozilla.org/en-US/docs/Web/API/Node/compareDocumentPosition
		// [Node.contains()] https://developer.mozilla.org/en-US/docs/Web/API/Node/contains
		// [Node.getRootNode()] https://developer.mozilla.org/en-US/docs/Web/API/Node/getRootNode
		// [Node.hasChildNodes()] https://developer.mozilla.org/en-US/docs/Web/API/Node/hasChildNodes
		// [Node.insertBefore()] https://developer.mozilla.org/en-US/docs/Web/API/Node/insertBefore
		// [Node.isDefaultNamespace()] https://developer.mozilla.org/en-US/docs/Web/API/Node/isDefaultNamespace
		// [Node.isEqualNode()] https://developer.mozilla.org/en-US/docs/Web/API/Node/isEqualNode
		// [Node.isSameNode()] https://developer.mozilla.org/en-US/docs/Web/API/Node/isSameNode
		// [Node.lookupPrefix()] https://developer.mozilla.org/en-US/docs/Web/API/Node/lookupPrefix
		// [Node.lookupNamespaceURI()] https://developer.mozilla.org/en-US/docs/Web/API/Node/lookupNamespaceURI
		// [Node.normalize()] https://developer.mozilla.org/en-US/docs/Web/API/Node/normalize
		// [Node.removeChild()] https://developer.mozilla.org/en-US/docs/Web/API/Node/removeChild
		// [Node.replaceChild()] https://developer.mozilla.org/en-US/docs/Web/API/Node/replaceChild
	
	
		////// Load .js files
		DKClass::DKCreate("DKNode/DKNodeDUK.js");
		
		return true;
	}
	
	static DKNode* eventTarget(duk_context* ctx){
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKNode*)addressToPointer(eventTargetAddress);
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
		DKINFO("CPP_DKNodeDUK()\n");
		DKNode* _node = new DKNode();
		DKString eventTargetAddress = pointerToAddress(_node);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	
	////// Instance properties //////
	// [Node.baseURI](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/baseURI
	// [Node.childNodes](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/childNodes
	// [Node.firstChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/firstChild
	// [Node.isConnected](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/isConnected
	// [Node.lastChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/lastChild
	// [Node.nextSibling](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/nextSibling
	// [Node.nodeName](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeName
	// [Node.nodeType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeType
	// [Node.nodeValue] https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeValue
	// [Node.ownerDocument](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/ownerDocument
	// [Node.parentNode](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/parentNode
	// [Node.parentElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/parentElement
	// [Node.previousSibling](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/previousSibling
	// [Node.textContent] https://developer.mozilla.org/en-US/docs/Web/API/Node/textContent

	
	////// Instance methods //////
	// [Node.appendChild()] https://developer.mozilla.org/en-US/docs/Web/API/Node/appendChild
	// [Node.cloneNode()] https://developer.mozilla.org/en-US/docs/Web/API/Node/cloneNode
	// [Node.compareDocumentPosition()] https://developer.mozilla.org/en-US/docs/Web/API/Node/compareDocumentPosition
	// [Node.contains()] https://developer.mozilla.org/en-US/docs/Web/API/Node/contains
	// [Node.getRootNode()] https://developer.mozilla.org/en-US/docs/Web/API/Node/getRootNode
	// [Node.hasChildNodes()] https://developer.mozilla.org/en-US/docs/Web/API/Node/hasChildNodes
	// [Node.insertBefore()] https://developer.mozilla.org/en-US/docs/Web/API/Node/insertBefore
	// [Node.isDefaultNamespace()] https://developer.mozilla.org/en-US/docs/Web/API/Node/isDefaultNamespace
	// [Node.isEqualNode()] https://developer.mozilla.org/en-US/docs/Web/API/Node/isEqualNode
	// [Node.isSameNode()] https://developer.mozilla.org/en-US/docs/Web/API/Node/isSameNode
	// [Node.lookupPrefix()] https://developer.mozilla.org/en-US/docs/Web/API/Node/lookupPrefix
	// [Node.lookupNamespaceURI()] https://developer.mozilla.org/en-US/docs/Web/API/Node/lookupNamespaceURI
	// [Node.normalize()] https://developer.mozilla.org/en-US/docs/Web/API/Node/normalize
	// [Node.removeChild()] https://developer.mozilla.org/en-US/docs/Web/API/Node/removeChild
	// [Node.replaceChild()] https://developer.mozilla.org/en-US/docs/Web/API/Node/replaceChild
};
REGISTER_OBJECT(DKNodeDUK, true)


#endif //DKNodeDUK_H
#endif //HAVE_DKDuktape