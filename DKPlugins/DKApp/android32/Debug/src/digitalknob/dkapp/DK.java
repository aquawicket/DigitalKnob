// AUTO-GENERATED FILE. "dkapp" is renamed.
package digitalknob.dkapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;


////////////////////////////////
public class DK extends Activity
{
	static {
		System.loadLibrary("DKAndroid");
	}

	public native void initJNIBridge();
	public static native void exitJNIBridge();
	public static native void CallCppFunction(String data);
	
	//Main Android Activity life cycle
	@Override
	protected void onCreate(Bundle app) {
		Log.e("dkapp", "onCreate");
		super.onCreate(app);
		//initJNIBridge(); // Calls C++ function to store object for C++ to Java bridge

		Intent splashActivity;
		splashActivity = new Intent(this, SplashActivity.class);
		startActivity(splashActivity);

		/*
		final Intent webviewActivity;
		webviewActivity = new Intent(this, WebviewActivity.class);
		Handler handler = new Handler();
		handler.postDelayed(new Runnable() {
			@Override
			public void run(){
				startActivity(webviewActivity);
				finish();
			}
		}, 0);
		*/

		final Intent sdlActivity;
		sdlActivity = new Intent(this, SDLActivity.class);
		Handler handler = new Handler();
		handler.postDelayed(new Runnable() {
			@Override
			public void run(){
				startActivity(sdlActivity);
				finish();
			}
		}, 0);
	}

	////////////////////////////////////
	@Override
	protected void onDestroy() {
		Log.e("dkapp", "onDestroy");
		//exitJNIBridge();
		//CallCppFunction("DKAndroid_exit");
		System.exit(0);
		super.onDestroy();
	}

	/*
	//////////////////
	public void Exit() {
		Log.e("dkapp", "Exit()");
		exitJNIBridge();
		System.exit(0);
		super.onDestroy();
	}
	*/
}