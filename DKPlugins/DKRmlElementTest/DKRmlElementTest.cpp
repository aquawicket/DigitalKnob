#include "DK/stdafx.h"
#include "DKRmlElementTest/DKRmlElementTest.h"

#include "../include/RmlUi/Core/Factory.h"

bool DKRmlElementTest::Init(){
	DKDEBUGFUNC();
	ref = std::make_unique<ElementIframeInstancer>(); // Make sure custom_instancer is kept alive until after the call to Rml::Shutdown
	Rml::Factory::RegisterElementInstancer("iframe", ref.get());
	return true;
}

bool DKRmlElementTest::End(){
	DKDEBUGFUNC();
	return true;
}