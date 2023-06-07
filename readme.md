# DirectXTex CLI

## About

This is a collection of some simple Windows shell scripts for use with Microsoft's [DirectXTex](https://github.com/microsoft/DirectXTex). These scripts can provide information on the format and details of DDS texture files, as well as converting them to different formats.
_*Note that converting existing files will overwrite them if the CLI script is used._

## Installation

An `install.bat` script is included, this adds a context menu for all `*.dds` files for a more fluid workflow. Be advised that this feature may not work if DDS files have been modified to be handled by some programs in the registry. The [base DirectXTex files](https://github.com/microsoft/DirectXTex/releases/latest) **are not** included in this repository or any releases, download and place the following files in the same folder as [the latest release](https://github.com/MrMendelli/DirectXTex-CLI/releases/latest):
- `texassemble.exe`
- `texconv.exe`
- `texdiag.exe`

## Use

If the main script _(`DirectXTex CLI.bat`)_ is ran directly, it will result in one of two errors:
- The main program files are missing
- An infile has not been supplied

In order to use this script, either drag files onto the script directly or use the included installation script to work with files from the context menu. Multiple files can be handled with either method. If no file is supplied, an option to print the internal help documentation is presented. This script is not limited to DDS files, various image formats are supported. 
