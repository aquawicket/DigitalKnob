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

import android.app.Dialog;
import android.content.Context;
import android.graphics.PixelFormat;
import android.opengl.GLSurfaceView;
import android.util.AttributeSet;
import android.util.Log;
import android.view.*;
import javax.microedition.khronos.egl.EGL10;
import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.egl.EGLContext;
import javax.microedition.khronos.egl.EGLDisplay;
import javax.microedition.khronos.opengles.GL10;

/**
 * A simple GLSurfaceView sub-class that demonstrate how to perform
 * OpenGL ES 1.0 rendering into a GL Surface. Note the following important
 * details:
 *
 * - The class must use a custom context factory to enable 1.0 rendering.
 *   See ContextFactory class definition below.
 *
 * - The class must use a custom EGLConfigChooser to be able to select
 *   an EGLConfig that supports 1.0. This is done by providing a config
 *   specification to eglChooseConfig() that has the attribute
 *   EGL10.ELG_RENDERABLE_TYPE containing the EGL_OPENGL_ES_BIT flag
 *   set. See ConfigChooser class definition below.
 *
 * - The class must select the surface's format, then choose an EGLConfig
 *   that matches it exactly (with regards to red/green/blue/alpha channels
 *   bit depths). Failure to do so would result in an EGL_BAD_MATCH error.
 */
 
//////////////////////////////////////////
public class EGLview extends GLSurfaceView
{
	private static String TAG = "EGLview";
	private static final boolean DEBUG = false;
	
	public EGLview(Context context){
	    super(context);
	    init(false, 16, 8);
	}
	public EGLview(Context context, AttributeSet attrs){
	    super(context,attrs);
	    init(false, 16, 8);
	}
	
	
	public EGLview(Context context, boolean translucent, int depth, int stencil){
	    super(context);
	    init(translucent, depth, stencil);
	}
	
	private void init(boolean translucent, int depth, int stencil){
	
	    /* By default, GLSurfaceView() creates a RGB_565 opaque surface.
	     * If we want a translucent one, we should change the surface's
	     * format here, using PixelFormat.TRANSLUCENT for GL Surfaces
	     * is interpreted as any 32-bit surface with alpha by SurfaceFlinger.
	     */
	    if (translucent){
	        this.getHolder().setFormat(PixelFormat.TRANSLUCENT);
	    }
	
	    /* Setup the context factory for 1.0 rendering.
	     * See ContextFactory class definition below
	     */
	    setEGLContextFactory(new ContextFactory());
	
	    /* We need to choose an EGLConfig that matches the format of
	     * our surface exactly. This is going to be done in our
	     * custom config chooser. See ConfigChooser class definition
	     * below.
	     */
	    //setEGLConfigChooser( translucent ?
	    //                     new ConfigChooser(8, 8, 8, 8, depth, stencil) :
	    //                     new ConfigChooser(5, 6, 5, 0, depth, stencil) );
	
	    setEGLConfigChooser(8 , 8, 8, 8, 16, 0);  //FIX
	    
	    /* Set the renderer responsible for frame rendering */
	    setRenderer(new Renderer());
	}
	
	private static class ContextFactory implements GLSurfaceView.EGLContextFactory {
	    private static int EGL_CONTEXT_CLIENT_VERSION = 0x3098;
	    public EGLContext createContext(EGL10 egl, EGLDisplay display, EGLConfig eglConfig){
	        Log.w(TAG, "creating OpenGL ES 1 context");
	        checkEglError("Before eglCreateContext", egl);
	        int[] attrib_list = {EGL_CONTEXT_CLIENT_VERSION, 1, EGL10.EGL_NONE };
	        EGLContext context = egl.eglCreateContext(display, eglConfig, EGL10.EGL_NO_CONTEXT, attrib_list);
	        checkEglError("After eglCreateContext", egl);
	        return context;
	    }
	
	    public void destroyContext(EGL10 egl, EGLDisplay display, EGLContext context){
	        egl.eglDestroyContext(display, context);
	    }
	}
	
	private static void checkEglError(String prompt, EGL10 egl){
	    int error;
	    while ((error = egl.eglGetError()) != EGL10.EGL_SUCCESS){
	        Log.e(TAG, String.format("%s: EGL error: 0x%x", prompt, error));
	    }
	}
	
	private static class ConfigChooser implements GLSurfaceView.EGLConfigChooser {
	
	    public ConfigChooser(int r, int g, int b, int a, int depth, int stencil){
	        mRedSize = r;
	        mGreenSize = g;
	        mBlueSize = b;
	        mAlphaSize = a;
	        mDepthSize = depth;
	        mStencilSize = stencil;
	    }
	
