#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRml/DKRml.h"
#include "DKRml/DKElement.h"


//////////////////////
bool DKElement::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKElement_clientHeight", DKElement::clientHeight);
	DKDuktape::AttachFunction("DKElement_clientLeft", DKElement::clientLeft);
	DKDuktape::AttachFunction("DKElement_clientTop", DKElement::clientTop);
	DKDuktape::AttachFunction("DKElement_clientWidth", DKElement::clientWidth);
	DKDuktape::AttachFunction("DKElement_getAttribute", DKElement::getAttribute);
	DKDuktape::AttachFunction("DKElement_getElementsByClassName", DKElement::getElementsByClassName);
	DKDuktape::AttachFunction("DKElement_getElementsByTagName", DKElement::getElementsByTagName);
	DKDuktape::AttachFunction("DKElement_hasAttribute", DKElement::hasAttribute);
	DKDuktape::AttachFunction("DKElement_innerHTML", DKElement::innerHTML);
	DKDuktape::AttachFunction("DKElement_setAttribute", DKElement::setAttribute);
	
	DKClass::DKCreate("DKRml/DKElement.js");
	return true;
}

/////////////////////////////////////////////
int DKElement::clientHeight(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Core::Element* element = DKRml::Get()->getElementByAddress(address);
	if(!element){
		DKERROR("DKRmlJS::clientWidth(): element invalid\n");
		duk_push_boolean(ctx, false);
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

///////////////////////////////////////////
int DKElement::clientLeft(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Core::Element* element = DKRml::Get()->getElementByAddress(address);
	if(!element){
		DKERROR("DKRmlJS::clientWidth(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	int clientLeft = 0;
	if(element != DKRml::Get()->document->GetFirstChild()){ //not html node
		clientLeft = (int)element->GetClientLeft();
	}
	duk_push_int(ctx, clientLeft);
	return true;
}

//////////////////////////////////////////
int DKElement::clientTop(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Core::Element* element = DKRml::Get()->getElementByAddress(address);
	if(!element){
		DKERROR("DKRmlJS::clientWidth(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	int clientTop = 0;
	if(element != DKRml::Get()->document->GetFirstChild()){ //not html node
		clientTop = (int)element->GetClientTop();
	}
	duk_push_int(ctx, clientTop);
	return true;
}

////////////////////////////////////////////
int DKElement::clientWidth(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Core::Element* element = DKRml::Get()->getElementByAddress(address);
	if(!element){
		DKERROR("DKRmlJS::clientWidth(): element invalid\n");
		duk_push_boolean(ctx, false);
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

/////////////////////////////////////////////
int DKElement::getAttribute(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString attribute = duk_require_string(ctx, 1);
	Rml::Core::Element* element = DKRml::Get()->getElementByAddress(address);
	if(!element){
		DKERROR("DKRmlJS::getAttribute("+address+","+attribute+"): element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	Rml::Core::Variant* variant = element->GetAttribute(attribute.c_str());
	if(!variant){ 
		//DKWARN("DKRmlJS::getAttribute("+address+","+attribute+"): element does not contain the requested attribute\n");
		duk_push_undefined(ctx);
		return true;
	}
	Rml::Core::String temp = element->GetAttribute(attribute.c_str())->Get<Rml::Core::String>();
	DKString value = temp.CString();
	duk_push_string(ctx, value.c_str());
	return true;
}

///////////////////////////////////////////////////////
int DKElement::getElementsByClassName(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString name = duk_require_string(ctx, 0);
	Rml::Core::ElementList elements;
	DKRml::Get()->document->GetElementsByClassName(elements, name.c_str());
	if(elements.empty()){
		duk_push_null(ctx);
		return true;
	}
	DKString str;
	for(unsigned int i=0; i<elements.size(); i++){
		const void* address = static_cast<const void*>(elements[i]);
		std::stringstream ss;
		ss << address;  
		str += ss.str(); 
		if(i < elements.size()-1){ str += ","; }
	}
	duk_push_string(ctx, str.c_str());
	return true;
}

/////////////////////////////////////////////////////
int DKElement::getElementsByTagName(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString name = duk_require_string(ctx, 0);
	Rml::Core::ElementList elements;
	DKRml::Get()->document->GetElementsByTagName(elements, name.c_str());
	if(same(name, "html")){
		elements.push_back(DKRml::Get()->document); //html tag
	}
	/*
	if(same(name, "body")){
	elements.push_back(DKRml::Get()->document); //body tag
	}
	*/
	if(elements.empty()){
		duk_push_null(ctx);
		return true;
	}
	DKString str;
	for(unsigned int i=0; i<elements.size(); i++){
		const void* address = static_cast<const void*>(elements[i]);
		std::stringstream ss;
		ss << address;  
		str += ss.str(); 
		if(i < elements.size()-1){ str += ","; }
	}
	duk_push_string(ctx, str.c_str());
	return true;
}

/////////////////////////////////////////////
int DKElement::hasAttribute(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString attribute = duk_require_string(ctx, 1);
	Rml::Core::Element* element = DKRml::Get()->getElementByAddress(address);
	if(!element){
		DKERROR("DKRmlJS::hasAttribute(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	if(!element->HasAttribute(attribute.c_str())){ 
		duk_push_boolean(ctx, false);
		return true;
	}
	duk_push_boolean(ctx, true);
	return true;
}

//////////////////////////////////////////
int DKElement::innerHTML(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Core::Element* element = DKRml::Get()->getElementByAddress(address);
	if(!element){
		DKERROR("DKRmlJS::innerHTML(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//get
	if(!duk_is_string(ctx, 1)){
		DKString innerHtml = element->GetInnerRML().CString();
		if(innerHtml.empty()){ return true; }
		duk_push_string(ctx, innerHtml.c_str());
	}
	//set
	else{
		DKString innerHTML = duk_require_string(ctx, 1);
		element->SetInnerRML(innerHTML.c_str());
	}

	return true;
}

/////////////////////////////////////////////
int DKElement::setAttribute(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
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
		DKERROR("DKRmlJS::setAttribute(): value invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	Rml::Core::Element* element = DKRml::Get()->getElementByAddress(address);
	if(!element){
		DKERROR("DKRmlJS::setAttribute(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	element->SetAttribute(attribute.c_str(), value.c_str());
	duk_push_boolean(ctx, true);

	//if the attribute is "src", then post process to load scripts or iframes
	if(same(attribute,"src")){
		DKRmlToRML dkRmlToRml;
		dkRmlToRml.PostProcess(element);
	}

	return true;
}

#endif //USE_DKDuktape