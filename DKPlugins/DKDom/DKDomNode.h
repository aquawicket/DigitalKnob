//https://developer.mozilla.org/en-US/docs/Web/API/Node

#pragma once
#ifndef DKDomNode_H
#define DKDomNode_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////
class DKDomNode : public DKObjectT<DKDomNode>
{
public:
	bool Init();
	
	// Properties
	static int baseURI(duk_context* ctx);
	static int baseURIObject(duk_context* ctx);
	static int childNodes(duk_context* ctx);
	static int firstChild(duk_context* ctx);
	static int isConnected(duk_context* ctx);
	static int lastChild(duk_context* ctx);
	static int nextSibling(duk_context* ctx);
	static int nodeName(duk_context* ctx);
	static int nodeType(duk_context* ctx);
	static int nodeValue(duk_context* ctx);
	static int ownerDocument(duk_context* ctx);
	static int parentNode(duk_context* ctx);
	static int parentElement(duk_context* ctx);
	static int previousSibling(duk_context* ctx);
	static int textContent(duk_context* ctx);
	
	// Obsolete properties
	static int localName(duk_context* ctx);
	static int namespaceURI(duk_context* ctx);
	static int nodePrincipal(duk_context* ctx);
	static int prefix(duk_context* ctx);
	static int rootNode(duk_context* ctx);

	// Methods
	static int appendChild(duk_context* ctx);
	static int cloneNode(duk_context* ctx);
	static int compareDocumentPosition(duk_context* ctx);
	static int contains(duk_context* ctx);
	static int getBoxQuads(duk_context* ctx);
	static int getRootNode(duk_context* ctx);
	static int hasChildNodes(duk_context* ctx);
	static int insertBefore(duk_context* ctx);
	static int isDefaultNamespace(duk_context* ctx);
	static int isEqualNode(duk_context* ctx);
	static int isSameNode(duk_context* ctx);
	static int lookupPrefix(duk_context* ctx);
	static int lookupNamespaceURI(duk_context* ctx);
	static int normalize(duk_context* ctx);
	static int removeChild(duk_context* ctx);
	static int replaceChild(duk_context* ctx);

	// Obsolete methods
	static int getUserData(duk_context* ctx);
	static int hasAttributes(duk_context* ctx);
	static int isSupported(duk_context* ctx);
	static int setUserData(duk_context* ctx);
};


REGISTER_OBJECT(DKDomNode, true)

#endif //DKDomNode_H