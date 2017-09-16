@echo off
set current=%~dp0
cd ..
cd ..

@echo *** _automation
cd _automation
git pull
cd ..

if not exist actuariat_python goto teachpyx:
@echo *** actuariat_python
cd actuariat_python
git pull
cd ..

:teachpyx:
if not exist teachpyx goto ensae_projects:
@echo *** teachpyx
cd teachpyx
git pull
cd ..

:ensae_projects:
if not exist ensae_projects goto ensae_teaching_cs:
@echo *** ensae_projects
cd ensae_projects
git pull
cd ..

:ensae_teaching_cs:
if not exist ensae_teaching_cs goto jyquickhelper:
@echo *** ensae_teaching_cs
cd ensae_teaching_cs
git pull
cd ..

:jyquickhelper:
if not exist jyquickhelper goto mlstatpy:
@echo *** jyquickhelper
cd jyquickhelper
git pull
cd ..

:mlstatpy:
if not exist mlstatpy goto pyensae:
@echo *** mlstatpy
cd mlstatpy
git pull
cd ..

:pyensae:
if not exist pyensae goto pymmails:
@echo *** pyensae
cd pyensae
git pull
cd ..

:pymmails:
if not exist pymmails goto pymyinstall:
@echo *** pymmails
cd pymmails
git pull
cd ..

:pymyinstall:
if not exist pymyinstall goto pyquickhelper:
@echo *** pymyinstall
cd pymyinstall
git pull
cd ..

:pyquickhelper:
if not exist pyquickhelper goto pyrsslocal:
@echo *** pyquickhelper
cd pyquickhelper
git pull
cd ..

:pyrsslocal:
if not exist pyrsslocal goto python3_module_template:
@echo *** pyrsslocal
cd pyrsslocal
git pull
cd ..

:python3_module_template:
if not exist python3_module_template goto jupytalk:
@echo *** python3_module_template
cd python3_module_template
git pull
cd ..

:jupytalk:
if not exist jupytalk goto tkinterquickhelper:
@echo *** jupytalk
cd jupytalk
git pull
cd ..

:tkinterquickhelper:
if not exist tkinterquickhelper goto code_beatrix:
@echo *** tkinterquickhelper
cd tkinterquickhelper
git pull
cd ..

:code_beatrix:
if not exist code_beatrix goto cpyquickhelper:
@echo *** code_beatrix
cd code_beatrix
git pull
cd ..

:cpyquickhelper:
if not exist cpyquickhelper goto teachpyx:
@echo *** cpyquickhelper
cd cpyquickhelper
git pull
cd ..
cd %current%
