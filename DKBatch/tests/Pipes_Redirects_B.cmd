@echo off
echo(
echo ### Pipes_Redirects_B.cmd %* ###

rem Read the piped input
for /F %%G IN ('find /v ""') do (set input_pipe=%%G)
echo input_pipe = '%input_pipe%'
