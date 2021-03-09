#include "DK/stdafx.h"
#include "Rocket/Core/Factory.h"
#include "DK/DKFile.h"
#include "DKRocket/DKRocketCss.h"

DKRocket* DKRocketCss::dkRocket;

//////////////////
bool DKRocketCss::Init()
{
	DKDEBUGFUNC();
	dkRocket = DKRocket::Get();
	if(!dkRocket){
		DKERROR("DKRocketCss::Init(): INVALID OBJECTS\n");
		return false;
	}

	//data = ("DKRocketCss", file)
	if(data.size() < 2){
		DKString _data = toString(data, ",");
		DKERROR("DKRocketCss::Init("+_data+"): missing parameters\n");
	}
	if(data.size() > 2){
		DKString _data = toString(data, ",");
		DKERROR("DKRocketCss::Init("+_data+"): too many parameters\n");
	}
	
	replace(data[1], DKFile::local_assets, "");
    DKString file = DKFile::local_assets+"/"+data[1];

	Rocket::Core::StyleSheet* current_sheet = dkRocket->document->GetStyleSheet();
	Rocket::Core::StyleSheet* new_sheet = Rocket::Core::Factory::InstanceStyleSheetFile(file.c_str());
	current_sheet = current_sheet->CombineStyleSheet(new_sheet);
	dkRocket->document->SetStyleSheet(current_sheet);
	return true;
}

/////////////////
bool DKRocketCss::End()
{
	DKDEBUGFUNC();
	return true;
}