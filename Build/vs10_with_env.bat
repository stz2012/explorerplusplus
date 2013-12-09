@echo off

set TARGET_ARCH=x86
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
	) else (
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

devenv /useenv
goto :EOF

:setBaseDir
set BASE_DIR=%~f1
exit /b

:End
pause
