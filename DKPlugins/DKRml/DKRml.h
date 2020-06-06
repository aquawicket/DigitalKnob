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

	bool LoadFont(const DKString& file);
	bool LoadFonts();
	bool LoadHtml(const DKString& url);
	bool LoadUrl(const DKString& url);
	void ProcessEvent(Rml::Core::Event& rmlEvent); //overwritten
	bool RegisterEvent(const DKString& elementAddress, const DKString& type);
	bool SendEvent(const DKString& elementAddress, const DKString& type, const DKString& value);
	bool DebuggerOff();
	bool DebuggerOn();
	bool DebuggerToggle();
	bool UnregisterEvent(const DKString& elementAddress, const DKString& type);

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

