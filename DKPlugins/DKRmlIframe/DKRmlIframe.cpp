#include "DK/stdafx.h"

#include "DKRmlIframe/DKRmlIframe.h"
#include "DKRMLIframe/ElementIframe.h"


bool DKRmlIframe::Init()
{
	DKDEBUGFUNC();
	// Make sure custom_instancer is kept alive until after the call to Rml::Shutdown
	//auto custom_instancer = std::make_unique<Rml::ElementIframeInstancer>();
	ref = std::make_unique<Rml::ElementIframeInstancer>();

	Rml::Factory::RegisterElementInstancer("iframe", ref.get());

	// Make sure custom_instancer is kept alive until after the call to Rml::Shutdown
	//auto custom_instancer = std::make_unique< Rml::ElementInstancerGeneric< Rml::ElementIframe > >();
	//Rml::Factory::RegisterElementInstancer("iframe", custom_instancer.get());


	return true;
}

bool DKRmlIframe::End()
{
	DKDEBUGFUNC();
	return true;
}