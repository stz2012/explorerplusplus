@echo off

call :setBaseDir %~dp0..\..\
set PANTHEIOS_ROOT=%BASE_DIR%pantheios-1.0.1
set STLSOFT=%BASE_DIR%stlsoft-1.9.117

IF DEFINED VS100COMNTOOLS (
	rem Load VisualStudio Environment Variable
	IF "%PROCESSOR_ARCHITECTURE%" == "x86" (
		call "%VS100COMNTOOLS%..\..\VC\vcvarsall.bat" x86
	) else (
		call "%VS100COMNTOOLS%..\..\VC\vcvarsall.bat" x86_amd64
	)
) ELSE (
	echo VisualStudio 2010 is not installed.
	goto End
)

IF NOT EXIST %PANTHEIOS_ROOT% (
	echo Pantheios logging library is not installed.
	goto End
)
IF NOT EXIST %STLSOFT% (
	echo STLSoft libraries is not installed.
	goto End
)

IF "%PROCESSOR_ARCHITECTURE%" == "x86" (
	cd %PANTHEIOS_ROOT%\build\vc10
	nmake build.libs
) ELSE (
	cd %PANTHEIOS_ROOT%\build\vc10
	nmake build.libs
	cd %PANTHEIOS_ROOT%\build\vc10.x64
	nmake build.libs
)
goto End

:setBaseDir
set BASE_DIR=%~f1
exit /b

:End
pause
