@echo off
set PANTHEIOS_ROOT=C:\tmp\pantheios-1.0.1
set STLSOFT=C:\tmp\stlsoft-1.9.117
cd %PANTHEIOS_ROOT%\build\vc10
call "%VS100COMNTOOLS%..\..\VC\vcvarsall.bat" x86
nmake build
pause
