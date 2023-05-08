// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/Node.idl
// [SOURCE] https://dom.spec.whatwg.org/#interface-node
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Node
#if HAVE_DKDuktape

#pragma once
#ifndef DKNodeDUK_H
#define DKNodeDUK_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=Window]
// interface Node : EventTarget {
class DKNodeDUK : public DKObjectT<DKNodeDUK>
{
public:
	bool Init(){
		
		DKDuktape::AttachFunction("CPP_DKNodeDUK", DKNodeDUK::constructor);
		
		// const unsigned short ELEMENT_NODE = 1;
		// const unsigned short ATTRIBUTE_NODE = 2;
		// const unsigned short TEXT_NODE = 3;
		// const unsigned short CDATA_SECTION_NODE = 4;
		// const unsigned short ENTITY_REFERENCE_NODE = 5; // legacy
		// const unsigned short ENTITY_NODE = 6; // legacy
		// const unsigned short PROCESSING_INSTRUCTION_NODE = 7;
		// const unsigned short COMMENT_NODE = 8;
		// const unsigned short DOCUMENT_NODE = 9;
		// const unsigned short DOCUMENT_TYPE_NODE = 10;
		// const unsigned short DOCUMENT_FRAGMENT_NODE = 11;
		// const unsigned short NOTATION_NODE = 12; // legacy
	
		// readonly attribute unsigned short nodeType;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_nodeType", DKNodeDUK::nodeType);
	
		// readonly attribute DOMString nodeName;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_nodeName", DKNodeDUK::nodeName);
		
		// readonly attribute USVString baseURI;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_baseURI", DKNodeDUK::baseURI);
		
		// readonly attribute boolean isConnected;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_isConnected", DKNodeDUK::isConnected);
		
		// readonly attribute Document? ownerDocument;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_ownerDocument", DKNodeDUK::ownerDocument);
		
		// Node getRootNode(optional GetRootNodeOptions options = {});
		DKDuktape::AttachFunction("CPP_DKNodeDUK_getRootNode", DKNodeDUK::getRootNode);
		
		// readonly attribute Node? parentNode;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_parentNode", DKNodeDUK::parentNode);
		
		// readonly attribute Element? parentElement;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_parentElement", DKNodeDUK::parentElement);
		
		// boolean hasChildNodes();
		DKDuktape::AttachFunction("CPP_DKNodeDUK_hasChildNodes", DKNodeDUK::hasChildNodes);
		
		// [SameObject] readonly attribute NodeList childNodes;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_childNodes", DKNodeDUK::childNodes);
		
		// readonly attribute Node? firstChild;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_firstChild", DKNodeDUK::firstChild);
		
		// readonly attribute Node? lastChild;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_lastChild", DKNodeDUK::lastChild);
		
		// readonly attribute Node? previousSibling;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_previousSibling", DKNodeDUK::previousSibling);
		
		// readonly attribute Node? nextSibling;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_nextSibling", DKNodeDUK::nextSibling);
		
		// [CEReactions] attribute DOMString? nodeValue;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_nodeValue", DKNodeDUK::nodeValue);
		
		// [CEReactions] attribute DOMString? textContent;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_textContent", DKNodeDUK::textContent);
		
		// [CEReactions] undefined normalize();
		DKDuktape::AttachFunction("CPP_DKNodeDUK_normalize", DKNodeDUK::normalize);
		
		// [CEReactions, NewObject] Node cloneNode(optional boolean deep = false);
		DKDuktape::AttachFunction("CPP_DKNodeDUK_cloneNode", DKNodeDUK::cloneNode);
		
		// boolean isEqualNode(Node? otherNode);
		DKDuktape::AttachFunction("CPP_DKNodeDUK_isEqualNode", DKNodeDUK::isEqualNode);
		
		// boolean isSameNode(Node? otherNode); // legacy alias of ===
		DKDuktape::AttachFunction("CPP_DKNodeDUK_isSameNode", DKNodeDUK::isSameNode);
		
		// const unsigned short DOCUMENT_POSITION_DISCONNECTED = 0x01;
		// const unsigned short DOCUMENT_POSITION_PRECEDING = 0x02;
		// const unsigned short DOCUMENT_POSITION_FOLLOWING = 0x04;
		// const unsigned short DOCUMENT_POSITION_CONTAINS = 0x08;
		// const unsigned short DOCUMENT_POSITION_CONTAINED_BY = 0x10;
		// const unsigned short DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = 0x20;
	
		// unsigned short compareDocumentPosition(Node other);
		DKDuktape::AttachFunction("CPP_DKNodeDUK_compareDocumentPosition", DKNodeDUK::compareDocumentPosition);
		
		// boolean contains(Node? other);
		DKDuktape::AttachFunction("CPP_DKNodeDUK_contains", DKNodeDUK::contains);
		
		// DOMString? lookupPrefix(DOMString? namespace);
		DKDuktape::AttachFunction("CPP_DKNodeDUK_lookupPrefix", DKNodeDUK::lookupPrefix);
		
		// DOMString? lookupNamespaceURI(DOMString? prefix);
		DKDuktape::AttachFunction("CPP_DKNodeDUK_lookupNamespaceURI", DKNodeDUK::lookupNamespaceURI);
		
		// boolean isDefaultNamespace(DOMString? namespace);
		DKDuktape::AttachFunction("CPP_DKNodeDUK_isDefaultNamespace", DKNodeDUK::isDefaultNamespace);
		
		// [CEReactions] Node insertBefore(Node node, Node? child);
		DKDuktape::AttachFunction("CPP_DKNodeDUK_insertBefore", DKNodeDUK::insertBefore);
		
		// [CEReactions] Node appendChild(Node node);
		DKDuktape::AttachFunction("CPP_DKNodeDUK_appendChild", DKNodeDUK::appendChild);
		
		// [CEReactions] Node replaceChild(Node node, Node child);
		DKDuktape::AttachFunction("CPP_DKNodeDUK_replaceChild", DKNodeDUK::replaceChild);
		
		// [CEReactions] Node removeChild(Node child);
		DKDuktape::AttachFunction("CPP_DKNodeDUK_removeChild", DKNodeDUK::removeChild);
		
		
		////// Load .js files //////
		DKClass::DKCreate("DKNode/DKNodeDUK.js");
		
		return true;
	}
	
