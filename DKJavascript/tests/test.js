new ActiveXObject("WScript.Shell").Run("C:/Windows/System32/notepad.exe", 1, false);

rundll32.exe javascript:"\..\mshtml,RunHTMLApplication ";console.log('test');alert('test');close();
rundll32.exe javascript:"\..\mshtml,RunHTMLApplication ";new ActiveXObject('WScript.Shell').Run('C:/Windows/System32/notepad.exe',1,false);close();
// rundll32.exe javascript:"\..\mshtml.dll,RunHTMLApplication ";new ActiveXObject('WScript.Shell').Run('C:/Windows/System32/notepad.exe', 1, false);close();


rundll32.exe javascript:"\..\mshtml.dll,RunHTMLApplication ";eval("w=new%20ActiveXObject(\"WScript.Shell\");w.run(\"C:/Windows/System32/notepad.exe\");window.close()");