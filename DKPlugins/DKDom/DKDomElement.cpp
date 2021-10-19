//https://developer.mozilla.org/en-US/docs/Web/API/Element

#include "DK/DKApp.h"
#include "DKDom.h"
#include "DKDom/DKDomElement.h"


bool DKDomElement::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKDomElement_clientHeight", DKDomElement::clientHeight);
	DKDuktape::AttachFunction("CPP_DKDomElement_clientLeft", DKDomElement::clientLeft);
	DKDuktape::AttachFunction("CPP_DKDomElement_clientTop", DKDomElement::clientTop);
	DKDuktape::AttachFunction("CPP_DKDomElement_clientWidth", DKDomElement::clientWidth);
	DKDuktape::AttachFunction("CPP_DKDomElement_closest", DKDomElement::closest);
	DKDuktape::AttachFunction("CPP_DKDomElement_getAttribute", DKDomElement::getAttribute);
	DKDuktape::AttachFunction("CPP_DKDomElement_getElementsByClassName", DKDomElement::getElementsByClassName);
	DKDuktape::AttachFunction("CPP_DKDomElement_getElementsByTagName", DKDomElement::getElementsByTagName);
	DKDuktape::AttachFunction("CPP_DKDomElement_hasAttribute", DKDomElement::hasAttribute);
	DKDuktape::AttachFunction("CPP_DKDomElement_removeAttribute", DKDomElement::removeAttribute);
	DKDuktape::AttachFunction("CPP_DKDomElement_innerHTML", DKDomElement::innerHTML);
	DKDuktape::AttachFunction("CPP_DKDomElement_outerHTML", DKDomElement::outerHTML);
	DKDuktape::AttachFunction("CPP_DKDomElement_querySelector", DKDomElement::querySelector);
	DKDuktape::AttachFunction("CPP_DKDomElement_querySelectorAll", DKDomElement::querySelectorAll);
	DKDuktape::AttachFunction("CPP_DKDomElement_scrollHeight", DKDomElement::scrollHeight);
	DKDuktape::AttachFunction("CPP_DKDomElement_scrollIntoView", DKDomElement::scrollIntoView);
	DKDuktape::AttachFunction("CPP_DKDomElement_scrollLeft", DKDomElement::scrollLeft);
	DKDuktape::AttachFunction("CPP_DKDomElement_scrollTop", DKDomElement::scrollTop);
	DKDuktape::AttachFunction("CPP_DKDomElement_scrollWidth", DKDomElement::scrollWidth);
	DKDuktape::AttachFunction("CPP_DKDomElement_setAttribute", DKDomElement::setAttribute);
	DKDuktape::AttachFunction("CPP_DKDomElement_tagName", DKDomElement::tagName);
	
	DKClass::DKCreate("DKDom/DKDomElement.js");
	return true;
}

/*
bool DKDomElement::GetElements(Rml::Element* parent, Rml::ElementList& elements){
	DKDEBUGFUNC(parent, "DKDomElementList&");
	if(!parent){ return false; }
	typedef std::queue<Rml::Element*> SearchQueue;
	SearchQueue search_queue;

	elements.push_back(DKRml::Get()->document->GetFirstChild()->GetParentNode()); //add the body tag first
	for(int i = 0; i < parent->GetNumChildren(); ++i)
		search_queue.push(parent->GetChild(i));

	while(!search_queue.empty()){
		Rml::Element* element = search_queue.front();
		search_queue.pop();

		if(!has(element->GetTagName(), "#")){ //.CString()
			elements.push_back(element);
		}

		// Add all children to search.
		for (int i = 0; i < element->GetNumChildren(); i++){
			search_queue.push(element->GetChild(i));
		}
	}
	return true;
}
*/

int DKDomElement::clientHeight(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	int clientHeight = 0;
	if(element == DKRml::Get()->document->GetFirstChild()){ //html node, get context size
		clientHeight = DKRml::Get()->context->GetDimensions().y; 
	}
	else{
		clientHeight = (int)element->GetClientHeight();
	}
	duk_push_int(ctx, clientHeight);
	return true;
}

int DKDomElement::clientLeft(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	int clientLeft = 0;
	if(element != DKRml::Get()->document->GetFirstChild()){ //not html node
		clientLeft = (int)element->GetClientLeft();
	}
	duk_push_int(ctx, clientLeft);
	return true;
}

