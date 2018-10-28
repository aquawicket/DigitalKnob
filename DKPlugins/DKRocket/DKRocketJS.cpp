#ifdef USE_DKDuktape
#include "DKRocket.h"
#include "DKRocketJS.h"


///////////////////////
bool DKRocketJS::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKRocket_LoadUrl", DKRocketJS::LoadUrl);
	DKDuktape::AttachFunction("DKRocket_Reload", DKRocketJS::Reload);
	DKDuktape::AttachFunction("DKRocket_ToggleDebugger", DKRocketJS::ToggleDebugger);
	DKDuktape::AttachFunction("DKRocket_getElementById", DKRocketJS::getElementById);
	DKDuktape::AttachFunction("DKRocket_getAttribute", DKRocketJS::getAttribute);
	DKDuktape::AttachFunction("DKRocket_hasAttribute", DKRocketJS::hasAttribute);
	DKDuktape::AttachFunction("DKRocket_setAttribute", DKRocketJS::setAttribute);
	DKDuktape::AttachFunction("DKRocket_getElementsByClassName", DKRocketJS::getElementsByClassName);
	DKDuktape::AttachFunction("DKRocket_getElementsByTagName", DKRocketJS::getElementsByTagName);
	DKDuktape::AttachFunction("DKRocket_innerHeight", DKRocketJS::innerHeight);
	DKDuktape::AttachFunction("DKRocket_innerWidth", DKRocketJS::innerWidth);
	DKDuktape::AttachFunction("DKRocket_name", DKRocketJS::name);
	DKDuktape::AttachFunction("DKRocket_setProperty", DKRocketJS::setProperty);
	DKDuktape::AttachFunction("DKRocket_getPropertyValue", DKRocketJS::getPropertyValue);
	DKDuktape::AttachFunction("DKRocket_innerHTML", DKRocketJS::innerHTML);
	DKDuktape::AttachFunction("DKRocket_setInnerHTML", DKRocketJS::setInnerHTML);
	return true;
}

/////////////////////////////////////////
int DKRocketJS::LoadUrl(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString file = duk_require_string(ctx, 0);
	if(!DKRocket::Get()->LoadUrl(file)){ return 0; }
	return 1;
}

////////////////////////////////////////
int DKRocketJS::Reload(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKRocket::Get()->Reload();
	return 1;
}

////////////////////////////////////////////////
int DKRocketJS::ToggleDebugger(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKRocket::Get()->ToggleDebugger();
	return 1;
}

/////////////////////////////////////////////
int DKRocketJS::innerHeight(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	int y = DKRocket::Get()->context->GetDimensions().y;
	duk_push_int(ctx, y);
	return 1;
}

////////////////////////////////////////////
int DKRocketJS::innerWidth(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	int x = DKRocket::Get()->context->GetDimensions().x;
	duk_push_int(ctx, x);
	return 1;
}

//////////////////////////////////////
int DKRocketJS::name(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString name = DKRocket::Get()->context->GetName().CString();
	duk_push_string(ctx, name.c_str());
	return 1;
}

////////////////////////////////////////////////
int DKRocketJS::getElementById(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString id = duk_require_string(ctx, 0);
	Rocket::Core::Element* element = DKRocket::Get()->document->GetElementById(id.c_str());
	if(!element){
		DKERROR("DKRocketJS::getElementById(): element invalid");
		duk_push_boolean(ctx, false);
		return true;
	}

	const void * address = static_cast<const void*>(element);
	std::stringstream ss;
	ss << address;  
	DKString str = ss.str(); 

	duk_push_string(ctx, str.c_str());
	//duk_push_pointer(ctx, element);
	return true;
}

