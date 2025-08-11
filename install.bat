:: This is free and unencumbered software released into the public domain.
::
:: Anyone is free to copy, modify, publish, use, compile, sell, or
:: distribute this software, either in source code form or as a compiled
:: binary, for any purpose, commercial or non-commercial, and by any
:: means.
::
:: In jurisdictions that recognize copyright laws, the author or authors
:: of this software dedicate any and all copyright interest in the
:: software to the public domain. We make this dedication for the benefit
:: of the public at large and to the detriment of our heirs and
:: successors. We intend this dedication to be an overt act of
:: relinquishment in perpetuity of all present and future rights to this
:: software under copyright law.
::
:: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
:: EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
:: MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
:: IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
:: OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
:: ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
:: OTHER DEALINGS IN THE SOFTWARE.
::
:: For more information, please refer to <https://unlicense.org>

@echo off

if not "%1"=="am_admin" (
    powershell -Command "Start-Process -Verb RunAs -WorkingDirectory '%cd%' -FilePath '%0' -ArgumentList 'am_admin', '%cd%'"
    exit /b
)

cd "%2"

if "%processor_architecture%" == "AMD64" goto AMD64
if "%processor_architecture%" == "IA64" goto IA64
if "%processor_architecture%" == "ARM64" goto ARM64
if "%processor_architecture%" == "x86" goto x86

:AMD64
copy amd64\KBDCNPY.dll "%SystemRoot%\System32\"
copy wow64\KBDCNPY.dll "%SystemRoot%\SysWOW64\"
goto commonexit

:IA64
echo IA64
copy ia64\KBDCNPY.dll "%SystemRoot%\System32\"
goto commonexit

:ARM64
echo Not supported on ARM64
goto end

:x86
copy i386\KBDCNPY.dll "%SystemRoot%\System32\"
goto commonexit

:commonexit
regedit /s 00000804.reg

:end

