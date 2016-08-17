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

	public static native void CallCppFunction(String data);
	public native void initJNIBridge();
	public static native void exitJNIBridge();

	//Main Android Activity life cycle
	@Override
	protected void onCreate(Bundle app) {
		Log.e("dkapp", "onCreate");
		super.onCreate(app);
		//initJNIBridge(); // Calls C++ function to store object for C++ to Java bridge

		Intent splash;
		splash = new Intent(this, SplashActivity.class);
		startActivity(splash);

		final Intent webView;
		webView = new Intent(this, WebviewActivity.class);
		Handler handler = new Handler();
		handler.postDelayed(new Runnable() {
			@Override
			public void run(){
				startActivity(webView);
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