//////////////////////////////////////////////
int DKRocketJS::getAttribute(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString attribute = duk_require_string(ctx, 1);
	Rocket::Core::Element* element = getElementByAddress(address);
	if(!element){
		DKERROR("DKRocketJS::getAttribute("+attribute+"): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	Rocket::Core::Variant* variant = element->GetAttribute(attribute.c_str());
	if(!variant){ 
		DKERROR("DKRocketJS::getAttribute("+attribute+"): variant invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	Rocket::Core::String temp = element->GetAttribute(attribute.c_str())->Get<Rocket::Core::String>();
	DKString value = temp.CString();
	duk_push_string(ctx, value.c_str());
	return true;
}

//////////////////////////////////////////////
int DKRocketJS::hasAttribute(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString attribute = duk_require_string(ctx, 1);
	Rocket::Core::Element* element = getElementByAddress(address);
	if(!element){
		DKERROR("DKRocketJS::hasAttribute(): element invalid\n");
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

//////////////////////////////////////////////
int DKRocketJS::setAttribute(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString attribute = duk_require_string(ctx, 1);
	DKString value = duk_require_string(ctx, 2);
	Rocket::Core::Element* element = getElementByAddress(address);
	if(!element){
		DKERROR("DKRocketJS::setAttribute(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	element->SetAttribute(attribute.c_str(), value.c_str());
	duk_push_boolean(ctx, true);
	return true;
}

////////////////////////////////////////////////////////
int DKRocketJS::getElementsByClassName(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString name = duk_require_string(ctx, 0);
	Rocket::Core::ElementList elements;
	DKRocket::Get()->document->GetElementsByClassName(elements, name.c_str());
	if(elements.empty()){ return true; }
	DKString str;
	for(unsigned int i=0; i<elements.size(); i++){
		const void * address = static_cast<const void*>(elements[i]);
		std::stringstream ss;
		ss << address;  
		str += ss.str(); 
		if(i < elements.size()-1){ str += ","; }
	}
	duk_push_string(ctx, str.c_str());
	return true;
}

//////////////////////////////////////////////////////
int DKRocketJS::getElementsByTagName(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString name = duk_require_string(ctx, 0);
	Rocket::Core::ElementList elements;
	DKRocket::Get()->document->GetElementsByTagName(elements, name.c_str());
	if(same(name, "body")){
		elements.push_back(DKRocket::Get()->document->GetFirstChild()->GetParentNode()); //body tag
	}
	DKString str;
	for(unsigned int i=0; i<elements.size(); i++){
		const void * address = static_cast<const void*>(elements[i]);
		std::stringstream ss;
		ss << address;  
		str += ss.str(); 
		if(i < elements.size()-1){ str += ","; }
	}
	duk_push_string(ctx, str.c_str());
	return true;
}

///////////////////////////////////////////////////////////////////////////////
Rocket::Core::Element* DKRocketJS::getElementByAddress(const DKString& address)
{
	DKDEBUGFUNC(address);
	Rocket::Core::Element* body = DKRocket::Get()->document->GetElementById("body"); //TEST: This needs to be recursive
	Rocket::Core::ElementList elements;
	GetElements(body, elements);
	for(unsigned int i=0; i<elements.size(); i++){
		const void * addr = static_cast<const void*>(elements[i]);
		std::stringstream ss;
		ss << addr;  
		DKString str = ss.str(); 
		if(same(address, str)){
			return elements[i];
		}
	}
	DKERROR("DKRocketJS::getElementByAddress("+address+"): element not found\n");
	return NULL;
}

////////////////////////////////////////////////////////////////////////////////////////////////
bool DKRocketJS::GetElements(Rocket::Core::Element* parent, Rocket::Core::ElementList& elements)
{
	DKDEBUGFUNC(parent, "DKElementList&");
	if(!parent){ return false; }
	typedef std::queue<Rocket::Core::Element*> SearchQueue;
	SearchQueue search_queue;

	elements.push_back(DKRocket::Get()->document->GetFirstChild()->GetParentNode()); //add the body tag first
	for(int i = 0; i < parent->GetNumChildren(); ++i)
		search_queue.push(parent->GetChild(i));

	while(!search_queue.empty()){
		Rocket::Core::Element* element = search_queue.front();
		search_queue.pop();

		if(!has(element->GetTagName().CString(), "#")){
			elements.push_back(element);
		}

		// Add all children to search.
		for (int i = 0; i < element->GetNumChildren(); i++){
			search_queue.push(element->GetChild(i));
		}
	}
	return true;
}

/////////////////////////////////////////////
int DKRocketJS::setProperty(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString propertyName = duk_require_string(ctx, 1);
	DKString propertyValue = duk_require_string(ctx, 2);
	//DKString priority = duk_require_string(ctx, 3); //TODO

	Rocket::Core::Element* element = getElementByAddress(address);
	if(!element){
		DKERROR("DKRocketJS::setProperty(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	element->SetProperty(propertyName.c_str(), propertyValue.c_str());
	return true;
}

///////////////////////////////////////////////////
int  DKRocketJS::getPropertyValue(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString propertyName = duk_require_string(ctx, 1);
	Rocket::Core::Element* element = getElementByAddress(address);
	if(!element){
		DKERROR("DKRocketJS::getPropertyValue(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	const Rocket::Core::Property* prop = element->GetProperty(propertyName.c_str());
	if(!prop){ 
		DKERROR("DKRocketJS::getPropertyValue(): prop is invalid\n");
		duk_push_boolean(ctx, false);
		return true; 
	}
	DKString propertyValue = element->GetProperty(propertyName.c_str())->ToString().CString();
	duk_push_string(ctx, propertyValue.c_str());
	return true;
}

///////////////////////////////////////////
int DKRocketJS::innerHTML(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rocket::Core::Element* element = getElementByAddress(address);
	if(!element){
		DKERROR("DKRocketJS::innerHTML(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	DKString innerHtml = element->GetInnerRML().CString();
	if(innerHtml.empty()){ return true; }
	duk_push_string(ctx, innerHtml.c_str());
	return true;
}

//////////////////////////////////////////////
int DKRocketJS::setInnerHTML(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString innerHTML = duk_require_string(ctx, 1);
	Rocket::Core::Element* element = getElementByAddress(address);
	if(!element){
		DKERROR("DKRocketJS::innerHTML(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	element->SetInnerRML(innerHTML.c_str());
	return true;
}

#endif //USE_DKDuktape