#include "DK/stdafx.h"
#include "DKRmlDKElement/DKRmlDKElement.h"

#include "../include/RmlUi/Core/Factory.h"

bool DKRmlDKElement::Init(){
	DKDEBUGFUNC();
	ref = std::make_unique<DKRmlDKElementInstancer>(); // Make sure custom_instancer is kept alive until after the call to Rml::Shutdown
	Rml::Factory::RegisterElementInstancer("dkimage", ref.get());
	return true;
}

bool DKRmlDKElement::End(){
	DKDEBUGFUNC();
	return true;
}