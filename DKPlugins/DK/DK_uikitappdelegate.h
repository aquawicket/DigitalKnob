#if USE_AppDelegate

#import <UIKit/UIKit.h>

//'UIAccelerometerDelegate' is deprecated: first deprecated in iOS 13.0 - UIAcceleration has been replaced by the CoreMotion framework
//@interface AppDelegate : NSObject <UIApplicationDelegate, UIAccelerometerDelegate>{
//	UIAccelerationValue        accel[3];
//}
@interface AppDelegate : NSObject, UIApplicationDelegate {
    
}
    
//@property (nonatomic, retain) UIWindow *_window;
//- (void)updateScene;
//@end

#endif
