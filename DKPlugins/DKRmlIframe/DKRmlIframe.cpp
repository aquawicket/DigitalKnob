#include "DK/stdafx.h"
#include "DKRmlIframe/DKRmlIframe.h"
//include "DKRMLIframe/DKRmlIframeInstancer.h"
#include "../include/RmlUi/Core/ElementInstancer.h"
#include "../source/Core/Elements/ElementImage.h"
//TODO 

///////////////////////////
bool DKRocketIframe::Init()
{
	DKDEBUGFUNC();
	auto custom_instancer = std::make_unique< Rml::ElementInstancerGeneric< Rml::ElementIframe > >();
	Rml::Factory::RegisterElementInstancer("iframe", custom_instancer.get());

	return true;
}

//////////////////////////
bool DKRocketIframe::End()
{
	DKDEBUGFUNC();
	return true;
}