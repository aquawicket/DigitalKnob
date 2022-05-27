#include "DK/stdafx.h"
#include "DKRmlElement/DKRmlElement.h"
#include "../include/RmlUi/Core/Factory.h"

bool DKRmlElement::Init(){
	DKDEBUGFUNC();
	ref = std::make_unique<RmlElementInstancer>(); // Make sure custom_instancer is kept alive until after the call to Rml::Shutdown
	Rml::Factory::RegisterElementInstancer("dkrmlelement", ref.get());
	return true;
}

bool DKRmlElement::End(){
	DKDEBUGFUNC();
	return true;
}