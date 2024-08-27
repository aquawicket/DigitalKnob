::https://stackoverflow.com/a/18751689/688352

@echo off
(
   rem Switch the context to the library file
   ren switingContextTrick_main.cmd orig-main.cmd
   ren switingContextTrick_library.cmd switingContextTrick_main.cmd
   rem From this point on, any library function can be called, for example:
   echo I am Main, calling switingContextTrick_library:
   call :switingContextTrick_library param1
   echo Back in Main
   rem Switch back the context to the original one
   ren switingContextTrick_main.cmd switingContextTrick_library.cmd
   ren orig-main.cmd switingContextTrick_main.cmd
)
