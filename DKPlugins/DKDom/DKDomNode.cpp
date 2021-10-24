//https://developer.mozilla.org/en-US/docs/Web/API/Node

#include "DK/DKApp.h"
#include "DKDom.h"
#include "DKDom/DKDomElement.h"
#include "DKDom/DKDomNode.h"


bool DKDomNode::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKDomNode_baseURI", DKDomNode::baseURI);
	DKDuktape::AttachFunction("CPP_DKDomNode_baseUriObject", DKDomNode::baseURIObject);
	DKDuktape::AttachFunction("CPP_DKDomNode_childNodes", DKDomNode::childNodes);
	DKDuktape::AttachFunction("CPP_DKDomNode_firstChild", DKDomNode::firstChild);
	DKDuktape::AttachFunction("CPP_DKDomNode_isConnected", DKDomNode::isConnected);
	DKDuktape::AttachFunction("CPP_DKDomNode_lastChild", DKDomNode::lastChild);
	DKDuktape::AttachFunction("CPP_DKDomNode_nextSibling", DKDomNode::nextSibling);
	DKDuktape::AttachFunction("CPP_DKDomNode_nodeName", DKDomNode::nodeName);
	DKDuktape::AttachFunction("CPP_DKDomNode_nodeType", DKDomNode::nodeType);
	DKDuktape::AttachFunction("CPP_DKDomNode_nodeValue", DKDomNode::nodeValue);
	DKDuktape::AttachFunction("CPP_DKDomNode_ownerDocument", DKDomNode::ownerDocument);
	DKDuktape::AttachFunction("CPP_DKDomNode_parentNode", DKDomNode::parentNode);
	DKDuktape::AttachFunction("CPP_DKDomNode_parentElement", DKDomNode::parentElement);
	DKDuktape::AttachFunction("CPP_DKDomNode_previousSibling", DKDomNode::previousSibling);
	DKDuktape::AttachFunction("CPP_DKDomNode_textContent", DKDomNode::textContent);
	DKDuktape::AttachFunction("CPP_DKDomNode_localName", DKDomNode::localName);
	DKDuktape::AttachFunction("CPP_DKDomNode_namespaceURI", DKDomNode::namespaceURI);
	DKDuktape::AttachFunction("CPP_DKDomNode_nodePrincipal", DKDomNode::nodePrincipal);
	DKDuktape::AttachFunction("CPP_DKDomNode_prefix", DKDomNode::prefix);
	DKDuktape::AttachFunction("CPP_DKDomNode_rootNode", DKDomNode::rootNode);
	DKDuktape::AttachFunction("CPP_DKDomNode_appendChild", DKDomNode::appendChild);
	DKDuktape::AttachFunction("CPP_DKDomNode_cloneNode", DKDomNode::cloneNode);
	DKDuktape::AttachFunction("CPP_DKDomNode_compareDocumentPosition", DKDomNode::compareDocumentPosition);
	DKDuktape::AttachFunction("CPP_DKDomNode_contains", DKDomNode::contains);
	DKDuktape::AttachFunction("CPP_DKDomNode_getBoxQuads", DKDomNode::getBoxQuads);
	DKDuktape::AttachFunction("CPP_DKDomNode_getRootNode", DKDomNode::getRootNode);
	DKDuktape::AttachFunction("CPP_DKDomNode_hasChildNodes", DKDomNode::hasChildNodes);
	DKDuktape::AttachFunction("CPP_DKDomNode_insertBefore", DKDomNode::insertBefore);
	DKDuktape::AttachFunction("CPP_DKDomNode_isDefaultNamespace", DKDomNode::isDefaultNamespace);
	DKDuktape::AttachFunction("CPP_DKDomNode_isEqualNode", DKDomNode::isEqualNode);
	DKDuktape::AttachFunction("CPP_DKDomNode_isSameNode", DKDomNode::isSameNode);
	DKDuktape::AttachFunction("CPP_DKDomNode_lookupPrefix", DKDomNode::lookupPrefix);
	DKDuktape::AttachFunction("CPP_DKDomNode_lookupNamespaceURI", DKDomNode::lookupNamespaceURI);
	DKDuktape::AttachFunction("CPP_DKDomNode_normalize", DKDomNode::normalize);
	DKDuktape::AttachFunction("CPP_DKDomNode_removeChild", DKDomNode::removeChild);
	DKDuktape::AttachFunction("CPP_DKDomNode_replaceChild", DKDomNode::replaceChild);
	DKDuktape::AttachFunction("CPP_DKDomNode_getUserData", DKDomNode::getUserData);
	DKDuktape::AttachFunction("CPP_DKDomNode_hasAttributes", DKDomNode::hasAttributes);
	DKDuktape::AttachFunction("CPP_DKDomNode_isSupported", DKDomNode::isSupported);
	DKDuktape::AttachFunction("CPP_DKDomNode_setUserData", DKDomNode::setUserData);
	
	DKClass::DKCreate("DKDom/DKDomNode.js");
	return true;
}

