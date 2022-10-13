#pragma once
#ifndef DKOSGRml_H
#define DKOSGRml_H
#include "DKOSGViewer/DKOSGViewer.h"
#include "DKOSGWindow/DKOSGWindow.h"
#include "DKRml/DKRml.h"
#include "DKOSGRml/DKOSGRmlGui.h"
#include "DKOSGRml/DKOSGRmlSystem.h"
#include "DK/DKEvents.h"

class DKOSGRml : public DKObjectT<DKOSGRml>
{
public:
	bool Init();
	bool End();
	
	bool SetupRml();
	void OnResize(DKEvent* event);

	DKOSGViewer* dkOsgViewer;
	DKOSGWindow* dkOsgWindow;
	DKRml* dkRml;
	DKRmlGuiNode* guinode;
	static DKOSGRmlRender* guirender;
	static DKOSGRmlSystem* guisystem;
	osg::ref_ptr<osg::Camera> guicam;
};

REGISTER_OBJECT(DKOSGRml, true)
#endif //DKOSGRml_H
