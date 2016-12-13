// AUTO-GENERATED FILE. "dkapp" is renamed.
package digitalknob.dkapp;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.res.AssetManager;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.inputmethod.InputMethodManager;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;


////////////////////////////////
public class DK extends Activity
{
	public static DK instance;
	public native void initJNIBridge();
	public native void exitJNIBridge();
	public static native void CallCppFunction(String data);

	public static DK Get(){ //Use "DK.Get().function" or "DK.Get().variable" to access this class
		return instance;
	}

	public static void Instance(DK instance){
		DK.instance = instance;
	}
	
	static {
		System.loadLibrary("DKAndroid");
	}

	/////////////////////////////////////////////
	@Override protected void onCreate(Bundle app) 
	{
		Log.d("DK.java", "onCreate()");
		super.onCreate(app);
		Instance(this);

		initJNIBridge(); // Calls C++ function to store object for C++ to Java bridge
		//CallCppFunction("DKAndroid_init");

		OpenActivity("SplashActivity");

		Handler handler = new Handler();
		handler.postDelayed(new Runnable() {
			@Override
			public void run(){
				copyAssets();
				OpenActivity("SDLActivity");
				//OpenActivity("WebviewActivity");
			}
		}, 2000);
	}

	////////////////////////////////////
	@Override protected void onDestroy()
	{
		Log.d("DK.java", "onDestroy()");
		exitJNIBridge();
		//CallCppFunction("DKAndroid_exit");
		finishAffinity();
		System.exit(0);
		super.onDestroy();
	}

	//////////////////
	public void Exit()
	{
		Log.d("DK.java", "Exit()");
		onDestroy();
	}
	
	/////////////////////////////////////
	public void OpenActivity(String name)
	{
		Log.d("DK.java", "OpenActivity("+name+")");
		Intent intent = new Intent();
		intent.setClassName("digitalknob.dkapp", "digitalknob.dkapp."+name);
		startActivity(intent);
	}


	/////////////////////////
	private void copyAssets()
	{
		Log.d("DK.java", "copyAssets()");
		Log.i("DK.java", "Copying assets to storage . . .");
		Context context = this.getApplicationContext();
		int stringId = context.getApplicationInfo().labelRes;
		String appdir = "/mnt/sdcard/"+context.getString(stringId);
		File checkfile = new File(appdir+"/ASSETS");

		if(checkfile.exists()){
			Log.i("DK.java", "Remove "+appdir+"/ASSETS file from the device to reload assets.");
			return;
		}
		else{
			Log.i("DK.java", "Reloading Assets . . .");
			copyFileOrDir("null", true);
		}
	}

	///////////////////////////////////
	private void copyAsset(String path)
	{
		Log.d("DK.java", "copyAsset("+path+")");
		Log.i("DK.java", "Copying "+path+" to storage . . .");
		copyFile(path, true);
	}

	//////////////////////////////////////////////////////////
	private void copyFileOrDir(String path, boolean overwrite)
	{
		//Log.d("DK.java", "copyFileOrDir("+path+",boolean)");	
		if(path.equals("null")){ path = ""; }
		Context context = this.getApplicationContext();
		int stringId = context.getApplicationInfo().labelRes;

		AssetManager assetManager = this.getAssets();
		String assets[] = null;
		try{
			assets = assetManager.list(path);
			if(assets.length == 0){
				copyFile(path, overwrite);
			}
			else{
				String fullPath = "/mnt/sdcard/"+context.getString(stringId) + "/" + path;
				File dir = new File(fullPath);
				if(!dir.exists()){
					dir.mkdir();
				}
				for(int i = 0; i < assets.length; ++i){
					if(path.equals("")){
						copyFileOrDir(assets[i], overwrite);
					}
					else{
						copyFileOrDir(path + "/" + assets[i], overwrite);
					}
				}
			}
		}
		catch(IOException ex){
			Log.e("DK.java", "copyFileOrDir("+path+",boolean): I/O Exception", ex);
		}
	}

	/////////////////////////////////////////////////////////
	private void copyFile(String filename, boolean overwrite)
	{
		//Log.d("DK.java", "copyFile("+filename+",boolean)");
		Context context = this.getApplicationContext();
		int stringId = context.getApplicationInfo().labelRes;

		AssetManager assetManager = this.getAssets();
		InputStream in = null;
		OutputStream out = null;
		try{
			in = assetManager.open(filename);
			String newFileName = "/mnt/sdcard/"+context.getString(stringId) + "/" + filename;
			out = new FileOutputStream(newFileName);

			File file = new File(newFileName);
			if(file.exists() && !overwrite){ return; }

			byte[] buffer = new byte[1024];
			int read;
			while((read = in.read(buffer)) != -1){
				out.write(buffer, 0, read);
			}
			in.close();
			in = null;
			out.flush();
			out.close();
			out = null;
		}
		catch(Exception e){
			Log.e("DK.java", "copyFile("+filename+",boolean)"+e.getMessage());
		}
	}
	
	////////////////////////////
	public void toggleKeyboard()
	{
		Log.d("DK.java","toggleKeyborad()");
		InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);

		if(imm != null){
			imm.toggleSoftInput(InputMethodManager.SHOW_FORCED,0);
		}
	}
}