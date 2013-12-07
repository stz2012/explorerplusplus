@echo off

call :setBaseDir %~dp0..\..\
set PANTHEIOS_ROOT=%BASE_DIR%pantheios-1.0.1
set STLSOFT=%BASE_DIR%stlsoft-1.9.117
set TARGET_ARCH=x86

IF DEFINED VS100COMNTOOLS (
	rem Load VisualStudio Environment Variable
	IF "%TARGET_ARCH%" == "x64" (
		call "%VS100COMNTOOLS%..\..\VC\vcvarsall.bat" x86_amd64
	) else (
		call "%VS100COMNTOOLS%..\..\VC\vcvarsall.bat" %TARGET_ARCH%
	)
) else (
	echo VisualStudio 2010 is not installed.
	goto End
)

IF "%TARGET_ARCH%" == "x64" (
	cd %PANTHEIOS_ROOT%\build\vc10.x64
) else (
	cd %PANTHEIOS_ROOT%\build\vc10
)
nmake build.libs
goto End

:setBaseDir
set BASE_DIR=%~f1
exit /b

:End
pause
