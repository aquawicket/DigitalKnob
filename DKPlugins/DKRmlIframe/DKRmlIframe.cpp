#include "DK/stdafx.h"
#include "DKRmlIframe/DKRmlIframe.h"
#include "DKRmlIframe/ElementIframe.h"
//include "DKRMLIframe/DKRmlIframeInstancer.h"
#include "../include/RmlUi/Core/ElementInstancer.h"


bool DKRmlIframe::Init()
{
	DKDEBUGFUNC();
	auto iframe_instancer = std::make_unique< Rml::ElementInstancerGeneric< Rml::ElementIframe > >();
	Rml::Factory::RegisterElementInstancer("iframe", iframe_instancer.get());
	return true;
}

bool DKRmlIframe::End()
{
	DKDEBUGFUNC();
	return true;
}