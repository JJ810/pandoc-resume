@echo off
REM System command wrapper: build-resume
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0build-resume.ps1" %*
