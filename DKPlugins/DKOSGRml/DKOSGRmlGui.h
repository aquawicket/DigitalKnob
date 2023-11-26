/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
#pragma once
#ifndef DKOSGRmlGui_H
#define DKOSGRmlGui_H

#include "DK/DKLog.h"
#include "DKOSGRml/DKOSGRmlRender.h"

//WARNING_DISABLE
#include <RmlUi/Core.h>
#include <RmlUi/Debugger.h>
#include <osg/Group>
#include <osgViewer/View>
//WARNING_ENABLE


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
