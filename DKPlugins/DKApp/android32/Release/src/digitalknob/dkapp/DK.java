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
	public static native void initJNIBridge();
	public static native void exitJNIBridge();
	public static native void CallCppFunction(String data);

	static {
		System.loadLibrary("DKAndroid");
		initJNIBridge(); // Calls C++ function to store object for C++ to Java bridge
	}

	@Override
	protected void onCreate(Bundle app) {
		Log.e("dkwebview", "onCreate");
		super.onCreate(app);

		OpenActivity("SplashActivity");

		Handler handler = new Handler();
		handler.postDelayed(new Runnable() {
			@Override
			public void run(){
				OpenActivity("WebviewActivity");
				//OpenActivity("SDLActivity");
			}
		}, 2000);
	}

	@Override
	protected void onDestroy(){
		Log.e("dkwebview", "onDestroy");
		//exitJNIBridge();
		//CallCppFunction("DKAndroid_exit");
		System.exit(0);
		super.onDestroy();
	}

	protected void OpenActivity(String name) {
		Intent intent = new Intent();
		intent.setClassName("digitalknob.dkapp", "digitalknob.dkapp."+name);
		startActivity(intent);
	}
}