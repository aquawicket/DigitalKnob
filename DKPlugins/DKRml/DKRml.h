#pragma once
#ifndef DKRml_H
#define DKRml_H

#include <RmlUi/Core.h>
#include <RmlUi/Controls.h>
//#include <RmlUi/Core/ElementUtilities.h>
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

	bool LoadFont(const DKString& file);
	bool LoadFonts();
	bool LoadUrl(const DKString& url);
	bool LoadHtml(const DKString& url);
	bool RegisterEvent(const DKString& id, const DKString& type);
	bool Reload();
	bool SendEvent(const DKString& id, const DKString& type, const DKString& value);
	bool ToggleDebugger();
	bool UnregisterEvent(const DKString& id, const DKString& type);	
	void ProcessEvent(Rml::Core::Event& event); //overwritten 
	Rml::Core::Element* getElementByAddress(const DKString& address);
	bool GetElements(Rml::Core::Element* parent, Rml::Core::ElementList& elements);

	DKString href;
	DKString protocol;
	DKString _path;
	Rml::Core::Context* context;
	Rml::Core::ElementDocument* document;
	static DKRmlFile* dkRmlFile;
	Rml::Core::Element* hover;

	DKRmlToRML dkRmlToRML;
};

REGISTER_OBJECT(DKRml, true)
#endif //DKRml_H

