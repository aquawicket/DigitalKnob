#include "stdafx.h"
#include "DKCss.h"
#include "DKFile.h"
#include "Rocket/Core/Factory.h"

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
	Rocket::Core::StyleSheet* style_sheet = Rocket::Core::Factory::InstanceStyleSheetFile(file.c_str());

	//TODO - add the stylesheet to the rocket context
	//dkRocket->context->GetDocument(0)->
}

////////////////////////
void DKCss::End()
{
	DKLog("DKCss::End()\n", DKDEBUG);
}