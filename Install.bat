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
if not %errorlevel% equ 0 (cls & title Error & color 0c & echo You must run this script as an administrator. & pause > nul) else (goto :RegEdit)
popd
exit /b

:RegEdit
reg add "HKCR\.dds\Shell\DirectXTex..." /v "SubCommands" /t REG_SZ /d "DirectXTex;DirectXTex Analyze;DirectXTex Information;DirectXTex Help;" /f
reg add "HKCR\.dds\Shell\DirectXTex..." /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f

:CommandStore
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DirectXTex" /ve /t REG_SZ /d "Convert" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DirectXTex" /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DirectXTex\command" /ve /t REG_SZ /d "\"%~dp0DirectXTex CLI.bat\"  \"%%1\"" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DirectXTex Analyze" /ve /t REG_SZ /d "Analyze" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DirectXTex Analyze" /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DirectXTex Analyze\command" /ve /t REG_SZ /d "\"%~dp0Analyze.bat\"  \"%%1\"" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DirectXTex Information" /ve /t REG_SZ /d "Information" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DirectXTex Information" /v "icon" /t REG_SZ /d "%~dp0icon.ico" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\DirectXTex Information\command" /ve /t REG_SZ /d "\"%~dp0Information.bat\"  \"%%1\"" /f

cls & color 0a & echo DirectXTex installation completed. & pause > nul
