// https://github.com/mikke89/RmlUi
// https://mikke89.github.io/RmlUiDoc/

#pragma once
#ifndef DKRml_H
#define DKRml_H

#include <RmlUi/Core.h>
#include "DK/DK.h"
#include "DKWindow/DKWindow.h"
#include "DKRml/DKRmlFile.h"
#include "DKRml/DKRmlConverter.h"

class DKRml : public Rml::EventListener, public DKObjectT<DKRml> {
public:
	bool Init();
	bool End();
	bool LoadFont(const DKString& file);
	bool LoadFonts();
	bool LoadUrl(const DKString& url);
	bool LoadHtml(const DKString& html);
	void ProcessEvent(Rml::Event& rmlEvent); //overwritten
	bool RegisterEvent(const DKString& elementAddress, const DKString& type);
	bool SendEvent(const DKString& elementAddress, const DKString& type, const DKString& value);
	bool DebuggerOff();
	bool DebuggerOn();
	bool DebuggerToggle();
	bool UnregisterEvent(const DKString& elementAddress, const DKString& type);
	static Rml::Event* addressToEvent(const DKString& address);
	static DKString eventToAddress(Rml::Event* event);
	static Rml::Element* addressToElement(const DKString& address);
	static DKString elementToAddress(Rml::Element* element);
	DKString href;
	DKString protocol;
	DKString _path;
	DKString workingPath;
	Rml::Context* context;
	Rml::ElementDocument* document;
	static DKRmlFile* dkRmlFile;
	Rml::Element* hover;
	DKRmlConverter dkRmlConverter;
};

REGISTER_OBJECT(DKRml, true)
#endif //DKRml_H
