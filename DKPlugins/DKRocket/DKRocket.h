#pragma once
#ifndef DKRocket_H
#define DKRocket_H

#include <Rocket/Core.h>
#include <Rocket/Controls.h>
#include "DK/DK.h"
#include "DKWindow/DKWindow.h"
#include "DKRocket/DKRocketFile.h"
#include "DKRocket/DKRocketToRML.h"

///////////////////////////////////////////////////////////////////////////////
class DKRocket : public Rocket::Core::EventListener, public DKObjectT<DKRocket>
{
public:
	bool Init();
	bool End();

	Rocket::Core::Element* addressToElement(const DKString& address);
	DKString elementToAddress(Rocket::Core::Element* element);
	bool GetElements(Rocket::Core::Element* parent, Rocket::Core::ElementList& elements);
	bool LoadFont(const DKString& file);
	bool LoadFonts();
	bool LoadHtml(const DKString& url);
	bool LoadUrl(const DKString& url);
	bool RegisterEvent(const DKString& elementAddress, const DKString& type);
	bool Reload();
	bool SendEvent(const DKString& elementAddress, const DKString& type, const DKString& value);
	bool ToggleDebugger();
	bool UnregisterEvent(const DKString& elementAddress, const DKString& type);
	void ProcessEvent(Rocket::Core::Event& event); //overwritten

	DKString href;
	DKString protocol;
	DKString _path;
	DKString workingPath;
	Rocket::Core::Context* context;
	Rocket::Core::ElementDocument* document;
	static DKRocketFile* dkRocketFile;
	Rocket::Core::Element* hover;

	DKRocketToRML dkRocketToRML;
};

REGISTER_OBJECT(DKRocket, true)
#endif //DKRocket_H

