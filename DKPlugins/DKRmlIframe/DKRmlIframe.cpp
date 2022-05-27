#include "DK/stdafx.h"
#include "DKRmlIframe/DKRmlIframe.h"
#include "../include/RmlUi/Core/Factory.h"

bool DKRmlIframe::Init(){
	DKDEBUGFUNC();
	ref = std::make_unique<RmlIframeInstancer>(); // Make sure custom_instancer is kept alive until after the call to Rml::Shutdown
	Rml::Factory::RegisterElementInstancer("iframe", ref.get());
	return true;
}

bool DKRmlIframe::End(){
	DKDEBUGFUNC();
	return true;
}