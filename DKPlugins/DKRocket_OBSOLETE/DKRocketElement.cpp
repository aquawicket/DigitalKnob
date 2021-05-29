#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRocket/DKRocket.h"
#include "DKRocket/DKRocketElement.h"


//////////////////////
bool DKRocketElement::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKRocketElement_clientHeight", DKRocketElement::clientHeight);
	DKDuktape::AttachFunction("DKRocketElement_clientLeft", DKRocketElement::clientLeft);
	DKDuktape::AttachFunction("DKRocketElement_clientTop", DKRocketElement::clientTop);
	DKDuktape::AttachFunction("DKRocketElement_clientWidth", DKRocketElement::clientWidth);
	DKDuktape::AttachFunction("DKRocketElement_getAttribute", DKRocketElement::getAttribute);
	DKDuktape::AttachFunction("DKRocketElement_getElementsByClassName", DKRocketElement::getElementsByClassName);
	DKDuktape::AttachFunction("DKRocketElement_getElementsByTagName", DKRocketElement::getElementsByTagName);
	DKDuktape::AttachFunction("DKRocketElement_hasAttribute", DKRocketElement::hasAttribute);
	DKDuktape::AttachFunction("DKRocketElement_innerHTML", DKRocketElement::innerHTML);
	DKDuktape::AttachFunction("DKRocketElement_setAttribute", DKRocketElement::setAttribute);
	DKDuktape::AttachFunction("DKRocketElement_tagName", DKRocketElement::tagName);
	
	DKClass::DKCreate("DKRocket/DKRocketElement.js");
	return true;
}

/////////////////////////////////////////////
int DKRocketElement::clientHeight(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rocket::Core::Element* element = DKRocket::Get()->addressToElement(address);
	if(!element){
		DKERROR("DKRocketElement::clientWidth(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	int clientHeight = 0;
	if(element == DKRocket::Get()->document->GetFirstChild()){ //html node, get context size
		clientHeight = DKRocket::Get()->context->GetDimensions().y; 
	}
	else{
		clientHeight = (int)element->GetClientHeight();
	}
	duk_push_int(ctx, clientHeight);
	return true;
}

///////////////////////////////////////////
int DKRocketElement::clientLeft(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rocket::Core::Element* element = DKRocket::Get()->addressToElement(address);
	if(!element){
		DKERROR("DKRocketElement::clientWidth(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	int clientLeft = 0;
	if(element != DKRocket::Get()->document->GetFirstChild()){ //not html node
		clientLeft = (int)element->GetClientLeft();
	}
	duk_push_int(ctx, clientLeft);
	return true;
}

//////////////////////////////////////////
int DKRocketElement::clientTop(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rocket::Core::Element* element = DKRocket::Get()->addressToElement(address);
	if(!element){
		DKERROR("DKRocketElement::clientWidth(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	int clientTop = 0;
	if(element != DKRocket::Get()->document->GetFirstChild()){ //not html node
		clientTop = (int)element->GetClientTop();
	}
	duk_push_int(ctx, clientTop);
	return true;
}

////////////////////////////////////////////
int DKRocketElement::clientWidth(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rocket::Core::Element* element = DKRocket::Get()->addressToElement(address);
	if(!element){
		DKERROR("DKRocketElement::clientWidth(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	int clientWidth = 0;
	if(element == DKRocket::Get()->document->GetFirstChild()){ //html node, get context size
		clientWidth = DKRocket::Get()->context->GetDimensions().x; 
	}
	else{
		clientWidth = (int)element->GetClientWidth();
	}
	duk_push_int(ctx, clientWidth);
	return true;
}

/////////////////////////////////////////////
int DKRocketElement::getAttribute(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString attribute = duk_require_string(ctx, 1);
	Rocket::Core::Element* element = DKRocket::Get()->addressToElement(address);
	if(!element){
		DKERROR("DKRocketElement::getAttribute("+address+","+attribute+"): element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	Rocket::Core::Variant* variant = element->GetAttribute(attribute.c_str());
	if(!variant){ 
		//DKWARN("DKRocketElement::getAttribute("+address+","+attribute+"): element does not contain the requested attribute\n");
		duk_push_undefined(ctx);
		return true;
	}
	Rocket::Core::String temp = element->GetAttribute(attribute.c_str())->Get<Rocket::Core::String>();
	DKString value = temp.CString();
	duk_push_string(ctx, value.c_str());
	return true;
}

///////////////////////////////////////////////////////
int DKRocketElement::getElementsByClassName(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString name = duk_require_string(ctx, 0);
	Rocket::Core::ElementList elements;
	DKRocket::Get()->document->GetElementsByClassName(elements, name.c_str());
	if(elements.empty()){
		duk_push_null(ctx);
		return true;
	}
	DKString str;
	for(unsigned int i=0; i<elements.size(); i++){
		DKString elementAddress = DKRocket::Get()->elementToAddress(elements[i]);
		str += elementAddress;
		if(i < elements.size()-1){ str += ","; }
	}
	duk_push_string(ctx, str.c_str());
	return true;
}

/////////////////////////////////////////////////////
int DKRocketElement::getElementsByTagName(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString name = duk_require_string(ctx, 0);
	Rocket::Core::ElementList elements;
	DKRocket::Get()->document->GetElementsByTagName(elements, name.c_str());
	if(same(name, "html")){
		elements.push_back(DKRocket::Get()->document); //html tag
	}
	/*
	if(same(name, "body")){
	elements.push_back(DKRocket::Get()->document); //body tag
	}
	*/
	if(elements.empty()){
		duk_push_null(ctx);
		return true;
	}
	DKString str;
	for(unsigned int i=0; i<elements.size(); i++){
		DKString elementAddress = DKRocket::Get()->elementToAddress(elements[i]);
		str += elementAddress;
		if(i < elements.size()-1){ str += ","; }
	}
	duk_push_string(ctx, str.c_str());
	return true;
}

/////////////////////////////////////////////
int DKRocketElement::hasAttribute(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString attribute = duk_require_string(ctx, 1);
	Rocket::Core::Element* element = DKRocket::Get()->addressToElement(address);
	if(!element){
		DKERROR("DKRocketElement::hasAttribute(): element invalid\n");
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
int DKRocketElement::innerHTML(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rocket::Core::Element* element = DKRocket::Get()->addressToElement(address);
	if(!element){
		DKERROR("DKRocketElement::innerHTML(): element invalid\n");
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
int DKRocketElement::setAttribute(duk_context* ctx)
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
		DKERROR("DKRocketElement::setAttribute(): value invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	Rocket::Core::Element* element = DKRocket::Get()->addressToElement(address);
	if(!element){
		DKERROR("DKRocketElement::setAttribute(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	element->SetAttribute(attribute.c_str(), value.c_str());
	duk_push_boolean(ctx, true);

	//if the attribute is "src", then post process to load scripts or iframes
	if(same(attribute,"src")){
		DKRocketToRML dkRocketToRml;
		dkRocketToRml.PostProcess(element);
	}

	return true;
}

////////////////////////////////////////
int DKRocketElement::tagName(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rocket::Core::Element* element = DKRocket::Get()->addressToElement(address);
	if(!element){
		DKERROR("DKRocketElement::tagName(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	duk_push_string(ctx, element->GetTagName().CString());
	return true;
}
#endif //USE_DKDuktape