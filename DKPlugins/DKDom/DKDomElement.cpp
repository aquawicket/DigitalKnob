#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRml/DKRml.h"
#include "DKDom/DKDomElement.h"


/////////////////////////
bool DKDomElement::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKDomElement_clientHeight", DKDomElement::clientHeight);
	DKDuktape::AttachFunction("DKDomElement_clientLeft", DKDomElement::clientLeft);
	DKDuktape::AttachFunction("DKDomElement_clientTop", DKDomElement::clientTop);
	DKDuktape::AttachFunction("DKDomElement_clientWidth", DKDomElement::clientWidth);
	DKDuktape::AttachFunction("DKDomElement_getAttribute", DKDomElement::getAttribute);
	DKDuktape::AttachFunction("DKDomElement_getElementsByClassName", DKDomElement::getElementsByClassName);
	DKDuktape::AttachFunction("DKDomElement_getElementsByTagName", DKDomElement::getElementsByTagName);
	DKDuktape::AttachFunction("DKDomElement_hasAttribute", DKDomElement::hasAttribute);
	DKDuktape::AttachFunction("DKDomElement_innerHTML", DKDomElement::innerHTML);
	DKDuktape::AttachFunction("DKDomElement_setAttribute", DKDomElement::setAttribute);
	DKDuktape::AttachFunction("DKDomElement_tagName", DKDomElement::tagName);
	
	DKClass::DKCreate("DKDom/DKDomElement.js");
	return true;
}

/*
/////////////////////////////////////////////////////////////////////////////////////////
bool DKDomElement::GetElements(Rml::Core::Element* parent, Rml::Core::ElementList& elements)
{
	DKDEBUGFUNC(parent, "DKDomElementList&");
	if(!parent){ return false; }
	typedef std::queue<Rml::Core::Element*> SearchQueue;
	SearchQueue search_queue;

	elements.push_back(DKRml::Get()->document->GetFirstChild()->GetParentNode()); //add the body tag first
	for(int i = 0; i < parent->GetNumChildren(); ++i)
		search_queue.push(parent->GetChild(i));

	while(!search_queue.empty()){
		Rml::Core::Element* element = search_queue.front();
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

////////////////////////////////////////////////
int DKDomElement::clientHeight(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Core::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("DKDomElement::clientHeight(): element invalid\n");
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

//////////////////////////////////////////////
int DKDomElement::clientLeft(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Core::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("DKDomElement::clientLeft(): element invalid\n");
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

/////////////////////////////////////////////
int DKDomElement::clientTop(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Core::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("DKDomElement::clientTop(): element invalid\n");
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

///////////////////////////////////////////////
int DKDomElement::clientWidth(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Core::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("DKDomElement::clientWidth(): element invalid\n");
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

////////////////////////////////////////////////
int DKDomElement::getAttribute(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString attribute = duk_require_string(ctx, 1);
	Rml::Core::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("DKDomElement::getAttribute("+address+","+attribute+"): element invalid\n");
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
	DKString value = temp;//.CString();
	duk_push_string(ctx, value.c_str());
	return true;
}

//////////////////////////////////////////////////////////
int DKDomElement::getElementsByClassName(duk_context* ctx)
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
		DKString elementAddress = DKRml::elementToAddress(elements[i]);
		str += elementAddress;
		if(i < elements.size()-1){ str += ","; }
	}
	duk_push_string(ctx, str.c_str());
	return true;
}

////////////////////////////////////////////////////////
int DKDomElement::getElementsByTagName(duk_context* ctx)
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
		DKString elementAddress = DKRml::elementToAddress(elements[i]);
		str += elementAddress;
		if(i < elements.size()-1){ str += ","; }
	}
	duk_push_string(ctx, str.c_str());
	return true;
}

////////////////////////////////////////////////
int DKDomElement::hasAttribute(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString attribute = duk_require_string(ctx, 1);
	Rml::Core::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("DKDomElement::hasAttribute(): element invalid\n");
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

/////////////////////////////////////////////
int DKDomElement::innerHTML(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Core::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("DKDomElement::innerHTML(): element invalid\n");
		duk_push_boolean(ctx, false);
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

	return true;
}

////////////////////////////////////////////////
int DKDomElement::setAttribute(duk_context* ctx)
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
		DKERROR("DKDomElement::setAttribute(): value invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	Rml::Core::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("DKDomElement::setAttribute(): element invalid\n");
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

///////////////////////////////////////////
int DKDomElement::tagName(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Core::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("DKDomElement::tagName(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	duk_push_string(ctx, element->GetTagName().c_str());
	return true;
}
#endif //USE_DKDuktape