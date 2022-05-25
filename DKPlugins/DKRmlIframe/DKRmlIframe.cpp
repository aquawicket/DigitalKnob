#include "DK/stdafx.h"
#include "DKRmlIframe/DKRmlIframe.h"


bool DKRmlIframe::Init()
{
	DKDEBUGFUNC();
	auto iframe_instancer = std::make_unique<Rml::ElementIframeInstancer>();
	Rml::Factory::RegisterElementInstancer("iframe", iframe_instancer.get());
	return true;
}

bool DKRmlIframe::End()
{
	DKDEBUGFUNC();
	return true;
}