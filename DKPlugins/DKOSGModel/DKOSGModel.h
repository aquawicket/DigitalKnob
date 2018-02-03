#pragma once
#ifndef DKOSGModel_H
#define DKOSGModel_H
#include "DK.h"
#include <osg/Referenced>
#include "DKOSGWindow.h"


/////////////////////////////////////////
class DKOSGModel : public DKObjectT<DKOSGModel>
{
public:
	bool Init();
	bool End();

	bool Create(DKOSGWindow* window, osg::Group* theRoot, const DKString& file, osg::Vec3 pos);
	osg::ref_ptr<osg::Node> modelNode;
	osg::Group* theRoot;
};


REGISTER_OBJECT(DKOSGModel, false);
#endif //DKOSGModel_H