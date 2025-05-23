/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2025 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

// AUTO-GENERATED FILE. "dkapp" is renamed.
package digitalknob.dkapp;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.lang.reflect.Method;
import javax.microedition.khronos.opengles.GL10;
import android.app.*;
import android.content.*;
import android.text.InputType;
import android.view.*;
import android.view.inputmethod.BaseInputConnection;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputConnection;
import android.view.inputmethod.InputMethodManager;
import android.widget.AbsoluteLayout;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.os.*;
import android.util.Log;
import android.util.SparseArray;
import android.graphics.*;
import android.graphics.drawable.Drawable;
import android.media.*;
import android.hardware.*;
import android.content.pm.ActivityInfo;
import android.content.res.AssetManager;


/////////////////////////////////////////////////////////////
public class SDLActivity extends Activity implements Runnable
{
	public static SDLActivity instance;
	public static native int initSDL(Object arguments);

    // Keep track of the paused state
    public static boolean mIsPaused, mIsSurfaceReady, mHasFocus;
    public static boolean mExitCalledFromJava;

    /** If shared libraries (e.g. SDL or the native application) could not be loaded. */
    public static boolean mBrokenLibraries;

    // If we want to separate mouse and touch events.
    //  This is only toggled in native code when a hint is set!
    public static boolean mSeparateMouseAndTouch;

    // Main components
    protected static SDLActivity mSingleton;
    protected static SDLSurface mSurface;
    protected static View mTextEdit;
    protected static ViewGroup mLayout;
    protected static SDLJoystickHandler mJoystickHandler;

    // This is what SDL runs in. It invokes SDL_main(), eventually
    protected static Thread mSDLThread;

    // Audio
    protected static AudioTrack mAudioTrack;
    
    public static Context context;

    public static int width;
    public static int height;
    public static int format;
    public static float refresh;
    
	///////////////////////////
    public void loadLibraries()
	{
		Log.d("SDLActivity.java", "SDLActivity.loadLibraries()");
		System.loadLibrary("SDL2");
    }
	
	///////////////////////////
    @Override public void run()
	{
		Log.d("SDLActivity.java", "SDLActivity.run()");
		instance = this; 
		
        initSDL(mSingleton.getArguments());
    	DK.CallCppFunction("DKAndroid_init");
    	DK.CallCppFunction("DKAndroid_onResize,"+Integer.toString(width)+","+Integer.toString(height)+","+Integer.toString(format)+","+Float.toString(refresh));
    	DK.CallCppFunction("DKAndroid_loop");
        Log.v("SDL", "SDL thread terminated");
    }
	
    
    /**
     * This method is called by SDL before starting the native application thread.
     * It can be overridden to provide the arguments after the application name.
     * The default implementation returns an empty array. It never returns null.
     * @return arguments for the native application.
     */
    protected String[] getArguments() 
	{
        return new String[0];
    }

	///////////////////////////////
    public static void initialize() 
	{
		Log.d("SDLActivity.java", "SDLActivity.initialize()");
        // The static nature of the singleton and Android quirkyness force us to initialize everything here
        // Otherwise, when exiting the app and returning to it, these variables *keep* their pre exit values
        mSingleton = null;
        mSurface = null;
        mTextEdit = null;
        mLayout = null;
        mJoystickHandler = null;
        mSDLThread = null;
        mAudioTrack = null;
        mExitCalledFromJava = false;
        mBrokenLibraries = false;
        mIsPaused = false;
        mIsSurfaceReady = false;
        mHasFocus = true;
    }

    ////////////////////////////////////////////////////////////
    @Override protected void onCreate(Bundle savedInstanceState) 
	{
		Log.d("SDLActivity.java", "SDLActivity.onCreate()");
        Log.v("SDLActivity.java", "Device: " + android.os.Build.DEVICE);
        Log.v("SDLActivity.java", "Model: " + android.os.Build.MODEL);
        Log.v("SDLActivity.java", "onCreate(): " + mSingleton);
        super.onCreate(savedInstanceState);

        SDLActivity.initialize();
        // So we can call stuff from static callbacks
        mSingleton = this;

        // Load shared libraries
        String errorMsgBrokenLib = "";
        try {
            loadLibraries();
        } catch(UnsatisfiedLinkError e){
            System.err.println(e.getMessage());
            mBrokenLibraries = true;
            errorMsgBrokenLib = e.getMessage();
        } catch(Exception e){
            System.err.println(e.getMessage());
            mBrokenLibraries = true;
            errorMsgBrokenLib = e.getMessage();
        }

        if (mBrokenLibraries)
        {
            AlertDialog.Builder dlgAlert  = new AlertDialog.Builder(this);
            dlgAlert.setMessage("An error occurred while trying to start the application. Please try again and/or reinstall."
                  + System.getProperty("line.separator")
                  + System.getProperty("line.separator")
                  + "Error: " + errorMsgBrokenLib);
            dlgAlert.setTitle("SDL Error");
            dlgAlert.setPositiveButton("Exit",
                new DialogInterface.OnClickListener(){
                    @Override
                    public void onClick(DialogInterface dialog,int id){
                        // if this button is clicked, close current activity
                        SDLActivity.mSingleton.finish();
                    }
                });
           dlgAlert.setCancelable(false);
           dlgAlert.create().show();

           return;
        }

        // Set up the surface
        mSurface = new SDLSurface(getApplication());

        if(Build.VERSION.SDK_INT >= 12){
            mJoystickHandler = new SDLJoystickHandler_API12();
        }
        else {
            mJoystickHandler = new SDLJoystickHandler();
        }

        mLayout = new AbsoluteLayout(this);
        mLayout.addView(mSurface);

        setContentView(mLayout);
        
        // Get filename from "Open with" of another application
        Intent intent = getIntent();

        if (intent != null && intent.getData() != null){
            String filename = intent.getData().getPath();
            if (filename != null){
                Log.v("SDLActivity", "Got filename: " + filename);
                DK.CallCppFunction("DKAndroid_onDropFile,"+filename);
            }
        }
    }

    //////////////////////////////////
    @Override protected void onPause()
	{
        Log.d("SDLActivity.java", "SDLActivity.onPause()");
        super.onPause();

        if (SDLActivity.mBrokenLibraries){
           return;
        }

        SDLActivity.handlePause();
    }

	///////////////////////////////////
    @Override protected void onResume()
	{
        Log.d("SDLActivity.java", "SDLActivity.onResume()");
        super.onResume();

        if(SDLActivity.mBrokenLibraries){
           return;
        }

        SDLActivity.handleResume();
    }

	////////////////////////////////////////////////////////////
    @Override public void onWindowFocusChanged(boolean hasFocus) 
	{
		Log.d("SDLActivity.java", "SDLActivity.onWindowFocusChanged()");
        super.onWindowFocusChanged(hasFocus);
        
        if(SDLActivity.mBrokenLibraries){
           return;
        }

        SDLActivity.mHasFocus = hasFocus;
        if (hasFocus){
        	SDLActivity.handleResume();
        }
    }

	///////////////////////////////////
    @Override public void onLowMemory()
	{
        Log.d("SDLActivity.java", "SDLActivity.onLowMemory()");
        super.onLowMemory();

        if (SDLActivity.mBrokenLibraries){
           return;
        }
        DK.CallCppFunction("DKAndroid_onLowMemory");
    }

