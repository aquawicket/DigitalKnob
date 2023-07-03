// [IDL] https://dom.spec.whatwg.org/#interface-node
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Node
#if HAVE_DKDuktape

#pragma once
#ifndef DKNodeDUK_H
#define DKNodeDUK_H

#include "DKDuktape/DKDuktape.h"
#include "DKNode/DKNode.h"
#include "DKDocument/DKDocument.h"


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=Window]
// interface Node : EventTarget {
class DKNodeDUK : public DKObjectT<DKNodeDUK>
{
public:
	bool Init(){
		
		DKDuktape::AttachFunction("CPP_DKNodeDUK_constructor", DKNodeDUK::constructor);
		
		// const unsigned short ELEMENT_NODE = 1;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_ELEMENT_NODE", DKNodeDUK::ELEMENT_NODE);
		
		// const unsigned short ATTRIBUTE_NODE = 2;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_ATTRIBUTE_NODE", DKNodeDUK::ATTRIBUTE_NODE);
		
		// const unsigned short TEXT_NODE = 3;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_TEXT_NODE", DKNodeDUK::TEXT_NODE);
		
		// const unsigned short CDATA_SECTION_NODE = 4;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_CDATA_SECTION_NODE", DKNodeDUK::CDATA_SECTION_NODE);
		
		// const unsigned short ENTITY_REFERENCE_NODE = 5; // legacy
		DKDuktape::AttachFunction("CPP_DKNodeDUK_ENTITY_REFERENCE_NODE", DKNodeDUK::ENTITY_REFERENCE_NODE);
		
		// const unsigned short ENTITY_NODE = 6; // legacy
		DKDuktape::AttachFunction("CPP_DKNodeDUK_ENTITY_NODE", DKNodeDUK::ENTITY_NODE);
		
		// const unsigned short PROCESSING_INSTRUCTION_NODE = 7;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_PROCESSING_INSTRUCTION_NODE", DKNodeDUK::PROCESSING_INSTRUCTION_NODE);
		
		// const unsigned short COMMENT_NODE = 8;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_COMMENT_NODE", DKNodeDUK::COMMENT_NODE);
		
		// const unsigned short DOCUMENT_NODE = 9;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_DOCUMENT_NODE", DKNodeDUK::DOCUMENT_NODE);
		
		// const unsigned short DOCUMENT_TYPE_NODE = 10;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_DOCUMENT_TYPE_NODE", DKNodeDUK::DOCUMENT_TYPE_NODE);
		
		// const unsigned short DOCUMENT_FRAGMENT_NODE = 11;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_DOCUMENT_FRAGMENT_NODE", DKNodeDUK::DOCUMENT_FRAGMENT_NODE);
		
		// const unsigned short NOTATION_NODE = 12; // legacy
		DKDuktape::AttachFunction("CPP_DKNodeDUK_NOTATION_NODE", DKNodeDUK::NOTATION_NODE);
	
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
		DKDuktape::AttachFunction("CPP_DKNodeDUK_DOCUMENT_POSITION_DISCONNECTED", DKNodeDUK::DOCUMENT_POSITION_DISCONNECTED);
		
		// const unsigned short DOCUMENT_POSITION_PRECEDING = 0x02;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_DOCUMENT_POSITION_PRECEDING", DKNodeDUK::DOCUMENT_POSITION_PRECEDING);
		
		// const unsigned short DOCUMENT_POSITION_FOLLOWING = 0x04;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_DOCUMENT_POSITION_FOLLOWING", DKNodeDUK::DOCUMENT_POSITION_FOLLOWING);
		
		// const unsigned short DOCUMENT_POSITION_CONTAINS = 0x08;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_DOCUMENT_POSITION_CONTAINS", DKNodeDUK::DOCUMENT_POSITION_CONTAINS);
		
		// const unsigned short DOCUMENT_POSITION_CONTAINED_BY = 0x10;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_DOCUMENT_POSITION_CONTAINED_BY", DKNodeDUK::DOCUMENT_POSITION_CONTAINED_BY);
		
		// const unsigned short DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = 0x20;
		DKDuktape::AttachFunction("CPP_DKNodeDUK_DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC", DKNodeDUK::DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC);
	
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
	
	static DKNode* node(duk_context* ctx){
		DKString interfaceAddress = duk_require_string(ctx, 0);
		DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
		DKString nodeAddress = interface->address["Node"];
		DKNode* _node = (DKNode*)addressToPointer(nodeAddress);
		return _node;
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
		
		DKINFO("CPP_DKNodeDUK_constructor()\n");
		DKNode* _node = new DKNode();
		dukglue_push(ctx, _node->interfaceAddress);		//Note: Javascript should only ever receive the base interfaceAddress
		return true;
	}
	
	// const unsigned short ELEMENT_NODE = 1;
	static int ELEMENT_NODE(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, node(ctx)->ELEMENT_NODE());
		return true;
	}
	
