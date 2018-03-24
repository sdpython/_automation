@echo off
set CURRENT=%~dp0..\..
set PYADDPATH=%CURRENT%
@echo [ENV] PYADDPATH=%PYADDPATH%
set PYTHONPATH=%PYADDPATH%\pyquickhelper\src;%PYADDPATH%\pyensae\src;%PYADDPATH%\pyrsslocal\src;%PYADDPATH%\jyquickhelper\src
set PYTHONPATH=%CSADDPATH%\pyscope\src;%CSADDPATH%\pyaether\src;%CSADDPATH%\scikit-tlc\src;%CSADDPATH%\pyscopeslapi\src;%CSADDPATH%\pyscopeml\src;%PYTHONPATH%
set PYTHONPATH=%CURRENT%\automation\pytlccontrib\src;%PYTHONPATH%
set PATH=c:\Python364_x64;c:\Python364_x64;Scripts;%PATH%
start /b %~dp0\wscite\SciTE.exe
