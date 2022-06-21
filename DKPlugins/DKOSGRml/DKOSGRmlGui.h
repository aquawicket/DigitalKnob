#pragma once
#ifndef DKOSGRocketGui_H
#define DKOSGRocketGui_H

#include "DKLog.h"
#include <Rocket/Core/Core.h>
#include <Rocket/Debugger/Debugger.h>
#include <DKOSGRocketRender.h>
#include <osg/Group>
#include <osgViewer/View>

//typedef Rocket::Core::Element DKElement;
//typedef Rocket::Core::Property DKProperty;
//typedef Rocket::Core::EventListener DKListener;
typedef Rocket::Core::ElementDocument DKElementDocument;
//typedef Rocket::Core::ElementList DKElementList;
//typedef Rocket::Core::Event Rocket::Core::Event;
//typedef Rocket::Core::ElementUtilities DKElementUtilities;
//typedef Rocket::Core::String DKCString;

class DKRocketEventListener : public Rocket::Core::EventListener
{
public:
	DKRocketEventListener(Rocket::Core::Element* rootelem);
	~DKRocketEventListener();
	virtual void ProcessEvent(Rocket::Core::Event& ev);

	Rocket::Core::Element* _rootElement;
    bool _keys_handled;
    bool _mouse_handled;
};


class DKRocketGuiNode : public osg::Group //A node for rendering a libRocket GUI in OpenSceneGraph.
{
typedef osg::Group BaseClass;
public:
    /**
    * @param contextname Unique string identifying the gui node context
    * @param renderer Access to renderer interface singleton
    * @param debug Set to true to add libRocket debug gui
    */
	DKRocketGuiNode(const std::string& contextname, bool debug = false);
	~DKRocketGuiNode();
	virtual bool handle(const osgGA::GUIEventAdapter& ea, const osg::NodePath& np, osgGA::GUIActionAdapter& aa);
    
    Rocket::Core::Context* getContext() { return _context; } // get libRocket context of this gui
    virtual void traverse(osg::NodeVisitor& nv); // traversal handler for injecting time into libRocket
    Rocket::Core::Input::KeyIdentifier GetKeyCode(int osgkey); //transform osg key to libRocket key
    int GetKeyModifiers(int osgModKeyMask); // transform key modifiers from osg to libRocket
    int GetButtonId(int button); // transform from osg button to libRocket button
    void setCamera(osg::Camera* cam); // Set this if libRocket gui should render to a fullscreen camera.
    osgGA::GUIEventHandler* GetGUIEventHandler() const { return mGUIEventHandler; }

    void setScreenSize(int w, int h); // update view matrix and resize libRocket screen dimensions

//private:
    // Transform osg mouse position into libRocket screen coordinates
    void mousePosition(osgViewer::View* view, const osgGA::GUIEventAdapter& ea, const osg::NodePath& nodePath, int& x, int &y);
    unsigned int _previousTraversalNumber; // number of last frame so we don't update multiple times per frame
	DKOSGRocketRender* _renderer; // DKRocket render interface singleton  
    Rocket::Core::Context* _context; // context of this gui (one per gui)
	DKRocketEventListener* _contextEventListener;
    osg::ref_ptr<osg::Camera> _camera; // camera to render to (can be NULL)
    osg::ref_ptr<osgGA::GUIEventHandler> mGUIEventHandler;
};

class GUIEventHandler : public osgGA::GUIEventHandler
{
	DKRocketGuiNode* mGUINode;
public:
	GUIEventHandler(DKRocketGuiNode* node);
	virtual bool handle(const osgGA::GUIEventAdapter& ea, osgGA::GUIActionAdapter& aa, osg::Object*, osg::NodeVisitor* nv);
};

#endif //DKOSGRocketGui_H
