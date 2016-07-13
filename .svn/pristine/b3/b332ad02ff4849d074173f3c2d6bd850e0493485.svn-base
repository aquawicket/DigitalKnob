#ifdef ANDROID
#pragma once
#ifndef DKSDLWindowAndroid_H
#define DKSDLWindowAndroid_H

#include <jni.h>

///////////////////////////////////////////////////////////////
class DKSDLWindowAndroid : public DKObjectT<DKSDLWindowAndroid>
{
public:
	void Init();
	void End();
	
	void* onInitSDL(void* data);
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
};
	
REGISTER_OBJECT(DKSDLWindowAndroid, true)

#endif //DKSDLWindowAndroid_H
#endif //ANDROID