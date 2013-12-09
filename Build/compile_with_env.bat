@echo off

set TARGET_ARCH=x64
set TARGET_MODE=Release
set TARGET_LANG=JA
call :setBaseDir %~dp0..\..\
set BOOST=%BASE_DIR%boost_1_54_0
IF "%TARGET_ARCH%" == "x86" (
	set BOOST_LIB=%BASE_DIR%boost_1_54_0\lib32-msvc-10.0
) ELSE (
	set BOOST_LIB=%BASE_DIR%boost_1_54_0\lib64-msvc-10.0
)
set PANTHEIOS=%BASE_DIR%pantheios-1.0.1
set STLSOFT=%BASE_DIR%stlsoft-1.9.117

IF DEFINED VS100COMNTOOLS (
	rem Load VisualStudio Environment Variable
	IF "%TARGET_ARCH%" == "x86" (
		call "%VS100COMNTOOLS%..\..\VC\vcvarsall.bat" x86
	) ELSE (
		call "%VS100COMNTOOLS%..\..\VC\vcvarsall.bat" x86_amd64
	)
) ELSE (
	echo VisualStudio 2010 is not installed.
	goto End
)

IF NOT EXIST %BOOST% (
	echo Boost C++ libraries is not installed.
	goto End
) ELSE (
	IF NOT EXIST %BOOST_LIB% (
		echo Boost C++ libraries is not installed.
		goto End
	)
)
IF NOT EXIST %PANTHEIOS% (
	echo Pantheios logging library is not installed.
	goto End
)
IF NOT EXIST %STLSOFT% (
	echo STLSoft libraries is not installed.
	goto End
)

call :setBaseDir %~dp0..\
call :buildMainSolution "%BASE_DIR%Explorer++\Explorer++.sln" Explorer++.exe
call :buildLangSolution "%BASE_DIR%Translations\Explorer++%TARGET_LANG%\Explorer++%TARGET_LANG%.sln" Explorer++%TARGET_LANG%.dll
goto End

:setBaseDir
set BASE_DIR=%~f1
exit /b

:buildMainSolution
IF "%TARGET_ARCH%" == "x64" (
	devenv /useenv /rebuild "%TARGET_MODE%|x64" %1
) ELSE (
	devenv /useenv /rebuild "%TARGET_MODE%|Win32" %1
)
call :setOutputDir %1
IF EXIST "%OUTPUT_DIR%%2" (
	mkdir %TARGET_ARCH% > NUL 2>&1
	if ERRORLEVEL 1 cmd /c exit 0
	copy /Y "%OUTPUT_DIR%%2" %TARGET_ARCH%\
	copy /Y "%BASE_DIR%Documentation\*.txt" %TARGET_ARCH%\
)
exit /b

:buildLangSolution
devenv /useenv /rebuild %TARGET_MODE% %1
call :setOutputDir %1
IF EXIST "%OUTPUT_DIR%%2" (
	mkdir %TARGET_ARCH% > NUL 2>&1
	if ERRORLEVEL 1 cmd /c exit 0
	copy /Y "%OUTPUT_DIR%%2" %TARGET_ARCH%\
)
exit /b

:setOutputDir
set OUTPUT_DIR=%~dp1%TARGET_MODE%\
exit /b

:End
pause
