#include "stdafx.h"
#include "DKCss.h"
#include "DKFile.h"
#include "Rocket/Core/Factory.h"

DKRocket* DKCss::dkRocket;

/////////////////////////
void DKCss::Init()
{
	DKLog("DKCss::Init()\n", DKDEBUG);

	//link objects
	dkRocket = DKRocket::Get("DKRocket0");
	if(!dkRocket){
		DKLog("DKWidget::Init(): INVALID OBJECTS \n", DKERROR);
		return;
	}

	//data = ("DKCss", file)
	if(data.size() < 2){
		DKString _data = toString(data, ",");
		DKLog("DKCss::Init("+_data+"): missing parameters. \n", DKERROR);
	}
	if(data.size() > 2){
		DKString _data = toString(data, ",");
		DKLog("DKCss::Init("+_data+"): too many parameters. \n", DKERROR);
	}
	
    DKString file = DKFile::local_assets+data[1];

	DKString string;
	DKFile::FileToString(file, string);

	// Method 1 - Not Working
	/*
	Rocket::Core::StyleSheet* current_sheet = dkRocket->GetDocument()->GetStyleSheet();
	Rocket::Core::StyleSheet* new_sheet = Rocket::Core::Factory::InstanceStyleSheetFile(file.c_str());
	//Rocket::Core::StyleSheet* new_sheet = Rocket::Core::Factory::InstanceStyleSheetString(string.c_str());
	current_sheet->CombineStyleSheet(new_sheet);
	dkRocket->GetDocument()->SetStyleSheet(current_sheet);
	//Rocket::Core::Factory::ClearStyleSheetCache();
	*/


	// Method 2 - Not Working
	/*
	replace(file, DKFile::local_assets, "");
	Rocket::Core::Element* link = dkRocket->context->GetDocument(0)->CreateElement("link");
	link->SetAttribute("rel", "stylesheet");
	link->SetAttribute("type", "text/css");
	link->SetAttribute("id", file.c_str());
	link->SetAttribute("href", file.c_str());
	Rocket::Core::Element* body = dkRocket->GetDocument();
	body->AppendChild(link, true);
	*/
}

////////////////////////
void DKCss::End()
{
	DKLog("DKCss::End()\n", DKDEBUG);
}