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
#include "DK/stdafx.h"
#include "DKOSGRml/DKOSGRmlGui.h"
#include "DKOSGViewer/DKOSGViewer.h"
#include "DKOSGWindow/DKOSGWindow.h"
#include "DKRml/DKRml.h"

//WARNING_DISABLE
#include <osg/Notify>
#include <osg/TexMat>
#include <osg/TextureRectangle>
#include <osgGA/EventVisitor>
#include <osgViewer/View>
#include <OpenThreads/ScopedLock>
#include <sstream>
#include <osg/ShapeDrawable>
#include <iostream>
#include <assert.h>
//WARNING_ENABLE


DKRmlEventListener::DKRmlEventListener(Rml::Element* rootelem)
: _rootElement(rootelem), _keys_handled(false), _mouse_handled(false){

}

DKRmlEventListener::~DKRmlEventListener(){

}

void DKRmlEventListener::ProcessEvent(Rml::Event& ev){
	_keys_handled = _mouse_handled = false;
	DKString ele = ev.GetTargetElement()->GetId();
	if (ev.GetTargetElement() != _rootElement && !same(ele,"body"))
		_keys_handled = _mouse_handled = true;
	/*
    if(ev.GetTargetElement()->HasAttribute("passkeyevents"))
		_keys_handled = false;
    if(ev.GetTargetElement()->HasAttribute("passmouseevents"))
		_mouse_handled = false;
	*/
}



GUIEventHandler::GUIEventHandler(DKRmlGuiNode* node) : mGUINode(node){

}

bool GUIEventHandler::handle(const osgGA::GUIEventAdapter& ea, osgGA::GUIActionAdapter& aa, osg::Object*, osg::NodeVisitor* nv){
	DK_UNUSED(nv);
	osg::NodePath np;
    osg::NodePathList nodePaths = mGUINode->getParentalNodePaths();
    assert(!nodePaths.empty());
    return mGUINode->handle(ea, nodePaths.front(), aa); 
}

DKRmlGuiNode::DKRmlGuiNode(const std::string& contextname, bool debug)
    : _previousTraversalNumber(osg::UNINITIALIZED_FRAME_NUMBER)
    , _contextEventListener(NULL)
    , _camera(NULL)
    , mGUIEventHandler(new GUIEventHandler(this))
{
	DK_UNUSED(debug);
	_renderer = dynamic_cast<DKOSGRmlRender*>(Rml::GetRenderInterface());
    if(_renderer == NULL)
		DKERROR("GuiNode::GuiNode() _renderer invalid! \n");

    setDataVariance(osg::Object::STATIC);

    // if this is not set, osgViewer does not know how to set up initial camera transform:
    setInitialBound(osg::BoundingSphere(osg::Vec3(500, 500, 0), 500));

    // register for update traversal
    setNumChildrenRequiringUpdateTraversal(getNumChildrenRequiringUpdateTraversal() + 1);
    // register for update traversal
    //setNumChildrenRequiringEventTraversal(getNumChildrenRequiringEventTraversal() + 1);

    // create libRml context for this gui
	unsigned int width = DKOSGWindow::Get("DKOSGWindow0")->width;
	unsigned int height = DKOSGWindow::Get("DKOSGWindow0")->height;
	//osg::GraphicsContext::WindowingSystemInterface* wsi = osg::GraphicsContext::getWindowingSystemInterface();
    //if(wsi){ wsi->getScreenResolution(osg::GraphicsContext::ScreenIdentifier(0), width, height); }

    DKINFO("DKRmlGuiNode::DKRmlGuiNode() width="+toString(width)+" height="+toString(height)+" \n");
    
    _context = Rml::CreateContext(contextname.c_str(), Rml::Vector2i(width, height));
    if(_context != NULL){
		_contextEventListener = new DKRmlEventListener(_context->GetRootElement());
		_context->AddEventListener("keydown",     _contextEventListener);
		_context->AddEventListener("keyup",       _contextEventListener);
		_context->AddEventListener("mousedown",   _contextEventListener);
		_context->AddEventListener("mouseup",     _contextEventListener);
		_context->AddEventListener("mousescroll", _contextEventListener);
		_context->AddEventListener("mousemove",   _contextEventListener);
	}

    setCullingActive(false);
	osg::StateSet* ss = getOrCreateStateSet();
    ss->setRenderBinDetails(20000, "TraversalOrderBin");
    ss->setMode(GL_DEPTH_TEST, osg::StateAttribute::OFF);
}

