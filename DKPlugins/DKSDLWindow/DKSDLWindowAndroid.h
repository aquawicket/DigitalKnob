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
	
	bool onAccel(void*input, void* output);
	bool onAddJoystick(void*input, void* output);
	bool onCommitText(void*input, void* output);
	bool onDropFile(void*input, void* output);
	bool onGetHint(void*input, void* output);
	bool onHat(void*input, void* output);
	bool onInitSDL(void*input, void* output);
	bool onJoy(void*input, void* output);
	bool onKeyboardFocusLost(void*input, void* output);
	bool onKeyDown(void*input, void* output);
	bool onKeyUp(void*input, void* output);
	bool onLowMemory(void*input, void* output);
	bool onMouse(void*input, void* output);
	bool onPadDown(void*input, void* output);
	bool onPadUp(void*input, void* output);
	bool onPause(void*input, void* output);
	bool onQuit(void*input, void* output);
	bool onRemoveJoystick(void*input, void* output);
	bool onResize(void*input, void* output);
	bool onResume(void*input, void* output);
	bool onSetComposingText(void*input, void* output);
	bool onSurfaceChanged(void*input, void* output);
	bool onSurfaceDestroyed(void*input, void* output);
	bool onTouch(void*input, void* output);
};
	
REGISTER_OBJECT(DKSDLWindowAndroid, true)

#endif //DKSDLWindowAndroid_H
#endif //ANDROID