#include "DK/stdafx.h"
#include "DKRmlIframe/DKRmlIframe.h"
#include "../Include/RmlUi/Core/Factory.h"

bool DKRmlIframe::Init(){
	DKDEBUGFUNC();
	ref = std::make_unique<RmlIframeInstancer>(); // Make sure custom_instancer is kept alive until after the call to Rml::Shutdown
	Rml::Factory::RegisterElementInstancer("iframe", ref.get());
	DKClass::DKCreate("DKCef");
	return true;
}

bool DKRmlIframe::End(){
	DKDEBUGFUNC();
	return true;
}