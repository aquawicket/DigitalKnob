// AUTO-GENERATED FILE. "dkapp" is renamed.
package digitalknob.dkapp;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;

////////////////////////////////////////////
public class SplashActivity extends Activity
{
	public static SplashActivity instance;

	////////////////////////////////////////////////////////////
    @Override protected void onCreate(Bundle savedInstanceState)
	{
		Log.d("SplashActivity.java", "onCreate");
        super.onCreate(savedInstanceState);
		instance = this;
    }
}
