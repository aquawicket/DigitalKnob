#ifndef HEADINSTANCER_H
#define HEADINSTANCER_H

#include <RmlUi/Core/StringUtilities.h>
#include <RmlUi/Core/XMLParser.h>
#include <RmlUi/Core/SystemInterface.h>

#include "../../3rdParty/RmlUi-master/Source/Core/DocumentHeader.h"
//#include "TemplateCache.h"
#include <RmlUi/Core/Core.h>
#include <RmlUi/Core/Element.h>
#include <RmlUi/Core/ElementDocument.h>
#include <RmlUi/Core/URL.h>
#include <RmlUi/Core/Factory.h>
#include <RmlUi/Core/XMLNodeHandler.h>

class HeadInstancer : public Rml::XMLNodeHandler{
public:
	HeadInstancer();
	~HeadInstancer();

	/// Called when a new element start is opened
	Rml::Element* ElementStart(Rml::XMLParser* parser, const Rml::String& name, const Rml::XMLAttributes& attributes) override;
	/// Called when an element is closed
	bool ElementEnd(Rml::XMLParser* parser, const Rml::String& name) override;
	/// Called for element data
	bool ElementData(Rml::XMLParser* parser, const Rml::String& data, Rml::XMLDataType type) override;
};

#endif