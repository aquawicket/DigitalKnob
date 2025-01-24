if ("0"=="1") /* "Elevate privileges if need. And run node.js script. "
setlocal ENABLEDELAYEDEXPANSION
@echo off

@NET FILE 1>NUL 2>NUL
if not '%errorlevel%' == '0' ( 
  @rem if access denied error, run self as wsh-jscript to elevate.
  goto :UAC_ELEVATE
) else ( 
  @rem otherwise run.
  goto :NODE_JS
)
goto:eof

:UAC_ELEVATE
  @rem Pass this file's filename as command line arguments.
  @cscript //nologo //e:jscript "%~f0" "%~f0"
  exit /b

:NODE_JS
  node "%~f0"
  pause
  exit /b
*/ {}
// javascript block.
function wscriptMain(filename){
  // Run this bat file again with "runas" parameter
  var uac = new ActiveXObject("Shell.Application"); 
  uac.ShellExecute(filename, "", "", "runas", 1);
}

function nodeMain(){
  console.log("Hello, Node js");
  console.log(process.version);
}

// determine WSH or node.
if(typeof console === 'undefined'){
  wscriptMain(WScript.Arguments(0));
}else{
  nodeMain();
}