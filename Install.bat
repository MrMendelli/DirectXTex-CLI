@echo off

title DirectXTex Installation Script

>nul 2>&1 "%systemroot%\system32\cacls.exe" "%systemroot%\system32\config\system"

if '%errorlevel%' neq '0' (
	if '%1' equ '1' (
		echo Cannot elevate to administrator privilege. & pause > nul & exit /b
	) else (
		color 0e & echo Requesting administrative privilege... & goto :Elevate
	)
) else (goto :Elevated)

:Elevate
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\elevate.vbs"
echo UAC.ShellExecute "%~s0", "1", "", "runas", 1 >> "%temp%\elevate.vbs"
"%temp%\elevate.vbs"
exit /b

:Elevated
if exist "%temp%\elevate.vbs" (del "%temp%\elevate.vbs")

pushd "%systemroot%\system32"
reg query "HKU\S-1-5-19\Environment"
if not %errorlevel% equ 0 (cls & title Error & color 0c & echo You must run this script as an administrator. & pause > nul) else (goto :ExecuteScript)
popd
exit /b

:ExecuteScript

:Registry
::-------------------------------------------------------------------------------------------------------------------------------------------------------------

:Hives
for /f "tokens=1,2 delims==" %%s in ('wmic path win32_useraccount where name^='%username%' get sid /value ^| find /i "SID"') do set SID=%%t
set ClassRoot=HKEY_CLASSES_ROOT
set CurrentUser=HKEY_CURRENT_USER\SOFTWARE\Classes
set LocalMachine=HKEY_LOCAL_MACHINE\SOFTWARE\Classes
set UserAssociation=HKEY_USERS\%SID%\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts
set CommandStore=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell
echo.

:Commands
reg add "%CommandStore%\DirectXTex" /ve /t REG_SZ /d "Convert" /f
reg add "%CommandStore%\DirectXTex" /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f
reg add "%CommandStore%\DirectXTex\command" /ve /t REG_SZ /d "\"%~dp0DirectXTex CLI.bat\"  \"%%1\"" /f

reg add "%CommandStore%\DirectXTex Analyze" /ve /t REG_SZ /d "Analyze" /f
reg add "%CommandStore%\DirectXTex Analyze" /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f
reg add "%CommandStore%\DirectXTex Analyze\command" /ve /t REG_SZ /d "\"%~dp0Analyze.bat\"  \"%%1\"" /f

reg add "%CommandStore%\DirectXTex Information" /ve /t REG_SZ /d "Information" /f
reg add "%CommandStore%\DirectXTex Information" /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f
reg add "%CommandStore%\DirectXTex Information\command" /ve /t REG_SZ /d "\"%~dp0Information.bat\"  \"%%1\"" /f

set SubCommands="DirectXTex;DirectXTex Analyze;DirectXTex Information;"

:Formats
::-------------------------------------------------------------------------------------------------------------------------------------------------------------
cls & color 0e

:apng
echo Checking ^*.png...
set "apng=png"
for /f "usebackq tokens=2,*" %%a in (`reg query "%ClassRoot%\.%apng%" /v ""`) do set apngClassRoot=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%CurrentUser%\.%apng%" /v ""`) do set apngCurrentUser=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%LocalMachine%\.%apng%" /v ""`) do set apngLocalMachine=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%UserAssociation%\.%apng%\UserChoice" /v "ProgId"`) do set apngUserAssociation=%%b

:avif
echo Checking ^*.avif...
set "avif=avif"
for /f "usebackq tokens=2,*" %%a in (`reg query "%ClassRoot%\.%avif%" /v ""`) do set avifClassRoot=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%CurrentUser%\.%avif%" /v ""`) do set avifCurrentUser=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%LocalMachine%\.%avif%" /v ""`) do set avifLocalMachine=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%UserAssociation%\.%avif%\UserChoice" /v "ProgId"`) do set avifUserAssociation=%%b

:bmp
echo Checking ^*.bmp...
set "bmp=bmp"
for /f "usebackq tokens=2,*" %%a in (`reg query "%ClassRoot%\.%bmp%" /v ""`) do set bmpClassRoot=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%CurrentUser%\.%bmp%" /v ""`) do set bmpCurrentUser=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%LocalMachine%\.%bmp%" /v ""`) do set bmpLocalMachine=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%UserAssociation%\.%bmp%\UserChoice" /v "ProgId"`) do set bmpUserAssociation=%%b

:dds
echo Checking ^*.dds...
set "dds=dds"
for /f "usebackq tokens=2,*" %%a in (`reg query "%ClassRoot%\.%dds%" /v ""`) do set ddsClassRoot=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%CurrentUser%\.%dds%" /v ""`) do set ddsCurrentUser=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%LocalMachine%\.%dds%" /v ""`) do set ddsLocalMachine=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%UserAssociation%\.%dds%\UserChoice" /v "ProgId"`) do set ddsUserAssociation=%%b

