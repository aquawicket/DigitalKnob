#pragma once
#ifndef DKOSGStats_H
#define DKOSGStats_H
#include "DK.h"

#include <osg/ref_ptr>
#include <osgViewer/Viewer>
#include <osgViewer/ViewerEventHandlers>

/////////////////////////////////////////
class DKOSGStats : public DKObjectT<DKOSGStats> 
{
public:
	void Init();
	void End();
	void Toggle();

private:
	osg::ref_ptr<osgViewer::StatsHandler> stats;
};


REGISTER_OBJECT(DKOSGStats, true);

#endif //DKOSGStats_H
