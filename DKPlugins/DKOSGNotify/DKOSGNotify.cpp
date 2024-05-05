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
#include "DKOSGNotify/DKOSGNotify.h"
#include "DKAssets/DKAssets.h"
#include "DK/DKFile.h"

//WARNING_DISABLE
#include <iostream>
//WARING_ENABLE


bool DKOSGNotify::Init(){
	osg::setNotifyHandler(this);
#ifdef DEBUG
    osg::setNotifyLevel(osg::INFO);
#else
	osg::setNotifyLevel(osg::NOTICE);
#endif
	return true;
}

bool DKOSGNotify::End(){
	return true;
}

bool DKOSGNotify::AttachNotify(osg::NotifyHandler* panel){
	if(!panel){return false;}
	notifys.push_back(panel);
	return true;
}

bool DKOSGNotify::RemoveNotify(osg::NotifyHandler* panel){
	if(!panel){return false;}
	for(unsigned int i = 0; i < notifys.size(); i++){
		if(panel == notifys[i]){
			notifys[i] = NULL;
			notifys.erase(notifys.begin()+i);
			return true;
		}
	}
	return false;
}

void DKOSGNotify::notify(osg::NotifySeverity severity, const char *message){
	//FIXME - We get empty messages sometimes..  why?
	if(message && message[0] == '\0')
		return;
	output(severity,message); //App output
	for(unsigned int i=0; i<notifys.size(); i++){
		notifys[i]->notify(severity,message); //Attached outputs
	}
}

void DKOSGNotify::output(osg::NotifySeverity severity, const char *message){
	switch(severity){
		case osg::DEBUG_FP:
			DKDEBUG(message);
			break;
		case osg::DEBUG_INFO:
			DKDEBUG(message);
			break;
		case osg::NOTICE:
		case osg::INFO:
			DKINFO(message);
			break;
		case osg::WARN:
			DKWARN(message);
			break;
		case osg::FATAL:
			DKERROR(message);
			break;
		case osg::ALWAYS:
			DKINFO(message);
			break;
		default:
			DKINFO(message);
			break;
    }
}