	////////////////////////////////////
    @Override protected void onDestroy()
	{
        Log.d("SDLActivity.java", "SDLActivity.onDestroy()");

        if (SDLActivity.mBrokenLibraries){
           super.onDestroy();
           // Reset everything in case the user re opens the app
           SDLActivity.initialize();
           return;
        }

        // Send a quit message to the application
        SDLActivity.mExitCalledFromJava = true;
		DK.CallCppFunction("DKAndroid_onQuit");

        // Now wait for the SDL thread to quit
        if (SDLActivity.mSDLThread != null){
            try {
                SDLActivity.mSDLThread.join();
            } catch(Exception e){
                Log.v("SDLActivity", "Problem stopping thread: " + e);
            }
            SDLActivity.mSDLThread = null;

            //Log.v("SDLActivity", "Finished waiting for SDL thread");
        }

        super.onDestroy();
        // Reset everything in case the user re opens the app
        SDLActivity.initialize();
    }

	/////////////////////////////////////////////////////////
    @Override public boolean dispatchKeyEvent(KeyEvent event)
	{
		Log.d("SDLActivity.java", "SDLActivity.dispatchKeyEvent()");
		
        if (SDLActivity.mBrokenLibraries){
           return false;
        }

        int keyCode = event.getKeyCode();
        // Ignore certain special keys so they're handled by Android
        if (keyCode == KeyEvent.KEYCODE_VOLUME_DOWN ||
            keyCode == KeyEvent.KEYCODE_VOLUME_UP ||
            keyCode == KeyEvent.KEYCODE_CAMERA ||
            keyCode == 168 || /* API 11: KeyEvent.KEYCODE_ZOOM_IN */
            keyCode == 169 /* API 11: KeyEvent.KEYCODE_ZOOM_OUT */
            ){
            return false;
        }
        return super.dispatchKeyEvent(event);
    }

    /** Called by onPause or surfaceDestroyed. Even if surfaceDestroyed
     *  is the first to be called, mIsSurfaceReady should still be set
     *  to 'true' during the call to onPause (in a usual scenario).
     */
    public static void handlePause() 
	{
		Log.d("SDLActivity.java", "SDLActivity.handlePause()");
        if (!SDLActivity.mIsPaused && SDLActivity.mIsSurfaceReady){
            SDLActivity.mIsPaused = true;
			DK.CallCppFunction("DKAndroid_onPause");
            mSurface.handlePause();
        }
    }

    /** Called by onResume or surfaceCreated. An actual resume should be done only when the surface is ready.
     * Note: Some Android variants may send multiple surfaceChanged events, so we don't need to resume
     * every time we get one of those events, only if it comes after surfaceDestroyed
     */
    public static void handleResume() 
	{
		Log.d("SDLActivity.java", "SDLActivity.handleResume()");
        if (SDLActivity.mIsPaused && SDLActivity.mIsSurfaceReady && SDLActivity.mHasFocus){
            SDLActivity.mIsPaused = false;
			DK.CallCppFunction("DKAndroid_onResume");
            mSurface.handleResume();
        }
    }

    /* The native thread has finished */
    public static void handleNativeExit() 
	{
		Log.d("SDLActivity.java", "SDLActivity.handleNativeExit()");
        SDLActivity.mSDLThread = null;
        mSingleton.finish();
    }


    // Messages from the SDLMain thread
    static final int COMMAND_CHANGE_TITLE = 1;
    static final int COMMAND_UNUSED = 2;
    static final int COMMAND_TEXTEDIT_HIDE = 3;
    static final int COMMAND_SET_KEEP_SCREEN_ON = 5;

    protected static final int COMMAND_USER = 0x8000;

    /**
     * This method is called by SDL if SDL did not handle a message itself.
     * This happens if a received message contains an unsupported command.
     * Method can be overwritten to handle Messages in a different class.
     * @param command the command of the message.
     * @param param the parameter of the message. May be null.
     * @return if the message was handled in overridden method.
     */
    protected boolean onUnhandledMessage(int command, Object param) 
	{
		Log.d("SDLActivity.java", "SDLActivity.onUnhandledMessage()");
        return false;
    }

    /**
     * A Handler class for Messages from native SDL applications.
     * It uses current Activities as target (e.g. for the title).
     * static to prevent implicit references to enclosing object.
     */
    protected static class SDLCommandHandler extends Handler 
	{
		////////////////////////////////////////////////
        @Override public void handleMessage(Message msg) 
		{
			Log.d("SDLActivity.java", "SDLCommandHandler.handleMessage()");
            Context context = getContext();
            if (context == null){
                Log.e("SDLActivity", "error handling message, getContext() returned null");
                return;
            }
            switch (msg.arg1){
            case COMMAND_CHANGE_TITLE:
                if (context instanceof Activity){
                    ((Activity) context).setTitle((String)msg.obj);
                } else {
                    Log.e("SDLActivity", "error handling message, getContext() returned no Activity");
                }
                break;
            case COMMAND_TEXTEDIT_HIDE:
                if (mTextEdit != null){
                    mTextEdit.setVisibility(View.GONE);

                    InputMethodManager imm = (InputMethodManager) context.getSystemService(Context.INPUT_METHOD_SERVICE);
                    imm.hideSoftInputFromWindow(mTextEdit.getWindowToken(), 0);
                }
                break;
            case COMMAND_SET_KEEP_SCREEN_ON:
            {
                Window window = ((Activity) context).getWindow();
                if (window != null){
                    if ((msg.obj instanceof Integer) && (((Integer) msg.obj).intValue() != 0)){
                        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
                    } else {
                        window.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
                    }
                }
                break;
            }
            default:
                if ((context instanceof SDLActivity) && !((SDLActivity) context).onUnhandledMessage(msg.arg1, msg.obj)){
                    Log.e("SDLActivity", "error handling message, command is " + msg.arg1);
                }
            }
        }
    }

    // Handler for the messages
    Handler commandHandler = new SDLCommandHandler();

    // Send a message from the SDLMain thread
    boolean sendCommand(int command, Object data) 
	{
		Log.d("SDLActivity.java", "SDLActivity.sendCommand()");
        Message msg = commandHandler.obtainMessage();
        msg.arg1 = command;
        msg.obj = data;
        return commandHandler.sendMessage(msg);
    }

    /**
     * This method is called by SDL using JNI.
     */
    public static boolean setActivityTitle(String title) 
	{
		Log.d("SDLActivity.java", "SDLActivity.setActivityTitle()");
        // Called from SDLMain() thread and can't directly affect the view
        return mSingleton.sendCommand(COMMAND_CHANGE_TITLE, title);
    }

    /**
     * This method is called by SDL using JNI.
     */
    public static boolean sendMessage(int command, int param) 
	{
		Log.d("SDLActivity.java", "SDLActivity.sendMessage()");
        return mSingleton.sendCommand(command, Integer.valueOf(param));
    }

    /**
     * This method is called by SDL using JNI.
     */
    public static Context getContext() 
	{
		Log.d("SDLActivity.java", "SDLActivity.getContext()");
        return mSingleton;
    }

    /**
     * This method is called by SDL using JNI.
     * @return result of getSystemService(name) but executed on UI thread.
     */
    public Object getSystemServiceFromUiThread(final String name) 
	{
		Log.d("SDLActivity.java", "SDLActivity.getSystemServiceFromUiThread()");
        final Object lock = new Object();
        final Object[] results = new Object[2]; // array for writable variables
        synchronized (lock){
            runOnUiThread(new Runnable(){
                @Override
                public void run(){
                    synchronized (lock){
                        results[0] = getSystemService(name);
                        results[1] = Boolean.TRUE;
                        lock.notify();
                    }
                }
            });
            if (results[1] == null){
                try {
                    lock.wait();
                } catch (InterruptedException ex){
                    ex.printStackTrace();
                }
            }
        }
        return results[0];
    }