:gif
echo Checking ^*.gif...
set "gif=gif"
for /f "usebackq tokens=2,*" %%a in (`reg query "%ClassRoot%\.%gif%" /v ""`) do set gifClassRoot=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%CurrentUser%\.%gif%" /v ""`) do set gifCurrentUser=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%LocalMachine%\.%gif%" /v ""`) do set gifLocalMachine=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%UserAssociation%\.%gif%\UserChoice" /v "ProgId"`) do set gifUserAssociation=%%b

:ico
echo Checking ^*.ico...
set "ico=ico"
for /f "usebackq tokens=2,*" %%a in (`reg query "%ClassRoot%\.%ico%" /v ""`) do set icoClassRoot=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%CurrentUser%\.%ico%" /v ""`) do set icoCurrentUser=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%LocalMachine%\.%ico%" /v ""`) do set icoLocalMachine=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%UserAssociation%\.%ico%\UserChoice" /v "ProgId"`) do set icoUserAssociation=%%b

:jfif
echo Checking ^*.jfif...
set "jfif=jfif"
for /f "usebackq tokens=2,*" %%a in (`reg query "%ClassRoot%\.%jfif%" /v ""`) do set jfifClassRoot=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%CurrentUser%\.%jfif%" /v ""`) do set jfifCurrentUser=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%LocalMachine%\.%jfif%" /v ""`) do set jfifLocalMachine=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%UserAssociation%\.%jfif%\UserChoice" /v "ProgId"`) do set jfifUserAssociation=%%b

:jpg
echo Checking ^*.jpg...
set "jpg=jpg"
for /f "usebackq tokens=2,*" %%a in (`reg query "%ClassRoot%\.%jpg%" /v ""`) do set jpgClassRoot=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%CurrentUser%\.%jpg%" /v ""`) do set jpgCurrentUser=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%LocalMachine%\.%jpg%" /v ""`) do set jpgLocalMachine=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%UserAssociation%\.%jpg%\UserChoice" /v "ProgId"`) do set jpgUserAssociation=%%b

:jxr
echo Checking ^*.jxr...
set "jxr=jxr"
for /f "usebackq tokens=2,*" %%a in (`reg query "%ClassRoot%\.%jxr%" /v ""`) do set jxrClassRoot=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%CurrentUser%\.%jxr%" /v ""`) do set jxrCurrentUser=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%LocalMachine%\.%jxr%" /v ""`) do set jxrLocalMachine=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%UserAssociation%\.%jxr%\UserChoice" /v "ProgId"`) do set jxrUserAssociation=%%b

:png
echo Checking ^*.png...
set "png=png"
for /f "usebackq tokens=2,*" %%a in (`reg query "%ClassRoot%\.%png%" /v ""`) do set pngClassRoot=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%CurrentUser%\.%png%" /v ""`) do set pngCurrentUser=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%LocalMachine%\.%png%" /v ""`) do set pngLocalMachine=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%UserAssociation%\.%png%\UserChoice" /v "ProgId"`) do set pngUserAssociation=%%b

:tga
echo Checking ^*.tga...
set "tga=tga"
for /f "usebackq tokens=2,*" %%a in (`reg query "%ClassRoot%\.%tga%" /v ""`) do set tgaClassRoot=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%CurrentUser%\.%tga%" /v ""`) do set tgaCurrentUser=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%LocalMachine%\.%tga%" /v ""`) do set tgaLocalMachine=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%UserAssociation%\.%tga%\UserChoice" /v "ProgId"`) do set tgaUserAssociation=%%b

:tif
echo Checking ^*.tif...
set "tif=tif"
for /f "usebackq tokens=2,*" %%a in (`reg query "%ClassRoot%\.%tif%" /v ""`) do set tifClassRoot=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%CurrentUser%\.%tif%" /v ""`) do set tifCurrentUser=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%LocalMachine%\.%tif%" /v ""`) do set tifLocalMachine=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%UserAssociation%\.%tif%\UserChoice" /v "ProgId"`) do set tifUserAssociation=%%b

