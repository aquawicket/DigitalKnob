// AUTO-GENERATED FILE. "dkapp" is renamed.
package digitalknob.dkapp;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;

public class SplashActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            @Override
            public void run(){
                finish();
            }
        }, 2000);

    }
}