    static class ShowTextInputTask implements Runnable 
	{
        /*
         * This is used to regulate the pan&scan method to have some offset from
         * the bottom edge of the input region and the top edge of an input
         * method (soft keyboard)
         */
        static final int HEIGHT_PADDING = 15;

        public int x, y, w, h;

		////////////////////////////////////////////////////
        public ShowTextInputTask(int x, int y, int w, int h) 
		{
			Log.d("SDLActivity.java", "ShowTextInputTask.ShowTextInputTask()");
            this.x = x;
            this.y = y;
            this.w = w;
            this.h = h;
        }

		///////////////////////////
        @Override public void run() 
		{
			Log.d("SDLActivity.java", "ShowTextInputTask.ShowTextInputTask:run()");
            AbsoluteLayout.LayoutParams params = new AbsoluteLayout.LayoutParams(
                    w, h + HEIGHT_PADDING, x, y);

            if (mTextEdit == null){
                mTextEdit = new DummyEdit(getContext());

                mLayout.addView(mTextEdit, params);
            } else {
                mTextEdit.setLayoutParams(params);
            }

            mTextEdit.setVisibility(View.VISIBLE);
            mTextEdit.requestFocus();

            InputMethodManager imm = (InputMethodManager) getContext().getSystemService(Context.INPUT_METHOD_SERVICE);
            imm.showSoftInput(mTextEdit, 0);
        }
    }

    /**
     * This method is called by SDL using JNI.
     */
    public static boolean showTextInput(int x, int y, int w, int h) 
	{
		Log.d("SDLActivity.java", "SDLActivity.showTextInput()");
        // Transfer the task to the main thread as a Runnable
        return mSingleton.commandHandler.post(new ShowTextInputTask(x, y, w, h));
    }

    /**
     * This method is called by SDL using JNI.
     */
    public static Surface getNativeSurface() 
	{
		Log.d("SDLActivity.java", "SDLActivity.getNativeSurface()");
        return SDLActivity.mSurface.getNativeSurface();
    }

    // Audio

    /**
     * This method is called by SDL using JNI.
     */
    public static int audioInit(int sampleRate, boolean is16Bit, boolean isStereo, int desiredFrames) 
	{
		Log.d("SDLActivity.java", "SDLActivity.audioInit()");
        int channelConfig = isStereo ? AudioFormat.CHANNEL_CONFIGURATION_STEREO : AudioFormat.CHANNEL_CONFIGURATION_MONO;
        int audioFormat = is16Bit ? AudioFormat.ENCODING_PCM_16BIT : AudioFormat.ENCODING_PCM_8BIT;
        int frameSize = (isStereo ? 2 : 1) * (is16Bit ? 2 : 1);

        Log.v("SDLActivity", "SDL audio: wanted " + (isStereo ? "stereo" : "mono") + " " + (is16Bit ? "16-bit" : "8-bit") + " " + (sampleRate / 1000f) + "kHz, " + desiredFrames + " frames buffer");

        // Let the user pick a larger buffer if they really want -- but ye
        // gods they probably shouldn't, the minimums are horrifyingly high
        // latency already
        desiredFrames = Math.max(desiredFrames, (AudioTrack.getMinBufferSize(sampleRate, channelConfig, audioFormat) + frameSize - 1) / frameSize);

        if (mAudioTrack == null){
            mAudioTrack = new AudioTrack(AudioManager.STREAM_MUSIC, sampleRate,
                    channelConfig, audioFormat, desiredFrames * frameSize, AudioTrack.MODE_STREAM);

            // Instantiating AudioTrack can "succeed" without an exception and the track may still be invalid
            // Ref: https://android.googlesource.com/platform/frameworks/base/+/refs/heads/master/media/java/android/media/AudioTrack.java
            // Ref: http://developer.android.com/reference/android/media/AudioTrack.html#getState()

            if (mAudioTrack.getState() != AudioTrack.STATE_INITIALIZED){
                Log.e("SDLActivity", "Failed during initialization of Audio Track");
                mAudioTrack = null;
                return -1;
            }

            mAudioTrack.play();
        }

        Log.v("SDLActivity", "SDL audio: got " + ((mAudioTrack.getChannelCount() >= 2) ? "stereo" : "mono") + " " + ((mAudioTrack.getAudioFormat() == AudioFormat.ENCODING_PCM_16BIT) ? "16-bit" : "8-bit") + " " + (mAudioTrack.getSampleRate() / 1000f) + "kHz, " + desiredFrames + " frames buffer");

        return 0;
    }

    /**
     * This method is called by SDL using JNI.
     */
    public static void audioWriteShortBuffer(short[] buffer) 
	{
		//Log.d("SDLActivity.java", "SDLActivity.audioWriteShortBuffer()");
        for (int i = 0; i < buffer.length; ){
            int result = mAudioTrack.write(buffer, i, buffer.length - i);
            if (result > 0){
                i += result;
            } else if (result == 0){
                try {
                    Thread.sleep(1);
                } catch(InterruptedException e){
                    // Nom nom
                }
            } else {
                Log.w("SDLActivity", "SDL audio: error return from write(short)");
                return;
            }
        }
    }

    /**
     * This method is called by SDL using JNI.
     */
    public static void audioWriteByteBuffer(byte[] buffer) 
	{
		//Log.d("SDLActivity.java", "SDLActivity.audioWriteByteBuffer()");
        for (int i = 0; i < buffer.length; ){
            int result = mAudioTrack.write(buffer, i, buffer.length - i);
            if (result > 0){
                i += result;
            } else if (result == 0){
                try {
                    Thread.sleep(1);
                } catch(InterruptedException e){
                    // Nom nom
                }
            } else {
                Log.w("SDLActivity", "SDL audio: error return from write(byte)");
                return;
            }
        }
    }

    /**
     * This method is called by SDL using JNI.
     */
    public static void audioQuit() 
	{
		Log.d("SDLActivity.java", "SDLActivity.audioQuit()");
        if (mAudioTrack != null){
            mAudioTrack.stop();
            mAudioTrack = null;
        }
    }

    // Input

    /**
     * This method is called by SDL using JNI.
     * @return an array which may be empty but is never null.
     */
    public static int[] inputGetInputDeviceIds(int sources) 
	{
		Log.d("SDLActivity.java", "SDLActivity.inputGetInputDeviceIds()");
        int[] ids = InputDevice.getDeviceIds();
        int[] filtered = new int[ids.length];
        int used = 0;
        for (int i = 0; i < ids.length; ++i){
            InputDevice device = InputDevice.getDevice(ids[i]);
            if ((device != null) && ((device.getSources() & sources) != 0)){
                filtered[used++] = device.getId();
            }
        }
        return Arrays.copyOf(filtered, used);
    }

    // Joystick glue code, just a series of stubs that redirect to the SDLJoystickHandler instance
    public static boolean handleJoystickMotionEvent(MotionEvent event) 
	{
		Log.d("SDLActivity.java", "SDLActivity.handleJoystickMotionEvent()");
        return mJoystickHandler.handleMotionEvent(event);
    }

