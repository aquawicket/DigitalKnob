#ifdef IOS
#import "DKApp.h"
#import "DKClass.h"
#import "DKFile.h"

@implementation iphoneViewerAppDelegate


////////////////////////////////////////////////////////////////////
- (void)applicationDidFinishLaunching:(UIApplication *)application {

    //NSBundle *bundle = [NSBundle mainBundle];
    //NSDictionary *info = [bundle infoDictionary];
    //NSString *prodName = [info objectForKey:@"CFBundleExecutable"];
    //DKString appname = std::string([prodName UTF8String]); //NSString to std::string
    NSString *epath = [[NSBundle mainBundle] executablePath];
    DKFile::exe_path = std::string([epath UTF8String]); //NSString to std::string

    //NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	//NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Populator"];
	//NSString *folderPath = [documentsDirectory stringByAppendingPathComponent:@"Files"];
	//NSLog(@"Source Path: %@\n Documents Path: %@ \n Folder Path: %@", sourcePath, documentsDirectory, folderPath); 
    
    //DKFile::appfilename = "/Users/aquawicket/Desktop/digitalknob/DKApps/"+appname+"/iossim32/Release-iphonesimulator/"+appname+".app/"+appname;
	
    DKApp dkapp;
    
	#ifdef DKAPP
		DKINFO("DKAPP defined\n");
	#endif
		
	DKINFO("Registered Classes\n");
	DKStringArray classes;
	DKClass::GetClassList(classes);
	for(int i=0; i<classes.size(); i++){
		DKINFO(classes[i]+"\n");
	}

	//Attempt to preload these
	DKClass::DKCreate("DKAssets");
	DKClass::DKCreate("DKDuktape");

	DKObject* app = DKClass::DKCreate("App"); //App.h/App.cpp (user code)
	dkapp.Init();
		
    [NSTimer scheduledTimerWithTimeInterval:1.0/30.0 target:self selector:@selector(updateScene) userInfo:nil repeats:YES];
}

///////////////////
- (void)updateScene
{
    DKApp::DoFrame();
}

/////////////////////////////////////////////////////////////////
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

///////////////////////////////////////////////////////////////
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

////////////////////////////////////////////////////////////
-(void)applicationWillTerminate:(UIApplication *)application
{
    DKApp::Exit();
} 

/////////////////////////////////////////////////////////////////////////////////////////////////
- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{
    //Use a basic low-pass filter to only keep the gravity in the accelerometer values
    accel[0] = acceleration.x * 30.0 + accel[0] * (1.0 - 0.1);
    accel[1] = acceleration.y * 30.0 + accel[1] * (1.0 - 0.1);
    accel[2] = acceleration.z * 30.0 + accel[2] * (1.0 - 0.1);
}

///////////////
- (void)dealloc
{
    [super dealloc];
}

@end
#endif //IOS
