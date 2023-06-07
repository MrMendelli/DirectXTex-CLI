@echo off

:CheckApp
if exist "%~dp0texconv.exe" goto :InfileCheck
cls & title Error! & color 0c
set /p choice="DirectXTex not found, download now? "
if /i "%choice%" equ "Y" goto :DownloadApp
if /i "%choice%" equ "N" exit /b
cls & echo You must enter 'y' or 'n' to proceed... & pause > nul
goto :CheckApp

:DownloadApp
cls & echo Copy program files to working directory. & echo Press any key once installation completes.
start /wait https://github.com/Microsoft/DirectXTex/releases/latest
pause > nul
goto :CheckApp

:InfileCheck
if "%~1" neq "" goto :MainMenu
title Error & cls & color 0c
echo No infile supplied, exiting...
echo (Press any key to print help file.)
pause > nul
".\texconv.exe" -h >".\Texture Converter Help.txt"
start "" notepad ".\Texture Converter Help.txt"
exit /b

:MainMenu
cls & color 0a & title DirectXTex CLI
set format=""
mode con cols=71 lines=42
color 0a
echo Formats:
echo.
echo 10G10B10A2_UNORM         DXT2                       R8G8B8A8_SINT
echo 16G16B16A16_SINT         DXT3                       R8G8B8A8_SNORM
echo 16G16B16A16_UNORM        DXT4                       R8G8B8A8_UINT
echo 16G16_FLOAT              DXT5                       R8G8B8A8_UNORM
echo 32G32B32_FLOAT                                      R8G8_SNORM
echo 32_FLOAT                 FP16                       R8G8_UINT
echo 8G8B8A8_UNORM_SRGB       FP32                       R8G8_UNORM
echo 8G8R8X8_UNORM                                       R8_SINT
echo 8G8R8X8_UNORM_SRGB       G8R8_G8B8_UNORM            R8_SNORM
echo 8G8_B8G8_UNORM                                      R8_UINT
echo 8G8_SINT                 PTC_FLOAT                  R9G9B9E5_SHAREDEXP
echo 8_UNORM                                             RGBA
echo                          R10G10B10A2_UINT
echo A8_UNORM                 R10G10B10_XR_BIAS_A2_UNORM XT1
echo                          R11G11B10_FLOAT
echo B4G4R4A4_UNORM           R16G16B16A16_FLOAT         Y210
echo B5G5R5A1_UNORM           R16G16B16A16_SNORM         Y216
echo B5G6R5_UNORM             R16G16B16A16_UINT          Y410
echo B8G8R8A8_UNORM           R16G16_SINT                Y416
echo B8G8R8A8_UNORM_SRGB      R16G16_SNORM               YUV
echo BC1_UNORM BC1_UNORM_SRGB R16G16_UINT                YUY2
echo BC2_UNORM                R16G16_UNORM
echo BC3_UNORM                R16_FLOAT
echo BC3_UNORM_SRGB           R16_SINT
echo BC4_SNORM                R16_SNORM
echo BC4_UNORM                R16_UINT
echo BC5_SNORM                R16_UNORM
echo BC6H_SF16                R32G32B32A32_FLOAT
echo BC6H_UF16                R32G32B32A32_SINT
echo BC7_UNORM                R32G32B32A32_UINT
echo BC7_UNORM_SRGB           R32G32B32_SINT
echo BGR                      R32G32B32_UINT
echo BGRA                     R32G32_FLOAT
echo BPTC                     R32G32_SINT
echo                          R32G32_UINT
echo C2_UNORM_SRGB            R32_SINT
echo C5_UNORM                 R32_UINT
echo.
set /p format="Convert file(s) to: "
echo.
if %format% neq "" goto :ProcessImages
cls & color 0c & title Error
echo You must enter a format to proceed... & pause > nul
goto :MainMenu

:ProcessImages
cls & color 0e
echo Converting...
"%~dp0texconv" -f %format% %* -y > nul
goto :MainMenu