	static DKNode* eventTarget(duk_context* ctx){
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKNode*)addressToPointer(eventTargetAddress);
	}
	static bool GetBool(duk_context* ctx, int index = 1){
		if (duk_is_boolean(ctx, index))
			return duk_to_boolean(ctx, index);
		return false;
	}
	static double GetDouble(duk_context* ctx, int index = 1){
		if (duk_is_number(ctx, index))
			return duk_to_number(ctx, index);
		return 0.0;
	}
	static int GetInt(duk_context* ctx, int index = 1){
		if (duk_is_number(ctx, index))
			return duk_to_int(ctx, index);
		return 0;
	}
	static DKString GetString(duk_context* ctx, int index = 1){
		if (duk_is_string(ctx, index))
			return duk_to_string(ctx, index);
		return "";
	}
	static unsigned int GetUint(duk_context* ctx, int index = 1){
		if (duk_is_number(ctx, index))
			return duk_to_uint(ctx, index);
		return 0;
	}
	
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKNodeDUK()\n");
		DKNode* _node = new DKNode();
		DKString eventTargetAddress = pointerToAddress(_node);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	// const unsigned short ELEMENT_NODE = 1;
	// const unsigned short ATTRIBUTE_NODE = 2;
	// const unsigned short TEXT_NODE = 3;
	// const unsigned short CDATA_SECTION_NODE = 4;
	// const unsigned short ENTITY_REFERENCE_NODE = 5; // legacy
	// const unsigned short ENTITY_NODE = 6; // legacy
	// const unsigned short PROCESSING_INSTRUCTION_NODE = 7;
	// const unsigned short COMMENT_NODE = 8;
	// const unsigned short DOCUMENT_NODE = 9;
	// const unsigned short DOCUMENT_TYPE_NODE = 10;
	// const unsigned short DOCUMENT_FRAGMENT_NODE = 11;
	// const unsigned short NOTATION_NODE = 12; // legacy
	
	// readonly attribute unsigned short nodeType;
	static int nodeType(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _nodeType = GetUint(ctx);
		if(!eventTarget(ctx)->nodeType(_nodeType, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _nodeType);
		return true;
	}
	
	// readonly attribute DOMString nodeName;
	static int nodeName(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _nodeName = GetString(ctx);
		if(!eventTarget(ctx)->nodeName(_nodeName, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _nodeName);
		return true;
	}
	
	// readonly attribute USVString baseURI;
	static int baseURI(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _baseURI = GetString(ctx);
		if(!eventTarget(ctx)->baseURI(_baseURI, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _baseURI);
		return true;
	}
	
	// readonly attribute boolean isConnected;
	static int isConnected(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		bool _isConnected = GetBool(ctx);
		if(!eventTarget(ctx)->isConnected(_isConnected, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _isConnected);
		return true;
	}
	
	// readonly attribute Document? ownerDocument;
	static int ownerDocument(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _ownerDocument = GetString(ctx);
		if(!eventTarget(ctx)->ownerDocument(_ownerDocument, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _ownerDocument);
		return true;
	}
	
	// Node getRootNode(optional GetRootNodeOptions options = {});
	static int getRootNode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _options = GetString(ctx);
		DKString _node;
		if(!eventTarget(ctx)->getRootNode(_options, _node))
			return false;
		dukglue_push(ctx, _node);	
		return true;
	}
	
	// readonly attribute Node? parentNode;
	static int parentNode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _parentNode = GetString(ctx);
		if(!eventTarget(ctx)->parentNode(_parentNode, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _parentNode);
		return true;
	}
	
	// readonly attribute Element? parentElement;
	static int parentElement(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _parentElement = GetString(ctx);
		if(!eventTarget(ctx)->parentElement(_parentElement, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _parentElement);
		return true;
	}
	
	// boolean hasChildNodes();
	static int hasChildNodes(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		bool _hasChildNodes;
		if(!eventTarget(ctx)->hasChildNodes(_hasChildNodes))
			return false;
		dukglue_push(ctx, _hasChildNodes);	
		return true;
	}
	
	// [SameObject] readonly attribute NodeList childNodes;
	static int childNodes(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _childNodes = GetString(ctx);
		if(!eventTarget(ctx)->childNodes(_childNodes, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _childNodes);
		return true;
	}
	
	// readonly attribute Node? firstChild;
	static int firstChild(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _firstChild = GetString(ctx);
		if(!eventTarget(ctx)->firstChild(_firstChild, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _firstChild);
		return true;
	}
	
	// readonly attribute Node? lastChild;
	static int lastChild(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _lastChild = GetString(ctx);
		if(!eventTarget(ctx)->lastChild(_lastChild, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _lastChild);
		return true;
	}
	
	// readonly attribute Node? previousSibling;
	static int previousSibling(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _previousSibling = GetString(ctx);
		if(!eventTarget(ctx)->previousSibling(_previousSibling, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _previousSibling);
		return true;
	}
	
	// readonly attribute Node? nextSibling;
	static int nextSibling(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _nextSibling = GetString(ctx);
		if(!eventTarget(ctx)->nextSibling(_nextSibling, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _nextSibling);
		return true;
	}
	
	// [CEReactions] attribute DOMString? nodeValue;
	static int nodeValue(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _nodeValue = GetString(ctx);
		if(!eventTarget(ctx)->nodeValue(_nodeValue, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _nodeValue);
		return true;
	}
	
	// [CEReactions] attribute DOMString? textContent;
	static int textContent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _textContent = GetString(ctx);
		if(!eventTarget(ctx)->textContent(_textContent, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _textContent);
		return true;
	}
	
	// [CEReactions] undefined normalize();
	static int normalize(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(!eventTarget(ctx)->normalize())
			return false;
		return true;
	}
	
	// [CEReactions, NewObject] Node cloneNode(optional boolean deep = false);
	static int cloneNode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		bool _deep = GetBool(ctx);
		DKString _node;
		if(!eventTarget(ctx)->cloneNode(_deep, _node))
			return false;
		dukglue_push(ctx, _node);	
		return true;
	}
	
	// boolean isEqualNode(Node? otherNode);
	static int isEqualNode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _otherNode = GetString(ctx);
		bool _isEqualNode;
		if(!eventTarget(ctx)->isEqualNode(_otherNode, _isEqualNode))
			return false;
		dukglue_push(ctx, _isEqualNode);	
		return true;
	}
	
	// boolean isSameNode(Node? otherNode); // legacy alias of ===
	static int isSameNode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _otherNode = GetString(ctx);
		bool _isSameNode;
		if(!eventTarget(ctx)->isSameNode(_otherNode, _isSameNode))
			return false;
		dukglue_push(ctx, _isSameNode);	
		return true;
	}
	
	// const unsigned short DOCUMENT_POSITION_DISCONNECTED = 0x01;
	// const unsigned short DOCUMENT_POSITION_PRECEDING = 0x02;
	// const unsigned short DOCUMENT_POSITION_FOLLOWING = 0x04;
	// const unsigned short DOCUMENT_POSITION_CONTAINS = 0x08;
	// const unsigned short DOCUMENT_POSITION_CONTAINED_BY = 0x10;
	// const unsigned short DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = 0x20;
	
	// unsigned short compareDocumentPosition(Node other);
	static int compareDocumentPosition(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _other = GetString(ctx);
		unsigned int _compareDocumentPosition;
		if(!eventTarget(ctx)->compareDocumentPosition(_other, _compareDocumentPosition))
			return false;
		dukglue_push(ctx, _compareDocumentPosition);	
		return true;
	}
	
	// boolean contains(Node? other);
	static int contains(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _other = GetString(ctx);
		bool _contains;
		if(!eventTarget(ctx)->contains(_other, _contains))
			return false;
		dukglue_push(ctx, _contains);	
		return true;
	}
	
	// DOMString? lookupPrefix(DOMString? namespace);
	static int lookupPrefix(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _namespace = GetString(ctx);
		DKString _lookupPrefix;
		if(!eventTarget(ctx)->lookupPrefix(_namespace, _lookupPrefix))
			return false;
		dukglue_push(ctx, _lookupPrefix);	
		return true;
	}
	
	// DOMString? lookupNamespaceURI(DOMString? prefix);
	static int lookupNamespaceURI(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _namespace = GetString(ctx);
		DKString _lookupNamespaceURI;
		if(!eventTarget(ctx)->lookupNamespaceURI(_namespace, _lookupNamespaceURI))
			return false;
		dukglue_push(ctx, _lookupNamespaceURI);	
		return true;
	}
	
	// boolean isDefaultNamespace(DOMString? namespace);
	static int isDefaultNamespace(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _namespace = GetString(ctx);
		bool _isDefaultNamespace;
		if(!eventTarget(ctx)->isDefaultNamespace(_namespace, _isDefaultNamespace))
			return false;
		dukglue_push(ctx, _isDefaultNamespace);	
		return true;
	}
	
	// [CEReactions] Node insertBefore(Node node, Node? child);
	static int insertBefore(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _node = GetString(ctx);
		DKString _child = GetString(ctx, 2);
		DKString _insertBefore;
		if(!eventTarget(ctx)->insertBefore(_node, _child, _insertBefore))
			return false;
		dukglue_push(ctx, _insertBefore);	
		return true;
	}
	
	// [CEReactions] Node appendChild(Node node);
	static int appendChild(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _node = GetString(ctx);
		DKString _appendChild;
		if(!eventTarget(ctx)->appendChild(_node, _appendChild))
			return false;
		dukglue_push(ctx, _appendChild);	
		return true;
	}
	
	// [CEReactions] Node replaceChild(Node node, Node child);
	static int replaceChild(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _node = GetString(ctx);
		DKString _child = GetString(ctx, 2);
		DKString _replaceChild;
		if(!eventTarget(ctx)->replaceChild(_node, _child, _replaceChild))
			return false;
		dukglue_push(ctx, _replaceChild);	
		return true;
	}
	
	// [CEReactions] Node removeChild(Node child);
	static int removeChild(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _node = GetString(ctx);
		DKString _removeChild;
		if(!eventTarget(ctx)->removeChild(_node, _removeChild))
			return false;
		dukglue_push(ctx, _removeChild);	
		return true;
	}
};
REGISTER_OBJECT(DKNodeDUK, true)


#endif //DKNodeDUK_H
#endif //HAVE_DKDuktape