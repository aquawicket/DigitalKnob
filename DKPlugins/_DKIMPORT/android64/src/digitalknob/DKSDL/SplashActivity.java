// AUTO-GENERATED FILE. "DKSDL" is renamed.
package digitalknob.DKSDL;

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
