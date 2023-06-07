@echo off

::".\texassemble.exe" -h >".\DirectX Texture Assembler Help.txt"
".\texconv.exe" -h >".\Texture Converter Help.txt"
::".\texdiag.exe" -h >".\DirectX Diag Help.txt"
::start "" notepad ".\DirectX Texture Assembler Help.txt"
start "" notepad ".\Texture Converter Help.txt"
::start "" notepad ".\DirectX Diag Help.txt"
