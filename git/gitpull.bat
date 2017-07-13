@echo off
set current=%~dp0
cd ..
cd ..

@echo *** _automation
cd _automation
git pull
cd ..

@echo *** actuariat_python
cd actuariat_python
git pull
cd ..

@echo *** teachpyx
cd teachpyx
git pull
cd ..

@echo *** ensae_projects
cd ensae_projects
git pull
cd ..

@echo *** ensae_teaching_cs
cd ensae_teaching_cs
git pull
cd ..

@echo *** jyquickhelper
cd jyquickhelper
git pull
cd ..

@echo *** mlstatpy
cd mlstatpy
git pull
cd ..

@echo *** pyensae
cd pyensae
git pull
cd ..

@echo *** pymmails
cd pymmails
git pull
cd ..

@echo *** pymyinstall
cd pymyinstall
git pull
cd ..

@echo *** pyquickhelper
cd pyquickhelper
git pull
cd ..

@echo *** pyrsslocal
cd pyrsslocal
git pull
cd ..

@echo *** python3_module_template
cd python3_module_template
git pull
cd ..

@echo *** jupytalk
cd jupytalk
git pull
cd ..

@echo *** tkinterquickhelper
cd tkinterquickhelper
git pull
cd ..

@echo *** code_beatrix
cd code_beatrix
git pull
cd ..

@echo *** cpyquickhelper
cd cpyquickhelper
git pull
cd ..
cd %current%