    /**
     * This method is called by SDL using JNI.
     */
    public static void pollInputDevices() 
	{
		//Log.d("SDLActivity.java", "SDLActivity.pollInputDevices()");
        if (SDLActivity.mSDLThread != null){
            mJoystickHandler.pollInputDevices();
        }
    }

    // APK expansion files support

    /** com.android.vending.expansion.zipfile.ZipResourceFile object or null. */
    private Object expansionFile;

    /** com.android.vending.expansion.zipfile.ZipResourceFile's getInputStream() or null. */
    private Method expansionFileMethod;

    /**
     * This method was called by SDL using JNI.
     * deprecated because of an incorrect name
     */
    @Deprecated
    public InputStream openAPKExtensionInputStream(String fileName) throws IOException 
	{
		Log.d("SDLActivity.java", "SDLActivity.openAPKExtensionInputStream()");
        return openAPKExpansionInputStream(fileName);
    }

    /**
     * This method is called by SDL using JNI.
     * @return an InputStream on success or null if no expansion file was used.
     * @throws IOException on errors. Message is set for the SDL error message.
     */
    public InputStream openAPKExpansionInputStream(String fileName) throws IOException 
	{
		Log.d("SDLActivity.java", "SDLActivity.openAPKExpansionInputStream()");
        // Get a ZipResourceFile representing a merger of both the main and patch files
        if (expansionFile == null){
        	String mainHint = null;// = DK.CallCppFunction("DKAndroid_onGetHint,SDL_ANDROID_APK_EXPANSION_MAIN_FILE_VERSION");
            if (mainHint == null){
                return null; // no expansion use if no main version was set
            }
            String patchHint = null;
            if (patchHint == null){
                return null; // no expansion use if no patch version was set
            }

            Integer mainVersion;
            Integer patchVersion;
            try {
                mainVersion = Integer.valueOf(mainHint);
                patchVersion = Integer.valueOf(patchHint);
            } catch (NumberFormatException ex){
                ex.printStackTrace();
                throw new IOException("No valid file versions set for APK expansion files", ex);
            }

            try {
                // To avoid direct dependency on Google APK expansion library that is
                // not a part of Android SDK we access it using reflection
                expansionFile = Class.forName("com.android.vending.expansion.zipfile.APKExpansionSupport")
                    .getMethod("getAPKExpansionZipFile", Context.class, int.class, int.class)
                    .invoke(null, this, mainVersion, patchVersion);

                expansionFileMethod = expansionFile.getClass()
                    .getMethod("getInputStream", String.class);
            } catch (Exception ex){
                ex.printStackTrace();
                expansionFile = null;
                expansionFileMethod = null;
                throw new IOException("Could not access APK expansion support library", ex);
            }
        }

        // Get an input stream for a known file inside the expansion file ZIPs
        InputStream fileStream;
        try {
            fileStream = (InputStream)expansionFileMethod.invoke(expansionFile, fileName);
        } catch (Exception ex){
            // calling "getInputStream" failed
            ex.printStackTrace();
            throw new IOException("Could not open stream from APK expansion file", ex);
        }

        if (fileStream == null){
            // calling "getInputStream" was successful but null was returned
            throw new IOException("Could not find path in APK expansion file");
        }

        return fileStream;
    }

    // Messagebox

    /** Result of current messagebox. Also used for blocking the calling thread. */
    protected final int[] messageboxSelection = new int[1];

    /** Id of current dialog. */
    protected int dialogs = 0;

    /**
     * This method is called by SDL using JNI.
     * Shows the messagebox from UI thread and block calling thread.
     * buttonFlags, buttonIds and buttonTexts must have same length.
     * @param buttonFlags array containing flags for every button.
     * @param buttonIds array containing id for every button.
     * @param buttonTexts array containing text for every button.
     * @param colors null for default or array of length 5 containing colors.
     * @return button id or -1.
     */
    public int messageboxShowMessageBox(final int flags, final String title, final String message, final int[] buttonFlags,
										final int[] buttonIds, final String[] buttonTexts, final int[] colors) 
	{
		Log.d("SDLActivity.java", "SDLActivity.messageboxShowMessageBox()");
        messageboxSelection[0] = -1;

        // sanity checks

        if ((buttonFlags.length != buttonIds.length) && (buttonIds.length != buttonTexts.length)){
            return -1; // implementation broken
        }

        // collect arguments for Dialog

        final Bundle args = new Bundle();
        args.putInt("flags", flags);
        args.putString("title", title);
        args.putString("message", message);
        args.putIntArray("buttonFlags", buttonFlags);
        args.putIntArray("buttonIds", buttonIds);
        args.putStringArray("buttonTexts", buttonTexts);
        args.putIntArray("colors", colors);

        // trigger Dialog creation on UI thread

        runOnUiThread(new Runnable(){
            @Override
            public void run(){
                showDialog(dialogs++, args);
            }
        });

        // block the calling thread

        synchronized (messageboxSelection){
            try {
                messageboxSelection.wait();
            } catch (InterruptedException ex){
                ex.printStackTrace();
                return -1;
            }
        }

        // return selected value

        return messageboxSelection[0];
    }

    @Override protected Dialog onCreateDialog(int ignore, Bundle args) 
	{
		Log.d("SDLActivity.java", "SDLActivity.onCreateDialog()");
        // TODO set values from "flags" to messagebox dialog

        // get colors

        int[] colors = args.getIntArray("colors");
        int backgroundColor;
        int textColor;
        int buttonBorderColor;
        int buttonBackgroundColor;
        int buttonSelectedColor;
        if (colors != null){
            int i = -1;
            backgroundColor = colors[++i];
            textColor = colors[++i];
            buttonBorderColor = colors[++i];
            buttonBackgroundColor = colors[++i];
            buttonSelectedColor = colors[++i];
        } else {
            backgroundColor = Color.TRANSPARENT;
            textColor = Color.TRANSPARENT;
            buttonBorderColor = Color.TRANSPARENT;
            buttonBackgroundColor = Color.TRANSPARENT;
            buttonSelectedColor = Color.TRANSPARENT;
        }

        // create dialog with title and a listener to wake up calling thread

        final Dialog dialog = new Dialog(this);
        dialog.setTitle(args.getString("title"));
        dialog.setCancelable(false);
        dialog.setOnDismissListener(new DialogInterface.OnDismissListener(){
            @Override
            public void onDismiss(DialogInterface unused){
                synchronized (messageboxSelection){
                    messageboxSelection.notify();
                }
            }
        });

        // create text

        TextView message = new TextView(this);
        message.setGravity(Gravity.CENTER);
        message.setText(args.getString("message"));
        if (textColor != Color.TRANSPARENT){
            message.setTextColor(textColor);
        }

        // create buttons

        int[] buttonFlags = args.getIntArray("buttonFlags");
        int[] buttonIds = args.getIntArray("buttonIds");
        String[] buttonTexts = args.getStringArray("buttonTexts");

        final SparseArray<Button> mapping = new SparseArray<Button>();

        LinearLayout buttons = new LinearLayout(this);
        buttons.setOrientation(LinearLayout.HORIZONTAL);
        buttons.setGravity(Gravity.CENTER);
        for (int i = 0; i < buttonTexts.length; ++i){
            Button button = new Button(this);
            final int id = buttonIds[i];
            button.setOnClickListener(new View.OnClickListener(){
                @Override
                public void onClick(View v){
                    messageboxSelection[0] = id;
                    dialog.dismiss();
                }
            });
            if (buttonFlags[i] != 0){
                // see SDL_messagebox.h
                if ((buttonFlags[i] & 0x00000001) != 0){
                    mapping.put(KeyEvent.KEYCODE_ENTER, button);
                }
                if ((buttonFlags[i] & 0x00000002) != 0){
                    mapping.put(111, button); /* API 11: KeyEvent.KEYCODE_ESCAPE */
                }
            }
            button.setText(buttonTexts[i]);
            if (textColor != Color.TRANSPARENT){
                button.setTextColor(textColor);
            }
            if (buttonBorderColor != Color.TRANSPARENT){
                // TODO set color for border of messagebox button
            }
            if (buttonBackgroundColor != Color.TRANSPARENT){
                Drawable drawable = button.getBackground();
                if (drawable == null){
                    // setting the color this way removes the style
                    button.setBackgroundColor(buttonBackgroundColor);
                } else {
                    // setting the color this way keeps the style (gradient, padding, etc.)
                    drawable.setColorFilter(buttonBackgroundColor, PorterDuff.Mode.MULTIPLY);
                }
            }
            if (buttonSelectedColor != Color.TRANSPARENT){
                // TODO set color for selected messagebox button
            }
            buttons.addView(button);
        }

        // create content

        LinearLayout content = new LinearLayout(this);
        content.setOrientation(LinearLayout.VERTICAL);
        content.addView(message);
        content.addView(buttons);
        if (backgroundColor != Color.TRANSPARENT){
            content.setBackgroundColor(backgroundColor);
        }

        // add content to dialog and return

        dialog.setContentView(content);
        dialog.setOnKeyListener(new Dialog.OnKeyListener(){
            @Override
            public boolean onKey(DialogInterface d, int keyCode, KeyEvent event){
                Button button = mapping.get(keyCode);
                if (button != null){
                    if (event.getAction() == KeyEvent.ACTION_UP){
                        button.performClick();
                    }
                    return true; // also for ignored actions
                }
                return false;
            }
        });

        return dialog;
    }
}

