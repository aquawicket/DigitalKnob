#ifdef ANDROID
#pragma once
#ifndef DKSDLWindowAndroid_H
#define DKSDLWindowAndroid_H

#include <jni.h>

class DKSDLWindowAndroid : public DKObjectT<DKSDLWindowAndroid>
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
	bool onSetComposingText(const void* input, void* output);
	bool onSurfaceChanged(const void* input, void* output);
	bool onSurfaceDestroyed(const void* input, void* output);
	bool onTouch(const void* input, void* output);
};

REGISTER_OBJECT(DKSDLWindowAndroid, true)
#endif //DKSDLWindowAndroid_H
#endif //ANDROID