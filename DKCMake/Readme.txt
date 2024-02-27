*** DKCMake: The DigitalKnob Build System ***

* There is only one CMakeLists.txt file in the root of the /digitalknob folder.

* When running Cmake, the source path is always the /digitalknob folder, where the CMakeLists.txt file is located. 
* The build directory is the path to the app followed by the OS.  i.e  DKApps/DKMyApp/win32  
	* Output Build OS's are
		* /android_arm32
		* /android_arm64
		* /emscripten
		* /ios_arm32
		* /ios_arm64
		* /iossim_x86
		* /iossim64
		* /linux32
		* /linux64
		* /mac32
		* /mac64
		* /raspberry32
		* /raspberry64
		* /win32
		* /win64
		
* Note: DKCMake will fill in most variables by the path you have selected.		

* Upon loading DKCMake.cmake, variables required will be...
	TYPE - (Debug, Release, All)
	LEVEL - (Build, Rebuild, RebuildAll)
		Build - "Build the project wihtout dependencies"
		Rebuild - "Rebuild the project wihtout dependencies"
		RebuildAll - "Rebuild the project and dependencies"
	
* All Apps, Plugins and 3rdParty Libraries, require a DKMAKE.cmake file to interact with the build system.


****************************************************
**     Building from the a CMake gui 
****************************************************

*** SOURCE DIRECTORY ****
/digitalknob      ( I.E.  C:/Users/username/digitalknob for windows.. ,where the digitalknob folder resides on your system )

*** BINARY DIRECTORY ****
/digitalknob/Development/DKApps/DKCore/win32   ( By setting the binary directory to be win32, most variables will be casted )


****************************************************
**     Questions and Answers
****************************************************

Q. How do I add a 3rdParty library to DigitalKnob
A. Take a look in the /digitalknob/3rdParty/_DKIMPORTS folder,   there you will find tons of examples of how DK uses DKMAKE.cmake files.

Q. How do I add an App
A. For now, just rename any of the folders in /DKApps to your desired app name and use it as a template.

Q. I'm still having so many issues..  what else can I do.
A. Contact me..    *email hidden*  just message me here ;)

