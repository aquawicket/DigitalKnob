//#ifdef USE_osgFX
#pragma once
#ifndef DKOSGPicker_H
#define DKOSGPicker_H

#include "DK.h"
#include <osgViewer/ViewerEventHandlers>
#include <osgFX/Outline>


////////////////////////////////////////////////////////////////////////////////
class DKOSGPicker : public osgGA::GUIEventHandler, public DKObjectT<DKOSGPicker> 
{
public:
	void Init();
	
	~DKOSGPicker();

private:
    bool handle(const osgGA::GUIEventAdapter& ea,osgGA::GUIActionAdapter& aa);
    void pick(osgViewer::View* view, const osgGA::GUIEventAdapter& ea);
	void remove(osgViewer::View* view, const osgGA::GUIEventAdapter& ea);
    void setLabel(const DKString& name);
	osg::ref_ptr<osgFX::Outline> outline;
    osg::ref_ptr<osgText::Text> _updateText;
};


REGISTER_OBJECT(DKOSGPicker, true);

#endif //DKOSGPicker_H
//#endif //USE_osgFX