:webp
echo Checking ^*.webp...
set "webp=webp"
for /f "usebackq tokens=2,*" %%a in (`reg query "%ClassRoot%\.%webp%" /v ""`) do set webpClassRoot=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%CurrentUser%\.%webp%" /v ""`) do set webpCurrentUser=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%LocalMachine%\.%webp%" /v ""`) do set webpLocalMachine=%%b
for /f "usebackq tokens=2,*" %%a in (`reg query "%UserAssociation%\.%webp%\UserChoice" /v "ProgId"`) do set webpUserAssociation=%%b

:Associate
::-------------------------------------------------------------------------------------------------------------------------------------------------------------
cls & color 0a

:apng
echo Associating ^*.png...
reg add "%apngClassRoot%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%apngClassRoot%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%apngCurrentUser%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%apngCurrentUser%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%apngLocalMachine%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%apngLocalMachine%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%ClassRoot%\%apngUserAssociation%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%ClassRoot%\%apngUserAssociation%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1

:avif
echo Associating ^*.avif...
reg add "%avifClassRoot%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%avifClassRoot%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%avifCurrentUser%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%avifCurrentUser%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%avifLocalMachine%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%avifLocalMachine%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%ClassRoot%\%avifUserAssociation%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%ClassRoot%\%avifUserAssociation%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1

:bmp
echo Associating ^*.bmp...
reg add "%bmpClassRoot%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%bmpClassRoot%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%bmpCurrentUser%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%bmpCurrentUser%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%bmpLocalMachine%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%bmpLocalMachine%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%ClassRoot%\%bmpUserAssociation%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%ClassRoot%\%bmpUserAssociation%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1

:dds
echo Associating ^*.dds...
reg add "%ddsClassRoot%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%ddsClassRoot%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%ddsCurrentUser%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%ddsCurrentUser%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%ddsLocalMachine%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%ddsLocalMachine%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%ClassRoot%\%ddsUserAssociation%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%ClassRoot%\%ddsUserAssociation%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1

:gif
echo Associating ^*.gif...
reg add "%gifClassRoot%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%gifClassRoot%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%gifCurrentUser%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%gifCurrentUser%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%gifLocalMachine%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%gifLocalMachine%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%ClassRoot%\%gifUserAssociation%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%ClassRoot%\%gifUserAssociation%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1

:ico
echo Associating ^*.ico...
reg add "%icoClassRoot%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%icoClassRoot%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%icoCurrentUser%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%icoCurrentUser%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%icoLocalMachine%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%icoLocalMachine%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%ClassRoot%\%icoUserAssociation%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%ClassRoot%\%icoUserAssociation%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1

:jfif
echo Associating ^*.jfif...
reg add "%jfifClassRoot%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%jfifClassRoot%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%jfifCurrentUser%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%jfifCurrentUser%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%jfifLocalMachine%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%jfifLocalMachine%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%ClassRoot%\%jfifUserAssociation%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%ClassRoot%\%jfifUserAssociation%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1

:jpg
echo Associating ^*.jpg...
reg add "%jpgClassRoot%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%jpgClassRoot%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%jpgCurrentUser%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%jpgCurrentUser%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%jpgLocalMachine%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%jpgLocalMachine%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%ClassRoot%\%jpgUserAssociation%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%ClassRoot%\%jpgUserAssociation%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1

:jxr
echo Associating ^*.jxr...
reg add "%jxrClassRoot%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%jxrClassRoot%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%jxrCurrentUser%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%jxrCurrentUser%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%jxrLocalMachine%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%jxrLocalMachine%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%ClassRoot%\%jxrUserAssociation%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%ClassRoot%\%jxrUserAssociation%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1

:png
echo Associating ^*.png...
reg add "%pngClassRoot%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%pngClassRoot%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%pngCurrentUser%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%pngCurrentUser%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%pngLocalMachine%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%pngLocalMachine%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%ClassRoot%\%pngUserAssociation%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%ClassRoot%\%pngUserAssociation%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1

:tga
echo Associating ^*.tga...
reg add "%tgaClassRoot%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%tgaClassRoot%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%tgaCurrentUser%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%tgaCurrentUser%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%tgaLocalMachine%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%tgaLocalMachine%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%ClassRoot%\%tgaUserAssociation%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%ClassRoot%\%tgaUserAssociation%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1

:tif
echo Associating ^*.tif...
reg add "%tifClassRoot%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%tifClassRoot%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%tifCurrentUser%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%tifCurrentUser%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%tifLocalMachine%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%tifLocalMachine%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%ClassRoot%\%tifUserAssociation%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%ClassRoot%\%tifUserAssociation%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1

:webp
echo Associating ^*.webp...
reg add "%webpClassRoot%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%webpClassRoot%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%webpCurrentUser%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%webpCurrentUser%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%webpLocalMachine%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%webpLocalMachine%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1
reg add "%ClassRoot%\%webpUserAssociation%\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f > nul 2>&1
reg add "%ClassRoot%\%webpUserAssociation%\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d %SubCommands% /f > nul 2>&1

cls & color 0a & echo DirectXTex installation completed. & pause > nul