/**
    SDLSurface. This is what we draw on, so we need to know when it's created
    in order to do anything useful.

    Because of this, that's where we set up the SDL thread
*/
class SDLSurface extends SurfaceView implements SurfaceHolder.Callback,
    View.OnKeyListener, View.OnTouchListener, SensorEventListener  {
	
	public static SurfaceView instance;
    // Sensors
    protected static SensorManager mSensorManager;
    protected static Display mDisplay;

    // Keep track of the surface size to normalize touch events
    protected static float mWidth, mHeight;
    
     // Startup
    public SDLSurface(Context context){
    	
		//Log.d("SDLActivity.java", "SDLSurface.SDLSurface()");
        super(context);
		instance = this;
        getHolder().addCallback(this);

        setFocusable(true);
        setFocusableInTouchMode(true);
        requestFocus();
        setOnKeyListener(this);
        setOnTouchListener(this);

        mDisplay = ((WindowManager)context.getSystemService(Context.WINDOW_SERVICE)).getDefaultDisplay();
        mSensorManager = (SensorManager)context.getSystemService(Context.SENSOR_SERVICE);

        if(Build.VERSION.SDK_INT >= 12){
            setOnGenericMotionListener(new SDLGenericMotionListener_API12());
        }

        // Some arbitrary defaults to avoid a potential division by zero
        mWidth = 1.0f;
        mHeight = 1.0f;
    }

    public void handlePause(){
		Log.d("SDLActivity.java", "SDLSurface.handlePause()");
        enableSensor(Sensor.TYPE_ACCELEROMETER, false);
    }

    public void handleResume(){
		Log.d("SDLActivity.java", "SDLSurface.handleResume()");
        setFocusable(true);
        setFocusableInTouchMode(true);
        requestFocus();
        setOnKeyListener(this);
        setOnTouchListener(this);
        enableSensor(Sensor.TYPE_ACCELEROMETER, true);
    }

    public Surface getNativeSurface() 
	{
		Log.d("SDLActivity.java", "SDLSurface.getNativeSurface()");
        return getHolder().getSurface();
    }

    // Called when we have a valid drawing surface
    @Override
    public void surfaceCreated(SurfaceHolder holder){
        Log.d("SDLActivity.java", "SDLSurface.surfaceCreated()");
        holder.setType(SurfaceHolder.SURFACE_TYPE_GPU);
    }

    // Called when we lose the surface
    @Override
    public void surfaceDestroyed(SurfaceHolder holder){
        Log.d("SDLActivity.java", "SDLSurface.surfaceDestroyed()");
        // Call this *before* setting mIsSurfaceReady to 'false'
        SDLActivity.handlePause();
        SDLActivity.mIsSurfaceReady = false;
		DK.CallCppFunction("DKAndroid_onSurfaceDestroyed");
    }

    // Called when the surface is resized
    @Override
    public void surfaceChanged(SurfaceHolder holder,
                               int format, int width, int height){
        Log.d("SDLActivity.java", "SDLSurface.surfaceChanged()");
        //setWillNotDraw(false);
    	
        int sdlFormat = 0x15151002; // SDL_PIXELFORMAT_RGB565 by default
        switch (format){
        case PixelFormat.A_8:
            Log.v("SDL", "pixel format A_8");
            break;
        case PixelFormat.LA_88:
            Log.v("SDL", "pixel format LA_88");
            break;
        case PixelFormat.L_8:
            Log.v("SDL", "pixel format L_8");
            break;
        case PixelFormat.RGBA_4444:
            Log.v("SDL", "pixel format RGBA_4444");
            sdlFormat = 0x15421002; // SDL_PIXELFORMAT_RGBA4444
            break;
        case PixelFormat.RGBA_5551:
            Log.v("SDL", "pixel format RGBA_5551");
            sdlFormat = 0x15441002; // SDL_PIXELFORMAT_RGBA5551
            break;
        case PixelFormat.RGBA_8888:
            Log.v("SDL", "pixel format RGBA_8888");
            sdlFormat = 0x16462004; // SDL_PIXELFORMAT_RGBA8888
            break;
        case PixelFormat.RGBX_8888:
            Log.v("SDL", "pixel format RGBX_8888");
            sdlFormat = 0x16261804; // SDL_PIXELFORMAT_RGBX8888
            break;
        case PixelFormat.RGB_332:
            Log.v("SDL", "pixel format RGB_332");
            sdlFormat = 0x14110801; // SDL_PIXELFORMAT_RGB332
            break;
        case PixelFormat.RGB_565:
            Log.v("SDL", "pixel format RGB_565");
            sdlFormat = 0x15151002; // SDL_PIXELFORMAT_RGB565
            break;
        case PixelFormat.RGB_888:
            Log.v("SDL", "pixel format RGB_888");
            // Not sure this is right, maybe SDL_PIXELFORMAT_RGB24 instead?
            sdlFormat = 0x16161804; // SDL_PIXELFORMAT_RGB888
            break;
        default:
            Log.v("SDL", "pixel format unknown " + format);
            break;
        }

        mWidth = width;
        mHeight = height;
        SDLActivity.width = width;
        SDLActivity.height = height;
        SDLActivity.format = sdlFormat;
        SDLActivity.refresh = mDisplay.getRefreshRate();
        DK.CallCppFunction("DKAndroid_onResize,"+Integer.toString(width)+","+Integer.toString(height)+","+Integer.toString(sdlFormat)+","+Float.toString(mDisplay.getRefreshRate()));
        Log.v("SDL", "Window size: " + width + "x" + height);

 
        boolean skip = false;
        int requestedOrientation = SDLActivity.mSingleton.getRequestedOrientation();

        if (requestedOrientation == ActivityInfo.SCREEN_ORIENTATION_UNSPECIFIED)
        {
            // Accept any
        }
        else if (requestedOrientation == ActivityInfo.SCREEN_ORIENTATION_PORTRAIT)
        {
            if (mWidth > mHeight){
               skip = true;
            }
        } else if (requestedOrientation == ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE){
            if (mWidth < mHeight){
               skip = true;
            }
        }

        // Special Patch for Square Resolution: Black Berry Passport
        if (skip){
           double min = Math.min(mWidth, mHeight);
           double max = Math.max(mWidth, mHeight);
           
           if (max / min < 1.20){
              Log.v("SDL", "Don't skip on such aspect-ratio. Could be a square resolution.");
              skip = false;
           }
        }

        if (skip){
           Log.v("SDL", "Skip .. Surface is not ready.");
           return;
        }


        // Set mIsSurfaceReady to 'true' *before* making a call to handleResume
        SDLActivity.mIsSurfaceReady = true;
		DK.CallCppFunction("DKAndroid_onSurfaceChanged");

        if (SDLActivity.mSDLThread == null){ 
            // This is the entry point to the C app.
            // Start up the C app thread and enable sensor input for the first time

            final Thread sdlThread = new Thread(new SDLActivity(), "SDLThread");
            enableSensor(Sensor.TYPE_ACCELEROMETER, true);
            sdlThread.start();

            // Set up a listener thread to catch when the native thread ends
            SDLActivity.mSDLThread = new Thread(new Runnable(){
                @Override
                public void run(){
                    try {
                        sdlThread.join();
                    }
                    catch(Exception e){}
                    finally{
                        // Native thread has finished
                        if (! SDLActivity.mExitCalledFromJava){
                            SDLActivity.handleNativeExit();
                        }
                    }
                }
            }, "SDLThreadListener");
            SDLActivity.mSDLThread.start();
        }

        if (SDLActivity.mHasFocus){
            SDLActivity.handleResume();
        }
    }

    // Key events
    @Override
    public boolean onKey(View  v, int keyCode, KeyEvent event){
		Log.d("SDLActivity.java", "SDLSurface.onKey()");
        // Dispatch the different events depending on where they come from
        // Some SOURCE_DPAD or SOURCE_GAMEPAD are also SOURCE_KEYBOARD
        // So, we try to process them as DPAD or GAMEPAD events first, if that fails we try them as KEYBOARD

        if ( (event.getSource() & InputDevice.SOURCE_GAMEPAD) != 0 ||
                   (event.getSource() & InputDevice.SOURCE_DPAD) != 0 ){
        	/*//TODO = fixme
            if (event.getAction() == KeyEvent.ACTION_DOWN){
                if (SDLActivity.onNativePadDown(event.getDeviceId(), keyCode) == 0){
                    return true;
                }
            } else if (event.getAction() == KeyEvent.ACTION_UP){
                if (SDLActivity.onNativePadUp(event.getDeviceId(), keyCode) == 0){
                    return true;
                }
            }
            */
        }

        if( (event.getSource() & InputDevice.SOURCE_KEYBOARD) != 0){
            if (event.getAction() == KeyEvent.ACTION_DOWN){
                //Log.v("SDL", "key down: " + keyCode);
                DK.CallCppFunction("DKAndroid_onKeyDown,"+Integer.toString(keyCode));
                return true;
            }
            else if (event.getAction() == KeyEvent.ACTION_UP){
                //Log.v("SDL", "key up: " + keyCode);
                DK.CallCppFunction("DKAndroid_onKeyUp,"+Integer.toString(keyCode));
                return true;
            }
        }

        return false;
    }

    ///////////////////////////////////////////////////////////
    @Override public boolean onTouch(View v, MotionEvent event)
	{
		Log.d("SDLActivity.java", "SDLSurface.onTouch()");
        /* Ref: http://developer.android.com/training/gestures/multi.html */
        final int touchDevId = event.getDeviceId();
        final int pointerCount = event.getPointerCount();
        int action = event.getActionMasked();
        int pointerFingerId;
        int mouseButton;
        int i = -1;
        float x,y,p;

        // !!! FIXME: dump this SDK check after 2.0.4 ships and require API14.
        if (event.getSource() == InputDevice.SOURCE_MOUSE && SDLActivity.mSeparateMouseAndTouch){
            if (Build.VERSION.SDK_INT < 14){
                mouseButton = 1;    // For Android==12 all mouse buttons are the left button
            } else {
                try {
                    mouseButton = (Integer) event.getClass().getMethod("getButtonState").invoke(event);
                } catch(Exception e){
                    mouseButton = 1;    // oh well.
                }
            }
            DK.CallCppFunction("DKAndroid_onMouse,"+Integer.toString(mouseButton)+","+Integer.toString(action)+","+Float.toString(event.getX(0))+","+Float.toString(event.getY(0)));
        } else {
            switch(action){
                case MotionEvent.ACTION_MOVE:
                    for (i = 0; i < pointerCount; i++){
                        pointerFingerId = event.getPointerId(i);
                        x = event.getX(i) / mWidth;
                        y = event.getY(i) / mHeight;
                        p = event.getPressure(i);
                        if (p > 1.0f){
                            // may be larger than 1.0f on some devices
                            // see the documentation of getPressure(i)
                            p = 1.0f;
                        }
                        DK.CallCppFunction("DKAndroid_onTouch,"+Integer.toString(touchDevId)+","+Integer.toString(pointerFingerId)+","+Integer.toString(action)+","+Float.toString(x)+","+Float.toString(y)+","+Float.toString(p));
                    }
                    break;

                case MotionEvent.ACTION_UP:
                case MotionEvent.ACTION_DOWN:
                    // Primary pointer up/down, the index is always zero
                    i = 0;
                case MotionEvent.ACTION_POINTER_UP:
                case MotionEvent.ACTION_POINTER_DOWN:
                    // Non primary pointer up/down
                    if (i == -1){
                        i = event.getActionIndex();
                    }

                    pointerFingerId = event.getPointerId(i);
                    x = event.getX(i) / mWidth;
                    y = event.getY(i) / mHeight;
                    p = event.getPressure(i);
                    if (p > 1.0f){
                        // may be larger than 1.0f on some devices
                        // see the documentation of getPressure(i)
                        p = 1.0f;
                    }
                    DK.CallCppFunction("DKAndroid_onTouch,"+Integer.toString(touchDevId)+","+Integer.toString(pointerFingerId)+","+Integer.toString(action)+","+Float.toString(x)+","+Float.toString(y)+","+Float.toString(p));
                    break;

                case MotionEvent.ACTION_CANCEL:
                    for (i = 0; i < pointerCount; i++){
                        pointerFingerId = event.getPointerId(i);
                        x = event.getX(i) / mWidth;
                        y = event.getY(i) / mHeight;
                        p = event.getPressure(i);
                        if (p > 1.0f){
                            // may be larger than 1.0f on some devices
                            // see the documentation of getPressure(i)
                            p = 1.0f;
                        }
                        DK.CallCppFunction("DKAndroid_onTouch,"+Integer.toString(touchDevId)+","+Integer.toString(pointerFingerId)+","+Integer.toString(MotionEvent.ACTION_UP)+","+Float.toString(x)+","+Float.toString(y)+","+Float.toString(p));
                    }
                    break;

                default:
                    break;
            }
        }

        return true;
   }

    // Sensor events
    public void enableSensor(int sensortype, boolean enabled){
		Log.d("SDLActivity.java", "SDLSurface.enableSensor()");
        // TODO: This uses getDefaultSensor - what if we have >1 accels?
        if (enabled){
            mSensorManager.registerListener(this,
                            mSensorManager.getDefaultSensor(sensortype),
                            SensorManager.SENSOR_DELAY_GAME, null);
        } else {
            mSensorManager.unregisterListener(this,
                            mSensorManager.getDefaultSensor(sensortype));
        }
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy){
		Log.d("SDLActivity.java", "SDLSurface.onAccuracyChanged()");
        // TODO
    }

    @Override
    public void onSensorChanged(SensorEvent event){
		//Log.d("SDLActivity.java", "SDLSurface.onSensorChanged()");
        if (event.sensor.getType() == Sensor.TYPE_ACCELEROMETER){
            float x, y;
            switch (mDisplay.getRotation()){
                case Surface.ROTATION_90:
                    x = -event.values[1];
                    y = event.values[0];
                    break;
                case Surface.ROTATION_270:
                    x = event.values[1];
                    y = -event.values[0];
                    break;
                case Surface.ROTATION_180:
                    x = -event.values[1];
                    y = -event.values[0];
                    break;
                default:
                    x = event.values[0];
                    y = event.values[1];
                    break;
            }
            DK.CallCppFunction("DKAndroid_onAccel,"+Float.toString(-x / SensorManager.GRAVITY_EARTH)+","+Float.toString(y / SensorManager.GRAVITY_EARTH)+","+Float.toString(event.values[2] / SensorManager.GRAVITY_EARTH - 1));
        }
    }
}

