#include "DK/stdafx.h"
#include "DKRmlIframe/DKRmlIframe.h"
#include "DKRmlIframe/ElementIframe.h"
#include "DKRMLIframe/ElementIframeInstancer.h"
//#include "../include/RmlUi/Core/ElementInstancer.h"


bool DKRmlIframe::Init()
{
	DKDEBUGFUNC();
	auto iframe_instancer = std::make_unique<ElementIframeInstancer>();
	Rml::Factory::RegisterElementInstancer("iframe", iframe_instancer.get());
	return true;
}

bool DKRmlIframe::End()
{
	DKDEBUGFUNC();
	return true;
}