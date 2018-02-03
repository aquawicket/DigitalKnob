#pragma once
#ifndef DKRocket_H
#define DKRocket_H

#include <Rocket/Core/Core.h>
#include <Rocket/Controls/Controls.h>
#include <Rocket/Core/ElementUtilities.h>
#include "DK/DK.h"
#include "DKWindow/DKWindow.h"
#include "DKRocket/DKRocketFile.h"

///////////////////////////////////////////////////////////////////////////////
class DKRocket : public Rocket::Core::EventListener, public DKObjectT<DKRocket>
{
public:
	bool Init();
	bool End();

	bool ToggleDebugger();
	bool LoadGui(const DKString& file);
	bool Reload();
	bool LoadFonts();
	bool LoadFont(const DKString& file);
	bool RegisterEvent(const DKString& id, const DKString& type);
	bool UnregisterEvent(const DKString& id, const DKString& type);
	bool SendEvent(const DKString& id, const DKString& type, const DKString& value);
	void ProcessEvent(Rocket::Core::Event& event); //overwritten 

	Rocket::Core::Context* context;
	Rocket::Core::ElementDocument* document;
	static DKRocketFile* dkRocketFile;
	Rocket::Core::Element* hover;
};

REGISTER_OBJECT(DKRocket, true)
#endif //DKRocket_H

