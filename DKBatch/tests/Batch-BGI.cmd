@if (@CodeSection == @Batch) @then

@echo off

rem "Batch-BGI Example.bat": Standard format required in Batch files that use the Batch-BGI graphics library
rem Written by Antonio Perez Ayala aka Aacini

setlocal
if "%~1" equ "BGI_interface" goto %1

rem Place here commands to execute before drawing graphics

echo Start drawing interface
"%~F0" BGI_interface 3>&1 1>&2 | CScript //nologo //E:JScript "%~F0"
echo End drawing interface

rem Place here commands to execute after drawing graphics

goto :EOF


:BGI_interface

rem Place here all drawing graphics commands.
rem This program include several short BGI examples copied from: 
rem http://www.cs.colorado.edu/~main/bgi/doc/

echo Initialize the HTA window
call :initwindow 400 300 "Batch-BGI Example"

echo/
echo --^> ARC example coming...
timeout /T 4
set /A stangle = 45, endangle = 135, radius = 100
set /A midx = _maxx / 2, midy = _maxy / 2
call :arc %midx%, %midy%, %stangle%, %endangle%, %radius%

echo/
echo --^> BAR example coming...
timeout /T 3
call :bar %midx%-110, %midy%-50, %midx%-10, %midy%+50

echo/
echo --^> BAR3D example coming...
timeout /T 3
call :setfillstyle 1, %BLUE%
call :bar3d %midx%+10, %midy%-50, %midx%+110, %midy%+50, 25, 1

echo/
echo --^> CIRCLE example coming...
timeout /T 3
call :setcolor %LIGHTRED%
call :circle %midx% %midy% %radius%+30

echo/
echo --^> MOVETO/LINETO example coming...
timeout /T 3
call :setcolor %LIGHTGREEN%
call :moveto 40,20 & call :lineto 120,100 & call :lineto 200,20 & call :lineto 280,100

echo/
echo --^> OUTTEXTXY example coming...
timeout /T 3
call :setfillstyle 1, %LIGHTMAGENTA%
set /A "Arial=7, SOLID_FILL=0"
call :settextstyle %Arial% %SOLID_FILL% 50
set "text=This is a test."
rem Note the use of textwidth *real JScript function* to center the text in the window:
call :outtextxy  (%_maxx%-textwidth("%text%"))/2  %_maxy%-30  "%text%"

rem To keep the graphics window open after this program terminate,
rem add KEEP_CURRENT_WINDOW parameter to closegraph subroutine
echo/
echo --^> Closing grahics...
timeout /T 6
echo Close the window
call :closegraph

echo End of drawing commands
goto :EOF

===============================================================================
Include here the code of the required Batch-BGI subroutines; copy they from the library file.

This example program use: arc, bar, bar3d, circle, lineto, moveto, outtextxy,
                          setcolor, setfillstyle, settextstyle and initwindow.

Copy from initwindow subroutine to the end of the library file; this will include
setallpalette and closegraph subroutines, that are also required.
===============================================================================

rem End of Batch section

@end

// Start of JScript section

var fso      = new ActiveXObject("Scripting.FileSystemObject"),
    WshShell = new ActiveXObject("WScript.Shell"),
    HTA      = new Array(), command, activepage, visualpage;

// Create the HTA file
HTA.FullName = WScript.ScriptFullName.replace(WScript.ScriptName,"Batch-BGI.hta");
HTA.file = fso.CreateTextFile(HTA.FullName,true);
HTA.file.WriteLine(
   "<meta http-equiv='x-ua-compatible' content='ie=edge'/>\r\n" +
   "<html> <head><HTA:APPLICATION></head>\r\n" +
   "<script language='JavaScript'>\r\n" +
   "var fso   = new ActiveXObject('Scripting.FileSystemObject'),\r\n" +
   "    stdin = fso.GetStandardStream(0), command, canvas, ctx;\r\n" +
   "fso.GetStandardStream(1).WriteLine();\r\n" +
   "function evalCommands() {while (command=stdin.ReadLine()) eval(command);}\r\n" +
   "window.onkeydown = evalCommands;\r\n" +
   "</script>\r\n" +
   "</html>\r\n"
);
HTA.file.Close();

// Receive commands from Batch section and send they to the HTA window
while ( ! WScript.Stdin.AtEndOfStream ) {

   command = WScript.Stdin.ReadLine();

   if ( command.substr(0,6) == 'eval("' ) {
      eval(command.split('"')[1]);   // command = eval("any *local* expression");
   } else {

      if ( command.substr(0,11) == "openwindow;" ) {

         // command = "openwindow;width;height;title;left;top;page" - create a new mshta.exe .HTA window

         var p = command.split(";"), width = p[1], height = p[2], title=p[3], left = p[4], top = p[5];
         activepage = visualpage = parseInt(p[6]);

         // Define the contents of the HTA window
         command = "\"<title>"+title+"</title> " +
                     "<style type='text/css'>body {color:white; background:black;}</style> " +
                     "<canvas id='BGIcanvas' width='"+width+"' height='"+height+"' style='border:1px solid;'>" +
                        "Your browser don't support the HTML5 Canvas tag" +
                     "</canvas>\"";

         // Open the window and wait for confirmation
         HTA[activepage] = WshShell.Exec('mshta.exe "'+HTA.FullName+'"');
         HTA[activepage].Stdout.ReadLine();

         HTA[activepage].Stdin.WriteLine( 
            "window.resizeTo("+width+"+34,"+height+"+64); "   +   // To adjust the margin, try: 34..40 64..82
            ((left!="-1")?("window.moveTo("+left+","+top+"); "):"") +
            "document.body.innerHTML = "+command+"; "         +
            "canvas = document.getElementById('BGIcanvas'); " +
            "ctx = canvas.getContext('2d'); "                 +
            "textwidth = function (txt) {return(ctx.measureText(txt).width)}; "
         );

      } else {

         // Read and send commands to the *active page*
         // until an "end of block" mark (empty line) is received
         while ( command ) {
            HTA[activepage].Stdin.WriteLine(command);
            command = WScript.Stdin.ReadLine();
         }

      }

      // Raise the event for "window.onkeydown" function in the HTA window
      if ( visualpage >= 0 ) {					// if screen refresh is active:
         HTA[activepage].Stdin.WriteLine();			//    Send the "end of block" mark (empty line)
         WshShell.AppActivate(HTA[visualpage].ProcessID);	//    Set focus on the HTA window *visual page*
         WshShell.SendKeys(" ");				//    And do a "key down"
      }

   }

}

fso.DeleteFile(HTA.FullName);