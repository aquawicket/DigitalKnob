#pragma once
#ifndef DKOSGRocket_H
#define DKOSGRocket_H
#include "DKOSGViewer.h"
#include "DKOSGWindow.h"
#include "DKRocket.h"
#include "DKOSGRocketGui.h"
#include "DKOSGRocketSystem.h"
#include "DKEvent.h"

/////////////////////////////////////////////////
class DKOSGRocket : public DKObjectT<DKOSGRocket>
{
public:
	void Init();
	void End();
	
	bool SetupRocket();
	void OnResize(DKEvent* event);

	DKOSGViewer* dkOsgViewer;
	DKOSGWindow* dkOsgWindow;
	DKRocket* dkRocket;
	DKRocketGuiNode* guinode;
	static DKOSGRocketRender* guirender;
	static DKOSGRocketSystem* guisystem;
	osg::ref_ptr<osg::Camera> guicam;
};


REGISTER_OBJECT(DKOSGRocket, true)
#endif //DKOSGRocket_H