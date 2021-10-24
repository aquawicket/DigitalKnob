//https://developer.mozilla.org/en-US/docs/Web/API/Node

#include "DK/DKApp.h"
#include "DKDom.h"
#include "DKDom/DKDomElement.h"
#include "DKDom/DKDomNode.h"


//////////////////////
bool DKDomNode::Init()
{
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


////////////////////////////////////////
int DKDomNode::baseURI(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::baseURI not implemented\n");
	return false;
}

//////////////////////////////////////////////
int DKDomNode::baseURIObject(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::baseURIObject not implemented\n");
	return false;
}

///////////////////////////////////////////
int DKDomNode::childNodes(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("DKDomNode::childNodes(): element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}

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
	if (!element) {
		DKERROR("DKDomNode::firstChild(): element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	Rml::Element* firstChild = element->GetFirstChild();
	if (!firstChild) {
		DKERROR("DKDomNode::firstChild(): firstChild invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	DKString elementAddress = DKRml::elementToAddress(firstChild);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

////////////////////////////////////////////
int DKDomNode::isConnected(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::isConnected not implemented\n");
	return false;
}

int DKDomNode::lastChild(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("DKDomNode::lastChild(): element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	Rml::Element* lastChild = element->GetLastChild();
	if (!lastChild) {
		DKERROR("DKDomNode::lastChild(): lastChild invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	DKString elementAddress = DKRml::elementToAddress(lastChild);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

int DKDomNode::nextSibling(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		duk_push_undefined(ctx);
		return DKERROR("element invalid\n");
	}
	Rml::Element* nextSibling = element->GetNextSibling();
	if (!nextSibling) {
		duk_push_undefined(ctx);
		return DKERROR("nextSibling invalid\n");
	}
	DKString elementAddress = DKRml::elementToAddress(nextSibling);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

/////////////////////////////////////////
int DKDomNode::nodeName(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::nodeName not implemented\n");
	return false;
}

/////////////////////////////////////////
int DKDomNode::nodeType(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::nodeType not implemented\n");
	return false;
}

//////////////////////////////////////////
int DKDomNode::nodeValue(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::nodeValue not implemented\n");
	return false;
}

int DKDomNode::ownerDocument(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		duk_push_undefined(ctx);
		return DKERROR("element invalid\n");
	}
	Rml::Element* ownerDocument = element->GetOwnerDocument();
	if (!ownerDocument) {
		duk_push_undefined(ctx);
		return DKERROR("ownerDocument invalid\n");
	}
	DKString ownerDocumentAddress = DKRml::elementToAddress(ownerDocument);
	duk_push_string(ctx, ownerDocumentAddress.c_str());
	return true;
}

int DKDomNode::parentNode(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		duk_push_undefined(ctx);
		DKERROR("element invalid\n");
		return true; 
	}
	Rml::Element* parentNode = element->GetParentNode();
	if (!parentNode) {
		duk_push_undefined(ctx);
		DKERROR("parentNode invalid\n");
		return true;
	}
	DKString parentAddress = DKRml::elementToAddress(parentNode);
	duk_push_string(ctx, parentAddress.c_str());
	return true;
}

// https://stackoverflow.com/a/8685780
int DKDomNode::parentElement(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomNode::parentElement(): element invalid\n");
	}
	Rml::Element* parentNode = element->GetParentNode();
	if (!parentNode) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomNode::parentElement(): parentNode invalid\n");
	}
	DKString parentAddress = DKRml::elementToAddress(parentNode);
	duk_push_string(ctx, parentAddress.c_str());
	//TODO: check this on javascript side if it is an instance of Element
	return true;
}

int DKDomNode::previousSibling(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		duk_push_undefined(ctx);
		return DKERROR("element invalid\n");
	}
	Rml::Element* previousSibling = element->GetPreviousSibling();
	if (!previousSibling) {
		duk_push_undefined(ctx);
		return DKWARN("previousSibling invalid\n");
	}
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
	if(!element){
		DKERROR("DKDomNode::appendChild(): element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	DKString childAddress = duk_require_string(ctx, 1);
	Rml::Element* child = DKRml::addressToElement(childAddress);
	if(!child){
		DKERROR("DKDomNode::appendChild(): child invalid\n");
		duk_push_undefined(ctx);
		return true;
	}

	if(!element->AppendChild(child->GetParentNode()->RemoveChild(child), true)){
		DKERROR("DKDomNode::appendChild(): AppendChild failed\n");
		duk_push_undefined(ctx);
		return true;
	}

	duk_push_string(ctx, childAddress.c_str());

	//post process if it's a <link>
	if(same("link", child->GetTagName())){
		if(child->HasAttribute("href")){
			DKRml::Get()->dkRmlConverter.PostProcess(child);
		}	
	}

	//post process if it's a <script>
	if (same("script", child->GetTagName())) {
		if(child->HasAttribute("src")) {
			DKRml::Get()->dkRmlConverter.PostProcess(child);
		}
	}

	return true;
}

//////////////////////////////////////////
int DKDomNode::cloneNode(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::cloneNode not implemented\n");
	return false;
}

////////////////////////////////////////////////////////
int DKDomNode::compareDocumentPosition(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::compareDocumentPosition not implemented\n");
	return false;
}

/////////////////////////////////////////
int DKDomNode::contains(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("DKDomNode::contains(): element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	DKString nodeAddress = duk_require_string(ctx, 1);
	Rml::Element* node = DKRml::addressToElement(nodeAddress);
	if(!node){
		DKERROR("DKDomNode::contains(): node invalid\n");
		duk_push_undefined(ctx);
		return true;
	}

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

////////////////////////////////////////////
int DKDomNode::getBoxQuads(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::getBoxQuads not implemented\n");
	return false;
}

/////////////////////////////////////////
int DKDomNode::getRootNode(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::getRootNode not implemented\n");
	return false;
}

int DKDomNode::hasChildNodes(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	bool hasChildNodes = element->HasChildNodes();
	duk_push_boolean(ctx, hasChildNodes);
	return true;
}

/////////////////////////////////////////////
int DKDomNode::insertBefore(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	
	DKString childAddress = duk_require_string(ctx, 1);
	Rml::Element* child = DKRml::addressToElement(childAddress);
	if(!child){
		DKERROR("child invalid\n");
		duk_push_undefined(ctx);
		return true;
	}

	DKString adjacentAddress = duk_require_string(ctx, 2);
	Rml::Element* adjacentElement = DKRml::addressToElement(adjacentAddress);
	if(!adjacentElement){
		DKERROR("adjacentElement invalid\n");
		duk_push_undefined(ctx);
		return true;
	}

	if(!element->InsertBefore(child->GetParentNode()->RemoveChild(child), adjacentElement)){
		DKERROR("InsertBefore failed\n");
		duk_push_undefined(ctx);
		return true;
	}

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

///////////////////////////////////////////////////
int DKDomNode::isDefaultNamespace(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::isDefaultNamespace not implemented\n");
	return false;
}

////////////////////////////////////////////
int DKDomNode::isEqualNode(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::isEqualNode not implemented\n");
	return false;
}

///////////////////////////////////////////
int DKDomNode::isSameNode(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::isSameNode not implemented\n");
	return false;
}

/////////////////////////////////////////////
int DKDomNode::lookupPrefix(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::lookupPrefix not implemented\n");
	return false;
}

///////////////////////////////////////////////////
int DKDomNode::lookupNamespaceURI(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::lookupNamespaceURI not implemented\n");
	return false;
}

/////////////////////////////////////////
int DKDomNode::normalize(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::normalize not implemented\n");
	return false;
}

////////////////////////////////////////////
int DKDomNode::removeChild(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("DKDomNode::removeChild(): element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	DKString childAddress = duk_require_string(ctx, 1);
	Rml::Element* child = DKRml::addressToElement(childAddress);
	if(!child){
		DKERROR("DKDomNode::removeChild(): child invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	//DKINFO("element->RemoveChild(child): " + element->GetTagName() + "->(" + child->GetTagName() + ")\n");
	if(!element->RemoveChild(child)){
		DKERROR("DKDomNode::removeChild(): element->RemoveChild failed\n");
		duk_push_undefined(ctx);
		return true;
	}
	duk_push_string(ctx, childAddress.c_str());
	return true;
}

/////////////////////////////////////////////
int DKDomNode::replaceChild(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	
	DKString newChildAddress = duk_require_string(ctx, 1);
	Rml::Element* newChild = DKRml::addressToElement(newChildAddress);
	if(!newChild){
		DKERROR("newChild invalid\n");
		duk_push_undefined(ctx);
		return true;
	}

	DKString oldChildAddress = duk_require_string(ctx, 2);
	Rml::Element* oldChild = DKRml::addressToElement(oldChildAddress);
	if(!oldChild){
		DKERROR("oldChild invalid\n");
		duk_push_undefined(ctx);
		return true;
	}

	if(!element->ReplaceChild(newChild->GetParentNode()->RemoveChild(newChild), oldChild)){
		DKERROR("replaceChild failed\n");
		duk_push_undefined(ctx);
		return true;
	}

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

////////////////////////////////////////////
int DKDomNode::getUserData(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::getUserData not implemented\n");
	return false;
}

//////////////////////////////////////////////
int DKDomNode::hasAttributes(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::hasAttributes not implemented\n");
	return false;
}

////////////////////////////////////////////
int DKDomNode::isSupported(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::isSupported not implemented\n");
	return false;
}

////////////////////////////////////////////
int DKDomNode::setUserData(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKERROR("DKDomNode::setUserData not implemented\n");
	return false;
}