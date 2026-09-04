@echo off
REM System command wrapper: build-resume
REM Closes the Command Prompt window when the build finishes.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0build-resume.ps1" %*
exit %ERRORLEVEL%
