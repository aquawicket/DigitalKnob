#ifndef HEADINSTANCER_H
#define HEADINSTANCER_H

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