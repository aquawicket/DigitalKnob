// AUTO-GENERATED FILE. "dkapp" is renamed.
package digitalknob.dkapp;

import android.app.Activity;
import android.os.Environment;
import android.content.res.AssetManager;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;
import java.io.FileOutputStream;
import android.app.AlertDialog;
import android.app.Service;
import android.content.Context;
import android.content.DialogInterface;
import android.content.res.Resources;
import android.graphics.Color;
import android.graphics.PointF;
import android.os.Bundle;
import android.util.FloatMath;
import android.util.Log;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.View;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.WindowManager;
import android.view.View.OnClickListener;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ImageButton;
import java.io.File;
import java.util.Date;
import java.util.Properties;

///////////////////////////////////////////////////////////////////////////////////////
public class DKMain extends Activity implements View.OnTouchListener, View.OnKeyListener
{
	static{
        System.loadLibrary("DKAndroid");
    }
	public static native void CallCppFunction(String data);
	public native void initJNIBridge();
	public static native void exitJNIBridge();
	
	enum moveTypes { NONE , DRAG, MDRAG, ZOOM ,ACTUALIZE}
	enum navType { PRINCIPAL , SECONDARY }
	enum lightType { ON , OFF }
		
	moveTypes mode=moveTypes.NONE;
	navType navMode = navType.SECONDARY;
	lightType lightMode = lightType.ON;
	
	PointF oneFingerOrigin = new PointF(0,0);
	long timeOneFinger=0;
	PointF twoFingerOrigin = new PointF(0,0);
	long timeTwoFinger=0;
	float distanceOrigin;
	
	int backgroundColor;
	
	//Context context = getApplicationContext();
	//int stringId = context.getApplicationInfo().labelRes;	
	private static final String TAG = "DKMain";
	//private static final String TAG = context.getString(stringId);

	//Main Android Activity life cycle
    @Override protected void onCreate(Bundle icicle) 
	{
    	Log.e(TAG,"onCreate");
        super.onCreate(icicle);
        initJNIBridge(); // Calls C++ function to store object for C++ to Java bridge
        setContentView(R.layout.ui_layout_gles);
        //Obtain every Ui element
	    mView= (EGLview) findViewById(R.id.surfaceGLES);
		mView.setOnTouchListener(this);
		mView.setOnKeyListener(this);      
		
		mView.setPreserveEGLContextOnPause(true);
    }
    //Ui elements
	EGLview mView;

	//////////////////////////////////
	@Override protected void onPause() 
	{
		Log.e(TAG,"onPause()");
        super.onPause();
        mView.onPause();
    }
	
	///////////////////////////////////
    @Override protected void onResume() 
	{
    	Log.e(TAG,"onResume()");
        super.onResume();
        mView.onResume();
    }
	
	////////////////////////////////////
    @Override protected void onDestroy() 
	{
    	Log.e(TAG,"onDestroy");
    	exitJNIBridge(); 
		CallCppFunction("DKAndroid_exit");
    	System.exit(0);
    	super.onDestroy();
    }
	
    /////  Main view event processing  ////
	///////////////////////////////////////////////////////////////////
    @Override public boolean onKey(View v, int keyCode, KeyEvent event) 
	{	
		return true;
	}
	
	///////////////////////////////////////////////////////////////
    @Override public boolean onKeyDown(int keyCode, KeyEvent event)
	{
    	//int keyChar= event.getUnicodeChar();
		CallCppFunction("DKAndroid_onKeyDown,"+Integer.toString(keyCode));
    	return true;
    }
	
	/////////////////////////////////////////////////////////////
    @Override public boolean onKeyUp(int keyCode, KeyEvent event)
	{
     	//int keyChar= event.getUnicodeChar();
		CallCppFunction("DKAndroid_onKeyUp,"+Integer.toString(keyCode));		
    	return true;
    }
	
