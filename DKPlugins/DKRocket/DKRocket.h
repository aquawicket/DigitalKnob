#pragma once
#ifndef DKRocket_H
#define DKRocket_H

#include <Rocket/Core/Core.h>
#include <Rocket/Controls/Controls.h>
#include <Rocket/Core/ElementUtilities.h>
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

	bool LoadFont(const DKString& file);
	bool LoadFonts();
	bool LoadUrl(const DKString& url);
	bool RegisterEvent(const DKString& id, const DKString& type);
	bool Reload();
	bool SendEvent(const DKString& id, const DKString& type, const DKString& value);
	bool ToggleDebugger();
	bool UnregisterEvent(const DKString& id, const DKString& type);	
	void ProcessEvent(Rocket::Core::Event& event); //overwritten 
	Rocket::Core::Element* getElementByAddress(const DKString& address);
	bool GetElements(Rocket::Core::Element* parent, Rocket::Core::ElementList& elements);

	DKString _url;
	DKString _path;
	Rocket::Core::Context* context;
	Rocket::Core::ElementDocument* document;
	static DKRocketFile* dkRocketFile;
	Rocket::Core::Element* hover;

	DKRocketToRML dkRocketToRML;
};

REGISTER_OBJECT(DKRocket, true)
#endif //DKRocket_H