int DKDomElement::clientTop(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	int clientTop = 0;
	if(element != DKRml::Get()->document->GetFirstChild()){ //not html node
		clientTop = (int)element->GetClientTop();
	}
	duk_push_int(ctx, clientTop);
	return true;
}

int DKDomElement::clientWidth(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	int clientWidth = 0;
	if(element == DKRml::Get()->document->GetFirstChild()){ //html node, get context size
		clientWidth = DKRml::Get()->context->GetDimensions().x; 
	}
	else{
		clientWidth = (int)element->GetClientWidth();
	}
	duk_push_int(ctx, clientWidth);
	return true;
}

int DKDomElement::closest(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString selector = duk_require_string(ctx, 1);
	DKDEBUGFUNC(address, selector);
	Rml::Element* element = DKRml::addressToElement(address);
	if(!element){
		duk_push_undefined(ctx);
		return DKERROR("DKDomElement::closest("+address+","+selector+"): element invalid\n");
	}
	Rml::Element* closestElement = element->Closest(selector);
	if(!closestElement){
		duk_push_undefined(ctx);
		return DKERROR("DKDomElement::closest("+address+","+selector+"): closestElement invalid\n");
	}
	DKString elementAddress = DKRml::elementToAddress(closestElement);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

int DKDomElement::getAttribute(duk_context* ctx){
	DKString address = duk_require_string(ctx, 0);
	DKString attribute = duk_require_string(ctx, 1);
	DKDEBUGFUNC(address, attribute);
	Rml::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	Rml::Variant* variant = element->GetAttribute(attribute.c_str());
	if(!variant){ 
		//DKERROR("variant invalid\n");
		duk_push_undefined(ctx);
		return true && DKDEBUGRETURN(ctx, "undefined");
	}
	Rml::String temp = element->GetAttribute(attribute.c_str())->Get<Rml::String>();
	DKString value = temp;
	duk_push_string(ctx, value.c_str());
	return true && DKDEBUGRETURN(ctx, value);
}

int DKDomElement::getElementsByClassName(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString name = duk_require_string(ctx, 1);
	Rml::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	Rml::ElementList elements;
	element->GetElementsByClassName(elements, name.c_str());
	if(elements.empty()){
		duk_push_null(ctx);
		return true && DKDEBUGRETURN(ctx, "empty");
	}
	DKString str;
	for(unsigned int i=0; i<elements.size(); i++){
		DKString elementAddress = DKRml::elementToAddress(elements[i]);
		str += elementAddress;
		if(i < elements.size()-1){ str += ","; }
	}
	duk_push_string(ctx, str.c_str());
	return true && DKDEBUGRETURN(ctx, str);
}

int DKDomElement::getElementsByTagName(duk_context* ctx){
	DKString address = duk_require_string(ctx, 0);
	DKString name = duk_require_string(ctx, 1);
	Rml::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	Rml::ElementList elements;
	element->GetElementsByTagName(elements, name.c_str());
	if(same(name, "html")){
		elements.push_back(DKRml::Get()->document); //html tag
	}
	if(elements.empty()){
		duk_push_null(ctx);
		return true && DKDEBUGRETURN(ctx, "empty");
	}
	DKString str;
	for(unsigned int i=0; i<elements.size(); i++){
		DKString elementAddress = DKRml::elementToAddress(elements[i]);
		str += elementAddress;
		if(i < elements.size()-1){ str += ","; }
	}
	duk_push_string(ctx, str.c_str());
	return true && DKDEBUGRETURN(ctx, str);
}

int DKDomElement::hasAttribute(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString attribute = duk_require_string(ctx, 1);
	Rml::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	if(!element->HasAttribute(attribute.c_str())){ 
		duk_push_boolean(ctx, false);
		return true && DKDEBUGRETURN(ctx, false);
	}
	duk_push_boolean(ctx, true);
	return true && DKDEBUGRETURN(ctx, true);
}

int DKDomElement::removeAttribute(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString attribute = duk_require_string(ctx, 1);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	element->RemoveAttribute(attribute);
	duk_push_boolean(ctx, true);
	return true;
}

int DKDomElement::innerHTML(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	//get
	if(!duk_is_string(ctx, 1)){
		DKString innerHtml = element->GetInnerRML();
		if(innerHtml.empty()){ return true; }
		duk_push_string(ctx, innerHtml.c_str());
	}
	//set
	else{
		DKString innerHTML = duk_require_string(ctx, 1);
		element->SetInnerRML(innerHTML.c_str());
	}
	return true && DKDEBUGRETURN(ctx, innerHTML);
}

int DKDomElement::outerHTML(duk_context* ctx){
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	//get
	if (!duk_is_string(ctx, 1)) {
		DKERROR("DKDomElement::outerHTML(): FIXME: TODO\n"); return false;
		DKString outerHtml = element->GetInnerRML(); //FIXME: element has bot GetOuterRml
		if (outerHtml.empty()) { return true; }
		duk_push_string(ctx, outerHtml.c_str());
	}
	//set
	else {
		DKString outerHTML = duk_require_string(ctx, 1);
		element->SetInnerRML(outerHTML.c_str());
	}
	return true && DKDEBUGRETURN(ctx, outerHTML);
}

int DKDomElement::querySelector(duk_context* ctx){
	DKString address = duk_require_string(ctx, 0);
	DKString selector = duk_require_string(ctx, 1);
	DKDEBUGFUNC(address, selector);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	Rml::Element* queryElement = element->QuerySelector(selector.c_str());
	if(!queryElement){
		duk_push_undefined(ctx);
		return DKERROR("queryElement invalid\n");
	}
	DKString elementAddress = DKRml::elementToAddress(queryElement);
	duk_push_string(ctx, elementAddress.c_str());
	return true && DKDEBUGRETURN(ctx, elementAddress);
}

int DKDomElement::querySelectorAll(duk_context* ctx){
	DKString address = duk_require_string(ctx, 0);
	DKString selectors = duk_require_string(ctx, 1);
	DKDEBUGFUNC(address, selectors);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	Rml::ElementList elements;
	element->QuerySelectorAll(elements, selectors.c_str());
	if(elements.empty()){
		duk_push_null(ctx);
		return true && DKDEBUGRETURN(ctx, "empty");
	}
	DKString str;
	for(unsigned int i=0; i<elements.size(); i++){
		DKString elementAddress = DKRml::elementToAddress(elements[i]);
		str += elementAddress;
		if(i < elements.size()-1){ str += ","; }
	}
	duk_push_string(ctx, str.c_str());
	return true && DKDEBUGRETURN(ctx, str);
}

int DKDomElement::scrollHeight(duk_context* ctx){
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	float scrollHeight = element->GetScrollHeight();
	duk_push_number(ctx, scrollHeight);
	return true && DKDEBUGRETURN(ctx, scrollHeight);
}

int DKDomElement::scrollIntoView(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	if(duk_is_boolean(ctx, 1)){
		bool alignWithTop = duk_require_boolean(ctx, 1);
		element->ScrollIntoView(alignWithTop);
	}
	else{
		element->ScrollIntoView();
	}
	return true;
}

int DKDomElement::scrollLeft(duk_context* ctx){
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	float scrollLeft = element->GetScrollLeft();
	duk_push_number(ctx, scrollLeft);
	return true && DKDEBUGRETURN(ctx, scrollLeft);
}

int DKDomElement::scrollTop(duk_context* ctx){
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	float scrollTop = element->GetScrollTop();
	duk_push_number(ctx, scrollTop);
	return true && DKDEBUGRETURN(ctx, scrollTop);
}

int DKDomElement::scrollWidth(duk_context* ctx){
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	float scrollWidth = element->GetScrollWidth();
	duk_push_number(ctx, scrollWidth);
	return true && DKDEBUGRETURN(ctx, scrollWidth);
}

int DKDomElement::setAttribute(duk_context* ctx){
	DKString address = duk_require_string(ctx, 0);
	DKString attribute = duk_require_string(ctx, 1);
	DKString value;
	if(duk_is_string(ctx, 2)){
		value = duk_require_string(ctx, 2);
	}
	else if(duk_is_boolean(ctx, 2)){
		value = toString(duk_require_boolean(ctx, 2));
	}
	else{
		DKERROR("value invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	Rml::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	element->SetAttribute(attribute.c_str(), value.c_str());
	duk_push_boolean(ctx, true);
	//if the attribute is "src", then post process to load scripts or iframes
	//if(same(attribute,"src")){
	//	DKRml::Get()->dkRmlToRML.PostProcess(element);
	//}
	DKDEBUGFUNC(ctx, address, attribute, value);
	return true;
}

int DKDomElement::tagName(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	duk_push_string(ctx, element->GetTagName().c_str());
	return true && DKDEBUGRETURN(ctx, element->GetTagName());
}