	///////////////////////////////////////////////////////////
    @Override public boolean onTouch(View v, MotionEvent event) 
	{
    	//dumpEvent(event);
    	long time_arrival = event.getEventTime();
    	int n_points = event.getPointerCount();
    	int action = event.getAction() & MotionEvent.ACTION_MASK;
    	
    	switch(n_points){
    	case 1:
    		switch(action){
    		case MotionEvent.ACTION_DOWN:
	    		mode = moveTypes.DRAG;
	    		
				CallCppFunction("DKAndroid_onMouseMove,"+Float.toString(event.getX(0))+","+Float.toString(event.getY(0)));
	    		if(navMode==navType.PRINCIPAL)
					CallCppFunction("DKAndroid_onMousePress,"+Float.toString(event.getX(0))+","+Float.toString(event.getY(0))+","+Integer.toString(2));
	    		else
					CallCppFunction("DKAndroid_onMousePress,"+Float.toString(event.getX(0))+","+Float.toString(event.getY(0))+","+Integer.toString(1));
	    		
	    		oneFingerOrigin.x=event.getX(0);
	    		oneFingerOrigin.y=event.getY(0);
    			break;
    		case MotionEvent.ACTION_CANCEL:
    			switch(mode){
    			case DRAG:
					CallCppFunction("DKAndroid_onMouseMove,"+Float.toString(event.getX(0))+","+Float.toString(event.getY(0)));
    				if(navMode==navType.PRINCIPAL)
						CallCppFunction("DKAndroid_onMouseRelease,"+Float.toString(event.getX(0))+","+Float.toString(event.getY(0))+","+Integer.toString(2));
    				else
						CallCppFunction("DKAndroid_onMouseRelease,"+Float.toString(event.getX(0))+","+Float.toString(event.getY(0))+","+Integer.toString(1));
    				break;
    			default :
    				Log.e(TAG,"There has been an anomaly in touch input 1point/action");
    			}
    			mode = moveTypes.NONE;
    			break;
    		case MotionEvent.ACTION_MOVE:
    			
				CallCppFunction("DKAndroid_onMouseMove,"+Float.toString(event.getX(0))+","+Float.toString(event.getY(0)));
    			
    			oneFingerOrigin.x=event.getX(0);
	    		oneFingerOrigin.y=event.getY(0);
	    		
    			break;
    		case MotionEvent.ACTION_UP:
    			switch(mode){
    			case DRAG:
    				if(navMode==navType.PRINCIPAL)
						CallCppFunction("DKAndroid_onMouseRelease,"+Float.toString(event.getX(0))+","+Float.toString(event.getY(0))+","+Integer.toString(2));
    				else
						CallCppFunction("DKAndroid_onMouseRelease,"+Float.toString(event.getX(0))+","+Float.toString(event.getY(0))+","+Integer.toString(1));
    				break;
    			default :
    				Log.e(TAG,"There has been an anomaly in touch input 1 point/action");
    			}
    			mode = moveTypes.NONE;
    			break;
    		default :
    			Log.e(TAG,"1 point Action not captured");	
    		}
    		break;
    	case 2:
    		switch (action){
    		case MotionEvent.ACTION_POINTER_DOWN:
    			//Free previous Action
    			switch(mode){
    			case DRAG:
    				if(navMode==navType.PRINCIPAL)
						CallCppFunction("DKAndroid_onMouseRelease,"+Float.toString(event.getX(0))+","+Float.toString(event.getY(0))+","+Integer.toString(2));
    				else
						CallCppFunction("DKAndroid_onMouseRelease,"+Float.toString(event.getX(0))+","+Float.toString(event.getY(0))+","+Integer.toString(1));
    				break;
    			}
    			mode = moveTypes.ZOOM;
    			distanceOrigin = sqrDistance(event);
    			twoFingerOrigin.x=event.getX(1);
    			twoFingerOrigin.y=event.getY(1);
    			oneFingerOrigin.x=event.getX(0);
	    		oneFingerOrigin.y=event.getY(0);
    			
				CallCppFunction("DKAndroid_onMouseMove,"+Float.toString(oneFingerOrigin.x)+","+Float.toString(oneFingerOrigin.y));
				CallCppFunction("DKAndroid_onMousePress,"+Float.toString(oneFingerOrigin.x)+","+Float.toString(oneFingerOrigin.y)+","+Integer.toString(3));
				CallCppFunction("DKAndroid_onMouseMove,"+Float.toString(oneFingerOrigin.x)+","+Float.toString(oneFingerOrigin.y));
    			
    		case MotionEvent.ACTION_MOVE:
    			float distance = sqrDistance(event);
    			float result = distance-distanceOrigin;
    			distanceOrigin=distance;
    			
    			if(result>1||result<-1){
    	    		oneFingerOrigin.y=oneFingerOrigin.y+result;
					CallCppFunction("DKAndroid_onMouseMove,"+Float.toString(oneFingerOrigin.x)+","+Float.toString(oneFingerOrigin.y));
    			}
    			
    			break;
    		case MotionEvent.ACTION_POINTER_UP:
    			mode =moveTypes.NONE;
				CallCppFunction("DKAndroid_onMouseRelease,"+Float.toString(oneFingerOrigin.x)+","+Float.toString(oneFingerOrigin.y)+","+Integer.toString(3));
    			break;
    		case MotionEvent.ACTION_UP:
    			mode =moveTypes.NONE;
				CallCppFunction("DKAndroid_onMouseRelease,"+Float.toString(oneFingerOrigin.x)+","+Float.toString(oneFingerOrigin.y)+","+Integer.toString(3));
    			break;
    		default :
    			Log.e(TAG,"2 point Action not captured");
    		}
    		break;    		
    	}
			
		return true;
	}
    