int DKDomNode::baseURI(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("DKDomNode::baseURI not implemented\n");
}

int DKDomNode::baseURIObject(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("DKDomNode::baseURIObject not implemented\n");
}

int DKDomNode::childNodes(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element)
		return DKERROR("DKDomNode::childNodes(): element invalid\n");
	int num = element->GetNumChildren();
	Rml::ElementList elements;
	for (int i = 0; i < num; i++) {
		elements.push_back(element->GetChild(i));
	}
	if (elements.empty()) {
		duk_push_null(ctx);
		return true;
	}
	DKString str;
	for (unsigned int i = 0; i < elements.size(); i++) {
		DKString elementAddress = DKRml::elementToAddress(elements[i]);
		str += elementAddress;
		if (i < elements.size() - 1) { str += ","; }
	}
	duk_push_string(ctx, str.c_str());
	return true;
}

int DKDomNode::firstChild(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element)
		return DKERROR("DKDomNode::firstChild(): element invalid\n");
	Rml::Element* firstChild = element->GetFirstChild();
	if (!firstChild)
		return DKERROR("DKDomNode::firstChild(): firstChild invalid\n");
	DKString elementAddress = DKRml::elementToAddress(firstChild);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

int DKDomNode::isConnected(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::isConnected not implemented\n");
	return false;
}

int DKDomNode::lastChild(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element)
		return DKERROR("DKDomNode::lastChild(): element invalid\n");
	Rml::Element* lastChild = element->GetLastChild();
	if (!lastChild)
		return DKERROR("DKDomNode::lastChild(): lastChild invalid\n");
	DKString elementAddress = DKRml::elementToAddress(lastChild);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

int DKDomNode::nextSibling(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element)
		return DKERROR("element invalid\n");
	Rml::Element* nextSibling = element->GetNextSibling();
	if (!nextSibling)
		return DKERROR("nextSibling invalid\n");
	DKString elementAddress = DKRml::elementToAddress(nextSibling);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

int DKDomNode::nodeName(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::nodeName not implemented\n");
	return false;
}

int DKDomNode::nodeType(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::nodeType not implemented\n");
	return false;
}

int DKDomNode::nodeValue(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::nodeValue not implemented\n");
	return false;
}

int DKDomNode::ownerDocument(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element)
		return DKERROR("element invalid\n");
	Rml::Element* ownerDocument = element->GetOwnerDocument();
	if (!ownerDocument)
		return DKERROR("ownerDocument invalid\n");
	DKString ownerDocumentAddress = DKRml::elementToAddress(ownerDocument);
	duk_push_string(ctx, ownerDocumentAddress.c_str());
	return true;
}

