#include "DK/stdafx.h"
#include "DKOSGStats.h"
#include "DKOSGWindow.h"

////////////////////
void DKOSGStats::Init()
{
//#ifdef USE_osgText
	stats = new osgViewer::StatsHandler();
	DKOSGWindow::Instance("DKOSGWindow")->view->addEventHandler(stats);
#ifndef ANDROID
	stats->setKeyEventTogglesOnScreenStats(osgGA::GUIEventAdapter::KEY_F1);
#endif
#ifdef USE_SHADERS
	DKLog("Warning: osgViewer::StatsHandler is enabled, but no shaders for it.");
#endif //USE_SHADERS
//#endif
}

///////////////////
void DKOSGStats::End()
{
	//DKOSGWindow::Instance("DKOSGWindow")->view->removeEventHandler(stats);
	stats = NULL;
}

//////////////////////
void DKOSGStats::Toggle()
{
	
}