DKRmlGuiNode::~DKRmlGuiNode(){
    if(_context)
		//_context->RemoveReference();
    delete _contextEventListener;
}

void DKRmlGuiNode::setCamera(osg::Camera* cam){
	_camera = cam;
    osgViewer::GraphicsWindow* win = dynamic_cast<osgViewer::GraphicsWindow*>(cam->getGraphicsContext());
    if(win){
		int x, y, w, h;
		win->getWindowRectangle(x, y, w, h);
        //DKLog("DKRmlGuiNode::setCamera() x="+toString(x)+" y="+toString(y)+" w="+toString(w)+" h="+toString(h)+" \n",DKINFO);
		setScreenSize(w, h);
    }
}

void DKRmlGuiNode::traverse(osg::NodeVisitor& nv){
	switch(nv.getVisitorType()){
		case osg::NodeVisitor::UPDATE_VISITOR:{
	        // ensure that we do not operate on this node more than
            // once during this traversal.  This is an issue since node
            // can be shared between multiple parents.
            if ((nv.getTraversalNumber( )!= _previousTraversalNumber) && nv.getFrameStamp()){
				if(_context != 0){
					_renderer->setRenderTarget(this, _context->GetDimensions().x, _context->GetDimensions().y, _camera != NULL);
					_context->Update();
					_context->Render();
				}
			}
		} 
        break;
        default: {}
	}
	osg::Group::traverse(nv);
}

