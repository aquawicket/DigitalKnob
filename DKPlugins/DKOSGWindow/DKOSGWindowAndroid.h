#ifdef ANDROID
#pragma once
#ifndef DKOSGWindowAndroid_H
#define DKOSGWindowAndroid_H

#include <jni.h>

///////////////////////////////////////////////////////////////
class DKOSGWindowAndroid : public DKObjectT<DKOSGWindowAndroid>
{
public:
	void Init();
	void End();
	
	//void* InitOSG(void* data);
	void* onDropFile(void* data);
	void* onResize(void* data);
	void* onPadDown(void* data);
	void* onPadUp(void* data);
	void* onJoy(void* data);
	void* onHat(void* data);
	void* onAddJoystick(void* data);
	void* onRemoveJoystick(void* data);
	void* onSurfaceChanged(void* data);
	void* onSurfaceDestroyed(void* data);
	void* onKeyDown(void* data);
	void* onKeyUp(void* data);
	void* onKeyboardFocusLost(void* data);
	void* onTouch(void* data);
	void* onMouse(void* data);
	void* onAccel(void* data);
	void* onLowMemory(void* data);
	void* onQuit(void* data);
	void* onPause(void* data);
	void* onResume(void* data);
	void* onCommitText(void* data);
	void* onSetComposingText(void* data);
	void* onGetHint(void* data);
	void* onMousePress(void* data);
	void* onMouseRelease(void* data);
	void* onMouseMove(void* data);
};
	
REGISTER_OBJECT(DKOSGWindowAndroid, true)

#endif //DKOSGWindowAndroid_H
#endif //ANDROID