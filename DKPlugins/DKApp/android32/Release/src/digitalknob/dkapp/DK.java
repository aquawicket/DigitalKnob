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
	public native void initJNIBridge();
	public static native void exitJNIBridge();
	public static native void CallCppFunction(String data);

	static {
		System.loadLibrary("DKAndroid");
	}

	@Override
	protected void onCreate(Bundle app) {
		Log.e("DK", "onCreate");
		super.onCreate(app);

		initJNIBridge(); // Calls C++ function to store object for C++ to Java bridge
		//CallCppFunction("DKAndroid_init");

		OpenActivity("SplashActivity");

		Handler handler = new Handler();
		handler.postDelayed(new Runnable() {
			@Override
			public void run(){
				OpenActivity("SDLActivity");
				//OpenActivity("WebviewActivity");
			}
		}, 2000);
	}

	@Override
	protected void onDestroy(){
		Log.e("DK", "onDestroy");
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


	/////////////////////////
	private void copyAssets()
	{
		Log.e("DK","Copying assets to storage . . .");
		Context context = this.getApplicationContext();
		int stringId = context.getApplicationInfo().labelRes;
		String appdir = "/mnt/sdcard/"+context.getString(stringId);
		File checkfile = new File(appdir+"/ASSETS");

		if(checkfile.exists()){
			Log.e("DK","Remove "+appdir+"/ASSETS file from the device to reload assets.");
			//copyFileOrDir("null", false);
			return;
		}
		else{
			Log.e("DK","Reloading Assets . . .");
			copyFileOrDir("null", true);
		}
	}

	///////////////////////////////////
	private void copyAsset(String path)
	{
		Log.e("DK", "Copying "+path+" to storage . . .");
		copyFile(path, true);
	}

	///////////////////////////////////////////////////////////
	private void copyFileOrDir(String path, boolean overwrite){
		if(path.equals("null")){ path = ""; }
		//Log.e(TAG, "copyAssets2("+path+")");
		Context context = this.getApplicationContext();
		int stringId = context.getApplicationInfo().labelRes;

		AssetManager assetManager = this.getAssets();
		String assets[] = null;
		try{
			assets = assetManager.list(path);
			if(assets.length == 0){
				//Log.e(TAG, path+" assets.length == 0");
				copyFile(path, overwrite);
			}
			else{
				//Log.e(TAG, path+" assets.length > 0");
				String fullPath = "/mnt/sdcard/"+context.getString(stringId) + "/" + path;
				//Log.e(TAG,"fullpath: "+fullPath);
				File dir = new File(fullPath);
				if(!dir.exists()){
					//Log.e(TAG,"!dir.exists()");
					dir.mkdir();
					//Log.e(TAG,"makedir: "+fullPath);
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
			Log.e("DK", "I/O Exception", ex);
		}
	}

	/////////////////////////////////////////////////////////
	private void copyFile(String filename, boolean overwrite)
	{
		//Log.e(TAG,"copyFile2("+filename+")");
		Context context = this.getApplicationContext();
		int stringId = context.getApplicationInfo().labelRes;

		AssetManager assetManager = this.getAssets();
		InputStream in = null;
		OutputStream out = null;
		try{
			in = assetManager.open(filename);
			String newFileName = "/mnt/sdcard/"+context.getString(stringId) + "/" + filename;
			//Log.e(TAG,"newFileNam: "+newFileName);
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
			Log.e("DK", "copyFile2 ERROR: "+e.getMessage());
		}
	}
	
	////////////////////////////
	public void toggleKeyboard()
	{
		Log.e("DK","toggleKeyborad()");
		InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);

		if(imm != null){
			imm.toggleSoftInput(InputMethodManager.SHOW_FORCED,0);
		}
	}
}