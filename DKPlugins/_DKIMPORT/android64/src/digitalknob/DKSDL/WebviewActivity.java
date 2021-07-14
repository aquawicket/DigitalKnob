// AUTO-GENERATED FILE. "DKSDL" is renamed.
package digitalknob.DKSDL;

import android.app.Activity;
import android.app.DownloadManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.ApplicationInfo;
import android.content.res.Configuration;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.view.MotionEvent;
import android.view.SurfaceView;
import android.view.View;
import android.webkit.DownloadListener;
import android.webkit.GeolocationPermissions;
import android.webkit.JavascriptInterface;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.FrameLayout;
import android.widget.Toast;
import android.widget.RelativeLayout;
import android.util.Log;


/////////////////////////////////////////////
public class WebviewActivity extends Activity 
{
	public static WebviewActivity instance;
    String homepage = "http://google.com";
	//String homepage = "file:////mnt/sdcard/appname/index.html";
	
    private ValueCallback<Uri> mUploadMessage;
    private final static int FILECHOOSER_RESULTCODE=1;
    private WebView mWebView;

	////////////////////////////////////////////////////////////
    @Override protected void onCreate(Bundle savedInstanceState) 
	{
		Log.d("WebviewActivity.java", "onCreate");
        super.onCreate(savedInstanceState);
		instance = this;
		
        setContentView(R.layout.webview);
        mWebView=(WebView)findViewById(R.id.webview_webview);

		if (0 != (getApplicationInfo().flags & ApplicationInfo.FLAG_DEBUGGABLE)){
            mWebView.setWebContentsDebuggingEnabled(true); //Debuggable in Chrome
        }
        mWebView.setInitialScale(1);
        mWebView.getSettings().setLoadWithOverviewMode(true);
        mWebView.getSettings().setUseWideViewPort(true);
        mWebView.getSettings().setJavaScriptEnabled(true);
        mWebView.getSettings().setAllowFileAccess(true);
        mWebView.getSettings().setAllowFileAccessFromFileURLs(true);
        mWebView.getSettings().setAllowUniversalAccessFromFileURLs(true);
		
		// Fix webview minimum font-size issue
		mWebView.getSettings().setMinimumFontSize(1);
		mWebView.getSettings().setMinimumLogicalFontSize(1);

        // Force links and redirects to open in the WebView instead of in a browser
        mWebView.setWebViewClient(new myWebViewClient());

        //Only disabled the horizontal scrolling:
        //mWebView.getSettings().setLayoutAlgorithm(WebSettings.LayoutAlgorithm.SINGLE_COLUMN);

        mWebView.setVerticalScrollBarEnabled(false);
        mWebView.setHorizontalScrollBarEnabled(false);

        mWebView.getSettings().setAppCacheEnabled(false);
        mWebView.getSettings().setCacheMode(WebSettings.LOAD_NO_CACHE);
		
		/*
		RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(640, 480);
        params.leftMargin = 30;
        params.bottomMargin = 100;
        params.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM, RelativeLayout.TRUE);
        mWebView.setLayoutParams(params);
		*/

		//Open links in WebView
        mWebView.setWebChromeClient(new myWebChromeClient(){
			
			///////////////////////////////////////////////////////////////////////////////////////////////////////
            public void onGeolocationPermissionsShowPrompt(String origin, GeolocationPermissions.Callback callback)
			{
				Log.d("WebviewActivity.java", "onGeolocationPermissionsShowPrompt");
                callback.invoke(origin, true, false);
            }

            //The undocumented magic method override
            //Eclipse will swear at you if you try to put @Override here
            // For Android 3.0+
            public void openFileChooser(ValueCallback<Uri> uploadMsg)
			{
				Log.d("WebviewActivity.java", "openFileChooser");
                mUploadMessage = uploadMsg;
                Intent i = new Intent(Intent.ACTION_GET_CONTENT);
                i.addCategory(Intent.CATEGORY_OPENABLE);
                i.setType("image/*");
                WebviewActivity.this.startActivityForResult(Intent.createChooser(i, "File Chooser"), FILECHOOSER_RESULTCODE);
            }

            // For Android 3.0+
            public void openFileChooser(ValueCallback uploadMsg, String acceptType) 
			{
				Log.d("WebviewActivity.java", "openFileChooser");
                mUploadMessage = uploadMsg;
                Intent i = new Intent(Intent.ACTION_GET_CONTENT);
                i.addCategory(Intent.CATEGORY_OPENABLE);
                i.setType("*/*");
                WebviewActivity.this.startActivityForResult(
                        Intent.createChooser(i, "File Browser"),
                        FILECHOOSER_RESULTCODE);
            }

            //For Android 4.1
            public void openFileChooser(ValueCallback<Uri> uploadMsg, String acceptType, String capture) 
			{
				Log.d("WebviewActivity.java", "openFileChooser");
                mUploadMessage = uploadMsg;
                Intent i = new Intent(Intent.ACTION_GET_CONTENT);
                i.addCategory(Intent.CATEGORY_OPENABLE);
                i.setType("image/*");
                WebviewActivity.this.startActivityForResult(Intent.createChooser(i, "File Chooser"), WebviewActivity.FILECHOOSER_RESULTCODE);
            }
        });

        //Download in WebView
        mWebView.setDownloadListener(new DownloadListener(){
			
            public void onDownloadStart(String url, String userAgent, String contentDisposition, String mimetype, long contentLength)
			{
				Log.d("WebviewActivity.java", "onDownloadStart");
				DownloadManager.Request request = new DownloadManager.Request(Uri.parse(url));

				request.allowScanningByMediaScanner();
				request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED); //Notify client once download is completed!
				final String fileName = url.substring(url.lastIndexOf('/') + 1);
				String destination = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS) + "/" +fileName;
				final Uri uri = Uri.parse("file://" + destination);
				request.setDestinationInExternalPublicDir(Environment.DIRECTORY_DOWNLOADS, fileName);
				final DownloadManager dm = (DownloadManager) getSystemService(DOWNLOAD_SERVICE);
				final long downloadId = dm.enqueue(request);
				Intent intent = new Intent(Intent.ACTION_OPEN_DOCUMENT); //This is important!
				intent.addCategory(Intent.CATEGORY_OPENABLE); //CATEGORY.OPENABLE
				intent.setType("*/*");//any application,any extension
				Toast.makeText(getApplicationContext(), "Downloading File", Toast.LENGTH_LONG).show();

				BroadcastReceiver onComplete = new BroadcastReceiver(){
                
					public void onReceive(Context ctxt, Intent intent)
					{
						Log.d("WebviewActivity.java", "onReceive");
						Intent install = new Intent(Intent.ACTION_VIEW);
						install.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
						if(fileName.contains(".apk")) {
							install.setDataAndType(uri, "application/vnd.android.package-archive");
						}
						else{
							install.setDataAndType(uri, dm.getMimeTypeForDownloadedFile(downloadId));
						}
						startActivity(install);
						unregisterReceiver(this);
						finish();
					}
				};

				registerReceiver(onComplete, new IntentFilter(DownloadManager.ACTION_DOWNLOAD_COMPLETE));
            }
        });

        /*
        //Download in browser
        mWebView.setDownloadListener(new DownloadListener() {
            public void onDownloadStart(String url, String userAgent,
                                        String contentDisposition, String mimetype,
                                        long contentLength) {
                Intent i = new Intent(Intent.ACTION_VIEW);
                i.setData(Uri.parse(url));
                startActivity(i);
            }
        });
        */

		mWebView.addJavascriptInterface(new JavaScriptInterface(), "DK");
        mWebView.loadUrl(homepage);
		DK.CallCppFunction("DKWebview_onCreate");
    }

	/////////////////////////////////
    private class JavaScriptInterface
    {
        @JavascriptInterface public String CallCppFunction(String data){
            //Toast.makeText(WebviewActivity.instance, "CallCppFunction("+data+")", Toast.LENGTH_LONG).show();
            return DK.CallCppFunction(data);
        }
    }

    /////////////////////////////////////////
    public void AttachFunction(String string)
    {
        Log.d("WebviewActivity.java", "AttachFunction("+string+")");
        //mWebView.loadUrl("javascript:function myfunc(){ DK.CallCppFunction('myfunc'); }");
        mWebView.loadUrl("javascript:"+string);
    }
	
    boolean doubleBackToExitPressedOnce = false;
	/////////////////////////////////////
    @Override public void onBackPressed() 
	{
		Log.d("WebviewActivity.java", "onBackPressed()");
        if(doubleBackToExitPressedOnce){
            super.onBackPressed();
			finishAffinity();
            return;
        }
        if (mWebView.canGoBack()){
            mWebView.goBack();
        }
		else{
            mWebView.scrollTo(0,0);
            this.doubleBackToExitPressedOnce = true;
            Toast.makeText(this, "Please click BACK again to exit", Toast.LENGTH_SHORT).show();

            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    doubleBackToExitPressedOnce = false;
                }
            }, 2000);
        }
    }

    /////////////////////////////////////////////////////////////////////
    @Override public void onConfigurationChanged(Configuration newConfig)
	{
		Log.d("WebviewActivity.java", "onConfigurationChanged()");
        super.onConfigurationChanged(newConfig);
    }

	/////////////////////////////////////////////////////////////////////////////////////////
    @Override protected void onActivityResult(int requestCode, int resultCode, Intent intent) 
	{
		Log.d("WebviewActivity.java", "onActivityResult()");
        if(requestCode==FILECHOOSER_RESULTCODE){
            if (null == mUploadMessage) return;
            Uri result = intent == null || resultCode != RESULT_OK ? null : intent.getData();
            mUploadMessage.onReceiveValue(result);
            mUploadMessage = null;
        }
    }
	
	////////////////////////////////////////////////////////
	@Override public boolean onTouchEvent(MotionEvent event)
    {
        Log.d("WebviewActivity.java","WebviewActivity.onTouchEvent");
        SurfaceView surfaceView = SDLSurface.instance;
        return surfaceView.dispatchTouchEvent(event); //send event to SDL
    }
	
	/*
    ///////////////////////////////////////////////////////////////
    @Override public boolean onKeyDown(int keyCode, KeyEvent event)
    {
        Log.d("WebviewActivity.java","WebviewActivity.onKeyDown");
        SurfaceView surfaceView = SDLSurface.instance;
        //return surfaceView.dispatchKeyEvent(event);
        surfaceView.onKeyDown(keyCode, event);
        return super.onKeyDown(keyCode, event);
    }

    /////////////////////////////////////////////////////////////
    @Override public boolean onKeyUp(int keyCode, KeyEvent event)
    {
        Log.d("WebviewActivity.java","WebviewActivity.onKeyUp");
        SurfaceView surfaceView = SDLSurface.instance;
        //return surfaceView.dispatchKeyEvent(event);
        surfaceView.onKeyUp(keyCode, event);
        return super.onKeyUp(keyCode, event);
    }
    */
	
	//////////////////////////////////////////////////
    public class myWebViewClient extends WebViewClient
    {
		/////////////////////////////////////////////////////////////////////////////
        @Override public void onPageStarted(WebView view, String url, Bitmap favicon)
		{
			Log.d("WebviewActivity.java", "onPageStarted()");
            super.onPageStarted(view, url, favicon);
        }

		///////////////////////////////////////////////////////////////////////////
        @Override public boolean shouldOverrideUrlLoading(WebView view, String url)
		{
			Log.d("WebviewActivity.java", "shouldOverrideUrlLoading()");
            view.loadUrl(url);
            return true;
        }

		//////////////////////////////////////////////////////////////
        @Override public void onPageFinished(WebView view, String url)
		{
			Log.d("WebviewActivity.java", "onPageFinished()");
            super.onPageFinished(view, url);
        }
    }

	//////////////////////////////////////////////////////
    public class myWebChromeClient extends WebChromeClient
    {
        private View mCustomView;
        private WebChromeClient.CustomViewCallback mCustomViewCallback;
        protected FrameLayout mFullscreenContainer;
        private int mOriginalOrientation;
        private int mOriginalSystemUiVisibility;

        public myWebChromeClient(){}

        /*
        public Bitmap getDefaultVideoPoster()
        {
            if (WebviewActivity.this == null) {
                return null;
            }
            return BitmapFactory.decodeResource(WebviewActivity.this.getApplicationContext().getResources(), 2130837573);
        }
        */

		//////////////////////////////
        public void onHideCustomView()
        {
			Log.d("WebviewActivity.java", "onHideCustomView()");
            ((FrameLayout)WebviewActivity.this.getWindow().getDecorView()).removeView(this.mCustomView);
            this.mCustomView = null;
            WebviewActivity.this.getWindow().getDecorView().setSystemUiVisibility(this.mOriginalSystemUiVisibility);
            WebviewActivity.this.setRequestedOrientation(this.mOriginalOrientation);
            this.mCustomViewCallback.onCustomViewHidden();
            this.mCustomViewCallback = null;
        }

		////////////////////////////////////////////////////////////////////////////////////
        public void onShowCustomView(View view, WebChromeClient.CustomViewCallback callback)
        {
			Log.d("WebviewActivity.java", "onShowCustomView()");
            if (this.mCustomView != null)
            {
                onHideCustomView();
                return;
            }
            this.mCustomView = view;
			this.mCustomView.setBackgroundColor(Color.BLACK);
            this.mOriginalSystemUiVisibility = WebviewActivity.this.getWindow().getDecorView().getSystemUiVisibility();
            this.mOriginalOrientation = WebviewActivity.this.getRequestedOrientation();
            this.mCustomViewCallback = callback;
            ((FrameLayout)WebviewActivity.this.getWindow().getDecorView()).addView(this.mCustomView, new FrameLayout.LayoutParams(-1, -1));
            WebviewActivity.this.getWindow().getDecorView().setSystemUiVisibility(3846);
        }
    }
}