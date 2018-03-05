@echo off

set PATH=%~dp0;%~dp0\..\..\third-party;%PATH%

if not defined VCDIR (
    for %%v in (
        %1
        "[15.0,16.0)"
        "[14.0,15.0)"
    ) do (
        for /f "usebackq tokens=*" %%p in (
            `vswhere -legacy -latest -version %%~v -property installationPath`
        ) do (
            echo %%p

            for %%q in (
                VC\Auxiliary\Build\vcvarsall.bat
                VC\vcvarsall.bat
            ) do (
                if exist "%%p\%%q" if not defined VCDIR (
                    set VCDIR=%%p
                    set VCVARSALL=%%p\%%q
                )
            )
        )
    )
)

if not defined VCDIR (
    echo "Could not find Microsoft Visual Studio, please set VCDIR to where it lives"
) else (
    call "%VCVARSALL%" x64
)
