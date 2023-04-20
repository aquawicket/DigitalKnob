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

#if ANDROID
#pragma once
#ifndef DKSdlWindowAndroid_H
#define DKSdlWindowAndroid_H

WARNING_DISABLE
#include <jni.h>
WARNING_ENABLE


class DKSdlWindowAndroid : public DKObjectT<DKSdlWindowAndroid>
{
public:
	bool Init();
	bool End();
	
	bool onAccel(const void* input, void* output);
	bool onAddJoystick(const void* input, void* output);
	bool onCommitText(const void* input, void* output);
	bool onDropFile(const void* input, void* output);
	bool onGetHint(const void* input, void* output);
	bool onHat(const void* input, void* output);
	bool onInitSDL(const void* input, void* output);
	bool onJoy(const void* input, void* output);
	bool onKeyDown(const void* input, void* output);
	bool onKeyUp(const void* input, void* output);
	bool onKeyboardFocusLost(const void* input, void* output);
	bool onLowMemory(const void* input, void* output);
	bool onMouse(const void* input, void* output);
	bool onPadDown(const void* input, void* output);
	bool onPadUp(const void* input, void* output);
	bool onPause(const void* input, void* output);
	bool onQuit(const void* input, void* output);
	bool onRemoveJoystick(const void* input, void* output);
	bool onResize(const void* input, void* output);
	bool onResume(const void* input, void* output);
	//bool onSetComposingText(const void* input, void* output);
	bool onSurfaceChanged(const void* input, void* output);
	bool onSurfaceDestroyed(const void* input, void* output);
	bool onTouch(const void* input, void* output);
};

REGISTER_OBJECT(DKSdlWindowAndroid, true)
#endif //DKSdlWindowAndroid_H
#endif //ANDROID
