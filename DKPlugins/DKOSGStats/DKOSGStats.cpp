#include "DK/stdafx.h"
#include "DKOSGStats/DKOSGStats.h"
#include "DKOSGWindow/DKOSGWindow.h"

bool DKOSGStats::Init(){
//#ifdef USE_osgText
	stats = new osgViewer::StatsHandler();
	DKOSGWindow::Instance("DKOSGWindow")->view->addEventHandler(stats);
#ifndef ANDROID
	stats->setKeyEventTogglesOnScreenStats(osgGA::GUIEventAdapter::KEY_F1);
#endif
#ifdef USE_SHADERS
	DKLog("Warning: osgViewer::StatsHandler is enabled, but no shaders for it.");
#endif //USE_SHADERS
	return true;
//#endif
}

bool DKOSGStats::End(){
	//DKOSGWindow::Instance("DKOSGWindow")->view->removeEventHandler(stats);
	stats = NULL;
	return true;
}

bool DKOSGStats::Toggle(){
	// TODO
	return DKERROR("not implemented \n");
}