	// const unsigned short ATTRIBUTE_NODE = 2;
	static int ATTRIBUTE_NODE(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, node(ctx)->ATTRIBUTE_NODE());
		return true;
	}
	
	// const unsigned short TEXT_NODE = 3;
	static int TEXT_NODE(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, node(ctx)->TEXT_NODE());
		return true;
	}
	
	// const unsigned short CDATA_SECTION_NODE = 4;
	static int CDATA_SECTION_NODE(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, node(ctx)->CDATA_SECTION_NODE());
		return true;
	}
	
	// const unsigned short ENTITY_REFERENCE_NODE = 5; // legacy
	static int ENTITY_REFERENCE_NODE(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, node(ctx)->ENTITY_REFERENCE_NODE());
		return true;
	}
	
	// const unsigned short ENTITY_NODE = 6; // legacy
	static int ENTITY_NODE(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, node(ctx)->ENTITY_NODE());
		return true;
	}
	
	// const unsigned short PROCESSING_INSTRUCTION_NODE = 7;
	static int PROCESSING_INSTRUCTION_NODE(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, node(ctx)->PROCESSING_INSTRUCTION_NODE());
		return true;
	}
	
	// const unsigned short COMMENT_NODE = 8;
	static int COMMENT_NODE(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, node(ctx)->COMMENT_NODE());
		return true;
	}
	
	// const unsigned short DOCUMENT_NODE = 9;
	static int DOCUMENT_NODE(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, node(ctx)->DOCUMENT_NODE());
		return true;
	}
	
	// const unsigned short DOCUMENT_TYPE_NODE = 10;
	static int DOCUMENT_TYPE_NODE(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, node(ctx)->DOCUMENT_TYPE_NODE());
		return true;
	}
	
	// const unsigned short DOCUMENT_FRAGMENT_NODE = 11;
	static int DOCUMENT_FRAGMENT_NODE(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, node(ctx)->DOCUMENT_FRAGMENT_NODE());
		return true;
	}
	
	// const unsigned short NOTATION_NODE = 12; // legacy
	static int NOTATION_NODE(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, node(ctx)->NOTATION_NODE());
		return true;
	}
	
	// readonly attribute unsigned short nodeType;
	static int nodeType(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			node(ctx)->nodeType((unsigned short)GetUint(ctx));
		dukglue_push(ctx, node(ctx)->nodeType());
		return true;
	}
	
	// readonly attribute DOMString nodeName;
	static int nodeName(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			node(ctx)->nodeName(GetString(ctx));
		dukglue_push(ctx, node(ctx)->nodeName());
		return true;
	}
	
	// readonly attribute USVString baseURI;
	static int baseURI(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			node(ctx)->baseURI(GetString(ctx));
		dukglue_push(ctx, node(ctx)->baseURI());
		return true;
	}
	
	// readonly attribute boolean isConnected;
	static int isConnected(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			node(ctx)->isConnected(GetBool(ctx));
		dukglue_push(ctx, node(ctx)->isConnected());
		return true;
	}
	
	///////////////////////////////////////////////////////////////////////////////////
	// NOTE: The first parameter is the interfaceAddress of the Node
	//		 The second parameter is the interfaceAddress of the Document
	// readonly attribute Document? ownerDocument;
	static int ownerDocument(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1)){
			DKString interfaceAddress = GetString(ctx);
			DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
			DKString documentAddress = interface->address["Document"];
			DKDocument* document = (DKDocument*)addressToPointer(documentAddress);
			node(ctx)->ownerDocument(document);
		}
		dukglue_push(ctx, node(ctx)->ownerDocument()->interfaceAddress);
		return true;
	}
	
	// Node getRootNode(optional GetRootNodeOptions options = {});
	static int getRootNode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		const DKString options = GetString(ctx);
		
		dukglue_push(ctx, node(ctx)->getRootNode(options)->interfaceAddress);	
		return true;
	}
	
	// readonly attribute Node? parentNode;
	static int parentNode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1)){
			DKString interfaceAddress = GetString(ctx);
			DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
			DKString nodeAddress = interface->address["Node"];
			DKNode* _node = (DKNode*)addressToPointer(nodeAddress);
			node(ctx)->parentNode(_node);
		}
		dukglue_push(ctx, node(ctx)->parentNode()->interfaceAddress);
		return true;
	}
	
	// readonly attribute Element? parentElement;
	static int parentElement(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1)){
			DKString interfaceAddress = GetString(ctx);
			DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
			DKString elementAddress = interface->address["Element"];
			DKElement* element = (DKElement*)addressToPointer(elementAddress);
			node(ctx)->parentElement(element);
		}
		dukglue_push(ctx, node(ctx)->parentElement()->interfaceAddress);
		return true;
	}
	
	// boolean hasChildNodes();
	static int hasChildNodes(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, node(ctx)->hasChildNodes());	
		return true;
	}
	
	// [SameObject] readonly attribute NodeList childNodes;
	static int childNodes(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			node(ctx)->childNodes(GetString(ctx));
		dukglue_push(ctx, node(ctx)->childNodes());
		return true;
	}
	
	// readonly attribute Node? firstChild;
	static int firstChild(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1)){
			DKString interfaceAddress = GetString(ctx);
			DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
			DKString nodeAddress = interface->address["Node"];
			DKNode* _node = (DKNode*)addressToPointer(nodeAddress);
			node(ctx)->firstChild(_node);
		}
		dukglue_push(ctx, node(ctx)->firstChild()->interfaceAddress);
		return true;
	}
	
	// readonly attribute Node? lastChild;
	static int lastChild(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1)){
			DKString interfaceAddress = GetString(ctx);
			DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
			DKString nodeAddress = interface->address["Node"];
			DKNode* _node = (DKNode*)addressToPointer(nodeAddress);
			node(ctx)->lastChild(_node);
		}
		dukglue_push(ctx, node(ctx)->lastChild()->interfaceAddress);
		return true;
	}
	
	// readonly attribute Node? previousSibling;
	static int previousSibling(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1)){
			DKString interfaceAddress = GetString(ctx);
			DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
			DKString nodeAddress = interface->address["Node"];
			DKNode* _node = (DKNode*)addressToPointer(nodeAddress);
			node(ctx)->previousSibling(_node);
		}
		dukglue_push(ctx, node(ctx)->previousSibling()->interfaceAddress);
		return true;
	}
	
	// readonly attribute Node? nextSibling;
	static int nextSibling(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1)){
			DKString interfaceAddress = GetString(ctx);
			DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
			DKString nodeAddress = interface->address["Node"];
			DKNode* _node = (DKNode*)addressToPointer(nodeAddress);
			node(ctx)->nextSibling(_node);
		}
		dukglue_push(ctx, node(ctx)->nextSibling()->interfaceAddress);
		return true;
	}
	
	// [CEReactions] attribute DOMString? nodeValue;
	static int nodeValue(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			node(ctx)->nodeValue(GetString(ctx));
		dukglue_push(ctx, node(ctx)->nodeValue());
		return true;
	}
	
	// [CEReactions] attribute DOMString? textContent;
	static int textContent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			node(ctx)->textContent(GetString(ctx));
		dukglue_push(ctx, node(ctx)->textContent());
		return true;
	}
	
	// [CEReactions] undefined normalize();
	static int normalize(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		node(ctx)->normalize();
		return true;
	}
	
	// [CEReactions, NewObject] Node cloneNode(optional boolean deep = false);
	static int cloneNode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		bool deep = GetBool(ctx);
		
		dukglue_push(ctx, node(ctx)->cloneNode(deep)->interfaceAddress);	
		return true;
	}
	
	// boolean isEqualNode(Node? otherNode);
	static int isEqualNode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString otherNodeInterfaceAddress = GetString(ctx);
		DKInterface* otherNodeInterface = (DKInterface*)addressToPointer(otherNodeInterfaceAddress);
		DKString otherNodeAddress = otherNodeInterface->address["Node"];
		DKNode* otherNode = (DKNode*)addressToPointer(otherNodeAddress);

		dukglue_push(ctx, node(ctx)->isEqualNode(otherNode));
		return true;
	}
	
	// boolean isSameNode(Node? otherNode); // legacy alias of ===
	static int isSameNode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString otherNodeInterfaceAddress = GetString(ctx);
		DKInterface* otherNodeInterface = (DKInterface*)addressToPointer(otherNodeInterfaceAddress);
		DKString otherNodeAddress = otherNodeInterface->address["Node"];
		DKNode* otherNode = (DKNode*)addressToPointer(otherNodeAddress);

		dukglue_push(ctx, node(ctx)->isSameNode(otherNode));	
		return true;
	}
	
	// const unsigned short DOCUMENT_POSITION_DISCONNECTED = 0x01;
	static int DOCUMENT_POSITION_DISCONNECTED(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		
		dukglue_push(ctx, node(ctx)->DOCUMENT_POSITION_DISCONNECTED());
		return true;
	}
	
	// const unsigned short DOCUMENT_POSITION_PRECEDING = 0x02;
	static int DOCUMENT_POSITION_PRECEDING(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		
		dukglue_push(ctx, node(ctx)->DOCUMENT_POSITION_PRECEDING());
		return true;
	}
	
	// const unsigned short DOCUMENT_POSITION_FOLLOWING = 0x04;
	static int DOCUMENT_POSITION_FOLLOWING(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		
		dukglue_push(ctx, node(ctx)->DOCUMENT_POSITION_FOLLOWING());
		return true;
	}
	
	// const unsigned short DOCUMENT_POSITION_CONTAINS = 0x08;
	static int DOCUMENT_POSITION_CONTAINS(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		
		dukglue_push(ctx, node(ctx)->DOCUMENT_POSITION_CONTAINS());
		return true;
	}
	
	// const unsigned short DOCUMENT_POSITION_CONTAINED_BY = 0x10;
	static int DOCUMENT_POSITION_CONTAINED_BY(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		
		dukglue_push(ctx, node(ctx)->DOCUMENT_POSITION_CONTAINED_BY());
		return true;
	}
	
	// const unsigned short DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = 0x20;
	static int DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		
		dukglue_push(ctx, node(ctx)->DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC());
		return true;
	}
	
	// unsigned short compareDocumentPosition(Node other);
	static int compareDocumentPosition(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString otherInterfaceAddress = GetString(ctx);
		DKInterface* otherInterface = (DKInterface*)addressToPointer(otherInterfaceAddress);
		DKString otherAddress = otherInterface->address["Node"];
		DKNode* other = (DKNode*)addressToPointer(otherAddress);

		dukglue_push(ctx, node(ctx)->compareDocumentPosition(other));	
		return true;
	}
	
	// boolean contains(Node? other);
	static int contains(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString otherInterfaceAddress = GetString(ctx);
		DKInterface* otherInterface = (DKInterface*)addressToPointer(otherInterfaceAddress);
		DKString otherAddress = otherInterface->address["Node"];
		DKNode* other = (DKNode*)addressToPointer(otherAddress);

		dukglue_push(ctx, node(ctx)->contains(other));	
		return true;
	}
	
	// DOMString? lookupPrefix(DOMString? namespace);
	static int lookupPrefix(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _namespace = GetString(ctx);

		dukglue_push(ctx, node(ctx)->lookupPrefix(_namespace));	
		return true;
	}
	
	// DOMString? lookupNamespaceURI(DOMString? prefix);
	static int lookupNamespaceURI(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _namespace = GetString(ctx);
		
		dukglue_push(ctx, node(ctx)->lookupNamespaceURI(_namespace));	
		return true;
	}
	
	// boolean isDefaultNamespace(DOMString? namespace);
	static int isDefaultNamespace(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _namespace = GetString(ctx);

		dukglue_push(ctx, node(ctx)->isDefaultNamespace(_namespace));	
		return true;
	}
	
	// [CEReactions] Node insertBefore(Node node, Node? child);
	static int insertBefore(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString nodeInterfaceAddress = GetString(ctx, 1);
		DKInterface* nodeInterface = (DKInterface*)addressToPointer(nodeInterfaceAddress);
		DKString nodeAddress = nodeInterface->address["Node"];
		DKNode* _node = (DKNode*)addressToPointer(nodeAddress);
		
		DKString childInterfaceAddress = GetString(ctx, 2);
		DKInterface* childInterface = (DKInterface*)addressToPointer(childInterfaceAddress);
		DKString childAddress = nodeInterface->address["Node"];
		DKNode* child = (DKNode*)addressToPointer(childAddress);
		
		dukglue_push(ctx, node(ctx)->insertBefore(_node, child)->interfaceAddress);	
		return true;
	}
	
	// [CEReactions] Node appendChild(Node node);
	static int appendChild(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString nodeInterfaceAddress = GetString(ctx, 1);
		DKInterface* nodeInterface = (DKInterface*)addressToPointer(nodeInterfaceAddress);
		DKString nodeAddress = nodeInterface->address["Node"];
		DKNode* _node = (DKNode*)addressToPointer(nodeAddress);
		
		dukglue_push(ctx, node(ctx)->appendChild(_node)->interfaceAddress);	
		return true;
	}
	
	// [CEReactions] Node replaceChild(Node node, Node child);
	static int replaceChild(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString nodeInterfaceAddress = GetString(ctx, 1);
		DKInterface* nodeInterface = (DKInterface*)addressToPointer(nodeInterfaceAddress);
		DKString nodeAddress = nodeInterface->address["Node"];
		DKNode* _node = (DKNode*)addressToPointer(nodeAddress);
		
		DKString childInterfaceAddress = GetString(ctx, 2);
		DKInterface* childInterface = (DKInterface*)addressToPointer(childInterfaceAddress);
		DKString childAddress = nodeInterface->address["Node"];
		DKNode* child = (DKNode*)addressToPointer(childAddress);
		
		dukglue_push(ctx, node(ctx)->replaceChild(_node, child)->interfaceAddress);	
		return true;
	}
	
	// [CEReactions] Node removeChild(Node child);
	static int removeChild(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString childInterfaceAddress = GetString(ctx, 1);
		DKInterface* childInterface = (DKInterface*)addressToPointer(childInterfaceAddress);
		DKString childAddress = childInterface->address["Node"];
		DKNode* child = (DKNode*)addressToPointer(childAddress);
		
		dukglue_push(ctx, node(ctx)->removeChild(child)->interfaceAddress);	
		return true;
	}
};
REGISTER_OBJECT(DKNodeDUK, true)


#endif //DKNodeDUK_H
#endif //HAVE_DKDuktape