	//////////////////
    public void Exit()
    {
    	Log.e(TAG,"Exit()");
    	exitJNIBridge();
    	System.exit(0);
    	super.onDestroy();
    }
	
	////////////////////////////
	public void toggleKeyboard()
	{
		Log.e(TAG,"toggleKeyborad()");
		InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
		
		if(imm != null){
			imm.toggleSoftInput(InputMethodManager.SHOW_FORCED,0);
		}
	}
	
	/////////////////////////
	private void copyAssets() 
	{
		Log.e(TAG,"Copying assets to storage . . .");
		
		Context context = getApplicationContext();
		int stringId = context.getApplicationInfo().labelRes;
		String appdir = "/mnt/sdcard/"+context.getString(stringId);
		File checkfile = new File(appdir+"/ASSETS");
		
		if(checkfile.exists()){ 
			Log.e(TAG,"Remove "+appdir+"/ASSETS file from the device to reload assets.");
			//copyFileOrDir("null", false);
			return;
		}
		else{
			Log.e(TAG,"Reloading Assets . . .");
			copyFileOrDir("null", true);
		}
	}
	
	///////////////////////////////////
	private void copyAsset(String path) 
	{
		Log.e(TAG,"Copying "+path+" to storage . . .");
		copyFile(path, true);
	}
	
	///////////////////////////////////////////////////////////
	private void copyFileOrDir(String path, boolean overwrite){
		if(path.equals("null")){ path = ""; }
		//Log.e(TAG, "copyAssets2("+path+")");
		Context context = getApplicationContext();
		int stringId = context.getApplicationInfo().labelRes;
		
		AssetManager assetManager = getAssets();
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
			Log.e(TAG, "I/O Exception", ex);
		}
	}

	/////////////////////////////////////////////////////////
	private void copyFile(String filename, boolean overwrite)
	{
		//Log.e(TAG,"copyFile2("+filename+")");
		Context context = getApplicationContext();
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
			Log.e(TAG, "copyFile2 ERROR: "+e.getMessage());
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
    //Utilities
    /** Show an event in the LogCat view, for debugging */
    private void dumpEvent(MotionEvent event) {
       String names[] = { "DOWN", "UP", "MOVE", "CANCEL", "OUTSIDE",
             "POINTER_DOWN", "POINTER_UP", "7?", "8?", "9?" };
       StringBuilder sb = new StringBuilder();
       int action = event.getAction();
       int actionCode = action & MotionEvent.ACTION_MASK;
       sb.append("event ACTION_").append(names[actionCode]);
       if (actionCode == MotionEvent.ACTION_POINTER_DOWN
             || actionCode == MotionEvent.ACTION_POINTER_UP) {
          sb.append("(pid ").append(
                action >> MotionEvent.ACTION_POINTER_ID_SHIFT);
          sb.append(")");
       }
       sb.append("[");
       for (int i = 0; i < event.getPointerCount(); i++) {
          sb.append("#").append(i);
          sb.append("(pid ").append(event.getPointerId(i));
          sb.append(")=").append((int) event.getX(i));
          sb.append(",").append((int) event.getY(i));
          if (i + 1 < event.getPointerCount())
             sb.append(";");
       }
       sb.append("]");
       //Log.d(TAG, sb.toString());
    }
    private float sqrDistance(MotionEvent event) {
        float x = event.getX(0) - event.getX(1);
        float y = event.getY(0) - event.getY(1);
        return (float)(Math.sqrt(x * x + y * y));
     }
}