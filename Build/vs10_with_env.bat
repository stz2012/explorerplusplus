@echo off

call :setBaseDir %~dp0..\..\
set BOOST=%BASE_DIR%boost_1_54_0
set BOOST_LIB=%BASE_DIR%boost_1_54_0\lib32-msvc-10.0
set PANTHEIOS=%BASE_DIR%pantheios-1.0.1
set STLSOFT=%BASE_DIR%stlsoft-1.9.117
set TARGET_ARCH=x86

IF DEFINED VS100COMNTOOLS (
	rem Load VisualStudio Environment Variable
	IF "%TARGET_ARCH%" == "x64" (
		call "%VS100COMNTOOLS%..\..\VC\vcvarsall.bat" amd64
	) else (
		call "%VS100COMNTOOLS%..\..\VC\vcvarsall.bat" %TARGET_ARCH%
	)
) else (
	echo VisualStudio 2010 is not installed.
	goto End
)

devenv /useenv
goto End

:setBaseDir
set BASE_DIR=%~f1
exit /b

:End
pause