Rml::Input::KeyIdentifier DKRmlGuiNode::GetKeyCode(int osgkey){
    switch(osgkey){
		case osgGA::GUIEventAdapter::KEY_Space : return Rml::Input::KI_SPACE;
	    case osgGA::GUIEventAdapter::KEY_0 : return Rml::Input::KI_0;
	    case osgGA::GUIEventAdapter::KEY_1 : return Rml::Input::KI_1;
	    case osgGA::GUIEventAdapter::KEY_2 : return Rml::Input::KI_2;
	    case osgGA::GUIEventAdapter::KEY_3 : return Rml::Input::KI_3;
	    case osgGA::GUIEventAdapter::KEY_4 : return Rml::Input::KI_4;
	    case osgGA::GUIEventAdapter::KEY_5 : return Rml::Input::KI_5;
	    case osgGA::GUIEventAdapter::KEY_6 : return Rml::Input::KI_6;
	    case osgGA::GUIEventAdapter::KEY_7 : return Rml::Input::KI_7;
	    case osgGA::GUIEventAdapter::KEY_8 : return Rml::Input::KI_8;
	    case osgGA::GUIEventAdapter::KEY_9 : return Rml::Input::KI_9;
	    case osgGA::GUIEventAdapter::KEY_A : return Rml::Input::KI_A;
	    case osgGA::GUIEventAdapter::KEY_B : return Rml::Input::KI_B;
	    case osgGA::GUIEventAdapter::KEY_C : return Rml::Input::KI_C;
	    case osgGA::GUIEventAdapter::KEY_D : return Rml::Input::KI_D;
	    case osgGA::GUIEventAdapter::KEY_E : return Rml::Input::KI_E;
	    case osgGA::GUIEventAdapter::KEY_F : return Rml::Input::KI_F;
	    case osgGA::GUIEventAdapter::KEY_G : return Rml::Input::KI_G;
	    case osgGA::GUIEventAdapter::KEY_H : return Rml::Input::KI_H;
	    case osgGA::GUIEventAdapter::KEY_I : return Rml::Input::KI_I;
	    case osgGA::GUIEventAdapter::KEY_J : return Rml::Input::KI_J;
	    case osgGA::GUIEventAdapter::KEY_K : return Rml::Input::KI_K;
	    case osgGA::GUIEventAdapter::KEY_L : return Rml::Input::KI_L;
	    case osgGA::GUIEventAdapter::KEY_M : return Rml::Input::KI_M;
	    case osgGA::GUIEventAdapter::KEY_N : return Rml::Input::KI_N;
	    case osgGA::GUIEventAdapter::KEY_O : return Rml::Input::KI_O;
	    case osgGA::GUIEventAdapter::KEY_P : return Rml::Input::KI_P;
	    case osgGA::GUIEventAdapter::KEY_Q : return Rml::Input::KI_Q;
	    case osgGA::GUIEventAdapter::KEY_R : return Rml::Input::KI_R;
	    case osgGA::GUIEventAdapter::KEY_S : return Rml::Input::KI_S;
	    case osgGA::GUIEventAdapter::KEY_T : return Rml::Input::KI_T;
	    case osgGA::GUIEventAdapter::KEY_U : return Rml::Input::KI_U;
	    case osgGA::GUIEventAdapter::KEY_V : return Rml::Input::KI_V;
	    case osgGA::GUIEventAdapter::KEY_W : return Rml::Input::KI_W;
	    case osgGA::GUIEventAdapter::KEY_X : return Rml::Input::KI_X;
	    case osgGA::GUIEventAdapter::KEY_Y : return Rml::Input::KI_Y;
	    case osgGA::GUIEventAdapter::KEY_Z : return Rml::Input::KI_Z;
	    case osgGA::GUIEventAdapter::KEY_F1  : return Rml::Input::KI_F1;
	    case osgGA::GUIEventAdapter::KEY_F2  : return Rml::Input::KI_F2;
	    case osgGA::GUIEventAdapter::KEY_F3  : return Rml::Input::KI_F3;
	    case osgGA::GUIEventAdapter::KEY_F4  : return Rml::Input::KI_F4;
	    case osgGA::GUIEventAdapter::KEY_F5  : return Rml::Input::KI_F5;
	    case osgGA::GUIEventAdapter::KEY_F6  : return Rml::Input::KI_F6;
	    case osgGA::GUIEventAdapter::KEY_F7  : return Rml::Input::KI_F7;
	    case osgGA::GUIEventAdapter::KEY_F8  : return Rml::Input::KI_F8;
	    case osgGA::GUIEventAdapter::KEY_F9  : return Rml::Input::KI_F9;
	    case osgGA::GUIEventAdapter::KEY_F10 : return Rml::Input::KI_F10;
	    case osgGA::GUIEventAdapter::KEY_F11 : return Rml::Input::KI_F11;
	    case osgGA::GUIEventAdapter::KEY_F12 : return Rml::Input::KI_F12;
	    case osgGA::GUIEventAdapter::KEY_F13 : return Rml::Input::KI_F13;
	    case osgGA::GUIEventAdapter::KEY_F14 : return Rml::Input::KI_F14;
	    case osgGA::GUIEventAdapter::KEY_F15 : return Rml::Input::KI_F15;
	    case osgGA::GUIEventAdapter::KEY_F16 : return Rml::Input::KI_F16;
	    case osgGA::GUIEventAdapter::KEY_F17 : return Rml::Input::KI_F17;
	    case osgGA::GUIEventAdapter::KEY_F18 : return Rml::Input::KI_F18;
	    case osgGA::GUIEventAdapter::KEY_F19 : return Rml::Input::KI_F19;
	    case osgGA::GUIEventAdapter::KEY_F20 : return Rml::Input::KI_F20;
	    case osgGA::GUIEventAdapter::KEY_F21 : return Rml::Input::KI_F21;
	    case osgGA::GUIEventAdapter::KEY_F22 : return Rml::Input::KI_F22;
	    case osgGA::GUIEventAdapter::KEY_F23 : return Rml::Input::KI_F23;
	    case osgGA::GUIEventAdapter::KEY_F24 : return Rml::Input::KI_F24;
		case osgGA::GUIEventAdapter::KEY_Plus: return Rml::Input::KI_ADD;
	    case osgGA::GUIEventAdapter::KEY_Home: return Rml::Input::KI_HOME;
	    case osgGA::GUIEventAdapter::KEY_Left: return Rml::Input::KI_LEFT;
	    case osgGA::GUIEventAdapter::KEY_Up: return Rml::Input::KI_UP;
	    case osgGA::GUIEventAdapter::KEY_Right: return Rml::Input::KI_RIGHT;
	    case osgGA::GUIEventAdapter::KEY_Down: return Rml::Input::KI_DOWN;
	    case osgGA::GUIEventAdapter::KEY_Page_Up: return Rml::Input::KI_PRIOR;
	    case osgGA::GUIEventAdapter::KEY_Page_Down: return Rml::Input::KI_NEXT;
	    case osgGA::GUIEventAdapter::KEY_End: return Rml::Input::KI_END;
	    case osgGA::GUIEventAdapter::KEY_Begin: return Rml::Input::KI_HOME;
	    case osgGA::GUIEventAdapter::KEY_BackSpace: return Rml::Input::KI_BACK;
	    case osgGA::GUIEventAdapter::KEY_Tab: return Rml::Input::KI_TAB;
	    case osgGA::GUIEventAdapter::KEY_Clear: return Rml::Input::KI_CLEAR;
	    case osgGA::GUIEventAdapter::KEY_Return: return Rml::Input::KI_RETURN;
	    case osgGA::GUIEventAdapter::KEY_Pause: return Rml::Input::KI_PAUSE;
	    case osgGA::GUIEventAdapter::KEY_Scroll_Lock: return Rml::Input::KI_SCROLL;
	    case osgGA::GUIEventAdapter::KEY_Escape: return Rml::Input::KI_ESCAPE;
	    case osgGA::GUIEventAdapter::KEY_Delete: return Rml::Input::KI_DELETE;
	    case osgGA::GUIEventAdapter::KEY_KP_0: return Rml::Input::KI_NUMPAD0;
	    case osgGA::GUIEventAdapter::KEY_KP_1: return Rml::Input::KI_NUMPAD1;
	    case osgGA::GUIEventAdapter::KEY_KP_2: return Rml::Input::KI_NUMPAD2;
	    case osgGA::GUIEventAdapter::KEY_KP_3: return Rml::Input::KI_NUMPAD3;
	    case osgGA::GUIEventAdapter::KEY_KP_4: return Rml::Input::KI_NUMPAD4;
	    case osgGA::GUIEventAdapter::KEY_KP_5: return Rml::Input::KI_NUMPAD5;
	    case osgGA::GUIEventAdapter::KEY_KP_6: return Rml::Input::KI_NUMPAD6;
	    case osgGA::GUIEventAdapter::KEY_KP_7: return Rml::Input::KI_NUMPAD7;
	    case osgGA::GUIEventAdapter::KEY_KP_8: return Rml::Input::KI_NUMPAD8;
	    case osgGA::GUIEventAdapter::KEY_KP_9: return Rml::Input::KI_NUMPAD9;
	    case osgGA::GUIEventAdapter::KEY_Shift_L: return Rml::Input::KI_LSHIFT;
	    case osgGA::GUIEventAdapter::KEY_Shift_R: return Rml::Input::KI_RSHIFT;
	    case osgGA::GUIEventAdapter::KEY_Control_L: return Rml::Input::KI_LCONTROL;
	    case osgGA::GUIEventAdapter::KEY_Control_R: return Rml::Input::KI_RCONTROL;
	    default : return Rml::Input::KI_UNKNOWN;
	}

/*
Not (yet) mapped:

KEY_Alt_L           = 0xFFE9,
KEY_Alt_R           = 0xFFEA,
KEY_Linefeed        = 0xFF0A,
KEY_Sys_Req         = 0xFF15,
KEY_Exclaim         = 0x21,
KEY_Quotedbl        = 0x22,
KEY_Hash            = 0x23,
KEY_Dollar          = 0x24,
KEY_Ampersand       = 0x26,
KEY_Quote           = 0x27,
KEY_Leftparen       = 0x28,
KEY_Rightparen      = 0x29,
KEY_Asterisk        = 0x2A,
KEY_Comma           = 0x2C,
KEY_Minus           = 0x2D,
KEY_Period          = 0x2E,
KEY_Slash           = 0x2F,
KEY_Colon           = 0x3A,
KEY_Semicolon       = 0x3B,
KEY_Less            = 0x3C,
KEY_Equals          = 0x3D,
KEY_Greater         = 0x3E,
KEY_Question        = 0x3F,
KEY_At              = 0x40,
KEY_Leftbracket     = 0x5B,
KEY_Backslash       = 0x5C,
KEY_Rightbracket    = 0x5D,
KEY_Caret           = 0x5E,
KEY_Underscore      = 0x5F,
KEY_Backquote       = 0x60,
KEY_F25             = 0xFFD6,
KEY_F26             = 0xFFD7,
KEY_F27             = 0xFFD8,
KEY_F28             = 0xFFD9,
KEY_F29             = 0xFFDA,
KEY_F30             = 0xFFDB,
KEY_F31             = 0xFFDC,
KEY_F32             = 0xFFDD,
KEY_F33             = 0xFFDE,
KEY_F34             = 0xFFDF,
KEY_F35             = 0xFFE0,
KEY_Select          = 0xFF60,
KEY_Print           = 0xFF61,
KEY_Execute         = 0xFF62,
KEY_Insert          = 0xFF63,
KEY_Undo            = 0xFF65,
KEY_Redo            = 0xFF66,
KEY_Menu            = 0xFF67,
KEY_Find            = 0xFF68,
KEY_Cancel          = 0xFF69,
KEY_Help            = 0xFF6A,
KEY_Break           = 0xFF6B,
KEY_Mode_switch     = 0xFF7E,
KEY_Script_switch   = 0xFF7E,
KEY_Num_Lock        = 0xFF7F,
KEY_KP_Space        = 0xFF80,
KEY_KP_Tab          = 0xFF89,
KEY_KP_Enter        = 0xFF8D,
KEY_KP_F1           = 0xFF91,
KEY_KP_F2           = 0xFF92,
KEY_KP_F3           = 0xFF93,
KEY_KP_F4           = 0xFF94,
KEY_KP_Home         = 0xFF95,
KEY_KP_Left         = 0xFF96,
KEY_KP_Up           = 0xFF97,
KEY_KP_Right        = 0xFF98,
KEY_KP_Down         = 0xFF99,
KEY_KP_Prior        = 0xFF9A,
KEY_KP_Page_Up      = 0xFF9A,
KEY_KP_Next         = 0xFF9B,
KEY_KP_Page_Down    = 0xFF9B,
KEY_KP_End          = 0xFF9C,
KEY_KP_Begin        = 0xFF9D,
KEY_KP_Insert       = 0xFF9E,
KEY_KP_Delete       = 0xFF9F,
KEY_KP_Equal        = 0xFFBD,
KEY_KP_Multiply     = 0xFFAA,
KEY_KP_Add          = 0xFFAB,
KEY_KP_Separator    = 0xFFAC,
KEY_KP_Subtract     = 0xFFAD,
KEY_KP_Decimal      = 0xFFAE,
KEY_KP_Divide       = 0xFFAF,
KEY_Caps_Lock       = 0xFFE5,
KEY_Shift_Lock      = 0xFFE6,
KEY_Meta_L          = 0xFFE7,
KEY_Meta_R          = 0xFFE8,
KEY_Super_L         = 0xFFEB,
KEY_Super_R         = 0xFFEC,
KEY_Hyper_L         = 0xFFED,
KEY_Hyper_R         = 0xFFEE  */
}

