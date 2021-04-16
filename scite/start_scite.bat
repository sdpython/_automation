@echo off
set CURRENT=%~dp0..\..
set PYADDPATH=%CURRENT%
@echo [ENV] PYADDPATH=%PYADDPATH%
set PYTHONPATH=%PYADDPATH%\pyquickhelper\src;%PYADDPATH%\pyensae\src;%PYADDPATH%\pyrsslocal\src;%PYADDPATH%\jyquickhelper\src
set PYTHONPATH=%PYADDPATH%\manydataapi\src
set PATH=c:\Python364_x64;c:\Python364_x64;Scripts;%PATH%
start /b %~dp0\wscite\SciTE.exe