int DKDomNode::parentNode(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element)
		return DKERROR("element invalid\n"); 
	Rml::Element* parentNode = element->GetParentNode();
	if (!parentNode)
		return DKERROR("parentNode invalid\n");
	DKString parentAddress = DKRml::elementToAddress(parentNode);
	if (parentAddress.empty())
		return DKERROR("parentAddress invalid\n");
	duk_push_string(ctx, parentAddress.c_str());
	return true;
}

// https://stackoverflow.com/a/8685780
int DKDomNode::parentElement(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element)
		return DKERROR("DKDomNode::parentElement(): element invalid\n");
	Rml::Element* parentNode = element->GetParentNode();
	if (!parentNode)
		return DKERROR("DKDomNode::parentElement(): parentNode invalid\n");
	DKString parentAddress = DKRml::elementToAddress(parentNode);
	duk_push_string(ctx, parentAddress.c_str());
	//TODO: check this on javascript side if it is an instance of Element
	return true;
}

int DKDomNode::previousSibling(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element)
		return DKERROR("element invalid\n");
	Rml::Element* previousSibling = element->GetPreviousSibling();
	if (!previousSibling)
		return DKERROR("previousSibling invalid\n");
	DKString elementAddress = DKRml::elementToAddress(previousSibling);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

int DKDomNode::textContent(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("function not implemented\n");
}

int DKDomNode::localName(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::localName not implemented\n");
	return false;
}

int DKDomNode::namespaceURI(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::namespaceURI not implemented\n");
	return false;
}

int DKDomNode::nodePrincipal(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::nodePrincipal not implemented\n");
	return false;
}

int DKDomNode::prefix(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::prefix not implemented\n");
	return false;
}

int DKDomNode::rootNode(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::rootNode not implemented\n");
	return false;
}

int DKDomNode::appendChild(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if(!element)
		return DKERROR("DKDomNode::appendChild(): element invalid\n");
	DKString childAddress = duk_require_string(ctx, 1);
	Rml::Element* child = DKRml::addressToElement(childAddress);
	if(!child)
		return DKERROR("DKDomNode::appendChild(): child invalid\n");
	if(!element->AppendChild(child->GetParentNode()->RemoveChild(child), true))
		return DKERROR("DKDomNode::appendChild(): AppendChild failed\n");
	duk_push_string(ctx, childAddress.c_str());
	//post process if it's a <link>
	if(same("link", child->GetTagName())){
		if(child->HasAttribute("href"))
			DKRml::Get()->dkRmlConverter.PostProcess(child);
	}
	//post process if it's a <script>
	if (same("script", child->GetTagName())) {
		if(child->HasAttribute("src"))
			DKRml::Get()->dkRmlConverter.PostProcess(child);
	}
	return true;
}

int DKDomNode::cloneNode(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("DKDomNode::cloneNode not implemented\n");
}

int DKDomNode::compareDocumentPosition(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("DKDomNode::compareDocumentPosition not implemented\n");
}

int DKDomNode::contains(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element)
		return DKERROR("DKDomNode::contains(): element invalid\n");
	DKString nodeAddress = duk_require_string(ctx, 1);
	Rml::Element* node = DKRml::addressToElement(nodeAddress);
	if(!node)
		return DKERROR("DKDomNode::contains(): node invalid\n");
	while(node){
		if(node == element){ 
			duk_push_boolean(ctx, true);
			return true; 
		}
		node = node->GetParentNode();
	}
	duk_push_boolean(ctx, false);
	return true;
}

int DKDomNode::getBoxQuads(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("DKDomNode::getBoxQuads not implemented\n");
}

int DKDomNode::getRootNode(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("DKDomNode::getRootNode not implemented\n");
}

int DKDomNode::hasChildNodes(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element)
		return DKERROR("element invalid\n");
	bool hasChildNodes = element->HasChildNodes();
	duk_push_boolean(ctx, hasChildNodes);
	return true;
}

