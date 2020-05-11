//https://github.com/mikke89/RmlUi
//https://mikke89.github.io/RmlUiDoc/

#pragma once
#ifndef DKRml_H
#define DKRml_H

#include <RmlUi/Core.h>
#include <RmlUi/Controls.h>
#include "DK/DK.h"
#include "DKWindow/DKWindow.h"
#include "DKRml/DKRmlFile.h"
#include "DKRml/DKRmlToRML.h"

///////////////////////////////////////////////////////////////////////
class DKRml : public Rml::Core::EventListener, public DKObjectT<DKRml>
{
public:
	bool Init();
	bool End();

	Rml::Core::Element* addressToElement(const DKString& address);
	DKString elementToAddress(Rml::Core::Element* element);
	bool GetElements(Rml::Core::Element* parent, Rml::Core::ElementList& elements);
	bool LoadFont(const DKString& file);
	bool LoadFonts();
	bool LoadHtml(const DKString& url);
	bool LoadUrl(const DKString& url);
	bool RegisterEvent(const DKString& elementAddress, const DKString& type);
	bool Reload();
	bool SendEvent(const DKString& elementAddress, const DKString& type, const DKString& value);
	bool ToggleDebugger();
	bool UnregisterEvent(const DKString& elementAddress, const DKString& type);
	void ProcessEvent(Rml::Core::Event& event); //overwritten

	DKString href;
	DKString protocol;
	DKString _path;
	DKString workingPath;
	Rml::Core::Context* context;
	Rml::Core::ElementDocument* document;
	static DKRmlFile* dkRmlFile;
	Rml::Core::Element* hover;

	DKRmlToRML dkRmlToRML;
};

REGISTER_OBJECT(DKRml, true)
#endif //DKRml_H