/* This is a fake invisible editor view that receives the input and defines the
 * pan&scan region
 */
class DummyEdit extends View implements View.OnKeyListener {
    InputConnection ic;

    public DummyEdit(Context context){
		//Log.d("SDLActivity.java", "DummyEdit.DummyEdit()");
        super(context);
        setFocusableInTouchMode(true);
        setFocusable(true);
        setOnKeyListener(this);
    }

    @Override
    public boolean onCheckIsTextEditor(){
		Log.d("SDLActivity.java", "DummyEdit.onCheckIsTextEditor()");
        return true;
    }

    @Override
    public boolean onKey(View v, int keyCode, KeyEvent event){

		Log.d("SDLActivity.java", "DummyEdit.onKey()");
        // This handles the hardware keyboard input
        if (event.isPrintingKey()){
            if (event.getAction() == KeyEvent.ACTION_DOWN){
                ic.commitText(String.valueOf((char) event.getUnicodeChar()), 1);
            }
            return true;
        }

        if (event.getAction() == KeyEvent.ACTION_DOWN){
            DK.CallCppFunction("DKAndroid_onKeyDown,"+Integer.toString(keyCode));
            return true;
        } else if (event.getAction() == KeyEvent.ACTION_UP){
            DK.CallCppFunction("DKAndroid_onKeyUp,"+Integer.toString(keyCode));
            return true;
        }

        return false;
    }

