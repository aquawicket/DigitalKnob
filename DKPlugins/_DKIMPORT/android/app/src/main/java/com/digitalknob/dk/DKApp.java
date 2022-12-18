/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2022 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/


package com.digitalknob.dk;

import android.os.Bundle;
import android.os.Handler;
import android.util.Log;

import org.libsdl.app.SDLActivity;


public class DKApp extends SDLActivity {
	public static DKApp instance;

	@Override
	protected void onCreate(Bundle app) {
		Log.d("DKApp.java", "onCreate()");
		super.onCreate(app);
		instance = this;

	/*
		initJNIBridge(); // Calls C++ function to store object for C++ to Java bridge

		OpenActivity("SplashActivity");

		Handler handler = new Handler();
		handler.postDelayed(new Runnable() {
			@Override
			public void run(){
				copyAssets();

				//TODO: maybe we can check if the plugins is available - DKAvailable(data)
				//if(USE_dkappWindow){
				OpenActivity("SDLActivity");
				//}
				//else{
				//CallCppFunction("DKAndroid_init");
				//}

				//This gives DK time to register functions for Webview
				Handler handler2 = new Handler();
				handler2.postDelayed(new Runnable() {
					@Override
					public void run(){
						//TODO: maybe we can check if the plugins is available - DKAvailable(data)
						//if(HAVE_DKWebview){
						//OpenActivity("WebviewActivity");
						//}
					}
				}, 2000);
			}
		}, 2000);
		*/
	}
}