int DKRmlGuiNode::GetKeyModifiers(int osgModKeyMask){
	int ret = 0;
    if((osgModKeyMask & osgGA::GUIEventAdapter::MODKEY_SHIFT) != 0) ret |= Rml::Input::KM_SHIFT;
    if((osgModKeyMask & osgGA::GUIEventAdapter::MODKEY_ALT) != 0) ret |= Rml::Input::KM_ALT;
    if((osgModKeyMask & osgGA::GUIEventAdapter::MODKEY_META) != 0) ret |= Rml::Input::KM_META;
    if((osgModKeyMask & osgGA::GUIEventAdapter::MODKEY_CAPS_LOCK) != 0) ret |= Rml::Input::KM_CAPSLOCK;
	if((osgModKeyMask & osgGA::GUIEventAdapter::MODKEY_NUM_LOCK) != 0) ret |= Rml::Input::KM_NUMLOCK;
	if((osgModKeyMask & osgGA::GUIEventAdapter::MODKEY_LEFT_CTRL) != 0) ret |= Rml::Input::KM_CTRL;
    return ret;
}

int DKRmlGuiNode::GetButtonId(int button){
    switch(button){
      case osgGA::GUIEventAdapter:: LEFT_MOUSE_BUTTON  : return 0;
      case osgGA::GUIEventAdapter:: RIGHT_MOUSE_BUTTON : return 1;
      case osgGA::GUIEventAdapter:: MIDDLE_MOUSE_BUTTON: return 2;
      default: return button;
    }
}