    //
    @Override
    public boolean onKeyPreIme (int keyCode, KeyEvent event){
		Log.d("SDLActivity.java", "DummyEdit.onKeyPreIme()");
        // As seen on StackOverflow: http://stackoverflow.com/questions/7634346/keyboard-hide-event
        // FIXME: Discussion at http://bugzilla.libsdl.org/show_bug.cgi?id=1639
        // FIXME: This is not a 100% effective solution to the problem of detecting if the keyboard is showing or not
        // FIXME: A more effective solution would be to change our Layout from AbsoluteLayout to Relative or Linear
        // FIXME: And determine the keyboard presence doing this: http://stackoverflow.com/questions/2150078/how-to-check-visibility-of-software-keyboard-in-android
        // FIXME: An even more effective way would be if Android provided this out of the box, but where would the fun be in that :)
        if (event.getAction()==KeyEvent.ACTION_UP && keyCode == KeyEvent.KEYCODE_BACK){
            if (SDLActivity.mTextEdit != null && SDLActivity.mTextEdit.getVisibility() == View.VISIBLE){
				DK.CallCppFunction("DKAndroid_onKeyboardFocusLost");
            }
        }
        return super.onKeyPreIme(keyCode, event);
    }

    @Override
    public InputConnection onCreateInputConnection(EditorInfo outAttrs){
		Log.d("SDLActivity.java", "DummyEdit.onCreateInputConnection()");
        ic = new SDLInputConnection(this, true);

        outAttrs.inputType = InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD;
        outAttrs.imeOptions = EditorInfo.IME_FLAG_NO_EXTRACT_UI
                | 33554432 /* API 11: EditorInfo.IME_FLAG_NO_FULLSCREEN */;

        return ic;
    }
}

class SDLInputConnection extends BaseInputConnection {

    public SDLInputConnection(View targetView, boolean fullEditor){
		//Log.d("SDLActivity.java", "SDLInputConnection.SDLInputConnection()");
        super(targetView, fullEditor);

    }

    @Override
    public boolean sendKeyEvent(KeyEvent event){
		Log.d("SDLActivity.java", "SDLInputConnection.sendKeyEvent()");
        /*
         * This handles the keycodes from soft keyboard (and IME-translated
         * input from hardkeyboard)
         */
        int keyCode = event.getKeyCode();
        if (event.getAction() == KeyEvent.ACTION_DOWN){
            if (event.isPrintingKey()){
                commitText(String.valueOf((char) event.getUnicodeChar()), 1);
            }
            DK.CallCppFunction("DKAndroid_onKeyDown,"+Integer.toString(keyCode));
            return true;
        } else if (event.getAction() == KeyEvent.ACTION_UP){

            DK.CallCppFunction("DKAndroid_onKeyUp,"+Integer.toString(keyCode));
            return true;
        }
        return super.sendKeyEvent(event);
    }

    @Override
    public boolean commitText(CharSequence text, int newCursorPosition){
		Log.d("SDLActivity.java", "SDLInputConnection.commitText()");
		//DK.CallCppFunction("DKAndroid_onCommitText");
        nativeCommitText(text.toString(), newCursorPosition);

        return super.commitText(text, newCursorPosition);
    }

    @Override
    public boolean setComposingText(CharSequence text, int newCursorPosition){
		Log.d("SDLActivity.java", "SDLInputConnection.setComposingText()");
		//DK.CallCppFunction("DKAndroid_onComposingText");
        nativeSetComposingText(text.toString(), newCursorPosition);

        return super.setComposingText(text, newCursorPosition);
    }

    public native void nativeCommitText(String text, int newCursorPosition);
    public native void nativeSetComposingText(String text, int newCursorPosition);

    @Override
    public boolean deleteSurroundingText(int beforeLength, int afterLength){
		Log.d("SDLActivity.java", "SDLInputConnection.deleteSurroundingText()");
        // Workaround to capture backspace key. Ref: http://stackoverflow.com/questions/14560344/android-backspace-in-webview-baseinputconnection
        if (beforeLength == 1 && afterLength == 0){
            // backspace
            return super.sendKeyEvent(new KeyEvent(KeyEvent.ACTION_DOWN, KeyEvent.KEYCODE_DEL))
                && super.sendKeyEvent(new KeyEvent(KeyEvent.ACTION_UP, KeyEvent.KEYCODE_DEL));
        }

        return super.deleteSurroundingText(beforeLength, afterLength);
    }
}

