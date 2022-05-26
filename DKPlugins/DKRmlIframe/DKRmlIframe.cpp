#include "DK/stdafx.h"
#include "DKRmlIframe/DKRmlIframe.h"

bool DKRmlIframe::Init(){
	DKDEBUGFUNC();
	ref = std::make_unique<ElementIframeInstancer>(); // Make sure custom_instancer is kept alive until after the call to Rml::Shutdown
	Rml::Factory::RegisterElementInstancer("iframe", ref.get());
	return true;
}

bool DKRmlIframe::End(){
	DKDEBUGFUNC();
	return true;
}