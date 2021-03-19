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
    DKString file = DKFile::local_assets+"/"+data[1];

	//https://stackoverflow.com/a/3141107/688352
	/*
	const Rml::StyleSheet* current_sheet = dkRml->document->GetStyleSheet();
	Rml::SharedPtr<Rml::StyleSheetContainer> file_sheet = Rml::Factory::InstanceStyleSheetFile(file.c_str());
	Rml::SharedPtr<Rml::StyleSheetContainer> new_sheet = file_sheet->CombineStyleSheetContainer((const Rml::StyleSheetContainer&)current_sheet);
	dkRml->document->GetOwnerDocument()->SetStyleSheetContainer(std::move(new_sheet));
	*/

	//Load user agent style sheet
	const Rml::StyleSheet* current_sheet = dkRml->document->GetStyleSheet();
	Rml::SharedPtr<Rml::StyleSheetContainer> file_sheet = Rml::Factory::InstanceStyleSheetFile(file.c_str());
	if (current_sheet) { //Combine the file_sheet to the current sheet
		Rml::SharedPtr<Rml::StyleSheetContainer> new_sheet = file_sheet->CombineStyleSheetContainer((const Rml::StyleSheetContainer&)current_sheet);
		dkRml->document->GetOwnerDocument()->SetStyleSheetContainer(std::move(new_sheet));
	}
	else { //no current sheet, just load the file sheet
		dkRml->document->GetOwnerDocument()->SetStyleSheetContainer(std::move(file_sheet));
	}
	
	return true;
}

/////////////////
bool DKCss::End()
{
	DKDEBUGFUNC();
	return true;
}