int DKDomNode::insertBefore(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element)
		return DKERROR("element invalid\n");	
	DKString childAddress = duk_require_string(ctx, 1);
	Rml::Element* child = DKRml::addressToElement(childAddress);
	if(!child)
		return DKERROR("child invalid\n");
	DKString adjacentAddress = duk_require_string(ctx, 2);
	Rml::Element* adjacentElement = DKRml::addressToElement(adjacentAddress);
	if(!adjacentElement)
		return DKERROR("adjacentElement invalid\n");
	if(!element->InsertBefore(child->GetParentNode()->RemoveChild(child), adjacentElement))
		return DKERROR("InsertBefore failed\n");
	duk_push_string(ctx, childAddress.c_str());
	//post process if it's a <link>
	if(same("link", child->GetTagName())){
		if(child->HasAttribute("href"))
			DKRml::Get()->dkRmlConverter.PostProcess(child);
	}
	//post process if it's a <script>
	if (same("script", child->GetTagName())) {
		if(child->HasAttribute("src"))
			DKRml::Get()->dkRmlConverter.PostProcess(child);
	}
	return true;
}

int DKDomNode::isDefaultNamespace(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKERROR("DKDomNode::isDefaultNamespace not implemented\n");
}

int DKDomNode::isEqualNode(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("DKDomNode::isEqualNode not implemented\n");
}

int DKDomNode::isSameNode(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("DKDomNode::isSameNode not implemented\n");
}

int DKDomNode::lookupPrefix(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("DKDomNode::lookupPrefix not implemented\n");
}

int DKDomNode::lookupNamespaceURI(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("DKDomNode::lookupNamespaceURI not implemented\n");
}

int DKDomNode::normalize(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("DKDomNode::normalize not implemented\n");
}

int DKDomNode::removeChild(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if(!element)
		return DKERROR("DKDomNode::removeChild(): element invalid\n");
	DKString childAddress = duk_require_string(ctx, 1);
	Rml::Element* child = DKRml::addressToElement(childAddress);
	if(!child)
		return DKERROR("DKDomNode::removeChild(): child invalid\n");
	//DKINFO("element->RemoveChild(child): " + element->GetTagName() + "->(" + child->GetTagName() + ")\n");
	if(!element->RemoveChild(child))
		return DKERROR("DKDomNode::removeChild(): element->RemoveChild failed\n");
	duk_push_string(ctx, childAddress.c_str());
	return true;
}

int DKDomNode::replaceChild(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element)
		return DKERROR("element invalid\n");	
	DKString newChildAddress = duk_require_string(ctx, 1);
	Rml::Element* newChild = DKRml::addressToElement(newChildAddress);
	if(!newChild)
		return DKERROR("newChild invalid\n");
	DKString oldChildAddress = duk_require_string(ctx, 2);
	Rml::Element* oldChild = DKRml::addressToElement(oldChildAddress);
	if(!oldChild)
		return DKERROR("oldChild invalid\n");
	if(!element->ReplaceChild(newChild->GetParentNode()->RemoveChild(newChild), oldChild))
		return DKERROR("replaceChild failed\n");
	duk_push_string(ctx, newChildAddress.c_str());
	//post process if it's a <link>
	if(same("link", oldChild->GetTagName())){
		if(oldChild->HasAttribute("href"))
			DKRml::Get()->dkRmlConverter.PostProcess(oldChild);
	}
	//post process if it's a <script>
	if (same("script", oldChild->GetTagName())) {
		if(oldChild->HasAttribute("src"))
			DKRml::Get()->dkRmlConverter.PostProcess(oldChild);
	}
	return true;
}

int DKDomNode::getUserData(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("DKDomNode::getUserData not implemented\n");
}

int DKDomNode::hasAttributes(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("DKDomNode::hasAttributes not implemented\n");
}

int DKDomNode::isSupported(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("DKDomNode::isSupported not implemented\n");
}

int DKDomNode::setUserData(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("DKDomNode::setUserData not implemented\n");
}
