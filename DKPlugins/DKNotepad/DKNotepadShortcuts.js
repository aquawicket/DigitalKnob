"use strict";

dk.notepadshortcuts = new Object;

dk.notepadshortcuts.init = function dk_notepadshortcuts_init()()
{
	document.addEventListener("keydown", dk.notepadshortcuts.onevent);
}

dk.notepadshortcuts.end = function dk_notepadshortcuts_end()
{
	document.removeEventListener("keydown", dk.notepadshortcuts.onevent);
}

dk.notepadshortcuts.onevent = function dk_notepadshortcuts_onevent(event)
{
	console.warn("dk.notepadshortcut.onevent(): event.type:"+event.type);
	console.warn("event.code = "+event.code);
}