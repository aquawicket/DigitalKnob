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
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
#pragma once
#ifndef DKOSGNotify_H
#define DKOSGNotify_H
#include "DK/DK.h"

//WARNING_DISABLE
#if ANDROID
	#include <android/log.h>
#endif
#include <osg/Notify>
//WARNING_ENABLE


class DKOSGNotify : public DKObjectT<DKOSGNotify>, public osg::NotifyHandler
{
public:
	bool Init();
	bool End();
	
	bool AttachNotify(osg::NotifyHandler* panel);
	bool RemoveNotify(osg::NotifyHandler* panel);

private: 
    void notify(osg::NotifySeverity severity, const char *message);
	void output(osg::NotifySeverity severity, const char *message);
	std::vector<osg::NotifyHandler*> notifys;
};


REGISTER_OBJECT(DKOSGNotify, true);
#endif //DKOSGNotify_H