	    /* This EGL config specification is used to specify 1.x rendering.
	     * We use a minimum size of 4 bits for red/green/blue, but will
	     * perform actual matching in chooseConfig() below.
	     */
	    private static int EGL_OPENGL_ES_BIT = 1;
	    private static int[] s_configAttribs2 =
	    {
	        EGL10.EGL_RED_SIZE, 4,
	        EGL10.EGL_GREEN_SIZE, 4,
	        EGL10.EGL_BLUE_SIZE, 4,
	        EGL10.EGL_RENDERABLE_TYPE, EGL_OPENGL_ES_BIT,
	        EGL10.EGL_NONE
	    };
	
	    public EGLConfig chooseConfig(EGL10 egl, EGLDisplay display){
	
	        /* Get the number of minimally matching EGL configurations
	         */
	        int[] num_config = new int[1];
	        egl.eglChooseConfig(display, s_configAttribs2, null, 0, num_config);
	
	        int numConfigs = num_config[0];
	
	        if (numConfigs <= 0){
	            throw new IllegalArgumentException("No configs match configSpec");
	        }
	
	        /* Allocate then read the array of minimally matching EGL configs
	         */
	        EGLConfig[] configs = new EGLConfig[numConfigs];
	        egl.eglChooseConfig(display, s_configAttribs2, configs, numConfigs, num_config);
	
	        if (DEBUG){
	             printConfigs(egl, display, configs);
	        }
	        /* Now return the "best" one
	         */
	        return chooseConfig(egl, display, configs);
	    }
	
	    public EGLConfig chooseConfig(EGL10 egl, EGLDisplay display,
	            EGLConfig[] configs){
	        for(EGLConfig config : configs){
	            int d = findConfigAttrib(egl, display, config,
	                    EGL10.EGL_DEPTH_SIZE, 0);
	            int s = findConfigAttrib(egl, display, config,
	                    EGL10.EGL_STENCIL_SIZE, 0);
	
	            // We need at least mDepthSize and mStencilSize bits
	            if (d < mDepthSize || s < mStencilSize)
	                continue;
	
	            // We want an *exact* match for red/green/blue/alpha
	            int r = findConfigAttrib(egl, display, config,
	                    EGL10.EGL_RED_SIZE, 0);
	            int g = findConfigAttrib(egl, display, config,
	                        EGL10.EGL_GREEN_SIZE, 0);
	            int b = findConfigAttrib(egl, display, config,
	                        EGL10.EGL_BLUE_SIZE, 0);
	            int a = findConfigAttrib(egl, display, config,
	                    EGL10.EGL_ALPHA_SIZE, 0);
	
	            if (r == mRedSize && g == mGreenSize && b == mBlueSize && a == mAlphaSize)
	                return config;
	        }
	        return null;
	    }
	
	    private int findConfigAttrib(EGL10 egl, EGLDisplay display,
	            EGLConfig config, int attribute, int defaultValue){
	
	        if (egl.eglGetConfigAttrib(display, config, attribute, mValue)){
	            return mValue[0];
	        }
	        return defaultValue;
	    }
	
	    private void printConfigs(EGL10 egl, EGLDisplay display,
	        EGLConfig[] configs){
	        int numConfigs = configs.length;
	        Log.w(TAG, String.format("%d configurations", numConfigs));
	        for (int i = 0; i < numConfigs; i++){
	            Log.w(TAG, String.format("Configuration %d:\n", i));
	            printConfig(egl, display, configs[i]);
	        }
	    }
	
