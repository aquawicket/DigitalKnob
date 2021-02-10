#include "DK/stdafx.h"
#include "RmlUi/Core/Factory.h"
#include "DK/DKFile.h"
#include "DKRml/DKCss.h"

DKRml* DKCss::dkRml;

//////////////////
bool DKCss::Init()
{
	DKDEBUGFUNC();
	dkRml = DKRml::Get();
	if(!dkRml){
		DKERROR("DKCss::Init(): INVALID OBJECTS\n");
		return false;
	}

	//data = ("DKCss", file)
	if(data.size() < 2){
		DKString _data = toString(data, ",");
		DKERROR("DKCss::Init("+_data+"): missing parameters\n");
	}
	if(data.size() > 2){
		DKString _data = toString(data, ",");
		DKERROR("DKCss::Init("+_data+"): too many parameters\n");
	}
	
	replace(data[1], DKFile::local_assets, "");
    DKString file = DKFile::local_assets+data[1];

	//Rml::SharedPtr<Rml::StyleSheet> current_sheet = dkRml->document->GetStyleSheet(); //old
	Rml::SharedPtr<Rml::StyleSheetContainer> current_sheet = dkRml->document->GetStyleSheetContainer();
	//Rml::SharedPtr<Rml::StyleSheet> new_sheet = Rml::Factory::InstanceStyleSheetFile(file.c_str()); //old
	Rml::SharedPtr<Rml::StyleSheetContainer> new_sheet = Rml::Factory::InstanceStyleSheetFile(file.c_str());
	//current_sheet = current_sheet->CombineStyleSheet(*new_sheet); //old
	current_sheet = current_sheet->CombineStyleSheetContainer(*new_sheet);
	dkRml->document->SetStyleSheetContainer(current_sheet);
	return true;
}

/////////////////
bool DKCss::End()
{
	DKDEBUGFUNC();
	return true;
}