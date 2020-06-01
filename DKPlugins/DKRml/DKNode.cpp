#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRml/DKRml.h"
#include "DKRml/DKElement.h"
#include "DKRml/DKNode.h"


///////////////////
bool DKNode::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKNode_appendChild", DKNode::appendChild);
	DKDuktape::AttachFunction("DKNode_childNodes", DKNode::childNodes);
	DKDuktape::AttachFunction("DKNode_parentNode", DKNode::parentNode);
	DKDuktape::AttachFunction("DKNode_removeChild", DKNode::removeChild);
	
	DKClass::DKCreate("DKRml/DKNode.js");
	return true;
}

/////////////////////////////////////////
int DKNode::appendChild(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Core::Element* element = DKElement::addressToElement(address);
	if(!element){
		DKERROR("DKNode::appendChild(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	DKString childAddress = duk_require_string(ctx, 1);
	Rml::Core::Element* child = DKElement::addressToElement(childAddress);
	if(!child){
		DKERROR("DKNode::appendChild(): child invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	if(!element->AppendChild(child->GetParentNode()->RemoveChild(child), true)){
		DKERROR("DKNode::appendChild(): AppendChild failed\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	duk_push_string(ctx, childAddress.c_str());

	//post process if it's a link
	if(same("link", child->GetTagName())){ //.CString()
		if(child->HasAttribute("href")){
			DKRmlToRML dkRmlToRML;
			dkRmlToRML.PostProcess(child);
		}	
	}
	return true;
}

////////////////////////////////////////
int DKNode::childNodes(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Core::Element* element = DKElement::addressToElement(address);
	if(!element){
		DKERROR("DKNode::childNodes(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	int num = element->GetNumChildren();
	Rml::Core::ElementList elements;
	for(int i=0; i<num; i++){
		elements.push_back(element->GetChild(i));
	}
	if(elements.empty()){
		duk_push_null(ctx);
		return true;
	}
	DKString str;
	for(unsigned int i=0; i<elements.size(); i++){
		DKString elementAddress = DKElement::elementToAddress(elements[i]);
		str += elementAddress;
		if(i < elements.size()-1){ str += ","; }
	}
	duk_push_string(ctx, str.c_str());
	return true;
}

////////////////////////////////////////
int DKNode::parentNode(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Core::Element* element = DKElement::addressToElement(address);
	if(!element){
		DKERROR("DKNode::parentNode(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	Rml::Core::Element* parentNode = element->GetParentNode();
	if(!parentNode){
		DKERROR("DKNode::parentNode(): parentNode invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	DKString parentAddress = DKElement::elementToAddress(parentNode);
	duk_push_string(ctx, parentAddress.c_str());
	return true;
}

/////////////////////////////////////////
int DKNode::removeChild(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Core::Element* element = DKElement::addressToElement(address);
	if(!element){
		DKERROR("DKNode::removeChild(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	DKString childAddress = duk_require_string(ctx, 1);
	Rml::Core::Element* child = DKElement::addressToElement(childAddress);
	if(!child){
		DKERROR("DKNode::removeChild(): child invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//DKINFO("element->RemoveChild(child): " + element->GetTagName() + "->(" + child->GetTagName() + ")\n");
	if(!element->RemoveChild(child)){
		DKERROR("DKNode::removeChild(): element->RemoveChild failed\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	duk_push_string(ctx, childAddress.c_str());
	return true;
}

#endif //USE_DKDuktape