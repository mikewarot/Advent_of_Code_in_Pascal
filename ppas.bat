@echo off
SET THEFILE=C:\Advent\advent2015_12b.exe
echo Linking %THEFILE%
C:\lazarus\fpc\3.2.0\bin\x86_64-win64\ld.exe -b pei-x86-64  --gc-sections    --entry=_mainCRTStartup    -o C:\Advent\advent2015_12b.exe C:\Advent\link.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occurred while assembling %THEFILE%
goto end
:linkend
echo An error occurred while linking %THEFILE%
:end
