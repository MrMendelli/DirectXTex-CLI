@echo off

if "%~1" neq "" goto :PrintInfo
title Error & cls & color 0c
echo No infile supplied! & pause > nul
exit /b

:PrintInfo
title %~nx1 Information
pushd "%~dp0"
texdiag.exe analyze %*
popd
pause > nul
