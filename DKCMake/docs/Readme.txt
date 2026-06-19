*** DKCMake: The DigitalKnob Build System ***

* There is only one CMakeLists.txt file in the root of the /DigitalKnob folder.

* When running Cmake, the source path is always the /DigitalKnob folder, where the CMakeLists.txt file is located. 
* The build directory is the path to the app followed by the OS.  i.e  DKCpp/apps/DKMyApp/Windows_X86  
	* Output Build OS's are
		* /Android_Arm32
		* /Android_Arm64
		* /Android_X86
		* /Android_X86_64
		* /Emscripten_Arm32
		* /Emscripten_Arm64
		* /Emscripten_X86
		* /Emscripten_X86_64
		* /Ios_Arm32
		* /Ios_Arm64
		* /Ios_X86
		* /Ios_X86_64
		* /Iossim_Arm32
		* /Iossim_Arm64
		* /Iossim_X86
		* /Iossim_x86_64
		* /Linux_Arm32
		* /Linux_Arm64
		* /Linux_X86
		* /Linux_X86_64
		* /Mac_Arm32
		* /Mac_Arm64
		* /Mac_X86
		* /Mac_X86_64
		* /Raspberry_Arm32
		* /Raspberry_Arm64
		* /Raspberry_X86
		* /Raspberry_X86_64
		* /Windows_Arm32
		* /Windows_Arm64
		* /Windows_X86
		* /Windows_X86_64
		
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
/DigitalKnob      ( I.E.  C:/Users/username/DigitalKnob for windows.. ,where the DigitalKnob folder resides on your system )

*** BINARY DIRECTORY ****
/DigitalKnob/Development/DKCpp/apps/DKCore/Windows_X86   ( By setting the binary directory to be Windows_X86, most variables will be casted )


****************************************************
**     Questions and Answers
****************************************************

Q. How do I add a 3rdParty library to DigitalKnob
A. Take a look in the /DigitalKnob/3rdParty/_DKIMPORTS folder,   there you will find tons of examples of how DK uses DKINSTALL.cmake files.

Q. How do I add an App
A. For now, just rename any of the folders in /DKCpp/apps to your desired app name and use it as a template.

Q. I'm still having so many issues..  what else can I do.
A. Contact me..    *email hidden*  just message me here ;)

