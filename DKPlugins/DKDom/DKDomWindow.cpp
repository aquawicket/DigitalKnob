//https://developer.mozilla.org/en-US/docs/Web/API/Window

#include "DKRml/DKRml.h"
#include "DKDom/DKDomWindow.h"
#include "DKDom/DKDomElement.h"


////////////////////////
bool DKDomWindow::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_devicePixelRatio", DKDomWindow::devicePixelRatio);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_innerHeight", DKDomWindow::innerHeight);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_innerWidth", DKDomWindow::innerWidth);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_name", DKDomWindow::name);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_addEventListener", DKDomWindow::addEventListener);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_removeEventListener", DKDomWindow::removeEventListener);
	
	DKClass::DKCreate("DKDom/DKDomWindow.js");
	
	return true;
}

///////////////////////////////////////////////////
int DKDomWindow::devicePixelRatio(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);

	//get
	if (!duk_is_number(ctx, 1)) {
		float ratio = DKRml::Get()->context->GetDensityIndependentPixelRatio();
		duk_push_number(ctx, ratio);
		return true;
	}
	//set
	float ratio = duk_require_number(ctx, 1);
	DKRml::Get()->context->SetDensityIndependentPixelRatio(ratio);
	return true;
}

//////////////////////////////////////////////
int DKDomWindow::innerHeight(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	int y = DKRml::Get()->context->GetDimensions().y;
	duk_push_int(ctx, y);
	return 1;
}

/////////////////////////////////////////////
int DKDomWindow::innerWidth(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	int x = DKRml::Get()->context->GetDimensions().x;
	duk_push_int(ctx, x);
	return 1;
}

///////////////////////////////////////
int DKDomWindow::name(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString name = DKRml::Get()->context->GetName();
	duk_push_string(ctx, name.c_str());
	return 1;
}

///////////////////////////////////////////////////
int DKDomWindow::addEventListener(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element;
	if(same(address,"document")){
		element = DKRml::Get()->document;
	}
	else{
		element = DKRml::addressToElement(address);
	}
	if(!element){
		DKERROR("DKDomWindow::addEventListener(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	DKString type = duk_require_string(ctx, 1);
	bool phase = false;
	if(duk_is_boolean(ctx, 2)){
		phase = duk_require_boolean(ctx, 2);
	}
	element->AddEventListener(type.c_str(), DKRml::Get(), phase);
	return true;
}

//////////////////////////////////////////////////////
int DKDomWindow::removeEventListener(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if(!element){
		DKERROR("DKDomWindow::removeEventListener(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	DKString type = duk_require_string(ctx, 1);
	bool phase = false;
	if(duk_is_boolean(ctx, 2)){
		phase = duk_require_boolean(ctx, 2);
	}
	element->RemoveEventListener(type.c_str(), DKRml::Get(), phase);
	return true;
}