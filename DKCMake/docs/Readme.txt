*** DKCMake: The DigitalKnob Build System ***

* There is only one CMakeLists.txt file in the root of the /digitalknob folder.

* When running Cmake, the source path is always the /digitalknob folder, where the CMakeLists.txt file is located. 
* The build directory is the path to the app followed by the OS.  i.e  DKCpp/apps/DKMyApp/win_x86  
	* Output Build OS's are
		* /android_arm32
		* /android_arm64
		* /emscripten
		* /ios_arm32
		* /ios_arm64
		* /iossim_x86
		* /iossim_x86_64
		* /linux_x86
		* /linux_x86_64
		* /mac_x86
		* /mac_x86_64
		* /raspberry_arm32
		* /raspberry_arm64
		* /win_x86
		* /win_x86_64
		
* Note: DKCMake will fill in most variables by the path you have selected.		

* Upon loading DKCMake.cmake, variables required will be...
	TYPE - (Debug, Release, All)
	LEVEL - (Build, Rebuild, RebuildAll)
		Build - "Build the project wihtout dependencies"
		Rebuild - "Rebuild the project wihtout dependencies"
		RebuildAll - "Rebuild the project and dependencies"
	
* All Apps, Plugins and 3rdParty Libraries, require a DKINSTALL.cmake file to interact with the build system.


****************************************************
**     Building from the a CMake gui 
****************************************************

*** SOURCE DIRECTORY ****
/digitalknob      ( I.E.  C:/Users/username/digitalknob for windows.. ,where the digitalknob folder resides on your system )

*** BINARY DIRECTORY ****
/digitalknob/Development/DKCpp/apps/DKCore/win_x86   ( By setting the binary directory to be win_x86, most variables will be casted )


****************************************************
**     Questions and Answers
****************************************************

Q. How do I add a 3rdParty library to DigitalKnob
A. Take a look in the /digitalknob/3rdParty/_DKIMPORTS folder,   there you will find tons of examples of how DK uses DKINSTALL.cmake files.

Q. How do I add an App
A. For now, just rename any of the folders in /DKCpp/apps to your desired app name and use it as a template.

Q. I'm still having so many issues..  what else can I do.
A. Contact me..    *email hidden*  just message me here ;)

