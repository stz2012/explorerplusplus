@echo off
set BOOST=C:\tmp\boost_1_54_0
set PANTHEIOS=C:\tmp\pantheios-1.0.1
set STLSOFT=C:\tmp\stlsoft-1.9.117
set LIB=C:\tmp\boost_1_54_0\lib32-msvc-10.0
call "%ProgramFiles%\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" x86
devenv /useenv /build release Explorer++\Explorer++.sln
devenv /useenv /build release Translations\Explorer++JA\Explorer++JA.sln
pause