void DKRmlGuiNode::mousePosition(osgViewer::View* view, const osgGA::GUIEventAdapter& ea, const osg::NodePath& nodePath, int& x, int &y){
	if(_camera.valid()){
        // fullscreen

        Rml::Vector2i dims = _context->GetDimensions();
        x = ea.getX();
        y = dims.y - ea.getY();

        if(ea.getMouseYOrientation() == osgGA::GUIEventAdapter::Y_INCREASING_DOWNWARDS){
           y = ea.getY();
        }
        else{
           y = dims.y - ea.getY();
        }
	}
    else{
		// in-scene
        if (!view->getCamera() || nodePath.empty()){
			x = ea.getX();
			y = ea.getY();
			return;
        }

        float local_x, local_y;
        const osg::Camera* camera = view->getCameraContainingPosition(ea.getX(), ea.getY(), local_x, local_y);
        if (!camera){
          camera = view->getCamera();
        }

        osg::Matrixd matrix;
        matrix.makeIdentity();
        if(nodePath.size() > 1){
            osg::NodePath prunedNodePath(nodePath.begin(),nodePath.end() - 1);
            matrix = osg::computeLocalToWorld(prunedNodePath);
        };

        matrix.postMult(camera->getViewMatrix());
        matrix.postMult(camera->getProjectionMatrix());

        double zNear = -1.0;
        double zFar = 1.0;
        if (camera->getViewport()){
            matrix.postMult(camera->getViewport()->computeWindowMatrix());
            zNear = 0.0;
            zFar = 1.0;
        }

        osg::Matrixd inverse;
        inverse.invert(matrix);

        osg::Vec3d startVertex = osg::Vec3d(local_x,local_y,zNear) * inverse;
        osg::Vec3d endVertex = osg::Vec3d(local_x,local_y,zFar) * inverse;

        osg::Vec3 pick = endVertex - startVertex;
        pick.normalize();

        // project pick ray to z-plane at z=0
        float dist = - startVertex[2] / pick[2];
        osg::Vec3 projected(startVertex[0] + pick[0] * dist, startVertex[1] + pick[1] * dist, 0);

        x = projected[0];
        y = projected[1];

	}
}

