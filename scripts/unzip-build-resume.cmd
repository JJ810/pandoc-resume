@echo off
REM System command wrapper: unzip-build-resume
REM Closes the Command Prompt window when the batch finishes.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0unzip-build-resume.ps1" %*
exit %ERRORLEVEL%