	    private void printConfig(EGL10 egl, EGLDisplay display,
	            EGLConfig config){
	        int[] attributes = {
	                EGL10.EGL_BUFFER_SIZE,
	                EGL10.EGL_ALPHA_SIZE,
	                EGL10.EGL_BLUE_SIZE,
	                EGL10.EGL_GREEN_SIZE,
	                EGL10.EGL_RED_SIZE,
	                EGL10.EGL_DEPTH_SIZE,
	                EGL10.EGL_STENCIL_SIZE,
	                EGL10.EGL_CONFIG_CAVEAT,
	                EGL10.EGL_CONFIG_ID,
	                EGL10.EGL_LEVEL,
	                EGL10.EGL_MAX_PBUFFER_HEIGHT,
	                EGL10.EGL_MAX_PBUFFER_PIXELS,
	                EGL10.EGL_MAX_PBUFFER_WIDTH,
	                EGL10.EGL_NATIVE_RENDERABLE,
	                EGL10.EGL_NATIVE_VISUAL_ID,
	                EGL10.EGL_NATIVE_VISUAL_TYPE,
	                0x3030, // EGL10.EGL_PRESERVED_RESOURCES,
	                EGL10.EGL_SAMPLES,
	                EGL10.EGL_SAMPLE_BUFFERS,
	                EGL10.EGL_SURFACE_TYPE,
	                EGL10.EGL_TRANSPARENT_TYPE,
	                EGL10.EGL_TRANSPARENT_RED_VALUE,
	                EGL10.EGL_TRANSPARENT_GREEN_VALUE,
	                EGL10.EGL_TRANSPARENT_BLUE_VALUE,
	                0x3039, // EGL10.EGL_BIND_TO_TEXTURE_RGB,
	                0x303A, // EGL10.EGL_BIND_TO_TEXTURE_RGBA,
	                0x303B, // EGL10.EGL_MIN_SWAP_INTERVAL,
	                0x303C, // EGL10.EGL_MAX_SWAP_INTERVAL,
	                EGL10.EGL_LUMINANCE_SIZE,
	                EGL10.EGL_ALPHA_MASK_SIZE,
	                EGL10.EGL_COLOR_BUFFER_TYPE,
	                EGL10.EGL_RENDERABLE_TYPE,
	                0x3042 // EGL10.EGL_CONFORMANT
	        };
	        String[] names = {
	                "EGL_BUFFER_SIZE",
	                "EGL_ALPHA_SIZE",
	                "EGL_BLUE_SIZE",
	                "EGL_GREEN_SIZE",
	                "EGL_RED_SIZE",
	                "EGL_DEPTH_SIZE",
	                "EGL_STENCIL_SIZE",
	                "EGL_CONFIG_CAVEAT",
	                "EGL_CONFIG_ID",
	                "EGL_LEVEL",
	                "EGL_MAX_PBUFFER_HEIGHT",
	                "EGL_MAX_PBUFFER_PIXELS",
	                "EGL_MAX_PBUFFER_WIDTH",
	                "EGL_NATIVE_RENDERABLE",
	                "EGL_NATIVE_VISUAL_ID",
	                "EGL_NATIVE_VISUAL_TYPE",
	                "EGL_PRESERVED_RESOURCES",
	                "EGL_SAMPLES",
	                "EGL_SAMPLE_BUFFERS",
	                "EGL_SURFACE_TYPE",
	                "EGL_TRANSPARENT_TYPE",
	                "EGL_TRANSPARENT_RED_VALUE",
	                "EGL_TRANSPARENT_GREEN_VALUE",
	                "EGL_TRANSPARENT_BLUE_VALUE",
	                "EGL_BIND_TO_TEXTURE_RGB",
	                "EGL_BIND_TO_TEXTURE_RGBA",
	                "EGL_MIN_SWAP_INTERVAL",
	                "EGL_MAX_SWAP_INTERVAL",
	                "EGL_LUMINANCE_SIZE",
	                "EGL_ALPHA_MASK_SIZE",
	                "EGL_COLOR_BUFFER_TYPE",
	                "EGL_RENDERABLE_TYPE",
	                "EGL_CONFORMANT"
	        };
	        int[] value = new int[1];
	        for (int i = 0; i < attributes.length; i++){
	            int attribute = attributes[i];
	            String name = names[i];
	            if ( egl.eglGetConfigAttrib(display, config, attribute, value)){
	                Log.w(TAG, String.format("  %s: %d\n", name, value[0]));
	            } else {
	                // Log.w(TAG, String.format("  %s: failed\n", name));
	                while (egl.eglGetError() != EGL10.EGL_SUCCESS);
	            }
	        }
	    }
	
	    // Subclasses can adjust these values:
	    protected int mRedSize;
	    protected int mGreenSize;
	    protected int mBlueSize;
	    protected int mAlphaSize;
	    protected int mDepthSize;
	    protected int mStencilSize;
	    private int[] mValue = new int[1];
	}
	
	private static class Renderer implements GLSurfaceView.Renderer {
	    public void onDrawFrame(GL10 gl){
	        DKMain.CallCppFunction("DKAndroid_step");
	    }
	
	    public void onSurfaceChanged(GL10 gl, int width, int height){
	    	DKMain.CallCppFunction("DKAndroid_init,"+Integer.toString(width)+","+Integer.toString(height));
	        DKMain.CallCppFunction("DKAndroid_onResize,"+Integer.toString(width)+","+Integer.toString(height));
	    }
	
	    public void onSurfaceCreated(GL10 gl, EGLConfig config){
	        	gl.glEnable(GL10.GL_DEPTH_TEST);
	        }
	    }
		    
}