/* A null joystick handler for API level < 12 devices (the accelerometer is handled separately) */
class SDLJoystickHandler {

    /**
     * Handles given MotionEvent.
     * @param event the event to be handled.
     * @return if given event was processed.
     */
    public boolean handleMotionEvent(MotionEvent event){
		Log.d("SDLActivity.java", "SDLJoystickHandler.handleMotionEvent()");
        return false;
    }

    /**
     * Handles adding and removing of input devices.
     */
    public void pollInputDevices(){
		Log.d("SDLActivity.java", "SDLJoystickHandler.pollInputDevices()");
    }
}

/* Actual joystick functionality available for API >= 12 devices */
class SDLJoystickHandler_API12 extends SDLJoystickHandler {

    static class SDLJoystick {
        public int device_id;
        public String name;
        public ArrayList<InputDevice.MotionRange> axes;
        public ArrayList<InputDevice.MotionRange> hats;
    }
    static class RangeComparator implements Comparator<InputDevice.MotionRange> {
        @Override
        public int compare(InputDevice.MotionRange arg0, InputDevice.MotionRange arg1){
            return arg0.getAxis() - arg1.getAxis();
        }
    }

    private ArrayList<SDLJoystick> mJoysticks;

    public SDLJoystickHandler_API12(){

        mJoysticks = new ArrayList<SDLJoystick>();
    }

    @Override
    public void pollInputDevices(){
        int[] deviceIds = InputDevice.getDeviceIds();
        // It helps processing the device ids in reverse order
        // For example, in the case of the XBox 360 wireless dongle,
        // so the first controller seen by SDL matches what the receiver
        // considers to be the first controller

        for(int i=deviceIds.length-1; i>-1; i--){
            SDLJoystick joystick = getJoystick(deviceIds[i]);
            if (joystick == null){
                joystick = new SDLJoystick();
                InputDevice joystickDevice = InputDevice.getDevice(deviceIds[i]);

                if ( 
                      (joystickDevice.getSources() & InputDevice.SOURCE_CLASS_JOYSTICK) != 0 
                   ||
                      (joystickDevice.getSources() & InputDevice.SOURCE_CLASS_BUTTON) != 0 
                  )
                {
                    joystick.device_id = deviceIds[i];
                    joystick.name = joystickDevice.getName();
                    joystick.axes = new ArrayList<InputDevice.MotionRange>();
                    joystick.hats = new ArrayList<InputDevice.MotionRange>();

                    List<InputDevice.MotionRange> ranges = joystickDevice.getMotionRanges();
                    Collections.sort(ranges, new RangeComparator());
                    for (InputDevice.MotionRange range : ranges ){
                        if ((range.getSource() & InputDevice.SOURCE_CLASS_JOYSTICK) != 0 ){
                            if (range.getAxis() == MotionEvent.AXIS_HAT_X ||
                                range.getAxis() == MotionEvent.AXIS_HAT_Y){
                                joystick.hats.add(range);
                            }
                            else {
                                joystick.axes.add(range);
                            }
                        }
                    }

                    mJoysticks.add(joystick);
                    
					//FIXME: causes crash					//DK.CallCppFunction("DKAndroid_onAddJoystick,"+Integer.toString(joystick.device_id)+","+joystick.name+",0,-1,"+Integer.toString(joystick.axes.size())+","+Integer.toString(joystick.hats.size()/2)+",0");
                }
            }
        }

        /* Check removed devices */
        ArrayList<Integer> removedDevices = new ArrayList<Integer>();
        for(int i=0; i < mJoysticks.size(); i++){
            int device_id = mJoysticks.get(i).device_id;
            int j;
            for (j=0; j < deviceIds.length; j++){
                if (device_id == deviceIds[j]) break;
            }
            if (j == deviceIds.length){
                removedDevices.add(Integer.valueOf(device_id));
            }
        }

        for(int i=0; i < removedDevices.size(); i++){
            int device_id = removedDevices.get(i).intValue();
            DK.CallCppFunction("DKAndroid_onRemoveJoystick,"+device_id);
            for (int j=0; j < mJoysticks.size(); j++){
                if (mJoysticks.get(j).device_id == device_id){
                    mJoysticks.remove(j);
                    break;
                }
            }
        }
    }

    protected SDLJoystick getJoystick(int device_id){
        for(int i=0; i < mJoysticks.size(); i++){
            if (mJoysticks.get(i).device_id == device_id){
                return mJoysticks.get(i);
            }
        }
        return null;
    }

    @Override
    public boolean handleMotionEvent(MotionEvent event){
        if ( (event.getSource() & InputDevice.SOURCE_JOYSTICK) != 0){
            int actionPointerIndex = event.getActionIndex();
            int action = event.getActionMasked();
            switch(action){
                case MotionEvent.ACTION_MOVE:
                    SDLJoystick joystick = getJoystick(event.getDeviceId());
                    if ( joystick != null ){
                        for (int i = 0; i < joystick.axes.size(); i++){
                            InputDevice.MotionRange range = joystick.axes.get(i);
                            /* Normalize the value to -1...1 */
                            float value = ( event.getAxisValue( range.getAxis(), actionPointerIndex) - range.getMin() ) / range.getRange() * 2.0f - 1.0f;
                            DK.CallCppFunction("DKAndroid_onJoy,"+Integer.toString(joystick.device_id)+","+Integer.toString(i)+","+Float.toString(value));
                        }
                        for (int i = 0; i < joystick.hats.size(); i+=2){
                            int hatX = Math.round(event.getAxisValue( joystick.hats.get(i).getAxis(), actionPointerIndex ) );
                            int hatY = Math.round(event.getAxisValue( joystick.hats.get(i+1).getAxis(), actionPointerIndex ) );
                            DK.CallCppFunction("DKAndroid_onHat,"+Integer.toString(joystick.device_id)+","+Integer.toString(i/2)+","+Integer.toString(hatX)+","+Integer.toString(hatY));
                        }
                    }
                    break;
                default:
                    break;
            }
        }
        return true;
    }
}

class SDLGenericMotionListener_API12 implements View.OnGenericMotionListener {
    // Generic Motion (mouse hover, joystick...) events go here
    @Override
    public boolean onGenericMotion(View v, MotionEvent event){
        float x, y;
        int action;

        switch ( event.getSource() ){
            case InputDevice.SOURCE_JOYSTICK:
            case InputDevice.SOURCE_GAMEPAD:
            case InputDevice.SOURCE_DPAD:
                SDLActivity.handleJoystickMotionEvent(event);
                return true;

            case InputDevice.SOURCE_MOUSE:
                action = event.getActionMasked();
                switch (action){
                    case MotionEvent.ACTION_SCROLL:
                        x = event.getAxisValue(MotionEvent.AXIS_HSCROLL, 0);
                        y = event.getAxisValue(MotionEvent.AXIS_VSCROLL, 0);
                        DK.CallCppFunction("DKAndroid_onMouse,0,"+Integer.toString(action)+","+Float.toString(x)+","+Float.toString(y));
                        return true;

                    case MotionEvent.ACTION_HOVER_MOVE:
                        x = event.getX(0);
                        y = event.getY(0);

                        DK.CallCppFunction("DKAndroid_onMouse,0,"+Integer.toString(action)+","+Float.toString(x)+","+Float.toString(y));
                        return true;

                    default:
                        break;
                }
                break;

            default:
                break;
        }

        // Event was not managed
        return false;
    }
}
