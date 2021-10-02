#include "DK/stdafx.h"
#include "RmlUi/Core/Factory.h"
#include "DK/DKFile.h"
#include "DKRml/DKRmlCss.h"

DKRml* DKRmlCss::dkRml;

bool DKRmlCss::Init(){
	DKDEBUGFUNC();
	dkRml = DKRml::Get();
	if(!dkRml)
		return DKERROR("dkRml invalid\n");
	//data = ("DKRmlCss", file)
	if(data.size() < 2){
		DKString _data = toString(data, ",");
		DKERROR("data is missing parameters: data:("+_data+")\n");
	}
	if(data.size() > 2){
		DKString _data = toString(data, ",");
		DKERROR("data has too many parameters: data:("+_data+")\n");
	}
	replace(data[1], DKFile::local_assets, "");
	DKString file = DKFile::local_assets+data[1];
	//Load user agent style sheet
	const Rml::StyleSheetContainer* doc_sheet = dkRml->document->GetOwnerDocument()->GetStyleSheetContainer();
	Rml::SharedPtr<Rml::StyleSheetContainer> file_sheet = Rml::Factory::InstanceStyleSheetFile(file.c_str());
	if (doc_sheet) { //Combine the file_sheet to the current sheet
		Rml::SharedPtr<Rml::StyleSheetContainer> new_sheet = doc_sheet->CombineStyleSheetContainer(*file_sheet);
		dkRml->document->GetOwnerDocument()->SetStyleSheetContainer(std::move(new_sheet));
	}
	else //no current sheet, just load the file sheet
		dkRml->document->GetOwnerDocument()->SetStyleSheetContainer(std::move(file_sheet));
	return true;
}

bool DKRmlCss::End(){
	DKDEBUGFUNC();
	return true;
}