void DKRmlGuiNode::setScreenSize(int w, int h){
	if(_camera != NULL){
		// tell libRml about new size
		_context->SetDimensions(Rml::Vector2i(w, h));

		// resize gui camera projection for new screen size
		_camera->setProjectionMatrix(osg::Matrix::ortho2D(0,w,0,h));

		// libRml gui seems to stand on its head, not sure why. Flip the view matrix.
		// If anyone has a more elegant solution for this then please contact me
		_camera->setViewMatrix(osg::Matrix::translate(0, -h, 0) * osg::Matrix::scale(1,-1,1) * osg::Matrix::identity());
		_camera->setViewport(0,0,w,h);
    }
}

bool DKRmlGuiNode::handle(const osgGA::GUIEventAdapter& ea, const osg::NodePath& np, osgGA::GUIActionAdapter& aa){
	if(ea.getHandled())
		return false; 

	Rml::Element* hover;
    switch(ea.getEventType()){
		case(osgGA::GUIEventAdapter::KEYDOWN):{

			Rml::Input::KeyIdentifier key = GetKeyCode(ea.getKey());
			int modifiers = GetKeyModifiers(ea.getModKeyMask());

			//DKLog(ea.getKey());
			//DKLog("\n");
         
			if(	/*	
				// Allowed
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Space ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_0 ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_1 ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_2 ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_3 ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_4 ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_5 ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_6 ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_7 ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_8 ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_9 ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_A ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_B ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_C ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_D ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_E ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_F ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_G ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_H ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_I ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_J ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_K ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_L ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_M ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_N ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_O ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_P ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Q ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_R ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_S ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_T ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_U ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_V ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_W ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_X ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Y ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Z ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Exclaim ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Quotedbl ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Hash ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Dollar ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Ampersand ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Quote ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Leftparen ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Rightparen ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Asterisk ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Plus ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Comma ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Minus ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Period ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Slash ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Colon ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Semicolon ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Less ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Equals ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Greater ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Question ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_At ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Leftbracket ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Backslash ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Rightbracket ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Caret ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Underscore ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_Backquote ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Space ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Tab ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Enter ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_F1 ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_F2 ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_F3 ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_F4 ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Home ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Left ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Up ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Right ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Down ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Prior ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Page_Up ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Next ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Page_Down ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_End ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Begin ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Insert ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Delete ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Equal ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Multiply ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Add ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Separator ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Subtract ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Decimal ||
				ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Divide ||
	            ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_0 ||
	            ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_1 ||
	            ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_2 ||
	            ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_3 ||
	            ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_4 ||
	            ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_5 ||
	            ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_6 ||
	            ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_7 ||
	            ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_8 ||
	            ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_9 ||
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Tab
				*/
				
				// Not Allowed
				ea.getKey() != osgGA::GUIEventAdapter::KEY_BackSpace &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Linefeed &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Clear &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Return &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Pause &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Scroll_Lock &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Sys_Req &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Escape &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Delete &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Home &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Left &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Up &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Right &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Down &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Prior &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Page_Up &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Next &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Page_Down &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_End &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Begin &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Select &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Print &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Execute &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Insert &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Undo &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Redo &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Menu &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Find &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Cancel &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Help &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Break &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Mode_switch &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Script_switch &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Num_Lock &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_Space &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_Tab &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_Enter &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_F1 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_F2 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_F3 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_F4 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_Home &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_Left &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_Up &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_Right &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_Down &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_Prior &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_Page_Up &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_Next &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_Page_Down &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_End &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_Begin &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_Insert &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_Delete &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_Equal &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_Multiply &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_Add &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_Separator &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_Subtract &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_Decimal &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_Divide &&
	            ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_0 &&
	            ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_1 &&
	            ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_2 &&
	            ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_3 &&
	            ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_4 &&
	            ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_5 &&
	            ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_6 &&
	            ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_7 &&
	            ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_8 &&
	            ea.getKey() != osgGA::GUIEventAdapter::KEY_KP_9 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F1 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F2 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F3 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F4 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F5 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F6 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F7 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F8 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F9 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F10 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F11 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F12 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F13 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F14 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F15 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F16 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F17 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F18 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F19 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F20 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F21 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F22 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F23 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F24 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F25 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F26 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F27 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F28 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F29 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F30 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F31 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F32 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F33 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F34 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_F35 &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Shift_L &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Shift_R &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Control_L &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Control_R &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Caps_Lock &&
				ea.getKey() != osgGA::GUIEventAdapter::KEY_Shift_Lock &&
	            ea.getKey() != osgGA::GUIEventAdapter::KEY_Meta_L &&
	            ea.getKey() != osgGA::GUIEventAdapter::KEY_Meta_R &&
	            ea.getKey() != osgGA::GUIEventAdapter::KEY_Alt_L &&
	            ea.getKey() != osgGA::GUIEventAdapter::KEY_Alt_R &&
	            ea.getKey() != osgGA::GUIEventAdapter::KEY_Super_L &&
	            ea.getKey() != osgGA::GUIEventAdapter::KEY_Super_R &&
	            ea.getKey() != osgGA::GUIEventAdapter::KEY_Hyper_L &&
	            ea.getKey() != osgGA::GUIEventAdapter::KEY_Hyper_R &&
				modifiers != 1
			){
				_context->ProcessTextInput((char)ea.getKey());
			}

			if(ea.getKey() == 24) //cut
				key = Rml::Input::KI_X;
			
			if(ea.getKey() == 3) //copy
				key = Rml::Input::KI_C;
		
			if(ea.getKey() == 22) //paste
				key = Rml::Input::KI_V;
			
			if(ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_End)
				_context->ProcessTextInput("1");
			
			if(ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Down)
				_context->ProcessTextInput("2");
			
			if(ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Page_Down)
				_context->ProcessTextInput("3");
			
			if(ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Left)
				_context->ProcessTextInput("4");
			
			if(ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Begin)
				_context->ProcessTextInput("5");
			
			if(ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Right)
				_context->ProcessTextInput("6");
			
			if(ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Home)
				_context->ProcessTextInput("7");
			
			if(ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Up)
				_context->ProcessTextInput("8");
			
			if(ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Page_Up)
				_context->ProcessTextInput("9");
			
			if(ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Insert)
				_context->ProcessTextInput("0");
			
			if(ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Delete)
				_context->ProcessTextInput(".");
			
			if(ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Subtract)
				_context->ProcessTextInput("-");
			
			if(ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Add)
				_context->ProcessTextInput("+");
			
			if(ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Multiply)
				_context->ProcessTextInput("*");
			
			if(ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Divide)
				_context->ProcessTextInput("/");
			
			if(ea.getKey() == osgGA::GUIEventAdapter::KEY_KP_Enter)
				_context->ProcessTextInput("\n");
			
			if(ea.getKey() == osgGA::GUIEventAdapter::KEY_Return)
				_context->ProcessTextInput("\n");

#if ANDROID
			if(ea.getKey() == 0) //backspace
				key = Rml::Input::KI_BACK;
		
			if(ea.getKey() == 10) //enter
				key = Rml::Input::KI_RETURN;
			
#endif

			_context->ProcessKeyDown(key, modifiers);
			//return (_camera != NULL && _contextEventListener->_keys_handled);
			return false; //pass event to OSG
		}
		case(osgGA::GUIEventAdapter::KEYUP):{
			Rml::Input::KeyIdentifier key = GetKeyCode(ea.getKey());
			int modifiers = GetKeyModifiers(ea.getModKeyMask());        
			_context->ProcessKeyUp(key, modifiers);
			//return (_camera != NULL &&  _contextEventListener->_keys_handled);
			return false; //pass event to OSG
		}
		case(osgGA::GUIEventAdapter::MOVE):{
			int x, y;
			osgViewer::View* view = dynamic_cast<osgViewer::View*>(&aa);
			mousePosition(view,ea, np, x, y);
			_context->ProcessMouseMove(x, y, GetKeyModifiers(ea.getModKeyMask()));
       
			//if we clicked an element, end the event.
			hover = DKRml::Get("DKRml0")->context->GetHoverElement();
			if(hover && (!has(hover->GetId(), "iframe_")))
				return true;
			return false; //pass event to OSG
		}	
		case(osgGA::GUIEventAdapter::DRAG):{
			int x, y;
			osgViewer::View* view = dynamic_cast<osgViewer::View*>(&aa);
			mousePosition(view,ea, np, x, y);
			_context->ProcessMouseMove(x, y, GetKeyModifiers(ea.getModKeyMask()));
       
			//if we clicked an element, end the event.
			hover = DKRml::Get("DKRml0")->context->GetHoverElement();
			if(hover && (!has(hover->GetId(), "iframe_")))
				return true;
			return false; //pass event to OSG
		}
		case(osgGA::GUIEventAdapter::PUSH):{
			_context->ProcessMouseButtonDown(GetButtonId(ea.getButton()), GetKeyModifiers(ea.getModKeyMask()));
			//osgViewer::View* view = dynamic_cast<osgViewer::View*>(&aa);
			//int x, y;
			//mousePosition(view,ea, np, x, y);
			//return true;
			//return (/*_camera != NULL &&*/  _contextEventListener->_mouse_handled);
			//if we clicked an element, end the event.
			hover = DKRml::Get("DKRml0")->context->GetHoverElement();
			if(hover && (!has(hover->GetId(), "iframe_")))
				return true;
			return false; //pass event to OSG
		}
		case(osgGA::GUIEventAdapter::RELEASE):{
			_context->ProcessMouseButtonUp(GetButtonId(ea.getButton()), GetKeyModifiers(ea.getModKeyMask()));
			//return true;
			//return (/*_camera != NULL &&*/  _contextEventListener->_mouse_handled);
			//if we clicked an element, end the event.
			hover = DKRml::Get("DKRml0")->context->GetHoverElement();
			if(hover && (!has(hover->GetId(), "iframe_")))
				return true;
			return false; //pass event to OSG
		}
		case(osgGA::GUIEventAdapter::SCROLL):{

#if MAC
		_context->ProcessMouseWheel((int)ea.getScrollingDeltaY(), GetKeyModifiers(ea.getModKeyMask()));
			//return (_camera != NULL &&  _contextEventListener->_mouse_handled);
#else
		int wheel_step = 2;
		if(ea.getScrollingMotion() == osgGA::GUIEventAdapter::SCROLL_DOWN)
			_context->ProcessMouseWheel(wheel_step, GetKeyModifiers(ea.getModKeyMask()));
		if(ea.getScrollingMotion() == osgGA::GUIEventAdapter::SCROLL_UP)
			_context->ProcessMouseWheel(-wheel_step, GetKeyModifiers(ea.getModKeyMask()));
#endif
			return false; //pass event to OSG
		}

		default: {}
    }
    return false;
}
