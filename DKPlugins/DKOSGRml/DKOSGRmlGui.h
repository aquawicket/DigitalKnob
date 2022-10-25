#pragma once
#ifndef DKOSGRmlGui_H
#define DKOSGRmlGui_H

#include "DK/DKLog.h"
#include <RmlUi/Core.h>
#include <RmlUi/Debugger.h>
#include <DKOSGRml/DKOSGRmlRender.h>
#include <osg/Group>
#include <osgViewer/View>

//typedef Rml::Element DKElement;
//typedef Rml::Property DKProperty;
//typedef Rml::EventListener DKListener;
typedef Rml::ElementDocument DKElementDocument;
//typedef Rml::ElementList DKElementList;
//typedef Rml::Event Rml::Core::Event;
//typedef Rml::ElementUtilities DKElementUtilities;
//typedef Rml::String DKCString;

class DKRmlEventListener : public Rml::EventListener
{
public:
	DKRmlEventListener(Rml::Element* rootelem);
	~DKRmlEventListener();
	virtual void ProcessEvent(Rml::Event& ev);

	Rml::Element* _rootElement;
    bool _keys_handled;
    bool _mouse_handled;
};


class DKRmlGuiNode : public osg::Group //A node for rendering a libRml GUI in OpenSceneGraph.
{
typedef osg::Group BaseClass;
public:
    /**
    * @param contextname Unique string identifying the gui node context
    * @param renderer Access to renderer interface singleton
    * @param debug Set to true to add libRml debug gui
    */
	DKRmlGuiNode(const std::string& contextname, bool debug = false);
	~DKRmlGuiNode();
	virtual bool handle(const osgGA::GUIEventAdapter& ea, const osg::NodePath& np, osgGA::GUIActionAdapter& aa);
    
    Rml::Context* getContext() { return _context; } // get libRml context of this gui
    virtual void traverse(osg::NodeVisitor& nv); // traversal handler for injecting time into libRml
    Rml::Input::KeyIdentifier GetKeyCode(int osgkey); //transform osg key to libRml key
    int GetKeyModifiers(int osgModKeyMask); // transform key modifiers from osg to libRml
    int GetButtonId(int button); // transform from osg button to libRml button
    void setCamera(osg::Camera* cam); // Set this if libRml gui should render to a fullscreen camera.
    osgGA::GUIEventHandler* GetGUIEventHandler() const { return mGUIEventHandler; }

    void setScreenSize(int w, int h); // update view matrix and resize libRml screen dimensions

//private:
    // Transform osg mouse position into libRml screen coordinates
    void mousePosition(osgViewer::View* view, const osgGA::GUIEventAdapter& ea, const osg::NodePath& nodePath, int& x, int &y);
    unsigned int _previousTraversalNumber; // number of last frame so we don't update multiple times per frame
	DKOSGRmlRender* _renderer; // DKRml render interface singleton  
    Rml::Context* _context; // context of this gui (one per gui)
	DKRmlEventListener* _contextEventListener;
    osg::ref_ptr<osg::Camera> _camera; // camera to render to (can be NULL)
    osg::ref_ptr<osgGA::GUIEventHandler> mGUIEventHandler;
};

class GUIEventHandler : public osgGA::GUIEventHandler
{
	DKRmlGuiNode* mGUINode;
public:
	GUIEventHandler(DKRmlGuiNode* node);
	virtual bool handle(const osgGA::GUIEventAdapter& ea, osgGA::GUIActionAdapter& aa, osg::Object*, osg::NodeVisitor* nv);
};

#endif //DKOSGRmlGui_H
